<?php

namespace app\model;

use Illuminate\Database\Eloquent\Model;

class UserVerifyContact extends Model
{
    /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'user_verify_contacts';

    /**
     * The primary key associated with the table.
     *
     * @var string
     */
    protected $primaryKey = 'user_verify_contact_id';

   // protected $fillable = ['user_verify_id', 'phone', 'name', 'relation'];
    /**
     * Indicates if the model should be timestamped.
     *
     * @var bool
     */
    public $timestamps = true;

    protected $dateFormat = 'U';

    const CREATED_AT = 'create_time';
    const UPDATED_AT = 'update_time';
    
    
}
