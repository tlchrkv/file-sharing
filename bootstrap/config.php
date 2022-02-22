<?php

declare(strict_types=1);

return [
    'env' => getenv('APP_ENV'),
    'version' => '1.0',

    'database' => [
        'adapter'  => 'Postgresql',
        'host'     => getenv('POSTGRES_HOST'),
        'username' => getenv('POSTGRES_USER'),
        'password' => getenv('POSTGRES_PASSWORD'),
        'dbname'   => getenv('POSTGRES_DB'),
    ],

    'application' => [
        'name'           => getenv('APP_NAME'),
        'url'            => getenv('APP_URL'),
        'baseUri'        => '/',
        'appDir'         => dirname(__DIR__) . '/app',
        'migrationsDir'  => dirname(__DIR__) . '/migrations',
        'cacheDir'       => dirname(__DIR__) . '/storage/cache',
        'viewsDir'       => dirname(__DIR__) . '/app/views',
        'modelsDir'      => dirname(__DIR__) . '/app/models',
        'controllersDir' => dirname(__DIR__) . '/app/controllers',
        'validatorsDir' => dirname(__DIR__) . '/app/validators',
        'tasksDir'       => dirname(__DIR__) . '/app/tasks',
        'filesDir'       => dirname(__DIR__) . '/storage/files',
    ],

    'shortLinkLength' => (int) getenv('SHORT_LINK_LENGTH'),

    'printNewLine' => true
];
