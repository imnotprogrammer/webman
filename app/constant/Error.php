<?php

namespace app\constant;

class Error {
    /** 校验token 未上传 */
    const TokenNotFound = 50001;
    /** token校验失败 */
    const TokenValidateFailed = 50002;

    /** token 过期 */
    const TokenExpired = 50003;

     /** token 个数不匹配 */
    const TokenNotMatch = 50004;

    /** 没有权限 */
    const PermissionDeny = 50020;
    /** 登录重试次数达到最大 */
    const LoginRetryMaxNums = 50030;

    /** 登录重试次数达到最大 */
    const LoginUserOrPasswordError = 50031;

    const LoginUsernameNotNull = 50031;
    const LoginPasswordNotNull = 50032;
    const LoginUsernameMaxLength = 50033;
    const LoginPasswordMaxLength = 50034;

    const SystemError = 50000;

    const DefaultErrorCode = self::SystemError;

    const TRANS_FILE = 'error';


    /**
     * 获取错误码信息通过错误码
     * @param int $code  错误码
     * @param array $extra 其它信息
     */
    public static function getMessageByCode($code, $extra = []) {
        return trans(
            $code,
            $extra,
            self::TRANS_FILE
        );
    }
}