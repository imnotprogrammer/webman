<?php

namespace App\admin\controller\system;

use App\Controller;

class Menu extends Controller
{
    /**
     * @name 菜单列表
     * @isMenu true
     * @locale menu.system.menus
     * @icon icon-dashboard
     * @path menus
     * @slug menus
     * @parentSlug system
     * @return \support\Response
     */
    public function list() {
        return $this->success([
            'token' => 'adsdasddddddd'
        ]);
    }

    /**
     * @name 添加菜单
     * @locale menu.system.menu.add
     * @icon icon-dashboard
     * @slug menu-add
     * @parentSlug menus
     * @return \support\Response
     */
    public function save() {
        return $this->success([
            'token' => 'adsdasddddddd'
        ]);
    }

    /**
     * @name 更新菜单
     * @locale menu.system.menu.update
     * @icon icon-dashboard
     * @slug menu-update
     * @parentSlug menus
     * @return \support\Response
     */
    public function update() {
        return $this->success([
            'token' => 'adsdasddddddd'
        ]);
    }

    /**
     * @name 删除菜单
     * @locale menu.system.menu.delete
     * @icon icon-dashboard
     * @slug menu-delete
     * @parentSlug menus
     * @return \support\Response
     */
    public function delete() {
        return $this->success([
            'token' => 'adsdasddddddd'
        ]);
    }
}