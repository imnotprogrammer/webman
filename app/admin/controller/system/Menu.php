<?php

namespace App\admin\controller\system;

use App\Controller;
use app\exception\AdminException;
use app\exception\CommonException;
use App\model\AdminPermission;
use App\validate\MenuValidate;
use support\Request;
use App\admin\service\Menu as MenuService;

class Menu extends Controller
{
    /**
     * @name 菜单列表
     * @isMenu true
     * @locale menu.system.permissions
     * @icon icon-dashboard
     * @path roles
     * @slug permission-list
     * @parentSlug system
     * @return \support\Response
     */
    public function list() {
        $list = MenuService::getMenus();
        return $this->success([
            'list' => MenuService::formatMenusEntity($list),
        ]);
    }

    /**
     * @name 添加菜单
     * @locale menu.system.permission.add
     * @icon icon-dashboard
     * @slug permission-create
     * @parentSlug permission-list
     * @return \support\Response
     * @throws AdminException
     */
    public function save(Request $request) {
        $data = $request->all();
        $check = (new MenuValidate())->scene('addMenu');
        if (!$check->check($data)) {
            throw new AdminException($check->getError());
        }
        $menu = MenuService::addMenu($data);
        return $this->success(MenuService::formatBaseMenu($menu));
    }

    /**
     * @name 更新菜单
     * @locale menu.system.permission.update
     * @icon icon-dashboard
     * @slug permission-update
     * @parentSlug permission-list
     * @return \support\Response
     * @throws \app\exception\AdminException
     */
    public function update(Request $request) {
        $menuId = $request->post('permissionId');
        $data = $request->post();
        unset($data['slug']);
        $check = (new MenuValidate())->scene('editMenu');
        if (!$check->check($data)) {
            throw new AdminException($check->getError());
        }
        $menu = MenuService::updateMenu($menuId, $data);
        return $this->success(MenuService::formatBaseMenu($menu));
    }

    /**
     * @name 删除菜单
     * @locale menu.system.permission.delete
     * @icon icon-dashboard
     * @slug permission-delete
     * @parentSlug permission-list
     * @return \support\Response
     */
    public function delete(Request $request) {
        $permissionIds = $request->post('permissionIds');
        $menuIds = explode(',', $permissionIds);
        MenuService::deleteMenu($menuIds);
        return $this->success();
    }

    /**
     * @name 菜单信息
     * @locale menu.system.permission.info
     * @icon icon-dashboard
     * @slug permission-info
     * @parentSlug permission-list
     * @return \support\Response
     */
    public function info(Request $request) {
        $permissionId = $request->get('permissionId');

        $menu = AdminPermission::find($permissionId);
        $menu = $menu ? MenuService::formatBaseMenu($menu) : [];

        return $this->success($menu);
    }
}