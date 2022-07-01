<?php


namespace App\admin\service;


use App\constant\AdminPage;
use app\constant\Error;
use app\exception\AdminException;
use app\model\AdminUser;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;

class Admin
{
    /**
     * 重置管理员用户密码
     * @param string $password
     * @param string $username
     * @return string|null
     * @throws AdminException
     */
    public static function resetAdminPassword(string $username, string $password = ''): ?string
    {
        $salt = generate_random_string();
        if (!$password) {
            $password = generate_random_string(10);
        }

        $adminUser = AdminUser::where('username', $username)->first();

        if (!$adminUser) {
            throw new AdminException(Error::UserNotExisit);
        }

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
     * @return AdminUser
     * @throws AdminException
     */
    public static function createAdmin($username, $name, $password)
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

        $user->save();

        return $user;
    }

    /**
     * @param $adminId
     * @return mixed
     */
    public static function deleteAdmin($adminId) {
        return AdminUser::where('admin_id', $adminId)->delete();
    }

    /**
     * @param $adminId
     * @param $username
     * @param $name
     * @param $avatar
     */
    public static function updateAdmin($adminId, $name, $avatar) {

        if ($adminId == AdminUser::DEFAULT_ADMIN_ID) {
            return false;
        }

        $admin = AdminUser::query()->find($adminId);

        if (!$admin) {
            return false;
        }

        $admin->name = $name;
        $admin->avatar = $avatar;

        return $admin->save();
    }

    /**
     * 获取管理员列表
     * @param array $search
     * @return LengthAwarePaginator
     */
    public static function getAdminUserList(array $search = []): LengthAwarePaginator
    {

        $perPage = $search['pageSize'] ?? AdminPage::PER_PAGE;
        $page = $search['page'] ?? AdminPage::DEFAULT_PAGE;
        $name = $search['name'] ?? '';

        $query = (new AdminUser())->query();

        $query->when($name, function ($query, $name) {
            $query->where('name', 'like', sprintf("%%%s%%", $name));
        });

        return $query->paginate(
            $perPage,
            AdminPage::DEFAULT_COLOUMN,
            AdminPage::PAGE_NAME,
            $page
        );
    }

    /**
     * @param $userId
     * @return array
     */
    public static function getAdminUserById($userId)
    {
        $admin = AdminUser::find($userId);

        if (!$admin) {
            return [];
        }

        return $admin;
    }

    /**
     * @param AdminUser $admin
     * @return array
     */
    public static function formAdminBase(AdminUser $admin): array
    {
        return [
            'adminId' => $admin->getAdminId(),
            'name' => $admin->name,
            'username' => $admin->username,
            'avatar' => $admin->getAvatar(),
            'createTime' => $admin->create_time
        ];
    }

}