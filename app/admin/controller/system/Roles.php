<?php

namespace App\admin\controller\system;

use App\Controller;

class Roles extends Controller
{
    /**
     * @name 角色列表
     * @isMenu true
     * @locale menu.system.roles
     * @icon icon-dashboard
     * @path roles
     * @slug roles
     * @parentSlug system
     * @return \support\Response
     */
    public function list() {
        return $this->success([
            'token' => 'adsdasddddddd'
        ]);
    }

    /**
     * @name 添加角色
     * @locale menu.system.role.add
     * @icon icon-dashboard
     * @slug role-add
     * @parentSlug roles
     * @return \support\Response
     */
    public function save() {
        return $this->success([
            'token' => 'adsdasddddddd'
        ]);
    }

    /**
     * @name 更新角色
     * @locale menu.system.role.update
     * @icon icon-dashboard
     * @slug role-update
     * @parentSlug roles
     * @return \support\Response
     */
    public function update() {
        return $this->success([
            'token' => 'adsdasddddddd'
        ]);
    }

    /**
     * @name 删除角色
     * @locale menu.system.role.delete
     * @icon icon-dashboard
     * @slug role-delete
     * @parentSlug roles
     * @return \support\Response
     */
    public function delete() {
        return $this->success([
            'token' => 'adsdasddddddd'
        ]);
    }
}