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

    // 管理员
    Route::get('/system/users', [\App\admin\controller\system\User::class, 'list'])
        ->name(\App\constant\Permissions::PERMISSION_ADMIN_LIST);

    Route::post('/system/user/create', [\App\admin\controller\system\User::class, 'save'])
        ->name(\App\constant\Permissions::PERMISSION_ADMIN_CREATE);

    Route::get('/system/user/info', [\App\admin\controller\system\User::class, 'info'])
        ->name(\App\constant\Permissions::PERMISSION_ADMIN_INFO);

    Route::post('/system/user/update', [\App\admin\controller\system\User::class, 'update'])
        ->name(\App\constant\Permissions::PERMISSION_ADMIN_UPDATE);

    // 角色
    Route::get('/system/roles', [\App\admin\controller\system\Roles::class, 'list'])
        ->name(\App\constant\Permissions::PERMISSION_ADMIN_LIST);

    Route::post('/system/role/create', [\App\admin\controller\system\Roles::class, 'save'])
        ->name(\App\constant\Permissions::PERMISSION_ADMIN_CREATE);

    Route::get('/system/role/info', [\App\admin\controller\system\Roles::class, 'info'])
        ->name(\App\constant\Permissions::PERMISSION_ADMIN_INFO);

    Route::post('/system/role/update', [\App\admin\controller\system\Roles::class, 'update'])
        ->name(\App\constant\Permissions::PERMISSION_ADMIN_UPDATE);

    Route::post('/system/role/delete', [\App\admin\controller\system\Roles::class, 'delete'])
        ->name(\App\constant\Permissions::PERMISSION_ADMIN_DELETE);

    // 权限
    Route::get('/system/permissions', [\App\admin\controller\system\Permissions::class, 'list'])
        ->name(\App\constant\Permissions::PERMISSION_PERMISSION_LIST);

    Route::post('/system/permission/create', [\App\admin\controller\system\Permissions::class, 'save'])
        ->name(\App\constant\Permissions::PERMISSION_PERMISSION_CREATE);

    Route::get('/system/permission/info', [\App\admin\controller\system\Permissions::class, 'info'])
        ->name(\App\constant\Permissions::PERMISSION_PERMISSION_INFO);

    Route::post('/system/permission/update', [\App\admin\controller\system\Permissions::class, 'update'])
        ->name(\App\constant\Permissions::PERMISSION_PERMISSION_UPDATE);
    Route::post('/system/permission/delete', [\App\admin\controller\system\Permissions::class, 'delete'])
        ->name(\App\constant\Permissions::PERMISSION_PERMISSION_DELETE);
});