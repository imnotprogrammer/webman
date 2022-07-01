<?php

namespace App\admin\controller;

use App\admin\service\Menu;
use App\Controller;
use support\Request;

/**
 * Class Home
 * @package App\admin\controller
 * @name 工作台
 * @isMenu true
 * @locale menu.dashboard
 * @icon icon-dashboard
 * @path /dashboard
 * @slug dashboard
 */
class Home extends Controller
{
    /**
     * @name 仪表盘
     * @isMenu true
     * @locale menu.dashboard.workplace
     * @icon icon-dashboard
     * @path Workplace
     * @slug workplace
     * @parentSlug dashboard
     * @return \support\Response
     */
    public function dashboard() {
        return $this->success([
            'token' => 'adsdasddddddd'
        ]);
    }

    /**
     * 菜单列表
     * @param Request $request
     * @skip true
     * @return \support\Response
     */
    public function menus(Request $request) {
        $userId = $request->user->getAdminId();

        return $this->success(Menu::getUserMenus($userId));
    }

    /**
     * @name 用户信息
     * @locale menu.user.info
     * @icon icon_search
     * @path /home/info
     * @slug personal-info
     * @parentSlug  dashboard
     * @param Request $request
     * @return \support\Response
     */
    public function info(Request $request) {

        return $this->success([
            'name' => $request->user->name,
            'avatar' => '//lf1-xgcdn-tos.pstatp.com/obj/vcloud/vadmin/start.8e0e4855ee346a46ccff8ff3e24db27b.png',
            'permissions' => Menu::getUserPermissions($request->user->getAdminId()),
            'role' => ''
        ]);
    }
}