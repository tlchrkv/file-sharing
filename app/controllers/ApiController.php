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

    public function encryptAction(string $id)
    {
        $file = File::findFirst($id);

        $file->encrypt($this->request->getPost('password'));

        return $this->response->setJsonContent(['status' => 'ok'])->send();
    }

    public function decryptAction(string $id)
    {
        $file = File::findFirst($id);

        $file->decrypt();

        return $this->response->setJsonContent(['status' => 'ok'])->send();
    }

    public function deleteAction(string $id)
    {
        $file = File::findFirst($id);

        $file->delete();

        return $this->response->setJsonContent(['status' => 'ok'])->send();
    }
}
