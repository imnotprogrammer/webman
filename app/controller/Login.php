<?php


namespace App\controller;


class Login
{
    public function index() {
        return json([
            'code' => 0,
            'msg' => '',
            'data' => [
                'token' => 'asdasdsssssssssssssssssssssss'
            ]
        ]);
    }
}