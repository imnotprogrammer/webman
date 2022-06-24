<?php

namespace App\admin\service;

use app\constant\Error;
use app\exception\AdminException;

class Token {
    const DEFAULT_EXPIRE_TIME = 5 * 3600;

    const TOKEN_LENGTH = 4;
    /**
     * 生成token;
     */
    public static function createToken($userId, $username) {
        $currentTime = time();
        $expireAt = $currentTime + config('common.token.expireTime', self::DEFAULT_EXPIRE_TIME);
        $splitChar = config('common.token.splitCode', '-');
        $userBase = [
            $userId,
            $username,
            $expireAt
        ];

        $userInfoStr = implode($splitChar, $userBase);
        return sprintf('%s%s%s', $userInfoStr, $splitChar, hash_hmac('md5', $userInfoStr, config('common.token.signature')));
    }

    /**
     * @param string  token 校验token是不是正确的
     */
    public static function checkToken($token) {
        $data = explode(config('common.token.splitCode', '-'), $token);
        if (count($data) != self::TOKEN_LENGTH) {
            throw new AdminException(Error::SystemError);
        }

        list($userId, $userName, $expireAt, $signature) = $data;

        $info = implode(config('common.token.splitCode', '-'), [
             $userId, $userName, $expireAt
        ]);
        
        $trueSignature = hash_hmac('md5', $info, config('common.token.signature'));

        if (time() >= $expireAt) {
             throw new AdminException(Error::TokenExpired);
        }

        if ($trueSignature !== $signature) {
            throw new AdminException(Error::TokenValidateFailed);
        }

        return $userId;
    }

}