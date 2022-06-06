<?php


namespace App\queue;


trait Retry
{
    public $ttl = 5;

    public $maxAttemptNum = 3;

    /**
     * 消息重新消费间隔时间
     * @return int time to reserve in seconds
     */
    public function getTtr() {
        return $this->ttl;
    }

    /**
     * 判断消息是否能重复消费
     * @param int $attempt number
     * @param \Exception|\Throwable $error from last execute of the job
     * @return bool
     */
    public function canRetry($attempt, $error) {
        if ($attempt >= $this->maxAttemptNum) {
            return false;
        }

        return true;
    }
}