<?php

declare(strict_types=1);

namespace App\Models\PasswordComplexity;

final class WeakPassword extends \Exception
{
    public function __construct()
    {
        parent::__construct('This password is weak. Choose security password.');
    }
}
