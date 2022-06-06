<?php


namespace App\utils;


use support\Redis;
use Workerman\Protocols\Http\Session;
use \Workerman\Protocols\Http\Session\RedisSessionHandler as ParentRedisSessionHandler;
use Workerman\Timer;

class RedisSessionHandler extends ParentRedisSessionHandler
{
    public function __construct($config)
    {
        $name = $config['connection'] ?? 'default';
        $this->_redis = Redis::connection($name);

        $this->_maxLifetime = (int)Session::$lifetime;

        Timer::add(!empty($config['ping']) ? $config['ping'] : 55, function () {
            $this->_redis->get('ping');
        });
    }
}