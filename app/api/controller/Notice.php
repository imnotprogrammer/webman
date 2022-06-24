<?php

namespace App\api\controller;

use App\Controller;

class Notice extends Controller
{
    public function list() {
        return $this->success([
            'token' => '123456'
        ]);
    }

    public function read() {
        return $this->success([
            'token' => '123456'
        ]);
    }
}