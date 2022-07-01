<?php

namespace App\admin\controller\system;

use App\admin\service\Admin;
use app\constant\Error;
use App\Controller;
use app\exception\AdminException;
use App\validate\AdminLogin;

/**
 * Class User
 * @package App\admin\controller\system
 * @name 用户管理
 * @isMenu true
 * @locale menu.system
 * @icon icon-dashboard
 * @path /system
 * @slug system
 */
class User extends Controller
{
    /**
     * @name 用户列表
     * @isMenu true
     * @locale menu.system.user
     * @icon icon-dashboard
     * @path /system/users
     * @slug user-list
     * @parentSlug system
     * @return \support\Response
     */
    public function list(): \support\Response
    {
        $list = Admin::getAdminUserList(request()->all());

        return $this->success([
            'list' => $this->formatItem($list->items()),
            'total' => $list->total(),
            'pageSize' => $list->perPage(),
            'page' => $list->currentPage(),
        ]);
    }

    /**
     * @param $items
     * @return array
     */
    private function formatItem($items): array
    {
        $result = [];
        foreach ($items as $item) {
            $result[] = Admin::formAdminBase($item);
        }
        return $result;
    }

    /**
     * @name 添加用户
     * @locale menu.system.user.add
     * @icon icon-dashboard
     * @slug user-create
     * @parentSlug user-list
     * @return \support\Response
     * @throws AdminException
     */
    public function save() {
        $params = request()->all();
        $validate = new AdminLogin();
        if (!$validate->scene('addUser')->check($params)) {
            throw new AdminException($validate->getError());
        }

        $admin = Admin::createAdmin(
            $params['username'],
            $params['name'],
            $params['password']
        );

        return $this->success(Admin::formAdminBase($admin));
    }

    /**
     * @name 更新用户
     * @locale menu.system.user.update
     * @icon icon-dashboard
     * @slug user-update
     * @parentSlug user-list
     * @return \support\Response
     * @throws AdminException
     */
    public function update() {
        $validate = new AdminLogin();

        if (!$validate->scene('editUser')->check(request()->all())) {
            throw new AdminException($validate->getError());
        }

        if (Admin::updateAdmin(
            request()->post('adminId'),
            request()->post('name'),
            request()->post('avatar')
        )) {
            return $this->success();
        } else {
            throw new AdminException(Error::UpdateFailed);
        }

    }

    /**
     * @name 删除用户
     * @locale menu.system.user.delete
     * @icon icon-dashboard
     * @slug user-delete
     * @parentSlug user-list
     * @return \support\Response
     */
    public function delete() {
        return $this->success([
            'token' => 'adsdasddddddd'
        ]);
    }

    /**
     * @name 用户信息
     * @locale menu.system.user.info
     * @icon icon-dashboard
     * @slug user-info
     * @parentSlug user-list
     * @return \support\Response
     */
    public function info() {
        $userId = request()->get('userId', request()->user->getAdminId());
        return $this->success(Admin::formAdminBase(Admin::getAdminUserById($userId)));
    }
}