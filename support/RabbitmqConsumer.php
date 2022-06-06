<?php


namespace Support;

use Psr\Log\LoggerInterface;
use Webman\Stomp\AmqpLib\Enforcer;
use Webman\Stomp\Process\Consumer;
use Webman\Stomp\RetryAbleConsumer;

class RabbitmqConsumer extends Consumer
{
    /**
     * @var LoggerInterface
     */
    static $logger = null;


    public function __construct($consumer_dir = '', LoggerInterface $logger = null)
    {
        $this->_consumerDir = $consumer_dir;
        if (!$logger) {
            static::$logger = Log::channel('consumer');
        } else {
            static::$logger = $logger;
        }

    }

    public function onWorkerStart()
    {
        $dir_iterator = new \RecursiveDirectoryIterator($this->_consumerDir);
        $iterator = new \RecursiveIteratorIterator($dir_iterator);


        // Get consumers by connection name
        $connectionList = [];
        foreach ($iterator as $file) {
            if (is_dir($file)) {
                continue;
            }
            $fileinfo = new \SplFileInfo($file);
            $ext = $fileinfo->getExtension();
            if ($ext === 'php') {
                $class = str_replace('/', "\\", substr(substr($file, strlen(base_path())), 0, -4));
                if (!is_a($class, 'Webman\Stomp\Consumer', true)) {
                    continue;
                }
                if (class_exists("support\bootstrap\Container")) {
                    // 兼容老版文件位置
                    $consumer = \support\bootstrap\Container::get($class);
                } elseif (class_exists("support\Container")) {
                    // 新版webman移动了文件位置
                    $consumer = \support\Container::get($class);
                } else {
                    throw new \RuntimeException('Container file not find.');
                }

                $connectionName = $consumer->connection ?? 'default';
                $connectionList[$connectionName][] = $consumer;
            }
        }

        // create custom exchange by php-amqplib/php-amqplib
        foreach ($connectionList as $connectionName => $consumers) {
            $amqpEnforcer = Enforcer::connection($connectionName);
            $amqpEnforcer::createDelayedExchange($connectionName);

            foreach ($consumers as $consumer) {
                $queue = $consumer->queue;
                $ack = $consumer->ack ?? 'auto';

                // create and bind queue
                $amqpEnforcer::createAndBindQueue($connectionName, $queue);

                $connection = \support\stomp\Client::connection($connectionName);
                $callback = function ($client, $package, $ack) use ($consumer) {
                    $startTime = microtime(true);
                    try {
                        \call_user_func([$consumer, 'consume'], $package['body'], $ack, $client);
                        static::$logger->info('consumer_receive_message', [
                            'd' => $package,
                            'r' => microtime(true) - $startTime
                        ]);
                    } catch (\Throwable $e) {
                        $o = 'throwable';

                        if ($consumer instanceof RetryAbleConsumer) {
                            if ($consumer->ack === 'client') {
                                // 先ack掉当前的消息
                                $ack->ack();
                            }
                            $attempt = $package['headers']['attempt-times'] ?? 0;
                            // 查看是否能重新消费
                            if ($consumer->canRetry($attempt, $e)) {
                                // 重新投递消息
                                $client->send($consumer->queue, $package['body'], $consumer->getTtr(), ['attempt-times' => $attempt + 1]);
                            }

                            $o = sprintf('retry-%s', $attempt + 1);
                        }

                        static::$logger->error('consumer_error', [
                            'm' => $e->getMessage(),
                            'l' => $e->getLine(),
                            't' => $e->getTraceAsString(),
                            'd' => $package,
                            'o' => $o
                        ]);

                    }

                    unset($startTime);
                    if (isset($startTime)) unset($startTime);
                };

                $connection->subscribe($queue, $callback, ['ack' => $ack, 'prefetch-count' => 10]);
            }

            // destroy current amqp connection
            $amqpEnforcer::destroy($connectionName);
        }

        unset($connectionList);
    }
}