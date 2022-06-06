<?php

return [
    'default' => [
        'host' => 'stomp://192.168.123.113:61613',
        'options' => [
            'vhost'    => '/',
            'login'    => 'guest',
            'passcode' =>  'guest',
            'heart_beat' => 20000,
            'debug'    => true,
        ],
        'amqp' => [
            'host'           => '192.168.123.113',
            'port'           => 35672,
            'namespace'      => 'tool',
            'exchange_name'  => 'exchange',
            'exchange_delay' => 'false'
        ]
    ]
];