<?php

namespace App\utils;

class Signature {
    /**
     * 签名字段
     */
    private $signField = '_sign';

    /**
     * 时间戳
     */
    private $timestampField = '_timestamp';

    /**
     * api校验key
     */
    private $apiKey = '';

    public function __construct($apiKey)
    {
        $this->apiKey = $apiKey;
    }

    /**
     * 获取签名
     * @param int $timestamp
     * @param array $parmas
     */
    public function getSignature($timestamp, $params) {
        ksort($params);
        $str = '';
        foreach ($params as $key => $value) {
            $str .= $key . '='. $value .'&';
        }

        return md5(rtrim($str, '&') . $this->apiKey);
    }

    /**
     * 验证签名
     * @param array $params
     */
    public function verify($params) {
        $sign = $params[$this->signField] ?? '';
        $timestamp = $params[$this->timestampField] ?? '';

        unset($params[$this->signField]);
        unset($params[$this->timestampField]);

        return $sign != $this->getSignature($timestamp, $params);
    }
}