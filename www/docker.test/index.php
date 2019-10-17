<?php

error_reporting(E_ALL);
ini_set('display_errors', 1);

var_dump([
    'PHP_VERSION'       => phpversion(),
    'NGINX_VERSION'     => $_SERVER['SERVER_SOFTWARE'],
    'MYSQL_VERSION'     => getMysqlVersion(),
    'REDIS_VERSION'     => getRedisVersion(),
    'LOADED_EXTENSIONS' => getLoadedExtensions(),
]);

/**
 * 测试 PHP 的 PDO 扩展
 */
function getMysqlVersion()
{
    if (extension_loaded('pdo_mysql')) {
        try {
            $pdo    = new PDO('mysql:host=mysql;dbname=mysql', 'root', 'root', [
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            ]);

            // select users
//            $result = $pdo->query("SELECT `User` FROM `user`")->fetchAll();
//            var_dump([
//                'pdo'       => $pdo,
//                'result'    => $result,
//            ]);

            // get version
            $result = $pdo->query("SELECT VERSION() as version")->fetch();
        } catch (PDOException $e) {
            return $e->getMessage();
        }

        return $result['version'];
    } else {
        return 'pdo_mysql 扩展未安装';
    }
}

/**
 * 测试 PHP 的 Redis 扩展
 */
function getRedisVersion()
{
    if (extension_loaded('redis')) {
        try {
            $redis  = new Redis();
            $redis->connect('redis', 6379);
            $info   = $redis->info();

//        var_dump($redis->get('name'));
        } catch (RedisException $e) {
            return $e->getMessage();
        }

        return $info['redis_version'];
    } else {
        return 'redis 扩展未安装';
    }
}

/**
 * 获取已安装的扩展
 */
function getLoadedExtensions()
{
    $loadedExtensions = get_loaded_extensions();
    foreach ($loadedExtensions as &$extension) {
        $extension .= ' ' . phpversion($extension);
    }

    return $loadedExtensions;
}
