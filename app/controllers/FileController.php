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

        switch (true) {
            case !$this->request->isPost() && $file->is_encrypted:
                echo $this->view->render('file', 'enter_password');
                break;
            case $this->request->isPost() && $this->request->getPost('password') && $file->isPublicShortCode($shortCode):
                $file->sendDecryptedToBrowser($this->request->getPost('password'));
                break;
            case $this->request->isPost() && $this->request->getPost('password') && !$file->isPublicShortCode($shortCode):
                // temporary decrypt or for every action
                $this->view->file = $file;
                echo $this->view->render('file', 'manage');
                break;
            case !$file->is_encrypted && $file->isPublicShortCode($shortCode):
                // echo $this->view->render('file', 'preview');
                $file->sendToBrowser();
                break;
            case !$file->is_encrypted && !$file->isPublicShortCode($shortCode):
                $this->view->file = $file;
                echo $this->view->render('file', 'manage');
                break;
        }

        exit;
    }
}
