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

    'type' => 'redis_cluster', // or redis or redis_cluster

    'handler' => \App\utils\RedisSessionHandler::class,

    'config' => [
        'file' => [
            'save_path' => runtime_path() . '/sessions',
        ],
        'redis' => [
            /*'host' => '192.168.123.113',
            'port' => 6379,
            'auth' => '123456',
            'timeout' => 2,
            'database' => '12',
            'prefix' => 'redis_session_',*/
            'connection' => 'session',
        ],
        'redis_cluster' => [
            'connection' => 'session_cluster'
        ]
    ],

    'session_name' => 'PHPSID',
    
    'auto_update_timestamp' => false,

    'lifetime' => 7*24*60*60,

    'cookie_lifetime' => 365*24*60*60,

    'cookie_path' => '/',

    'domain' => '',
    
    'http_only' => true,

    'secure' => false,
    
    'same_site' => '',

    'gc_probability' => [1, 1000],

];
