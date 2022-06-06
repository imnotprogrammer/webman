<?php
/**
 * This file is part of webman.
 *
 * Licensed under The MIT License
 * For full copyright and license information, please see the MIT-LICENSE.txt
 * Redistributions of files must retain the above copyright notice.
 *
 * @author    walkor<walkor@workerman.net>
 * @copyright walkor<walkor@workerman.net>
 * @link      http://www.workerman.net/
 * @license   http://www.opensource.org/licenses/mit-license.php MIT License
 */

return [
    // 默认数据库
    'default' => env('DB_CONNECTION', 'mysql'),
    // 各种数据库配置
    'connections' => [

        'mysql' => [
            'driver'      => 'mysql',
            'read' => [
                'host' => env('DB_MASTER_HOST', '127.0.0.1'),
                'password' => env('DB_MASTER_PASSWORD', ''),
            ],
            'write' => [
                'host' => env('DB_SLAVE_HOST', '127.0.0.1'),
                'password' => env('DB_SLAVE_PASSWORD', ''),
            ],

            //'host'        => env('DB_HOST', '127.0.0.1'),
            'port'        => env('DB_PORT', 3306),
            'database'    => env('DB_NAME', ''),
            'username'    => env('DB_USER', 'root'),
            //'password'    => env('DB_PASSWORD', ''),
            'unix_socket' => '',
            'charset'     => 'utf8',
            'collation'   => 'utf8_unicode_ci',
            'prefix'      => '',
            'strict'      => true,
            'engine'      => null,
        ],

        'sqlite' => [
            'driver'   => 'sqlite',
            'database' => '',
            'prefix'   => '',
        ],

        'pgsql' => [
            'driver'   => 'pgsql',
            'host'     => '127.0.0.1',
            'port'     => 5432,
            'database' => 'webman',
            'username' => 'webman',
            'password' => '',
            'charset'  => 'utf8',
            'prefix'   => '',
            'schema'   => 'public',
            'sslmode'  => 'prefer',
        ],

        'sqlsrv' => [
            'driver'   => 'sqlsrv',
            'host'     => 'localhost',
            'port'     => 1433,
            'database' => 'webman',
            'username' => 'webman',
            'password' => '',
            'charset'  => 'utf8',
            'prefix'   => '',
        ],
    ],
];
