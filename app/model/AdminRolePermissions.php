<?php

namespace app\model;

use Illuminate\Database\Eloquent\Relations\Pivot;

class AdminRolePermissions extends Pivot
{
    protected $dateFormat = 'U';
    /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'admin_role_permissions';


    /**
     * Indicates if the IDs are auto-incrementing.
     *
     * @var bool
     */
    public $incrementing = false;

}
