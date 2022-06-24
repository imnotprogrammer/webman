<?php

namespace App\admin\controller;

use App\admin\service\Menu;
use App\Controller;
use support\Request;

class Home extends Controller
{
    public function dashboard() {
        return $this->success([
            'token' => 'adsdasddddddd'
        ]);
    }

    public function menus(Request $request) {
        $userId = $request->get('userId', 1);
        
        return json(['code' => 0, 'msg' => 'ok', 'data' => Menu::getUserMenus($userId)], JSON_UNESCAPED_UNICODE|JSON_PRETTY_PRINT);
    }

    public function info(Request $request) {
        return $this->success([
            'name' => $request->user->name,
            'avatar' => '//lf1-xgcdn-tos.pstatp.com/obj/vcloud/vadmin/start.8e0e4855ee346a46ccff8ff3e24db27b.png',
            'permissions' => Menu::getUserPermissions($request->user->getAdminId()),
            'role' => ''
        ]);
    }
}