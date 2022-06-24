<?php

namespace App\api\controller;

use App\Controller;

class Repay extends Controller
{

    public function getRepayMethodList() {
        return $this->success([
            'token' => '123456'
        ]);
    }

    public function repay() {
        return $this->success([
            'token' => '123456'
        ]);
    }
}