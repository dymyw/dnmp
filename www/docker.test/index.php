<?php

echo 'docker.test';

/**
 * 测试 PHP 的 PDO 扩展
 */
$pdo    = new PDO('mysql:host=mysql;dbname=mysql', 'root', 'root', [
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
]);
$result = $pdo->query("SELECT `User` FROM `user`")->fetchAll();
var_dump([
    'pdo'       => $pdo,
    'result'    => $result,
]);
