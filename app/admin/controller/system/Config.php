<?php

namespace App\admin\controller\system;

use App\Controller;

class Config extends Controller
{
    public function show() {
        return $this->success([
            'token' => 'adsdasddddddd'
        ]);
    }

    public function save() {
        return $this->success([
            'token' => 'adsdasddddddd'
        ]);
    }

}