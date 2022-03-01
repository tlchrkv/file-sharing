<?php

declare(strict_types=1);

namespace App\Models;

use App\Models\Encryptor\FileEncryptor;
use App\Models\Exceptions\FileNotFound;
use App\Models\Exceptions\FileRequirePassword;
use App\Models\Filters\ExifFilter;
use App\Models\PasswordComplexity\ComplexityLevel;
use App\Models\PasswordComplexity\ComplexityMeter;
use App\Models\PasswordComplexity\WeakPassword;
use Phalcon\Mvc\Model;
use Ramsey\Uuid\Uuid;
use Phalcon\Mvc\Model\Resultset;

/**
 * @property string $id
 * @property string $original_name
 * @property bool $is_encrypted
 * @property string $public_short_code
 * @property string $private_short_code
 * @property string $stored_before
 * @property string $placement
 */
final class File extends Model
{
    private $password = '';

    public function initialize()
    {
        $this->setSource('files');
    }

    /**
     * @throws FileNotFound
     */
    public static function getByShortCode(string $shortCode): self
    {
        $file = File::findFirst([
            'conditions' => 'public_short_code = ?0 OR private_short_code = ?1',
            'bind'       => [$shortCode, $shortCode]
        ]);

        if ($file === false) {
            throw new FileNotFound();
        }

        return $file;
    }

    /**
     * @return File[]
     */
    public static function findExpired(\DateTimeInterface $dateTime): Resultset
    {
        return File::find(sprintf('stored_before <= \'%s\'', $dateTime->format('Y-m-d H:i:s')));
    }

    public static function store(StoreFileAction $action): self
    {
        if (self::isImagePlacement($action->tmpName)) {
            ExifFilter::clear($action->tmpName);
        }

        $file = new File();

        $placement = $action->filesDir . '/' . $action->id->toString();

        $file->save([
            'id' => $action->id,
            'original_name' => $action->originalName,
            'public_short_code' => ShortCodeGenerator::generate($action->shortCodeLength),
            'private_short_code' => ShortCodeGenerator::generate($action->shortCodeLength),
            'stored_before' => (new \DateTime('now'))->add($action->expireIn)->format('Y-m-d H:i:s'),
            'placement' => $placement,
        ]);

        move_uploaded_file($action->tmpName, $placement);

        return $file;
    }

    public function isImage(): bool
    {
        if (!$this->is_encrypted) {
            return self::isImagePlacement($this->placement);
        }

        $tmpDecryptPlacement = $this->createDecryptedCopy();
        $isImage = self::isImagePlacement($tmpDecryptPlacement);
        $this->removeDecryptedCopy();

        return $isImage;
    }

    private static function isImagePlacement(string $placement): bool
    {
        $finfo = finfo_open(FILEINFO_MIME_TYPE);
        $isImage = str_contains(finfo_file($finfo, $placement), 'image/');
        finfo_close($finfo);

        return $isImage;
    }

    public function isPublicShortCode(string $shortCode): bool
    {
        return $this->public_short_code === $shortCode;
    }

    public function isPrivateShortCode(string $shortCode): bool
    {
        return !$this->isPublicShortCode($shortCode);
    }

    public function isRequirePassword(): bool
    {
        return $this->is_encrypted;
    }

    public function isFreeAccess(): bool
    {
        return !$this->is_encrypted;
    }

    public function replaceOnNewDecryptedFile(string $tmpName): void
    {
        if (self::isImagePlacement($tmpName)) {
            ExifFilter::clear($tmpName);
        }

        unlink($this->placement);
        move_uploaded_file($tmpName, $this->placement);

        $this->is_encrypted = false;
        $this->save();
    }

    /**
     * @throws Encryptor\Exceptions\CanNotOpenFile
     * @throws WeakPassword
     */
    public function encrypt(string $password, ComplexityMeter $complexityMeter): void
    {
        if ($this->is_encrypted) {
            return;
        }

        if ($complexityMeter->measure($password)->getValue() === ComplexityLevel::low()->getValue()) {
            throw new WeakPassword();
        }

        FileEncryptor::encrypt($this->placement, $password, $this->placement . '.enc');
        unlink($this->placement);
        rename($this->placement . '.enc', $this->placement);

        $this->is_encrypted = true;
        $this->save();
    }

    /**
     * @throws Encryptor\Exceptions\CanNotOpenFile
     * @throws Encryptor\Exceptions\WrongPassword
     */
    public function decrypt(string $password): void
    {
        if (!$this->is_encrypted) {
            return;
        }

        FileEncryptor::decrypt($this->placement, $password, $this->placement . '.dec');
        unlink($this->placement);
        rename($this->placement . '.dec', $this->placement);

        $this->is_encrypted = false;
        $this->save();
    }

    public function fullDelete(): void
    {
        unlink($this->placement);
        $this->delete();
    }

    public function setPassword(string $password): self
    {
        $this->password = $password;

        return $this;
    }

    public function getImageBase64Content(): string
    {
        if ($this->is_encrypted) {
            $tmpDecryptedPlacement = $this->createDecryptedCopy();
            $data = file_get_contents($tmpDecryptedPlacement);
            $type = pathinfo($tmpDecryptedPlacement, PATHINFO_EXTENSION);
            $this->removeDecryptedCopy();

            return 'data:image/' . $type . ';base64,' . base64_encode($data);
        }

        $data = file_get_contents($this->placement);
        $type = pathinfo($this->placement, PATHINFO_EXTENSION);

        return 'data:image/' . $type . ';base64,' . base64_encode($data);
    }

    public function getExpiresInDaysHours(): string
    {
        $now = new \DateTime();
        $storedBefore = new \DateTime($this->stored_before);

        $interval = explode('|', $now->diff($storedBefore)->format('%d|%H'));
        $daysCount = (int) $interval[0];
        $hoursCount = (int) $interval[1];

        $humanFormat = '';

        if ($daysCount === 1) {
            $humanFormat .= '1 day ';
        }

        if ($daysCount > 1) {
            $humanFormat .= $daysCount . ' days ';
        }

        if ($hoursCount === 1) {
            $humanFormat .= '1 hour';
        }

        if ($hoursCount > 1) {
            $humanFormat .= $hoursCount . ' hours';
        }

        return $humanFormat;
    }

    /**
     * @throws FileRequirePassword
     * @throws Encryptor\Exceptions\CanNotOpenFile
     * @throws Encryptor\Exceptions\WrongPassword
     */
    private function createDecryptedCopy(): string
    {
        if (!$this->is_encrypted) {
            return $this->placement;
        }

        if ($this->password === '') {
            throw new FileRequirePassword();
        }

        $tmpDecryptedPlacement = $this->placement . '.dec';

        FileEncryptor::decrypt($this->placement, $this->password, $tmpDecryptedPlacement);

        return $tmpDecryptedPlacement;
    }

    private function removeDecryptedCopy(): void
    {
        unlink($this->placement . '.dec');
    }

    /**
     * @throws Encryptor\Exceptions\CanNotOpenFile
     * @throws Encryptor\Exceptions\WrongPassword
     */
    public function sendToBrowser(): void
    {
        if ($this->is_encrypted) {
            $placement = $this->createDecryptedCopy();
            $this->setupFileReturnResponse($placement);
            $this->removeDecryptedCopy();

            return;
        }

        $this->setupFileReturnResponse($this->placement);
    }

    private function setupFileReturnResponse(string $filePlacement): void
    {
        header('Cache-Control: No-Store');
        header("Content-Disposition: attachment; filename=\"$this->original_name\"");
        header('Content-Length: ' . filesize($filePlacement));
        readfile($filePlacement);
    }
}
