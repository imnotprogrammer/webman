<?php


namespace App\service;


use app\constant\ApiError;
use app\exception\ApiException;
use app\model\User;

class UserService
{

    /**
     * @throws ApiException
     */
    public static function getUserById($userId) {
        $user = User::query()->find($userId);
        if (!$user) {
            throw new ApiException(ApiError::UserNotExisit);
        }

        return $user;
    }

    /**
     * @throws ApiException
     */
    public static function getUserByPhone($phone) {
        $user = User::query()->where('phone', $phone)->first();
        if (!$user) {
            throw new ApiException(ApiError::UserNotExisit);
        }

        return $user;
    }

    /**
     * 短信验证码登录
     * @param $phone
     * @param $smsCode
     * @param string $inviteCode
     */
    public static function loginSms($phone, $smsCode, $inviteCode = '') {

    }

    /**
     * @param $phone
     * @param $password
     * @return string
     * @throws ApiException
     */
    public static function loginPassword($phone, $password): string
    {
        $user = static::getUserByPhone($phone);

        if ($user->passwd !== md5(md5($password) . md5($user->salt))) {
            throw new ApiException(ApiError::UserPasswordOrPhoneError);
        }

        return Token::createToken($user->user_id, $user->first_name);
    }
}