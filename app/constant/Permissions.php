<?php


namespace App\constant;


class Permissions
{
    /** @var string 登录 */
    const PERMISSION_LOGIN = 'login';
    /** @var string 首页数据 */
    const PERMISSION_HOME = 'home';
    /** @var string 用户基本信息 */
    const PERMISSION_USER_INFO = 'personal-info';
    /** @var string 用户菜单 */
    const PERMISSION_USER_MENUS = 'user-menus';
    /** @var string 管理员列表 */
    const PERMISSION_ADMIN_LIST = 'user-list';
    /** @var string 管理员创建 */
    const PERMISSION_ADMIN_CREATE = 'user-create';
    /** @var string 管理员详情 */
    const PERMISSION_ADMIN_INFO = 'user-info';
    /** @var string 管理员更新 */
    const PERMISSION_ADMIN_UPDATE = 'user-update';
    /** @var string 删除管理员 */
    const PERMISSION_ADMIN_DELETE = 'user-delete';
    /** @var string 角色列表 */
    const PERMISSION_ROLE_LIST = 'role-list';
    /** @var string 角色添加 */
    const PERMISSION_ROLE_CREATE = 'role-create';
    /** @var string 角色更新 */
    const PERMISSION_ROLE_UPDATE = 'role-update';
    /** @var string 角色删除 */
    const PERMISSION_ROLE_DELETE = 'role-delete';
    /** @var string 角色信息 */
    const PERMISSION_ROLE_INFO = 'role-info';

    /** @var string 权限列表 */
    const PERMISSION_PERMISSION_LIST = 'permission-list';
    /** @var string 权限添加 */
    const PERMISSION_PERMISSION_CREATE = 'permission-create';
    /** @var string 权限更新 */
    const PERMISSION_PERMISSION_UPDATE = 'permission-update';
    /** @var string 权限删除 */
    const PERMISSION_PERMISSION_DELETE = 'permission-delete';
    /** @var string 权限信息 */
    const PERMISSION_PERMISSION_INFO = 'permission-info';
}