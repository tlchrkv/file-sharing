<?php

declare(strict_types=1);

namespace App\Controllers;

use App\Models\File;
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
            $file->encrypt($_POST['password']);
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

        $file->updateFile($_FILES['file']['tmp_name']);

        return $this->response->setStatusCode(204)->send();
    }

    public function encryptAction(string $id)
    {
        $requestData = file_get_contents('php://input');

        /** @var File $file */
        $file = File::findFirstById($id);

        $file->encrypt($requestData['password']);

        return $this->response->setStatusCode(204)->send();
    }

    public function decryptAction(string $id)
    {
        $requestData = file_get_contents('php://input');

        /** @var File $file */
        $file = File::findFirstById($id);

        $file->decrypt($requestData['password']);

        return $this->response->setStatusCode(204)->send();
    }

    public function deleteAction(string $id)
    {
        /** @var File $file */
        $file = File::findFirstById($id);

        $file->fullDelete();

        return $this->response->setStatusCode(204)->send();
    }
}
