<?php

namespace App\admin\service;

use app\model\AdminPermission;
use app\model\AdminRole;
use app\model\AdminUser;
use Illuminate\Database\Eloquent\Collection;

class Menu {

     /**
      * 
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
      */
     private static function formatMenus($menus) {
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
      * 获取用户菜单
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

     public static function init() {

     }
}