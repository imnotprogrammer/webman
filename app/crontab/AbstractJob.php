<?php


namespace App\crontab;


abstract class AbstractJob
{

    protected $name;

    abstract public function execute();

    abstract public function getRule();
}