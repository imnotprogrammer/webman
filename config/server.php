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
    'listen' => sprintf('http://0.0.0.0:%s', env('SERVER_PORT', 8787)),
    'transport' => 'tcp',
    'context' => [],
    'name' => env('APP_NAME', 'webman'),
    'count' => cpu_count() * 2,
    'user' => '',
    'group' => '',
    'reusePort' => false,
    //'event_loop' => '\Workerman\Events\Libevent',
    'stop_timeout' => 2,
    'pid_file' => runtime_path() . '/webman.pid',
    'status_file' => runtime_path() . '/webman.status',
    'stdout_file' => runtime_path() . '/logs/stdout.log',
    'log_file' => runtime_path() . '/logs/workerman.log',
    'max_package_size' => 10 * 1024 * 1024
];
