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

    /** @var int 登录账户不能为空 */
    const LoginUsernameNotNull = 50035;

    /** @var int 登录密码不能为空 */
    const LoginPasswordNotNull = 50032;

    /** @var int 登录用户名达到最大长度 */
    const LoginUsernameMaxLength = 50033;

    /** @var int 登录密码达到最大长度 */
    const LoginPasswordMaxLength = 50034;

    /** @var int 用户已经存在 */
    const UserExisit = 50036;

    /** @var int 用户不存在 */
    const UserNotExisit = 50037;

    /** @var int 更新失败 */
    const UpdateFailed = 50038;

    /** @var int 保存成功 */
    const SaveFailed = 50039;

    /** @var int 系统错误 */
    const SystemError = 50000;

    /** @var int 默认返回错误码 */
    const DefaultErrorCode = self::SystemError;

    /** @var string 多语言文件 */
    const TRANS_FILE = 'error';


    /**
     * 获取错误码信息通过错误码
     * @param int $code  错误码
     * @param array $extra 其它信息
     */
    public static function getMessageByCode($code, $extra = []): ?string
    {
        return trans( $code, $extra, self::TRANS_FILE );
    }
}