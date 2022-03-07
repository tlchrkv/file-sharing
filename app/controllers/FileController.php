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

        if ($this->isRequireToAskPassword($file)) {
            return;
        }

        if ($this->isRequiredPasswordPassed($file)) {
            $file->setPassword($this->request->getPost('password'));
        }

        $file->sendToBrowser();
    }

    public function showAction(string $shortCode)
    {
        $file = File::getByShortCode($shortCode);

        if ($this->isRequireToAskPassword($file)) {
            $this->view->setTemplateAfter('simple');

            return $this->view->render('file', 'enter_password');
        }

        if ($this->isRequiredPasswordPassed($file)) {
            $file->setPassword($this->request->getPost('password'));
        }

        if ($file->isPublicShortCode($shortCode)) {
            $this->view->setTemplateAfter('preview');

            return $this->view->render('file', 'preview', ['file' => $file]);
        }

        if ($file->isPrivateShortCode($shortCode)) {
            $this->view->setTemplateAfter('simple');

            return $this->view->render('file', 'admin', ['file' => $file]);
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
