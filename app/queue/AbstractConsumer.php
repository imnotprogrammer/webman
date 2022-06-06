<?php


namespace App\queue;


use support\Log;
use Workerman\Stomp\AckResolver;

abstract class AbstractConsumer
{

    // 连接名，对应 config/stomp.php 里的连接`
    public $connection = 'default';

    // 值为 client 时需要调用$ack_resolver->ack()告诉服务端已经成功消费
    // 值为 auto   时无需调用$ack_resolver->ack()
    public $ack = 'client';

    abstract public function process($data);

    // 消费
    public function consume($data, AckResolver $ack_resolver = null)
    {
        $data = json_decode($data, true);

        $this->process($data);
        // 告
        //诉服务端，已经成功消费
        $ack_resolver->ack(); // ack为 auto时可以省略此调用

    }
}