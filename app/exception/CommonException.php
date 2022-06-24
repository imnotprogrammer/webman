<?php

namespace app\exception;

use app\constant\Error;
use Exception;

class CommonException extends Exception {
    public function __construct($errConst, $extra = [])
    {
        $message = Error::getMessageByCode($errConst, $extra);
        parent::__construct($message, $errConst);
    }
}