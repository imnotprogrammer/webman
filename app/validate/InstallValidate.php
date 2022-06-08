<?php


namespace App\validate;


use think\Validate;

class InstallValidate extends Validate
{
    protected $rule =   [
        //base
        'appName'  => 'require|max:50',
        'locale'   => 'string|accepted:zh_CN,en',
        'timezone'   => 'string',

        //database
        'databaseName'   => 'require|max:100',
        'databaseHost'   => 'require|max:250',
        'databaseUser'   => 'require|max:250',
        'databasePassword'   => 'string|require|max:250',
        'databasePort'   => 'integer|require|between:1,100000',

        // redis
        'redisHost'   => 'string|max:100',
        'redisPort'   => 'integer|require|between:1,100000',
        'redisAuth'   => 'string|max:250',
    ];

    protected $message  =   [
        'appName.require' => '请填写app名称',
        'appName.max'     => '名称最多不能超过50个字符',
        'locale.string'   => '请填写语言',
        'local.accepted'  => '语言取值错误',
        'timezone.string' => '请填写正确格式的时区',

        'databaseName.require' => '请填写数据库名称',
        'databaseName.max' => '数据库名称最大字符串不超过100个字符',
        'databaseHost.require' => '请填写数据库地址',
        'databaseHost.max' => '数据库名称最大字符串不超过250个字符',

    ];

    /**
     * @var \string[][] 场景
     */
    protected $scene = [
        'base'  =>  ['appName','locale', 'timezone', 'serverPort'],
        'database'  =>  ['databaseName','databaseHost', 'databaseUser', 'databasePort'],
        'redis'  =>  ['redisHost','redisPort', 'redisAuth'],
    ];
}