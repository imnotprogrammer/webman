<?php


namespace App\queue\stomp;


use App\queue\AbstractConsumer;
use App\queue\Retry;
use support\Log;
use Webman\Stomp\Consumer;
use Webman\Stomp\RetryAbleConsumer;
use Workerman\Stomp\AckResolver;

class SendEmail extends AbstractConsumer implements Consumer,RetryAbleConsumer
{
    use Retry;
    // 队列名
    public $queue = 'email';

    // 消费
    public function process($data)
    {
        Log::channel('consumer')->info('start to send email for data', $data);
    }
}