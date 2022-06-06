<?php


namespace process;


use App\crontab\PrintDataJob;
use App\crontab\PrintDateJob;
use Workerman\Crontab\Crontab;

class Task
{

    /**
     * @var string[] $jobs 定时任务列表
     */
    protected $jobs = [
        PrintDateJob::class,
        PrintDataJob::class

    ];

    /**
     * @var array $callableJob 回调函数组成得job
     *
     */
    protected $callableJob = [];

    /**
     * 定时任务规则
     */
    const DEFAULT_RULE = '* * * * *';

    public function onWorkerStart()
    {
        $exist = [];
        foreach ($this->jobs as $job) {
            if (!is_string($job) || in_array($job, $exist)) {
                continue;
            }

            if (class_exists($job) && method_exists($job, 'execute')) {
                $jobObj = new $job;
                if (method_exists($job, 'getRule')) {
                    $rule = $jobObj->getRule();
                } else {
                    echo sprintf('[Waring]Job %s not found execute rule, Decide to use the default rule * * * * *', $job);
                    $rule = self::DEFAULT_RULE;
                }

                new Crontab($rule, [$jobObj, 'execute'], $job);
            }
            $exist[] = $job;

        }
        unset($rules);

        foreach ($this->callableJob as $rule => $jobs) {
            if (is_array($jobs)) {
                foreach ($jobs as $jobCall) {
                    if (is_callable($jobCall)) {
                        new Crontab($rule, $jobCall);
                    }
                }
            }
        }

    }

    public function appendJobs($job) {
        $this->jobs[] = $job;
    }

    public function appendCallable($rule, callable $jobFunc) {
        $this->callableJob[$rule][] = $jobFunc;
    }

}