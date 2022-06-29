<?php

namespace App\admin\service;

use app\model\AdminPermission;
use app\model\AdminRole;
use app\model\AdminUser;
use App\utils\ParseDocument;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;

class Menu {

    /**
     * 获取用户菜单列表
     * @param int $adminId
     * @return array|mixed
     */
     public static function getUserMenus(int $adminId = AdminUser::DEFAULT_ADMIN_ID) {
         $menus = AdminPermission::allNodes()->toArray();
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
      * 菜单最多二级
      * @param $menus
      * @return mixed
      */
     private static function formatMenus($menus)
     {
          foreach ($menus as &$menu) {
              $menu['meta'] = [
                  'icon' => $menu['icon'],
                  'requiresAuth' => true,
                  'locale' => $menu['locale'],
              ];
              $menu['name'] = $menu['slug'];

              foreach ($menu['children'] as &$children) {
                   $children['meta'] = [
                        'icon' => $menu['icon'],
                        'requiresAuth' => true,
                        'locale' => $children['locale'],
                    ];

                    $children['name'] = $children['slug'];
                    unset($children['permission_id']);
                    unset($children['order']);
                    unset($children['parent_id']);
                    unset($children['is_menu']);
                    unset($children['icon']);
                    unset($children['locale']);
                    unset($children['slug']);
                    unset($children['children']);
                    unset($children['update_time']);
                    unset($children['delete_time']);
                    unset($children['create_time']);
              }

              unset($menu['permission_id']);
              unset($menu['order']);
              unset($menu['parent_id']);
              unset($menu['is_menu']);
              unset($menu['locale']);
              unset($menu['icon']);
              unset($menu['slug']);
              unset($menu['update_time']);
              unset($menu['delete_time']);
              unset($menu['create_time']);
          }

          return $menus;
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
     public static function init()
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
         AdminPermission::truncate();
         static::saveMenuTreeToDatabase($result);
         static::$slug = [];

         return $result;
     }

     static $slug = [];

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

             $menu = new AdminPermission([
                 'name' => $parent['name'],
                 'slug' => $parent['slug'],
                 'locale' => $parent['locale'],
                 'icon' => $parent['icon'],
                 'path' => $parent['path'],
                 'order' => $parent['order'] ?? 255,
                 'parent_id' => $parentId,
                 'is_menu' => $parent['isMenu'] ? 1 : 0
             ]);
             static::$slug[] = $parent['slug'];
             if ($menu->save() && isset($parent['children'])) {
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
}