<?php

namespace app\model;

use Carbon\Carbon;
use support\Model;


/**
 * Class Template
 * @package app\model
 * @property integer $template_id
 * @property string $name
 * @property array vars
 * @property string $path
 * @property Carbon $created_at
 * @property Carbon $updated_at
 *
 */
class Template extends Model
{
    /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'template';

    /**
     * The primary key associated with the table.
     *
     * @var string
     */
    protected $primaryKey = 'template_id';

    protected $casts = [
        'vars' => 'array'
    ];
}
