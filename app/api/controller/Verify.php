<?php

namespace App\api\controller;

use App\Controller;

class Verify extends Controller
{
    public function stepOne() {
        return $this->success([
            'token' => '123456'
        ]);
    }

    public function stepTwo() {
        return $this->success([
            'token' => '123456'
        ]);
    }

    public function stepThree() {
        return $this->success([
            'token' => '123456'
        ]);
    }

    public function stepFour() {
        return $this->success([
            'token' => '123456'
        ]);
    }

    public function live() {
        
    }
}