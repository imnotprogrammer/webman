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

    /** @var int 菜单名称不能为空 */
    const MenuNameNotNULL = 50040;
    /** @var int 菜单名称不能超过100个字符 */
    const MenuNameMaxLength = 50041;
    /** @var int 菜单标识不能为空 */
    const MenuSlugNotNull = 50042;
    /** @var int 菜单标识长度不能超过限制 */
    const MenuSlugMaxLength = 50043;
    /** @var int 菜单标识唯一 */
    const MenuSlugUniqiued = 50044;
    /** @var int 多语言key不能为空 */
    const MenuLocaleNotNUll = 50045;
    /** @var int 多语言key超过最大字符串长度 */
    const MenuLocaleMaxLength = 50046;
    /** @var int 多语言key超过最大字符串长度 */
    const MenuPermissionIdNotNULL = 50047;
    /** @var int 两次密码不一致 */
    const LoginPasswordConfirmError = 50048;

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