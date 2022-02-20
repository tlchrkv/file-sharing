<?php

declare(strict_types=1);

namespace App\Models\Encryptor\Exceptions;

final class CanNotOpenFile extends \Exception
{
    public function __construct(string $source)
    {
        parent::__construct(sprintf('Can\'t open file placed in \'%s\'', $source));
    }
}
