<?php

use app\constant\ApiError;

return [
    ApiError::UserNotExisit => '用户不存在',
    ApiError::UserNotVerify => '用户未认证',
    ApiError::UserNeedToRepayOverdueOrder => '需要对逾期订单还款',
    ApiError::UserPasswordOrPhoneError => '手机号或密码错误',
];