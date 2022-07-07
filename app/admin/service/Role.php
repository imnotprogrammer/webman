<?php


namespace App\admin\service;


use App\constant\AdminPage;
use app\constant\Error;
use app\exception\AdminException;
use app\exception\CommonException;
use app\model\AdminRole;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class Role
{
    /**
     * 获取角色列表
     * @param array $search
     * @return \Illuminate\Contracts\Pagination\LengthAwarePaginator
     */
    public static function getList(array $search = []) {
        $perPage = $search['pageSize'] ?? AdminPage::PER_PAGE;
        $page = $search['page'] ?? AdminPage::DEFAULT_PAGE;
        $name = $search['name'] ?? '';

        $query = (new AdminRole())->query();

        $query->when($name, function ($query, $name) {
            $query->where('name', 'like', sprintf("%%%s%%", $name));
        });
        $query->with('permissions');

        return $query->paginate(
            $perPage,
            AdminPage::DEFAULT_COLOUMN,
            AdminPage::PAGE_NAME,
            $page
        );
    }

    /**
     * 获取角色所有权限
     * @param $roleId
     * @return bool|Collection
     */
    public static function getRoleById($roleId)
    {
        if (!$roleId) {
            return false;
        }

        $role = AdminRole::find($roleId);

        if (!$role) {
            return false;
        }

        return $role;
    }

    /**
     * 根据角色标识获取权限列表
     * @param $slug
     * @return mixed
     */
    public static function getRoleBySlug($slug) {
        if (!$slug) {
            return false;
        }

        $role = AdminRole::query()->where('slug', $slug)->first();

        if (!$role) {
            return false;
        }

        return $role;
    }

    /**
     * 创建角色
     * @param $name
     * @param $slug
     * @param array $permissionIds
     * @return AdminRole
     * @throws AdminException
     */
    public static function createRole($name, $slug, array $permissionIds = []): AdminRole
    {
        if (!$name || !$slug) {
            throw new AdminException(1);
        }

        /** @var AdminRole $role */
        $role = static::getRoleBySlug($slug);
        if ($role) {
            throw new AdminException(Error::RoleNotFound);
        }

        $role = new AdminRole();
        $role->name = $name;
        $role->slug = $slug;

        $permissionIds = array_unique(array_filter($permissionIds, function ($value) {
            return !empty($value);
        }));

        if ($role->save() && $permissionIds) {
            $createTime = time();
            $role->permissions()->attach($permissionIds, [
                'create_time' => $createTime,
                'update_time' => $createTime
            ]);
        }

        return $role;
    }

    /**
     * 更新角色
     * @param $roleId
     * @param $name
     * @param array $permissionIds
     * @return AdminRole
     * @throws AdminException
     */
    public static function updateRole($roleId, $name, array $permissionIds = []): AdminRole
    {
        if (!$name) {
            throw new AdminException(Error::RoleNameNotNull);
        }

        if (!$roleId) {
            throw new AdminException(Error::RoleIdNotNull);
        }

        /** @var AdminRole $role */
        $role = static::getRoleById($roleId);
        if (!$role) {
            throw new AdminException(Error::RoleNotFound);
        }

        $role->name = $name;

        $permissionIds = array_unique(array_filter($permissionIds, function ($value) {
            return !empty($value);
        }));

        if ($role->save() && $permissionIds) {
            $role->permissions()->sync($permissionIds);
        }

        return $role;
    }


    /**
     * 删除角色(支持单个，批量)
     * @param $roleIds
     * @return mixed|string[]
     * @throws \Exception
     */
    public static function deleteRoles($roleIds) {
        if (is_string($roleIds)) {
            $roleIds = [$roleIds];
        }
        try {
            DB::beginTransaction();
            $roleList = AdminRole::query()
                ->whereIn('role_id', $roleIds)
                ->get();

            /** @var AdminRole $role */
            foreach ($roleList as $role) {
                $role->permissions()->delete();
                $role->delete();
            }

            DB::commit();
        } catch (\Exception $ex) {
            DB::rollBack();
            throw $ex;
        }

        return $roleIds;

    }

    /**
     * 格式角色信息
     * @param AdminRole $role
     * @return array
     */
    public static function formatRole(AdminRole $role): array
    {
        $result = [
            'roleId' => $role->role_id,
            'name' => $role->name,
            'slug' => $role->slug,
            'createTime' => $role->create_time,
            'permissions' => []
        ];

        if ($role->permissions) {
            foreach ($role->permissions as $permission) {
                $result['permissions'][] = [
                    'name' => $permission->name,
                    'slug' => $permission->slug,
                ];
            }

        }

        return $result;
    }

    /**
     * @param $collection
     * @return array
     */
    public static function formatRoles($collection) {
        $result = [];
        foreach ($collection as $col) {
            $result[] = static::formatRole($col);
        }
        return $result;
    }
}