<?php


namespace App\api\controller;


use App\Controller;

class Login extends Controller
{
    public function login() {
        return $this->success([
            'token' => '123456'
        ]);
    }

    public function register() {
        return $this->success([
            'token' => '123456'
        ]);
    }
}