<?php


namespace App\controller;


use App\Controller;
use support\Redis;
use support\Request;

class Template extends Controller
{
    public function list(Request $request) {
        Redis::connection('default')->set('testt',12312312);
        return json(\app\model\Template::get());
    }

    /**
     * @param Request $request
     * @return \support\Response
     */
    public function store(Request $request) {
        $template = new \app\model\Template();
        $template->name = $request->post('name');
        $template->vars = $request->post('vars');
        $template->path = $request->post('path');


        if ($template->save()) {
            return $this->success($template);
        } else {
            return $this->failed();
        }
    }
}