<?php

declare(strict_types=1);

namespace App\Controllers;

use Phalcon\Mvc\Controller;

final class ErrorController extends Controller
{
    public function defaultAction(\Throwable $exception)
    {
        if (str_contains($_SERVER['REQUEST_URI'], '/api/')) {
            $this->response->setContentType('application/json', 'UTF-8');

            return $this->response
                ->setStatusCode(500)
                ->setJsonContent(array_merge(
                    ['error' => $exception->getMessage()],
                    $this->config->env === 'local' ? ['trace' => $exception->getTraceAsString()] : []
                ))
                ->send();
        }

        $this->view->setTemplateAfter('common');
        $this->view->message = $exception->getMessage();
        $this->view->trace = $this->config->env === 'local' ? nl2br(htmlentities($exception->getTraceAsString())) : '';
    }
}
