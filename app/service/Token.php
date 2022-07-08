<?php

namespace App\service;

use app\constant\Error;
use app\exception\CommonException;

class Token {
    /**
     * Token过期时间
     */
    const DEFAULT_EXPIRE_TIME = 500 * 3600;

    /**
     * Token 包含字段数
     */
    const TOKEN_LENGTH = 4;

    /**
     * @param int $userId 用户ID
     * @param string $username 用户名称
     * @return string
     */
    public static function createToken(int $userId, string $username): string
    {
        $currentTime = time();
        $expireAt = $currentTime + config('common.token.expireTime', self::DEFAULT_EXPIRE_TIME);
        $splitChar = config('common.token.splitCode', '-');
        $userBase = [
            $userId,
            $username,
            $expireAt
        ];

        $userInfoStr = implode($splitChar, $userBase);
        return sprintf('%s%s%s',
            $userInfoStr,
            $splitChar,
            hash_hmac('md5', $userInfoStr, config('common.token.signature'))
        );
    }

    /**
     * @param string  token 校验token是不是正确的
     * @return int
     * @throws CommonException
     */
    public static function checkToken($token): int
    {
        $data = explode(config('common.token.splitCode', '-'), $token);
        if (count($data) != self::TOKEN_LENGTH) {
            throw new CommonException(Error::SystemError);
        }

        list($userId, $userName, $expireAt, $signature) = $data;

        $info = implode(config('common.token.splitCode', '-'), [
             $userId, $userName, $expireAt
        ]);
        
        $trueSignature = hash_hmac('md5', $info, config('common.token.signature'));

        if (time() >= $expireAt) {
             throw new CommonException(Error::TokenExpired);
        }

        if ($trueSignature !== $signature) {
            throw new CommonException(Error::TokenValidateFailed);
        }

        return $userId;
    }

}