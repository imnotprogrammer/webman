<?php


namespace App;


class Controller
{
    public function apiResponse($data = [], $code = 0, $msg = ''): \support\Response
    {
        return json([
            'code' => $code,
            'msg' => $msg,
            'data' => $data
        ]);
    }

    public function success($data = [], $msg = '', $code = 0): \support\Response
    {
        return $this->apiResponse($data, $code, $msg);
    }

    public function failed($msg = '', $code = 5000): \support\Response
    {
        return $this->apiResponse([], $code, $msg);
    }
}