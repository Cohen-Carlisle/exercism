<?php

class LuckyNumbers
{
    public function sumUp(array $digitsOfNumber1, array $digitsOfNumber2): int
    {
        return implode($digitsOfNumber1) + implode($digitsOfNumber2);
    }

    public function isPalindrome(int $number): bool
    {
        return $number == strrev($number);
    }

    public function validate(string $input): string
    {
        if ($input == "") {
            return "Required field";
        } elseif ((int) $input <= 0) {
            return "Must be a whole number larger than 0";
        } else {
            return "";
        }
    }
}
