<?php

use Webman\Route;

Route::group('/admin', function () {
    //Route::get('', [\App\admin\controller\Home::class, 'index']);

    Route::get('/home', [\App\admin\controller\Home::class, 'dashboard'])
        ->name(\App\constant\Permissions::PERMISSION_HOME);
    Route::post('/login', [\App\admin\controller\auth\Login::class, 'login'])
        ->name(\App\constant\Permissions::PERMISSION_LOGIN);
    Route::get('/menus', [\App\admin\controller\Home::class, 'menus'])
        ->name(\App\constant\Permissions::PERMISSION_USER_MENUS);
    Route::get('/info', [\App\admin\controller\Home::class, 'info'])
        ->name(\App\constant\Permissions::PERMISSION_USER_INFO);
});