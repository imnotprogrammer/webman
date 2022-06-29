<?php

namespace app\controller;

use App\Controller;
use App\validate\InstallValidate;
use support\Request;

class Install extends Controller
{
    public function init() {}
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

    public function saveDatabase(Request $request)
    {
        $databaseHost = $request->post('host', '');
        $databaseName = $request->post('name', '');
        $databasePort = $request->post('port', '3306');
        $databaseUser = $request->post('user', '');
        $databasePassword = $request->post('password', '');

        $validate = new InstallValidate();
        if (!$validate->scene('database')->check([
            'databaseHost' => $databaseHost,
            'databaseName' => $databaseName,
            'databasePort' => $databasePort,
            'databaseUser' => $databaseUser,
            'databasePassword' => $databasePassword,
        ])) {
            return $this->failed($validate->getError());
        }

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

    public function write() {
        $array = [
            '12312' => '2131',
            'wqeqw' => 'sadasd',
            'wqeqwewqe' => 'sadadas'
        ];
        file_put_contents(runtime_path() . DIRECTORY_SEPARATOR . '/1.log', json_encode($array).PHP_EOL, FILE_APPEND);
        return $this->success();
    }
}
