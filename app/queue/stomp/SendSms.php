<?php


namespace App\queue\stomp;


use App\queue\AbstractConsumer;
use App\queue\Retry;
use support\Log;
use Webman\Stomp\Consumer;
use Webman\Stomp\RetryAbleConsumer;

class SendSms extends AbstractConsumer implements Consumer,RetryAbleConsumer
{
    use Retry;
    // 队列名
    public $queue = 'sms';

    // 消费
    public function process($data)
    {
        Log::channel('consumer')->info('receive_sms_data', $data);
    }
}