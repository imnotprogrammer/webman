<?php


namespace support\stomp;


use support\Log;
use Webman\Stomp\StompClient;

class RewriteStompClient extends StompClient
{
    public function send($queueName, $body, $delay = 0, array $headers = [])
    {
        // generate destination
        if ($delay > 0) {
            $headers['x-delay'] = $delay * 1000;
        }

        $headers['destination'] = $this->getExchangePath($this->_configName, $queueName);

        $headers['content-length'] = strlen($body);
        if (!isset($headers['content-type'])) {
            $headers['content-type'] = 'text/plain';
        }

        $package = [
            'cmd' => 'SEND',
            'headers' => $headers,
            'body' => $body
        ];

        if ($this->sendPackage($package)) {
            Log::channel('producer')->info('producer message', [
                'd' => $body,
                'h' => $headers
            ]);
        }
    }

    public function sendPackage($package)
    {
        if ($this->checkDisconnecting()) {
            return false;
        }

        if ($this->_options['debug']) {
            $this->echoDebug($package, 'send');
        }

        return $this->_connection->send($package);
    }
}