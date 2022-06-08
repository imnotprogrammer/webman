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

use Webman\Route;

Route::get('/', function () {

});

Route::group('/admin', function () {
    Route::get('', [\App\admin\controller\Home::class, 'index']);
    Route::get('/login', [\App\admin\controller\auth\Login::class, 'login']);
});


Route::group('/api', function () {
    Route::get('/register', [\App\api\controller\Login::class, 'register']);
    Route::get('/login', [\App\api\controller\Login::class, 'login']);
});


