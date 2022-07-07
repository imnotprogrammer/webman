<?php

use app\constant\Error;

return [
    Error::TokenNotFound => '请先登录',
    Error::TokenValidateFailed => 'Token校验失败',
    Error::TokenExpired => 'Token过期',
    Error::TokenNotMatch => 'Token长度不匹配',
    Error::PermissionDeny => '没有权限操作',
    Error::LoginRetryMaxNums => '登录重试达到最大次数',
    Error::LoginUserOrPasswordError => '登录用户名或密码错误',
    Error::LoginUsernameNotNull => '请输入登录用户名',
    Error::LoginPasswordNotNull => '请输入登录密码',
    Error::LoginUsernameMaxLength => '登录用户名太长',
    Error::LoginPasswordMaxLength => '登录密码太长',
    Error::UserExisit => '用户已经存在',
    Error::UserNotExisit => '用户不存在',
    Error::UpdateFailed => '更新失败',
    Error::SaveFailed => '保存失败',
    Error::MenuNameNotNULL => '菜单名称不能为空',
    Error::MenuNameMaxLength => '菜单名称长度不能超过 :length 个字符',
    Error::MenuSlugNotNull => '菜单标识不能为空',
    Error::MenuSlugMaxLength => '菜单标识长度不能超过 :length 个字符',
    Error::MenuSlugUniqiued => '菜单标识需要唯一字符串',
    Error::MenuLocaleNotNUll => '请填写菜单显示名称多语言',
    Error::MenuLocaleMaxLength => '菜单显示名称不能超过 :length 个字符',
    Error::MenuPermissionIdNotNULL => '菜单ID不能为空',
    Error::LoginPasswordConfirmError => '两次密码输入不一致',
];