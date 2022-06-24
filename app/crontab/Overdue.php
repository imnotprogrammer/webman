<?php


namespace App\crontab;


class PrintLifeJob extends AbstractJob
{

    public function execute()
    {
        //TODO SOMETHING
    }


    public function getRule(): string
    {
        return "* * * * *";
    }
}