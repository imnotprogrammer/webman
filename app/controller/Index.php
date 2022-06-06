<?php

namespace app\controller;

use App\Controller;
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

        Redis::connection();

        session()->set('user_id', 123123);

        return response(config('app.runtime_path'));
    }

    public function view(Request $request)
    {
        return view('index/view', ['name' => 'webman']);
    }

    public function json(Request $request)
    {
        return json(['code' => 0, 'msg' => 'ok']);
    }

}
