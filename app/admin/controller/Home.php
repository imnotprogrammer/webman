<?php


namespace App\admin\controller;


use App\Controller;

class Home extends Controller
{
    public function index() {
        return $this->success([
            'token' => 'adsdasddddddd'
        ]);
    }
}