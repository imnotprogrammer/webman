<?php

namespace App\api\controller;

use App\Controller;

class Order extends Controller
{

    public function apply() {
        return $this->success([
            'token' => '123456'
        ]);
    }

    public function detail() {
        return $this->success([
            'token' => '123456'
        ]);
    }

    public function caluate() {
        
    }
}