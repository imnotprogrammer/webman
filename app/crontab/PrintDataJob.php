<?php


namespace App\crontab;


class PrintDataJob extends AbstractJob
{

    public function execute()
    {
        echo PHP_EOL . sprintf('[crontab Job] start to execute %s on %s', static::class, date('Y-m-d H:i:s'));
    }


    public function getRule(): string
    {
        return "* * * * *";
    }
}