<?php

declare(strict_types=1);

namespace App\Models;

use App\Models\Encryptor\FileEncryptor;
use App\Models\Exceptions\FileNotFound;
use App\Models\Exceptions\FileRequirePassword;
use App\Models\Filters\ExifFilter;
use Cassandra\Date;
use Phalcon\Mvc\Model;
use Ramsey\Uuid\Uuid;

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

        if ($file === null) {
            throw new FileNotFound();
        }

        return $file;
    }

    /**
     * @return File[]
     */
    public static function findExpired(\DateTimeInterface $dateTime): array
    {
        return File::find(sprintf('stored_before <= \'%s\'', $dateTime->format('Y-m-d H:i:s')))->toArray();
    }

    public static function store(StoreFileAction $action): self
    {
        if (self::isImage($action->tmpName)) {
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

    private static function isImage(string $tmpName)
    {
        $finfo = finfo_open(FILEINFO_MIME_TYPE);
        $isImage = str_contains(finfo_file($finfo, $tmpName), 'image/');
        finfo_close($finfo);

        return $isImage;
    }

    public function isPublicShortCode(string $shortCode): bool
    {
        return $this->public_short_code === $shortCode;
    }

    /**
     * @throws Encryptor\Exceptions\CanNotOpenFile
     */
    public function encrypt(string $password): void
    {
        FileEncryptor::encrypt($this->placement, $password, $this->placement);

        $this->is_encrypted = true;
        $this->save();
    }

    /**
     * @throws Encryptor\Exceptions\CanNotOpenFile
     * @throws Encryptor\Exceptions\WrongPassword
     */
    public function decrypt(string $password): void
    {
        FileEncryptor::decrypt($this->placement, $password, $this->placement);

        $this->is_encrypted = false;
        $this->save();
    }

    public function delete(): void
    {
        unlink($this->placement);
        $this->delete();
    }

    public function getImageBase64Content(): string
    {
        $data = file_get_contents($this->placement);
        $type = pathinfo($this->placement, PATHINFO_EXTENSION);

        return 'data:image/' . $type . ';base64,' . base64_encode($data);
    }

    public function getExpiresInDaysHours(): string
    {
        $now = new \DateTime();
        $storedBefore = new \DateTime($this->stored_before);

        return $now->diff($storedBefore)->format('%d day(s) %H hour(s)');
    }

    /**
     * @throws Encryptor\Exceptions\CanNotOpenFile
     * @throws Encryptor\Exceptions\WrongPassword
     */
    public function sendDecryptedToBrowser(string $password): void
    {
        $tmpDecryptedSource = $this->placement . '.dec';

        FileEncryptor::decrypt($this->placement, $password, $tmpDecryptedSource);

        header("Content-Disposition: attachment; filename=\"$this->original_name\"");
        readfile($tmpDecryptedSource);
        unlink($tmpDecryptedSource);
    }

    /**
     * @throws FileRequirePassword
     */
    public function sendToBrowser(): void
    {
        if ($this->is_encrypted) {
            throw new FileRequirePassword();
        }

        header("Content-Disposition: attachment; filename=\"$this->original_name\"");
        readfile($this->placement);
    }
}
