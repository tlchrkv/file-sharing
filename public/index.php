<?php

declare(strict_types=1);

use Phalcon\DI\FactoryDefault;
use Phalcon\Mvc\Application;

if (getenv('APP_ENV') === 'local') {
    error_reporting(E_ALL);
}

define('BASE_PATH', dirname(__DIR__));

try {
    $di = new FactoryDefault();

    include BASE_PATH . '/bootstrap/app.php';

    $config = $di->getConfig();

    include BASE_PATH . '/bootstrap/namespaces.php';

    $application = new Application($di);

    echo $application->handle()->getContent();

} catch (\Throwable $e) {
    if (str_contains($_SERVER['REQUEST_URI'], '/api/')) {
        return $this->response
            ->setStatusCode(500)
            ->setJsonContent(['error' => $e->getMessage()])
            ->send();
    }

    echo $e->getMessage(), '<br>';
    echo nl2br(htmlentities($e->getTraceAsString()));
}
