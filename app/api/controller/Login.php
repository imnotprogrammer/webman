<?php

namespace App\api\controller;

use App\Controller;
use App\service\UserService;
use support\Request;

class Login extends Controller
{
    public function sms() {
        return $this->success([
            'token' => '123456'
        ]);
    }

    /**
     * @param Request $request
     * @return \support\Response
     * @throws \app\exception\ApiException
     */
    public function password(Request $request) {
        $phone = $request->post('phone');
        $password = $request->post('password');

        $token = UserService::loginPassword($phone, $password);
        return $this->success([
            'token' => $token
        ]);
    }
}