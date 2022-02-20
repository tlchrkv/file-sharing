<?php

declare(strict_types=1);

use Phalcon\Mvc\Router;

$router = new Router();
$router->setUriSource(Router::URI_SOURCE_SERVER_REQUEST_URI);
$router->setDI($di);

$router->add('/{shortCode}', 'File::show')->via(['GET', 'POST']);

$router->add('/', 'Index::index')->via(['GET']);

$router->add('/api/v1/files', 'Api::store')->via(['POST']);
$router->add('/api/v1/files/{id}', 'Api::update')->via(['POST']);
$router->add('/api/v1/files/{id}/encrypt', 'Api::encrypt')->via(['PATCH']);
$router->add('/api/v1/files/{id}/decrypt', 'Api::decrypt')->via(['PATCH']);
$router->add('/api/v1/files/{id}', 'Api::delete')->via(['DELETE']);

$router->handle();

return $router;
