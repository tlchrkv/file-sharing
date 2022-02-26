<?php

declare(strict_types=1);

namespace App\Models\PasswordComplexity;

final class ComplexityLevel
{
    private $value;

    private function __construct(string $value)
    {
        $this->value = $value;
    }

    public function getValue(): string
    {
        return $this->value;
    }

    public static function low(): self
    {
        return new self('low');
    }

    public static function normal(): self
    {
        return new self('normal');
    }

    public static function high(): self
    {
        return new self('high');
    }

    public function getPosition(): int
    {
        if ($this->value === 'weak') {
            return 1;
        }

        if ($this->value === 'medium') {
            return 2;
        }

        return 3;
    }
}
