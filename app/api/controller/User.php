<?php

namespace App\api\controller;

use App\Controller;

class User extends Controller
{
    public function setPassword() {
        return $this->success([
            'token' => '123456'
        ]);
    }

    public function coupons() {
        return $this->success([
            [
                'couponId' => 1,
                'title' => 'sadasdas',
                'desc' => 'sadasdsa',
                'amount' => 121321,
                'expireDate' => '2022-09-21',
                'isExpired' => 1,
            ],
            [
                'couponId' => 2,
                'title' => 'sadasdas',
                'desc' => 'sadasdsa',
                'amount' => 121321,
                'expireDate' => '2022-09-21',
                'isExpired' => 1,
            ]
        ]);
    }

    public function push() {
        return $this->success();
    }

    public function info() {
         return $this->success([
            'token' => '123456'
        ]);
    }

    public function orders() {
       return $this->success([
            [
                'couponId' => 1,
                'title' => 'sadasdas',
                'desc' => 'sadasdsa',
                'amount' => 121321,
                'expireDate' => '2022-09-21',
                'isExpired' => 1,
            ],
            [
                'couponId' => 2,
                'title' => 'sadasdas',
                'desc' => 'sadasdsa',
                'amount' => 121321,
                'expireDate' => '2022-09-21',
                'isExpired' => 1,
            ]
        ]);
    }

    public function logout() {
        return $this->success();
    }
}