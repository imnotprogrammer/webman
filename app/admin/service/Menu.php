<?php

namespace App\admin\service;

use app\constant\Error;
use app\exception\AdminException;
use app\exception\CommonException;
use app\model\AdminPermission;
use app\model\AdminUser;
use App\utils\ParseDocument;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;

class Menu {

    /** @var int 默认排序 */
    const DEFAULT_ORDER = 255;

    /** @var array 标识集合 */
    static $slug = [];

    /**
     * 获取用户菜单列表
     * @param int $adminId
     * @return array|mixed
     */
     public static function getUserMenus(int $adminId = AdminUser::DEFAULT_ADMIN_ID) {
         $menus = AdminPermission::menuNodes();
         $menus = self::formatMenus($menus); 
         if ($adminId == AdminUser::DEFAULT_ADMIN_ID) {
             return $menus;
         }

         $userPermissions = static::getUserPermissions($adminId)->toArray();

         foreach ($menus as $key => $menu) {
              if (!in_array($menu['name'], $userPermissions)) {
                  unset($menus[$key]);
                  continue;
              }

              foreach ($menu['children'] as $index => $children) {
                  if (!in_array($children['name'], $userPermissions)) {
                       unset($menus[$key]['children'][$index]);
                  }
              }

              if (!count($menus[$key]['children'])) {
                  unset($menus[$key]);
              }
         }

         return $menus;
     }

     /**
      * 格式化菜单
      * @param $menus
      * @return mixed
      */
     private static function formatMenus($menus)
     {
         $result = [];
         foreach ($menus as $menu) {
             $temp = [
                 'name' => $menu['slug'],
                 'meta' => [
                     'icon' => $menu['icon'],
                     'requiresAuth' => true,
                     'locale' => $menu['locale'],
                 ],
             ];

             if (count($menu->children) > 0) {
                 $temp['children'] = static::formatMenus($menu->children);
             }

             $result[] = $temp;
         }
         return $result;
     }

    /**
     * 获取用户权限
     * @param int $adminId
     * @return mixed
     */
     public static function getUserPermissions(int $adminId) {
          if ($adminId == AdminUser::DEFAULT_ADMIN_ID) {
               return AdminPermission::get()->pluck('slug');
          }

          return AdminUser::find($adminId)
               ->roles()
               ->with('permissions')
               ->get()
               ->pluck('permissions')
               ->collapse()
               ->pluck('slug');
     }

    /**
     * 初始化后台系统菜单
     * @return mixed
     */
     public static function init($isClear = false)
     {
         $doMenuAction = new ParseDocument([app_path() .DIRECTORY_SEPARATOR . 'admin/controller']);
         $result = $doMenuAction->setStdout(true)->lookup()->getResult();

         foreach ($result as $key => &$value) {
             if ($value['parentSlug'] && !$value['isMenu']) {
                 static::findParent($result, $value);
                 unset($result[$key]);
             }
         }

         foreach ($result as $key=> &$value) {
             if ($value['parentSlug'] && $value['isMenu']) {
                 static::findParent($result, $value);
                 unset($result[$key]);
             }
         }

         static::$slug = [];
         if ($isClear) {
             AdminPermission::truncate();
         }

         static::saveMenuTreeToDatabase($result);
         static::$slug = [];

         return $result;
     }

    /**
     * 对遍历菜单进行入库操作
     * @param $result
     * @param int $parentId
     */
     public static function saveMenuTreeToDatabase($result, $parentId = 0) {
         foreach ($result as $parent) {
             if (in_array($parent['slug'], static::$slug)) {
                 continue;
             }

             if (!$parentId && $parent['isMenu']) {
                 echo '['.$parent['name'] .']('. $parent['slug'] .')|'.PHP_EOL;
             } else if ($parentId && $parent['isMenu']) {
                 echo '|----['.$parent['name'] .']('. $parent['slug'] .')|'. PHP_EOL;
             } else {
                 echo '|--------['.$parent['name'] .']('. $parent['slug'] . ')|' . PHP_EOL;
             }


             try {
                 $menu = static::addMenuExisitUpdate(array_merge($parent, ['parentId' => $parentId]));
             } catch (AdminException $ex) {

             }

             static::$slug[] = $parent['slug'];
             if (isset($parent['children'])) {
                 static::saveMenuTreeToDatabase($parent['children'], $menu->permission_id);
             }
         }
     }

    /**
     * 权限|菜单找父亲
     * @param $parents
     * @param $who
     */
     public static function findParent(&$parents, $who) {
         foreach ($parents as &$parent) {
             if ($parent['slug'] == $who['parentSlug']) {
                 $parent['children'][] = $who;
                 break;
             }
         }
     }

