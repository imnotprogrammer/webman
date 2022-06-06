<?php


namespace App\crontab;


class PrintDateJob extends AbstractJob
{

    public function execute()
    {
        echo '[PID]Current Process '  . date('Y-m-d H:i:s').PHP_EOL;
    }


    public function getRule(): string
    {
        return "* * * * *";
    }
}