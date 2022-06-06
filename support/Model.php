<?php


namespace support;

use Illuminate\Database\Eloquent\Model as BaseModel;
use Illuminate\Database\Eloquent\SoftDeletes;

class Model extends BaseModel
{
     use SoftDeletes;

    /**
     * Indicates if the model should be timestamped.
     *
     * @var bool
     */
   // public $timestamps = true;

    protected $dateFormat = 'U';

}