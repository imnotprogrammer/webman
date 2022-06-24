<?php

namespace App\api\controller;

use App\Controller;

class Captcha extends Controller
{
    public function sms() {
        return $this->success([
            'token' => '123456'
        ]);
    }
}