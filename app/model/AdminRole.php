<?php

namespace app\model;

use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use support\Model;

class AdminRole extends Model
{
    /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'admin_roles';

    /**
     * The primary key associated with the table.
     *
     * @var string
     */
    protected $primaryKey = 'role_id';
    
    /**
     * A role belongs to many users.
     *
     * @return BelongsToMany
     */
    public function administrators(): BelongsToMany
    {
        return $this->belongsToMany(AdminUser::class, 'admin_role_users', 'role_id', 'admin_id');
    }

     /**
     * A role belongs to many users.
     *
     * @return BelongsToMany
     */
    public function permissions(): BelongsToMany
    {
        return $this->belongsToMany(AdminPermission::class, 'admin_role_permissions', 'permission_id', 'role_id');
    }
}
