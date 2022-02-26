<?php

declare(strict_types=1);

namespace App\Controllers;

use App\Models\File;
use App\Models\PasswordComplexity\ComplexityMeter;
use App\Models\StoreFileAction;
use App\Validators\StoreActionValidator;
use Phalcon\Mvc\Controller;
use Ramsey\Uuid\Uuid;

final class ApiController extends Controller
{
    public function initialize()
    {
        $this->response->setContentType('application/json', 'UTF-8');
    }

    public function storeAction()
    {
        $messages = (new StoreActionValidator())->validate(array_merge($_POST, $_FILES));

        if (count($messages)) {
            foreach ($messages as $message) {
                return $this->response
                    ->setStatusCode(422)
                    ->setJsonContent(['error' => $message])
                    ->send();
            }
        }

        $file = File::store(
            new StoreFileAction(
                Uuid::uuid4(),
                $_FILES['file']['tmp_name'],
                $_FILES['file']['name'],
                new \DateInterval(sprintf('P%sD', $_POST['delete_after'])),
                $this->config->shortLinkLength,
                $this->config->application->filesDir
            )
        );

        if ($_POST['require_encryption'] === 'true') {
            $file->encrypt($_POST['password'], $this->getPasswordComplexityMeter());
        }

        return $this->response
            ->setStatusCode(200)
            ->setJsonContent([
                'data' => [
                    'public_link' => $this->config->application->url . $file->public_short_code,
                    'private_link' => $this->config->application->url . $file->private_short_code,
                ]
            ])
            ->send();
    }

    public function updateAction(string $id)
    {
        /** @var File $file */
        $file = File::findFirstById($id);

        $isFileEncryptedBefore = $file->is_encrypted;

        $file->replaceOnNewDecryptedFile($_FILES['file']['tmp_name']);

        if ($isFileEncryptedBefore && $_POST['password']) {
            $file->encrypt($_POST['password'], $this->getPasswordComplexityMeter());
        }

        return $this->response->setStatusCode(204)->send();
    }

    public function encryptAction(string $id)
    {
        $_PATCH = [];
        parse_str(file_get_contents('php://input'), $_PATCH);

        /** @var File $file */
        $file = File::findFirstById($id);

        $file->encrypt($_PATCH['password'], $this->getPasswordComplexityMeter());

        return $this->response->setStatusCode(204)->send();
    }

    public function decryptAction(string $id)
    {
        $_PATCH = [];
        parse_str(file_get_contents('php://input'), $_PATCH);

        /** @var File $file */
        $file = File::findFirstById($id);

        $file->decrypt($_PATCH['password']);

        return $this->response->setStatusCode(204)->send();
    }

    public function deleteAction(string $id)
    {
        /** @var File $file */
        $file = File::findFirstById($id);

        $file->fullDelete();

        return $this->response->setStatusCode(204)->send();
    }

    public function checkPasswordComplexityAction()
    {
        if (empty($_GET['password'])) {
            return $this->response
                ->setStatusCode(422)
                ->setJsonContent([
                    'error' => 'Password query parameter is required',
                ])
                ->send();
        }

        return $this->response
            ->setStatusCode(200)
            ->setJsonContent([
                'complexity' => $this->getPasswordComplexityMeter()
                    ->measure($_GET['password'])->getValue(),
            ])
            ->send();
    }

    private function getPasswordComplexityMeter(): ComplexityMeter
    {
        return new ComplexityMeter($this->config->minPasswordLength, $this->config->strongPasswordLength);
    }
}
