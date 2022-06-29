<?php

namespace app\model;

use App\admin\service\Admin;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use support\Model;

class AdminUser extends Model
{
    /**
     * 默认管理员ID
     */
    const DEFAULT_ADMIN_ID = 1;
    /** @var string 管理员名称 */
    const DEFAULT_ADMIN_NAME = 'Administrator';
    /** @var string 管理员登录账号 */
    const DEFAULT_ADMIN_USERNAME = 'admin';
    /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'admin_users';

    /**
     * The primary key associated with the table.
     *
     * @var string
     */
    protected $primaryKey = 'admin_id';

    protected $fillable = ['username', 'password', 'name', 'avatar', 'salt'];
    

    /**
     * A user has and belongs to many roles.
     *
     * @return BelongsToMany
     */
    public function roles(): BelongsToMany
    {
        return $this->belongsToMany(AdminRole::class, 'admin_role_users', 'user_id', 'role_id');
    }

    public function permissions() {
        return $this->hasManyThrough('admin_role_permissions', 'admin_role_users', 'user_id', 'permission_id', 'admin_id', 'role_id');
    }

    public function checkPassword($password) {
        return $this->password === Admin::createPassword($password, $this->salt);
    }


    public function getAdminId() {
        return $this->admin_id;
    }

}
