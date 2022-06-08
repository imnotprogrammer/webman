<?php

namespace app\controller;

use App\Controller;
use App\validate\InstallValidate;
use support\Request;

class Install extends Controller
{
    public function base(Request $request, InstallValidate $installValidate)
    {

        if (!$installValidate->scene('base')->check($request->all())) {
            return $this->failed($installValidate->getError());
        }

        $name = $request->post('appName', 'app');
        $locale = $request->post('locale', 'zh_CN');
        $timezone = $request->post('timezone', 'Asia/Shanghai');

        $installUtils = new \App\utils\Install();
        $installUtils->writeBase($name, $timezone, $locale);


        return $this->success();
    }

    public function saveDatabase(Request $request, InstallValidate $validate)
    {
        if (!$validate->scene('database')->check($request->all())) {
            return $this->failed($validate->getError());
        }

        $databaseHost = $request->post('databaseHost', '');
        $databaseName = $request->post('databaseName', '');
        $databasePort = $request->post('databasePort', '3306');
        $databaseUser = $request->post('databaseUser', '');
        $databasePassword = $request->post('databasePassword', '');

        $installUtils = new \App\utils\Install();
        $installUtils->writeDatabase($databaseHost, $databaseName, $databasePort, $databaseUser, $databasePassword);

        return $this->success();
    }

    public function saveRedis(Request $request, InstallValidate $validate)
    {

        if (!$validate->scene('redis')->check($request->all())) {
            return $this->failed($validate->getError());
        }

        $redisHost = $request->post('redisHost', '');
        $redisPort = $request->post('redisPort', '6379');
        $redisAuth = $request->post('redisAuth', '');

        $installUtils = new \App\utils\Install();
        $installUtils->writeRedis($redisHost, $redisPort, $redisAuth);

        return $this->success();
    }

    public function install(): \support\Response
    {
        $installUtils = new \App\utils\Install();
        if (!$installUtils->canInstall()) {
            return $this->failed('不能初始化数据,请填写相关配置');
        }
        return $this->success();
    }
}
