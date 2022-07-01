<?php

namespace App\admin\controller\system;

use App\admin\service\Role;
use App\Controller;
use support\Request;

class Permissions extends Controller
{
    /**
     * @name 权限列表
     * @isMenu true
     * @locale menu.system.roles
     * @icon icon-dashboard
     * @path roles
     * @slug permission-list
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
     * @name 添加权限
     * @locale menu.system.role.add
     * @icon icon-dashboard
     * @slug permission-create
     * @parentSlug permission-list
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
     * @name 更新权限
     * @locale menu.system.role.update
     * @icon icon-dashboard
     * @slug permission-update
     * @parentSlug permission-list
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
     * @name 删除权限
     * @locale menu.system.role.delete
     * @icon icon-dashboard
     * @slug permission-delete
     * @parentSlug permission-list
     * @return \support\Response
     */
    public function delete() {
        return $this->success([
            'token' => 'adsdasddddddd'
        ]);
    }
}