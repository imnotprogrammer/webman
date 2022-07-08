<?php

namespace app\exception;

use app\constant\ApiError;
use app\constant\Error;

class ApiException extends CommonException {

    public function __construct($errConst, $extra = [])
    {
        parent::__construct($errConst, $extra, ApiError::class);
    }
}