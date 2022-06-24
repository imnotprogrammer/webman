<?php

namespace app\model;

use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use support\Model;

class AdminPermission extends Model
{
    /**
     * 菜单标识-是
     */
    const MENU_YES = 1;

    /**
     * 菜单标识-不是
     */
    const MENU_NO = 0;
    /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'admin_permissions';

    /**
     * The primary key associated with the table.
     *
     * @var string
     */
    protected $primaryKey = 'permission_id';
    
    /**
     * @var array
     */
    protected $fillable = ['parent_id', 'name', 'slug', 'locale', 'path', 'is_menu', 'icon', 'order'];
    
    /**
     * @var array
     */
    public static $httpMethods = [
        'GET', 'POST', 'PUT', 'DELETE', 'PATCH', 'OPTIONS', 'HEAD',
    ];

    /**
     * Permission belongs to many roles.
     *
     * @return BelongsToMany
     */
    public function userPermissions(): BelongsToMany
    {
        return $this->belongsToMany(
            AdminRole::class,
            'admin_role_permissions',
            'permission_id',
            'role_id'
        );
    }

    /**
     * 子节点
     */
    public function children()
    {
        return $this->hasMany(AdminPermission::class, 'parent_id', 'permission_id')
            ->whereIsMenu(self::MENU_YES)
            ->with('children')
            ->orderBy('order', 'desc')
            ->orderBy('permission_id', 'desc');
    }

    /**
     * 获取所有菜单节点
     */
    public static function allNodes()
    {
        return self::query()
            ->whereParentId(0)
            ->whereIsMenu(1)
            ->with('children')
            ->orderBy('order', 'desc')
            ->orderBy('permission_id', 'desc')
            ->get();
    }
    
}
