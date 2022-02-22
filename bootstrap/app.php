<?php

declare(strict_types=1);

use Phalcon\Mvc\View;
use Phalcon\Mvc\Dispatcher;
use Phalcon\Crypt;
use Phalcon\Mvc\Url as UrlResolver;
use Phalcon\Mvc\View\Engine\Volt as VoltEngine;
use Phalcon\Mvc\Model\Metadata\Files as MetaDataAdapter;
use Phalcon\Session\Adapter\Files as SessionAdapter;
use Phalcon\Events\Manager as EventsManager;
use Phalcon\Http\Request;

$di->setShared('request', new Request());

$di->setShared('config', function () {
    $configArray = include BASE_PATH . '/bootstrap/config.php';

    return new Phalcon\Config($configArray);
});

$di->setShared('url', function () {
    $config = $this->getConfig();

    $url = new UrlResolver();
    $url->setBaseUri($config->application->baseUri);

    return $url;
});

$di->set('view', function () {
    $config = $this->getConfig();

    $view = new View();
    $view->setViewsDir($config->application->viewsDir);
    $view->registerEngines([
        '.volt' => function ($view) use ($config): VoltEngine {
            $volt = new VoltEngine($view, $this);
            $volt->setOptions([
                'compiledPath' => $config->application->cacheDir . '/volt',
                'compiledSeparator' => '_',
            ]);

            return $volt;
        },
        '.phtml' => 'Phalcon\Mvc\View\Engine\Php'
    ]);

    $view->appName = $config->application->name;

    return $view;
}, true);

$di->set('db', function () {
    $config = $this->getConfig();
    $adapter = 'Phalcon\Db\Adapter\Pdo\\' . $config->database->adapter;

    return new $adapter([
        'host'     => $config->database->host,
        'username' => $config->database->username,
        'password' => $config->database->password,
        'dbname'   => $config->database->dbname,
    ]);
});

$di->set('modelsMetadata', function () {
    $config = $this->getConfig();

    return new MetaDataAdapter([
        'metaDataDir' => $config->application->cacheDir . '/meta-data/'
    ]);
});

$di->set('session', function () {
    $session = new SessionAdapter();
    $session->start();

    return $session;
});

$di->set('eventsManager', function () {
    return new EventsManager();
});

$di->set('dispatcher', function () use ($di) {
    $evManager = $di->getShared('eventsManager');

    $evManager->attach(
        'dispatch:beforeException',
        static function ($event, $dispatcher, $exception): bool {
            $dispatcher->forward([
                'controller' => 'error',
                'action' => 'default',
                'params' => [$exception],
            ]);

            return false;
        }
    );

    $dispatcher = new Dispatcher();
    $dispatcher->setDefaultNamespace('App\Controllers');
    $dispatcher->setEventsManager($evManager);

    return $dispatcher;
});

$di->set('router', function () use ($di) {
    return require BASE_PATH . '/bootstrap/routes.php';
});
