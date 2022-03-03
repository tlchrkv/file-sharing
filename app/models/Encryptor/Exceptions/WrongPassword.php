<?php

declare(strict_types=1);

namespace App\Models\Encryptor\Exceptions;

final class WrongPassword extends \Exception
{
    public function __construct()
    {
        parent::__construct('Algorithm crashed');
    }
}
