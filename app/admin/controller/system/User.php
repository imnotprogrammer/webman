<?php

namespace App\admin\controller\system;

use App\Controller;

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
     * @path user
     * @slug user
     * @parentSlug system
     * @return \support\Response
     */
    public function list() {
        return $this->success([
            'token' => 'adsdasddddddd'
        ]);
    }

    /**
     * @name 添加用户
     * @locale menu.system.user.add
     * @icon icon-dashboard
     * @slug user-add
     * @parentSlug user
     * @return \support\Response
     */
    public function save() {
        return $this->success([
            'token' => 'adsdasddddddd'
        ]);
    }

    /**
     * @name 更新用户
     * @locale menu.system.user.update
     * @icon icon-dashboard
     * @slug user-update
     * @parentSlug user
     * @return \support\Response
     */
    public function update() {
        return $this->success([
            'token' => 'adsdasddddddd'
        ]);
    }

    /**
     * @name 删除用户
     * @locale menu.system.user.delete
     * @icon icon-dashboard
     * @slug user-delete
     * @parentSlug user
     * @return \support\Response
     */
    public function delete() {
        return $this->success([
            'token' => 'adsdasddddddd'
        ]);
    }
}