    /**
     * 获取所有菜单
     * @return mixed
     */
    public static function getMenus() {
        return AdminPermission::allNodes();
    }

    /**
     * @param $params
     * @return AdminPermission|\Illuminate\Database\Eloquent\Builder|Model|object
     * @throws AdminException
     */
    public static function addMenuExisitUpdate($params) {
        $menu = AdminPermission::where('slug', $params['slug'])->first();
        if ($menu) {
            $menu->name = $params['name'];
            $menu->icon = $params['icon'];
            $menu->locale = $params['locale'];
            $menu->path = $params['path'];
            $menu->order = $params['order'] ?? $menu->order;
            $menu->parent_id = $params['parentId'] ?? $menu->order;
            $menu->is_menu = $params['isMenu'] ? AdminPermission::MENU_YES : AdminPermission::MENU_NO;
        } else {
            $menu = new AdminPermission([
                'name' => $params['name'],
                'slug' => $params['slug'],
                'locale' => $params['locale'],
                'icon' => $params['icon'],
                'path' => $params['path'],
                'order' => $params['order'] ?: self::DEFAULT_ORDER,
                'parent_id' => $params['parentId'] ?: 0,
                'is_menu' => $params['isMenu'] ? AdminPermission::MENU_YES : AdminPermission::MENU_NO
            ]);
        }

        $menu->save();
        return $menu;
    }

    /**
     * 添加菜单或权限
     * @param $params
     * @return AdminPermission|false
     * @throws AdminException
     */
    public static function addMenu($params) {
        $isExist = AdminPermission::where('slug', $params['slug'])->first();
        if ($isExist) {
            throw new AdminException(Error::MenuSlugHasExisited, ['slug' => $params['slug']]);
        }

        $menu = new AdminPermission([
            'name' => $params['name'],
            'slug' => $params['slug'],
            'locale' => $params['locale'],
            'icon' => $params['icon'],
            'path' => $params['path'],
            'order' => $params['order'] ?: self::DEFAULT_ORDER,
            'parent_id' => $params['parentId'] ?: 0,
            'is_menu' => $params['isMenu'] ? AdminPermission::MENU_YES : AdminPermission::MENU_NO
        ]);

        if ($menu->save()) {
            return $menu;
        }

        throw new AdminException(Error::SaveFailed);

    }

    /**
     * 更新菜单
     * @param $menuId
     * @param $data
     * @return AdminPermission|AdminPermission[]|false|Collection|Model
     */
    public static function updateMenu($menuId, $data) {
        $menu = AdminPermission::find($menuId);
        if (!$menu) {
            throw new AdminException(Error::MenuNotFound);
        }

        $menu->name = $data['name'];
        $menu->icon = $data['icon'];
        $menu->locale = $data['locale'];
        $menu->path = $data['path'];
        $menu->order = $data['order'] ?? $menu->order;
        $menu->parent_id = $data['parentId'] ?? $menu->order;
        $menu->is_menu = $data['isMenu'] ? AdminPermission::MENU_YES : AdminPermission::MENU_NO;
        $menu->slug = $data['slug'] ?? $menu->slug;

        $menu->save();

        return $menu;

    }

    /**
     * 格式化菜单
     * @param AdminPermission $permission
     * @return array
     */
    public static function formatBaseMenu(AdminPermission $permission): array
    {
        $result = [
            'permissionId' => $permission->permission_id,
            'name' => $permission->name,
            'icon' => $permission->icon,
            'slug' => $permission->slug,
            'locale' => $permission->locale,
            'path' => $permission->path,
            'order' => $permission->order,
            'parentId' => $permission->parent_id,
            'isMenu' => $permission->is_menu
        ];

        $allChildren = $permission->allChildren;
        if (count($allChildren) > 0) {
            foreach ($allChildren as $child) {
                $result['children'][] = static::formatBaseMenu($child);
            }
        }
        return $result;
    }

    /**
     * 格式化菜单实体
     * @param $list
     * @return array
     */
    public static function formatMenusEntity($list): array
    {
        $result = [];
        foreach ($list as $menu) {
            $result[] = static::formatBaseMenu($menu);
        }

        return $result;
    }

    /**
     * 删除菜单/权限
     * @param $menuIds
     * @return false
     * @throws AdminException
     */
    public static function deleteMenu($menuIds): bool
    {
        $menuIds = array_unique(array_filter($menuIds));

        if (!$menuIds) {
            throw new AdminException(Error::MenuDeleteNotNull);
        }

        return (bool)AdminPermission::query()
            ->whereIn('permission_id', $menuIds)
            ->delete();
    }
}