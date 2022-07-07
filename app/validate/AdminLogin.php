<?php


namespace App\validate;

use app\constant\Error;
use App\utils\Validate;

class AdminLogin extends Validate
{
    protected $rule =   [
        'name'   => 'require|max:100',
        'username'   => 'require|max:100',
        'password'   => 'require|max:100',
        'confirmPassword'   => 'require|max:100|confirm:password',
        'avatar' => 'max:1000',
        'adminId' => 'require',
    ];

    protected $message  =   [
        'username.require' => Error::LoginUsernameNotNull,
        'username.max' => Error::LoginUsernameMaxLength,
        'password.require' => Error::LoginPasswordNotNull,
        'password.max' => Error::LoginPasswordMaxLength,
        'confirmPassword.require' => Error::LoginPasswordNotNull,
        'confirmPassword.max' => Error::LoginPasswordMaxLength,
        'confirmPassword.confirm' => Error::LoginPasswordConfirmError,
        'avatar.max' => Error::LoginPasswordMaxLength,
        'adminId.require' => Error::LoginPasswordMaxLength,
        //'adminId.int' => Error::LoginPasswordMaxLength,
    ];


    /**
     * @var \string[][] 场景
     */
    protected $scene = [
        'login'  =>  ['username', 'password'],
        'addUser'  =>  ['username','name', 'password', 'confirmPassword'],
        'editUser'  =>  ['name', 'adminId', 'password'],
        'deleteUser'  =>  ['adminId'],
    ];
}