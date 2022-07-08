<?php

namespace App\api\controller;

use App\Controller;
use App\service\VerifyService;
use support\Request;

class Verify extends Controller
{
    /**
     * @param Request $request
     * @return \support\Response
     * @throws \app\exception\ApiException
     */
    public function stepOne(Request $request) {
        VerifyService::verifyStepOne($request->user->user_id, $request->post());
        return $this->success([
            'token' => '123456'
        ]);
    }

    public function stepTwo(Request $request) {
        $rs = VerifyService::verifyStepTwo($request->user->user_id, $request->post());
        return $this->success([
            'token' => $rs
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