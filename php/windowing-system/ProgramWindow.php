<?php

class ProgramWindow
{
    public $x;
    public $y;
    public $height;
    public $width;

    public function __construct()
    {
        $this->x = 0;
        $this->y = 0;
        $this->height = 600;
        $this->width = 800;
    }

    public function resize($size)
    {
        $this->height = $size->height;
        $this->width = $size->width;
    }

    public function move($position)
    {
        $this->x = $position->x;
        $this->y = $position->y;
    }
}
