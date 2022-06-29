<?php


namespace App\admin\service;


use app\constant\Error;
use app\exception\AdminException;
use app\model\AdminUser;

class Admin
{
    /**
     * 重置管理员用户密码
     * @param string $password
     * @return string|null
     */
    public static function resetAdminPassword(string $password = ''): ?string
    {

        $salt = generate_random_string();
        if (!$password) {
            $password = generate_random_string(10);
        }

        $adminUser = AdminUser::findOrNew(AdminUser::DEFAULT_ADMIN_ID);

        $adminUser->name = AdminUser::DEFAULT_ADMIN_NAME;
        $adminUser->username = AdminUser::DEFAULT_ADMIN_USERNAME;
        $adminUser->password = static::createPassword($password, $salt);
        $adminUser->salt = $salt;
        $adminUser->save();

        return $password;
    }

    /**
     * 创建密码
     * @param $password
     * @param $salt
     * @return string
     */
    public static function createPassword($password, $salt): string
    {
        return md5(md5($password). $salt);
    }

    /**
     * 创建管理员
     * @param $username
     * @param $name
     * @param $password
     * @return bool
     * @throws AdminException
     */
    public static function createAdmin($username, $name, $password): bool
    {
        $user = AdminUser::where('username', $username)->first();
        if ($user) {
            throw new AdminException(Error::UserExisit);
        }

        $salt = generate_random_string();
        $password = static::createPassword($password, $salt);
        $user = new AdminUser([
            'username' => $username,
            'name' => $name,
            'password' => $password,
            'salt' => $salt
        ]);

        return $user->save();
    }

}