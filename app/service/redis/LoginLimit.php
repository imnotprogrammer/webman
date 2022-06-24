<?php

namespace App\service\redis;

use support\Redis;

class LoginLimit {
    /**
     * 默认连接
     */
    private $connection = 'default';

    private $maxLoginNums = 5;

    /** ID */
    private $ID;

    /** 限制类型 */
    private $type = self::LIMIT_TYPE_ADMIN;

    /** 过期时间 */
    private $ttl = 5 * 60;

    /**
     * 缓存key
     */
    private $key = 'login:limit:%s:%s';

    const LIMIT_TYPE_ADMIN = 1;
    const LIMIT_TYPE_API = 2;

    public function __construct($ID, $type = self::LIMIT_TYPE_ADMIN)
    {
        $this->ID = $ID;
        $this->type = $type;
    }

    /**
     * 设置最大登录次数
     */
    public function setMaxLoginNums($num) {
        $this->maxLoginNums = $num;
    }

    /**
     * 是否允许用户登录
     */
    public function isAllowLogin() {
        return Redis::connection($this->connection)->get($this->getCacheKey()) < $this->maxLoginNums ;
    }

    public function incr($step = 1) {
        $connection = Redis::connection($this->connection);
        $count = $connection->incrBy($this->getCacheKey(), $step);
        if ($count <= 1) {
            Redis::connection($this->connection)->expire($this->getCacheKey(), $this->ttl);
        }
    }

    public function getCacheKey() {
        return sprintf($this->key, $this->ID, $this->type);
    }
}