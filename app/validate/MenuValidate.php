<?php


namespace App\validate;


use app\constant\Error;
use App\utils\Validate;

class MenuValidate extends Validate
{
    protected $rule =   [
        'name' => 'require|max:100',
        'slug' => 'require|max:100',
        'locale' => 'require|max:100',
        'permissionId' => 'require',
        'permissionIds' => 'require',
    ];

    protected $message  =   [
        'name.require' => Error::MenuNameNotNULL,
        'name.max' => Error::MenuNameMaxLength,
        'slug.require' => Error::MenuSlugNotNull,
        'slug.max' => Error::MenuSlugMaxLength,
        'locale.max' => Error::MenuLocaleMaxLength,
        'locale.require' => Error::MenuLocaleNotNUll,
        'permissionId.require' => Error::MenuPermissionIdNotNULL,
        'permissionIds.require' => Error::MenuPermissionIdNotNULL,
    ];

    /**
     * @var \string[][] 场景
     */
    protected $scene = [
        'addMenu'  =>  ['name','slug', 'locale'],
        'editMenu'  =>  ['permissionId', 'name', 'locale'],
        'deleteMenu'  =>  ['permissionIds'],
    ];
}