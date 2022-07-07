<?php

namespace App\admin\controller\system;

use App\admin\service\Admin;
use App\admin\service\Role;
use App\Controller;
use app\model\AdminRole;
use support\Request;

class Roles extends Controller
{
    /**
     * @name 角色列表
     * @isMenu true
     * @locale menu.system.roles
     * @icon icon-dashboard
     * @path roles
     * @slug role-list
     * @parentSlug system
     * @return \support\Response
     */
    public function list() {
        $list = Role::getList(request()->all());

        return $this->success([
            'list' => Role::formatRoles($list),
            'total' => $list->total(),
            'pageSize' => $list->perPage(),
            'page' => $list->currentPage(),
        ]);
    }

    /**
     * @name 添加角色
     * @locale menu.system.role.add
     * @icon icon-dashboard
     * @slug role-create
     * @parentSlug role-list
     * @return \support\Response
     */
    public function save(Request $request) {
        $name = $request->post('name');
        $slug = $request->post('slug');
        $permissionIds = $request->post('permissionIds');

        $role = Role::createRole($name, $slug, explode(',', $permissionIds));;

        return $this->success(Role::formatRole($role));
    }

    /**
     * @name 更新角色
     * @locale menu.system.role.update
     * @icon icon-dashboard
     * @slug role-update
     * @parentSlug role-list
     * @return \support\Response
     * @throws \app\exception\AdminException
     */
    public function update(Request $request) {
        $roleId = $request->post('roleId');
        $name = $request->post('name');
        $permissionIds = $request->post('permissionIds');

        return $this->success(Role::formatRole(Role::updateRole($roleId, $name, explode(',', $permissionIds))));
    }

    /**
     * @name 删除角色
     * @locale menu.system.role.delete
     * @icon icon-dashboard
     * @slug role-delete
     * @parentSlug role-list
     * @return \support\Response
     */
    public function delete(Request $request) {
        $roleIds = explode(',', $request->post('roleIds'));
        Role::deleteRoles($roleIds);
        return $this->success();
    }

    /**
     * @name 角色信息
     * @locale menu.system.role.info
     * @icon icon-dashboard
     * @slug role-info
     * @parentSlug role-list
     * @return \support\Response
     */
    public function info(Request $request) {
        $roleId = $request->get('roleId');
        $role = AdminRole::find($roleId);

        return $this->success($role ? Role::formatRole($role) : []);
    }
}