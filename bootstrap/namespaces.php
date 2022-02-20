<?php

declare(strict_types=1);

use Phalcon\Loader;

$loader = new Loader();

$loader->registerNamespaces([
    'App\Models' => $config->application->modelsDir,
    'App\Controllers' => $config->application->controllersDir,
    'App\Validators' => $config->application->validatorsDir,
]);

$loader->register();

require_once BASE_PATH . '/vendor/autoload.php';
