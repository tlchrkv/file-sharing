<?php

declare(strict_types=1);

namespace App\Controllers;

use Phalcon\Mvc\Controller;

final class IndexController extends Controller
{
    public function initialize()
    {
        $this->view->setTemplateAfter('common');
    }

    public function indexAction()
    {
        $this->view->maxFileMegabytes = $this->config->maxFileMegabytes;
    }

    public function resultAction()
    {
        $this->view->publicLink = $_POST['public_link'];
        $this->view->privateLink = $_POST['private_link'];
    }
}
