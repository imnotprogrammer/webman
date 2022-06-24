<?php

namespace App\api\controller;

use App\Controller;
class Login extends Controller
{
    public function sms() {
        return $this->success([
            'token' => '123456'
        ]);
    }

    public function password() {
        return $this->success([
            'token' => '123456'
        ]);
    }
}