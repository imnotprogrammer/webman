<?php

use Webman\Route;

Route::group('/admin', function () {
    //Route::get('', [\App\admin\controller\Home::class, 'index']);

    Route::get('/home', [\App\admin\controller\Home::class, 'dashboard'])->name('home');
    Route::post('/login', [\App\admin\controller\auth\Login::class, 'login'])->name('login');
    Route::get('/menus', [\App\admin\controller\Home::class, 'menus'])->name('user-menus');
    Route::get('/info', [\App\admin\controller\Home::class, 'info'])->name('user-info');
});