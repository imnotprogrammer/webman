<?php

namespace App\api\controller;

use App\Controller;

class Config extends Controller
{
    public function index() {
        return $this->success([
            'token' => '123456'
        ]);
    }
}