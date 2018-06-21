<?php
$functions = get_defined_functions();
$dicts = array_merge(
    $functions['internal'],
    get_declared_classes(),
    get_declared_interfaces()
);

sort($dicts);

$result = implode("\n", $dicts);
file_put_contents(dirname(__FILE__) . '/../.vim/dictionaries/php.dict', $result);
