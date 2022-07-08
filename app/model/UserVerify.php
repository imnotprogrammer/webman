<?php

namespace app\model;

use Illuminate\Database\Eloquent\SoftDeletes;
use support\Model;

class UserVerify extends Model
{
    use SoftDeletes;

    /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'user_verify';

    /**
     * The primary key associated with the table.
     *
     * @var string
     */
    protected $primaryKey = 'user_verify_id';

    /*protected $fillable = [
        'first_name',
        'middle_name',
        'last_name',
        'gender',
        'birth',
        'marital_status',
        'number_of_children',
        '*'
    ];*/

    /**
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function contacts() {
        return $this->hasMany(UserVerifyContact::class, 'user_verify_id', 'user_verify_id');
    }
}
