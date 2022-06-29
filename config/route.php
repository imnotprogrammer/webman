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

use app\controller\Index;
use Webman\Route;

Route::get('/', [Index::class, 'json']);

Route::post('/database/save', [\app\controller\Install::class, 'saveDatabase']);
Route::post('/redis/save', [\app\controller\Install::class, 'saveRedis']);
Route::post('/base/save', [\app\controller\Install::class, 'base']);
Route::post('/start/init', [\app\controller\Install::class, 'init']);
Route::get('/test/write', [\app\controller\Install::class, 'write']);
$routeMapPath = base_path() . DIRECTORY_SEPARATOR . 'route';

$needLoadCollection = [
     'api.php',
     'admin.php'
];

/**
 * 加载映射文件
 */
foreach ($needLoadCollection as $routeFile) {
    require_once $routeMapPath . DIRECTORY_SEPARATOR . $routeFile;
}




