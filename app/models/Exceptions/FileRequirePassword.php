<?php

declare(strict_types=1);

namespace App\Models\Exceptions;

final class FileRequirePassword extends \Exception
{
    public function __construct()
    {
        parent::__construct('File require password');
    }
}
