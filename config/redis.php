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
    /**
     * option support 'predis' or 'phpredis'.
     * if check the phpredis.need to download and install phpredis extension
     * or composer require the 'predis/predis' package
     * default use 'predis'
     */
    'client' => 'predis',

    'default' => [
        'host' => env('REDIS_HOST', '127.0.0.1'),
        'password' => env('REDIS_AUTH', ''),
        'port' => env('REDIS_PORT', 6379),
        'database' => 0,
    ],

    'session' => [
        'host' => '192.168.123.113',
        'password' => '123456',
        'port' => 6379,
        'database' => 12,
        'timeout' => 2,
        'prefix' => 'redis_session_',
    ],

    'options' => [
        'cluster' => 'redis',
    ],

    'clusters' => [
        'session_cluster' => [
            [
                'host' => '192.168.123.113',
                'port' => 6379,
                'timeout' => 2,
                'password' => '123456',
                'prefix' => 'redis_session_',
            ]
        ],
    ],

];
