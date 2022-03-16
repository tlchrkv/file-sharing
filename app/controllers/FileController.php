<?php

declare(strict_types=1);

namespace App\Controllers;

use App\Models\File;
use Phalcon\Mvc\Controller;

final class FileController extends Controller
{
    public function downloadAction(string $shortCode)
    {
        $file = File::getByShortCode($shortCode);

        if ($file->isRequirePassword()) {
            $decodedPassword = base64_decode($_POST['password64']);
            $file->setPassword($decodedPassword);
        }

        $file->sendToBrowser();
    }

    public function showAction(string $shortCode)
    {
        $file = File::getByShortCode($shortCode);
        $objects = ['file' => $file, 'password64' => ''];

        if ($this->isRequireToAskPassword($file)) {
            $this->view->setTemplateAfter('simple');

            return $this->view->render('file', 'enter_password');
        }

        if ($this->isRequiredPasswordPassed($file)) {
            $file->checkPassword($this->request->getPost('password'));
            $file->setPassword($this->request->getPost('password'));
            $objects['password64'] = base64_encode($this->request->getPost('password'));
        }

        if ($file->isPublicShortCode($shortCode)) {
            $this->view->setTemplateAfter('preview');

            return $this->view->render('file', 'preview', $objects);
        }

        if ($file->isPrivateShortCode($shortCode)) {
            $this->view->setTemplateAfter('simple');

            return $this->view->render('file', 'admin', $objects);
        }

        exit;
    }

    private function isRequireToAskPassword(File $file): bool
    {
        return !$this->request->isPost() && $file->isRequirePassword();
    }

    private function isRequiredPasswordPassed(File $file): bool
    {
        return $file->isRequirePassword() && $this->request->isPost() && $this->request->getPost('password');
    }
}
