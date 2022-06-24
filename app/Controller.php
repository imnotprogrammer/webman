<?php


namespace App;


class Controller
{
    /**
     * @param array $data
     * @param int $code
     * @param string $msg
     * @return \support\Response
     */
    public function apiResponse($data = [], $code = 0, $msg = ''): \support\Response
    {
        return json([
            'code' => $code,
            'msg' => $msg,
            'data' => $data
        ]);
    }

    /**
     * @param array $data
     * @param string $msg
     * @param int $code
     * @return \support\Response
     */
    public function success($data = [], $msg = '', $code = 0): \support\Response
    {
        return $this->apiResponse($data, $code, $msg);
    }

    /**
     * @param string $msg
     * @param int $code
     * @return \support\Response
     */
    public function failed($msg = '', $code = 5000): \support\Response
    {
        return $this->apiResponse([], $code, $msg);
    }

    public function upload() {
        
    }
}