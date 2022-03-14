<?php

declare(strict_types=1);

namespace App\Models;

final class Authenticator
{
    public static function getPasswordFromHeader(): string
    {
        return base64_decode($_SERVER['HTTP_AUTHORIZATION']);
    }
}
