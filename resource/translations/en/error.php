<?php

use app\constant\Error;

return [
    Error::TokenNotFound => 'Please To Login Sysytem By Your Account',
    Error::TokenValidateFailed => 'Token Validate Failed',
    Error::TokenExpired => 'Token Expored',
    Error::TokenNotMatch => 'Token Length Not Matched',
    Error::PermissionDeny => 'No Permission',
    Error::LoginRetryMaxNums => 'Login Retry Max Nums',
    Error::LoginUserOrPasswordError => 'Login User Or Password Error',
    Error::LoginUsernameNotNull => 'Login Username Not Null',
    Error::LoginPasswordNotNull => 'Login Password Not Null',
    Error::LoginUsernameMaxLength => 'Login Username Max Length',
    Error::LoginPasswordMaxLength => 'Login Password Max Length',
    Error::UserExisit => 'User Exisit',
    Error::UserNotExisit => 'User Not Exisit',
    Error::UpdateFailed => 'Update Failed',
    Error::SaveFailed => 'Save Failed',
    Error::MenuNameNotNULL => 'Menu Name Not NULL',
    Error::MenuNameMaxLength => 'Menu Name Max Length',
    Error::MenuSlugNotNull => 'Menu Slug Not Null',
    Error::MenuSlugMaxLength => 'Menu Slug Max Length',
    Error::MenuSlugUniqiued => 'Menu Slug Uniqiued',
    Error::MenuLocaleNotNUll => 'Menu Locale Not NUll',
    Error::MenuLocaleMaxLength => 'Menu Locale Max Length',
    Error::MenuPermissionIdNotNULL => 'Menu Permission Id Not NULL',
    Error::LoginPasswordConfirmError => 'Login Password Confirm Error',
];