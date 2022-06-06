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


Route::group('/api', function () {
    Route::get('/login', [\App\controller\Login::class, 'index']);
});

Route::get('/template', [\App\controller\Template::class, 'list']);
Route::post('/template/add', [\App\controller\Template::class, 'store']);
Route::post('/', [\App\controller\Index::class, 'index']);



