<?php


namespace App\validate;

use app\constant\Error;
use App\utils\Validate;

class AdminLogin extends Validate
{
    protected $rule =   [
        'username'   => 'require|max:100',
        'password'   => 'require|max:100',
    ];

    protected $message  =   [
        'username.require' => Error::LoginUsernameNotNull,
        'username.max' => Error::LoginUsernameMaxLength,
        'password.require' => Error::LoginPasswordNotNull,
        'password.max' => Error::LoginPasswordMaxLength,

    ];


    /**
     * @var \string[][] 场景
     */
    protected $scene = [
        'login'  =>  ['username', 'password'],
        'database'  =>  ['databaseName','databaseHost', 'databaseUser', 'databasePort'],
        'redis'  =>  ['redisHost','redisPort', 'redisAuth'],
    ];
}