<?php

use app\constant\Error;

return [
    Error::SystemError => '系统错误',
    Error::TokenExpired => 'Token过期',
    Error::TokenValidateFailed => 'Token校验失败',
    Error::TokenNotFound => '请先登录',
    Error::TokenNotMatch => 'Token长度不匹配',
    Error::PermissionDeny => '没有权限操作',
    Error::LoginRetryMaxNums => '登录重试达到最大次数',
    Error::LoginUserOrPasswordError => '登录用户名或密码错误',
    Error::LoginUsernameNotNull => '请输入登录用户名',
    Error::LoginPasswordNotNull => '请输入登录密码',
    Error::LoginUsernameMaxLength => '登录用户名太长',
    Error::LoginPasswordMaxLength => '登录密码太长'
];