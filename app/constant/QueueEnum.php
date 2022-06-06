<?php


namespace App\constant;


final class QueueEnum
{
    /**
     * 邮件
     */
    const QUEUE_EMAIL = 'email';

    /**
     * 短信
     */
    const QUEUE_SMS = 'SMS';

    /**
     * 订单
     */
    const QUEUE_ORDER = 'order';

    const ALL_QUEUE = [
        self::QUEUE_EMAIL,
        self::QUEUE_SMS,
        self::QUEUE_ORDER
    ];


}