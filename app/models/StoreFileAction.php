<?php

declare(strict_types=1);

namespace App\Models;

use Ramsey\Uuid\UuidInterface;

final class StoreFileAction
{
    public $id;
    public $tmpName;
    public $originalName;
    public $expireIn;
    public $shortCodeLength;
    public $filesDir;

    public function __construct(
        UuidInterface $id,
        string $tmpName,
        string $originalName,
        \DateInterval $expireIn,
        int $shortCodeLength,
        string $filesDir
    ) {
        $this->id = $id;
        $this->tmpName = $tmpName;
        $this->originalName = $originalName;
        $this->expireIn = $expireIn;
        $this->shortCodeLength = $shortCodeLength;
        $this->filesDir = $filesDir;
    }
}
