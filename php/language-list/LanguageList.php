<?php

function language_list(...$list)
{
    return $list;
}

function add_to_language_list($list, $lang)
{
    $list[] = $lang;
    return $list;
}

function prune_language_list($list)
{
    return array_slice($list, 1);
}

function current_language($list)
{
    return $list[0];
}

function language_list_length($list)
{
    return count($list);
}
