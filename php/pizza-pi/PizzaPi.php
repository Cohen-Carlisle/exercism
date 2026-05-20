<?php

class PizzaPi
{
    public function calculateDoughRequirement($num_pizzas, $num_people)
    {
        return $num_pizzas * ($num_people * 20 + 200);
    }

    public function calculateSauceRequirement($num_pizzas, $sauce_container_ml)
    {
        return ceil($num_pizzas * 125 / $sauce_container_ml);
    }

    public function calculateCheeseCubeCoverage($cheese_cube_side_length, $cheese_thickness, $pizza_diameter)
    {
        return floor($cheese_cube_side_length ** 3 / ($cheese_thickness * pi() * $pizza_diameter));
    }

    public function calculateLeftOverSlices($num_pizzas, $num_people)
    {
        return $num_pizzas * 8 % $num_people;
    }
}
