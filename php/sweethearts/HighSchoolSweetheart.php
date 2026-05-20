<?php

class HighSchoolSweetheart
{
    public function firstLetter(string $name): string
    {
        $trimmed = ltrim($name);
        return substr($trimmed, 0, 1);
    }

    public function initial(string $name): string
    {
        $uppercaseFirstLetter = strtoupper($this->firstLetter($name));
        return "$uppercaseFirstLetter.";
    }

    public function initials(string $fullName): string
    {
        $squished = $this->squish($fullName);
        [$firstName, $lastName] = explode(" ", $squished, 2);
        $firstInitial = $this->initial($firstName);
        $lastInitial = $this->initial($lastName);
        return "$firstInitial $lastInitial";
    }

    public function pair(string $sweetheart1, string $sweetheart2): string
    {
        $initialPairing = $this->initials($sweetheart1) . "  +  " . $this->initials($sweetheart2);
        return <<<HEART
             ******       ******
           **      **   **      **
         **         ** **         **
        **            *            **
        **                         **
        **     $initialPairing     **
         **                       **
           **                   **
             **               **
               **           **
                 **       **
                   **   **
                     ***
                      *
        HEART;
    }

    private function squish(string $str): string
    {
        $trimmed = trim($str);
        return preg_replace("/\s+/", " ", $trimmed);
    }
}
