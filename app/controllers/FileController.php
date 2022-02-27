<?php

declare(strict_types=1);

namespace App\Controllers;

use App\Models\File;
use Phalcon\Mvc\Controller;

final class FileController extends Controller
{
    public function initialize()
    {
        $this->view->setTemplateAfter('common');
    }

    public function showAction(string $shortCode)
    {
        $file = File::getByShortCode($shortCode);

        if ($this->isRequireToAskPassword($file)) {
            echo $this->view->render('file', 'enter_password');

            exit;
        }

        if ($this->isRequiredPasswordPassed($file)) {
            $file->setPassword($this->request->getPost('password'));
        }

        if ($file->isPublicShortCode($shortCode)) {
            $file->sendToBrowser();

            exit;
        }

        if ($file->isPrivateShortCode($shortCode)) {
            echo $this->view->render('file', 'admin', ['file' => $file]);

            exit;
        }
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
