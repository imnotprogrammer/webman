<?php

namespace app\constant;

class ApiError {
    /** @var int UserNotExisit */
    const UserNotExisit = 50001;
    /** @var int UserNotVerify */
    const UserNotVerify = 50002;
    /** @var int UserNeedToRepayOverdueOrder */
    const UserNeedToRepayOverdueOrder = 50003;
    /** @var int UserPasswordOrPhoneError */
    const UserPasswordOrPhoneError = 50004;
    /**
     * 获取错误码信息通过错误码
     * @param int $code  错误码
     * @param array $extra 其它信息
     */
    public static function getMessageByCode($code, $extra = []): ?string
    {
        return trans( $code, $extra, 'api');
    }
}