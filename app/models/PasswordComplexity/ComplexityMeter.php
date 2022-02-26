<?php

declare(strict_types=1);

namespace App\Models\PasswordComplexity;

final class ComplexityMeter
{
    private $minPasswordLength;
    private $goodPasswordLength;

    public function __construct(int $minPasswordLength, int $goodPasswordLength)
    {
        $this->minPasswordLength = $minPasswordLength;
        $this->goodPasswordLength = $goodPasswordLength;
    }

    public function measure(string $password): ComplexityLevel
    {
        $varietyLevel = $this->getVarietyLevel($password);
        $lengthLevel = $this->getLengthLevel($password);

        if ($varietyLevel->getPosition() < $lengthLevel->getPosition()) {
            return $varietyLevel;
        }

        return $lengthLevel;
    }

    private function getVarietyLevel(string $password): ComplexityLevel
    {
        $anyLetter = '/^[a-zA-Z]+$/';
        $onlyDigits = '/^[0-9]+$/';
        $onlyNonWordSymbols = '/^[\W]+$/';
        $anyLetterOrDigit = '/^[a-zA-Z0-9]+$/';
        $anyLetterOrNonWordSymbol = '/^[a-zA-Z\W]+$/';
        $digitOrNonWordSymbol = '/^[0-9\W]+$/';
        $lowerCaseLetterOrDigitOrNonWordSymbol = '/^[a-z0-9\W]+$/';
        $upperCaseLetterOrDigitOrNonWordSymbol = '/^[A-Z0-9\W]+$/';
        $anyLetterOrDigitOrNonWordSymbol = '/^[\w\W]+$/';

        switch (true) {
            case $this->isMatch($anyLetter, $password):
            case $this->isMatch($onlyDigits, $password):
            case $this->isMatch($onlyNonWordSymbols, $password):
            default:
                return ComplexityLevel::low();
            case $this->isMatch($anyLetterOrDigit, $password):
            case $this->isMatch($anyLetterOrNonWordSymbol, $password):
            case $this->isMatch($digitOrNonWordSymbol, $password):
            case $this->isMatch($lowerCaseLetterOrDigitOrNonWordSymbol, $password):
            case $this->isMatch($upperCaseLetterOrDigitOrNonWordSymbol, $password):
                return ComplexityLevel::normal();
            case $this->isMatch($anyLetterOrDigitOrNonWordSymbol, $password):
                return ComplexityLevel::high();
        }
    }

    private function getLengthLevel(string $password): ComplexityLevel
    {
        switch (true) {
            case strlen($password) < $this->minPasswordLength:
            default:
                return ComplexityLevel::low();
            case strlen($password) < $this->goodPasswordLength:
                return ComplexityLevel::normal();
            case strlen($password) >= $this->goodPasswordLength:
                return ComplexityLevel::high();
        }
    }

    private function isMatch(string $pattern, string $value): bool
    {
        return 1 === preg_match($pattern, $value);
    }
}
