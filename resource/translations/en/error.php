<?php

use App\constant\Error;

return [
    Error::SystemError => 'Server Internal Error',
    Error::TokenExpired => 'Token Expored',
    Error::TokenValidateFailed => 'Token Validate Failed',
    Error::TokenNotFound => 'Please To Login Sysytem By Your Account',
    Error::TokenNotMatch => 'Token Length Not Matched',
    Error::PermissionDeny => 'No Permission',
];