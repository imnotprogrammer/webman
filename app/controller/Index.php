<?php

namespace app\controller;

use App\admin\service\Menu;
use App\Controller;
use app\model\AdminPermission;
use app\model\AdminRole;
use app\model\AdminUser;
use support\Db;
use support\Redis;
use support\Request;

class Index extends Controller
{

    static $queues = [
        'sms',
        'order',
        'email'
    ];
    public function index(Request $request)
    {

        /*$i = 0;
        while ($i < 2) {
            $i++;
            $index = mt_rand(0, 2);
            send_message_to_queue(static::$queues[$index], [
                'event' => 'notice',
                'data' => [
                    'name' => 'user',
                    'age' => '12',
                    'content' => 'very good!!!!'
                ]
            ]);
        }*/


        Db::connection()->select('select 1');
        session()->set('user_id', 123123);

        return response(config('app.runtime_path'));
    }

    public function view(Request $request)
    {
        return view('index/view', ['name' => 'webman']);
    }

    public function json(Request $request)
    {
        $userId = $request->get('userId', 1);
        
        return json(['code' => 0, 'msg' => 'ok', 'data' => [
            'menu' => Menu::getUserMenus($userId),
            'permissions' => Menu::getUserPermissions($userId)
        ]], JSON_UNESCAPED_UNICODE|JSON_PRETTY_PRINT);
    }

    public function login() {
        return json(['code' => 0, 'msg' => 'ok']);
    }

}
