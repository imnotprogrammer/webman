<?php

// @formatter:off
/**
 * A helper file for your Eloquent Models
 * Copy the phpDocs from this file to the correct Model,
 * And remove them from this file, to prevent double declarations.
 *
 * @author Barry vd. Heuvel <barryvdh@gmail.com>
 */


namespace App\model{
/**
 * App\model\AdminPermission
 *
 * @property int $permission_id
 * @property string $name 菜单(权限)名称
 * @property string|null $icon
 * @property string $slug 唯一标识
 * @property string|null $locale
 * @property string|null $path 请求路径
 * @property int $order 排序，
 * @property int $parent_id 父类id,权限和顶级菜单为0
 * @property int|null $is_menu 是否是菜单，1-是 2-否 默认1
 * @property \Illuminate\Support\Carbon|null $update_time
 * @property \Illuminate\Support\Carbon|null $create_time
 * @property \Illuminate\Support\Carbon|null $delete_time
 * @property-read \Illuminate\Database\Eloquent\Collection|AdminPermission[] $allChildren
 * @property-read \Illuminate\Database\Eloquent\Collection|AdminPermission[] $children
 * @property-read \Illuminate\Database\Eloquent\Collection|\app\model\AdminRole[] $userPermissions
 * @method static \Illuminate\Database\Eloquent\Builder|AdminPermission newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|AdminPermission newQuery()
 * @method static \Illuminate\Database\Query\Builder|AdminPermission onlyTrashed()
 * @method static \Illuminate\Database\Eloquent\Builder|AdminPermission query()
 * @method static \Illuminate\Database\Query\Builder|AdminPermission withTrashed()
 * @method static \Illuminate\Database\Query\Builder|AdminPermission withoutTrashed()
 */
	class AdminPermission extends \Eloquent {}
}

namespace app\model{
/**
 * Class AdminRole
 *
 * @package app\model
 * @property int $role_id
 * @property string $name
 * @property string $slug
 * @property Carbon $create_time
 * @property Carbon $update_time
 * @property Carbon $delete_time
 * @property-read \Illuminate\Database\Eloquent\Collection|\app\model\AdminUser[] $administrators
 * @property-read \Illuminate\Database\Eloquent\Collection|\App\model\AdminPermission[] $permissions
 * @method static \Illuminate\Database\Eloquent\Builder|AdminRole newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|AdminRole newQuery()
 * @method static \Illuminate\Database\Query\Builder|AdminRole onlyTrashed()
 * @method static \Illuminate\Database\Eloquent\Builder|AdminRole query()
 * @method static \Illuminate\Database\Query\Builder|AdminRole withTrashed()
 * @method static \Illuminate\Database\Query\Builder|AdminRole withoutTrashed()
 */
	class AdminRole extends \Eloquent {}
}

namespace app\model{
/**
 * app\model\AdminRolePermissions
 *
 * @property int $role_id
 * @property int $permission_id
 * @property int|null $create_time
 * @property int|null $update_time
 * @method static \Illuminate\Database\Eloquent\Builder|AdminRolePermissions newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|AdminRolePermissions newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|AdminRolePermissions query()
 */
	class AdminRolePermissions extends \Eloquent {}
}

namespace app\model{
/**
 * app\model\AdminUser
 *
 * @property int $admin_id
 * @property string $username
 * @property string $password
 * @property string|null $salt
 * @property string $name
 * @property string|null $avatar
 * @property string|null $remember_token
 * @property \Illuminate\Support\Carbon|null $create_time
 * @property \Illuminate\Support\Carbon|null $update_time
 * @property \Illuminate\Support\Carbon|null $delete_time
 * @property-read \Illuminate\Database\Eloquent\Collection|\app\model\AdminRole[] $roles
 * @method static \Illuminate\Database\Eloquent\Builder|AdminUser newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|AdminUser newQuery()
 * @method static \Illuminate\Database\Query\Builder|AdminUser onlyTrashed()
 * @method static \Illuminate\Database\Eloquent\Builder|AdminUser query()
 * @method static \Illuminate\Database\Query\Builder|AdminUser withTrashed()
 * @method static \Illuminate\Database\Query\Builder|AdminUser withoutTrashed()
 */
	class AdminUser extends \Eloquent {}
}

namespace app\model{
/**
 * app\model\Orders
 *
 * @property int $order_id
 * @property int|null $user_id 用户id
 * @property int|null $product_id 贷款产品ID
 * @property string $sn 订单编号
 * @property int|null $borrow_amount 借款金额，*100 名义贷款
 * @property int|null $need_repay_amount 应还总额 * 100
 * @property int|null $interest_amount 利息*100
 * @property int|null $decrease_amount 减免金额*100
 * @property int|null $repay_amount 还款金额，已还金额总和*100
 * @property int|null $loan_amount 放款金额
 * @property int|null $break_amount 违约金
 * @property int|null $extend_amount 展期费
 * @property int|null $faxi 罚息
 * @property int|null $borrow_count 第几次借款
 * @property int|null $service_fee 服务费用
 * @property int|null $status 订单状态
 * @property int|null $create_time 创建时间
 * @property int|null $update_time 更新时间
 * @property \Illuminate\Support\Carbon|null $delete_time 删除时间
 * @property int|null $settle_time 结清时间
 * @property int|null $loan_time 放款时间
 * @property int|null $extend_time 展期时间
 * @property int|null $expect_repay_time 到期时间
 * @property int|null $channel 渠道
 * @property int|null $last_status 订单上一次状态
 * @property mixed|null $extra 额外信息
 * @method static \Illuminate\Database\Eloquent\Builder|Orders newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|Orders newQuery()
 * @method static \Illuminate\Database\Query\Builder|Orders onlyTrashed()
 * @method static \Illuminate\Database\Eloquent\Builder|Orders query()
 * @method static \Illuminate\Database\Query\Builder|Orders withTrashed()
 * @method static \Illuminate\Database\Query\Builder|Orders withoutTrashed()
 */
	class Orders extends \Eloquent {}
}

namespace app\model{
/**
 * Class Template
 *
 * @package app\model
 * @property integer $template_id
 * @property string $name
 * @property array vars
 * @property string $path
 * @property Carbon $created_at
 * @property Carbon $updated_at
 * @method static \Illuminate\Database\Eloquent\Builder|Template newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|Template newQuery()
 * @method static \Illuminate\Database\Query\Builder|Template onlyTrashed()
 * @method static \Illuminate\Database\Eloquent\Builder|Template query()
 * @method static \Illuminate\Database\Query\Builder|Template withTrashed()
 * @method static \Illuminate\Database\Query\Builder|Template withoutTrashed()
 */
	class Template extends \Eloquent {}
}

namespace app\model{
/**
 * app\model\Test
 *
 * @method static \Illuminate\Database\Eloquent\Builder|Test newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|Test newQuery()
 * @method static \Illuminate\Database\Query\Builder|Test onlyTrashed()
 * @method static \Illuminate\Database\Eloquent\Builder|Test query()
 * @method static \Illuminate\Database\Query\Builder|Test withTrashed()
 * @method static \Illuminate\Database\Query\Builder|Test withoutTrashed()
 */
	class Test extends \Eloquent {}
}

namespace app\model{
/**
 * app\model\User
 *
 * @property int $user_id
 * @property string|null $real_full_name 用户姓名
 * @property string|null $first_name 用户名字首
 * @property string|null $last_name 用户名字尾
 * @property string|null $middle_name 用户名字中
 * @property string|null $card_number 身份唯一标识
 * @property string|null $phone 手机号码
 * @property string|null $passwd 用户登录密码
 * @property string|null $salt 用户登录盐值
 * @property string|null $email 用户邮箱
 * @property int|null $invite_user_id 邀请用户ID
 * 邀请人
 * @property int|null $gender 性别 0-未知 1-男 2-女
 * @property string|null $birth_day 出生年月
 * @property string|null $from 用户来源 注册设备类型,1-web 2-android 3-ios
 * @property int|null $last_login_time 最近登录时间
 * @property string|null $last_login_type 用户最近登录类型
 * @property int|null $create_time 注册时间
 * @property int|null $update_time 更新时间
 * @property \Illuminate\Support\Carbon|null $delete_time 禁用时间
 * @property int|null $current_verify_step 当前认证第几部默认为1
 * @property-read \app\model\UserVerify|null $verify
 * @method static \Illuminate\Database\Eloquent\Builder|User newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|User newQuery()
 * @method static \Illuminate\Database\Query\Builder|User onlyTrashed()
 * @method static \Illuminate\Database\Eloquent\Builder|User query()
 * @method static \Illuminate\Database\Query\Builder|User withTrashed()
 * @method static \Illuminate\Database\Query\Builder|User withoutTrashed()
 */
	class User extends \Eloquent {}
}

namespace app\model{
/**
 * app\model\UserVerify
 *
 * @property int $user_verify_id
 * @property int|null $user_id
 * @property string|null $first_name
 * @property string|null $middle_name
 * @property string|null $last_name
 * @property string|null $birth_date
 * @property int|null $gender
 * @property int|null $martial_status
 * @property int|null $number_of_children
 * @property int|null $family_contact_id
 * @property int|null $other_contact_id
 * @property string|null $state
 * @property string|null $city
 * @property string|null $area
 * @property string|null $address
 * @property int|null $educ_id
 * @property int|null $employment_status_id
 * @property string|null $employer_name
 * @property int|null $employer_period
 * @property int|null $salary
 * @property int|null $pay_day
 * @property string|null $id_number
 * @property string|null $bank_name
 * @property string|null $bank_code
 * @property string|null $bank_number
 * @property string|null $face_live_verify
 * @property \Illuminate\Support\Carbon|null $create_time
 * @property \Illuminate\Support\Carbon|null $update_time
 * @property \Illuminate\Support\Carbon|null $delete_time
 * @property-read \Illuminate\Database\Eloquent\Collection|\app\model\UserVerifyContact[] $contacts
 * @method static \Illuminate\Database\Eloquent\Builder|UserVerify newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|UserVerify newQuery()
 * @method static \Illuminate\Database\Query\Builder|UserVerify onlyTrashed()
 * @method static \Illuminate\Database\Eloquent\Builder|UserVerify query()
 * @method static \Illuminate\Database\Query\Builder|UserVerify withTrashed()
 * @method static \Illuminate\Database\Query\Builder|UserVerify withoutTrashed()
 */
	class UserVerify extends \Eloquent {}
}

namespace app\model{
/**
 * app\model\UserVerifyContact
 *
 * @property int $user_verify_contact_id
 * @property int|null $user_verify_id
 * @property string|null $phone
 * @property string|null $name
 * @property string|null $relation
 * @property \Illuminate\Support\Carbon|null $create_time
 * @property \Illuminate\Support\Carbon|null $update_time
 * @method static \Illuminate\Database\Eloquent\Builder|UserVerifyContact newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|UserVerifyContact newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|UserVerifyContact query()
 */
	class UserVerifyContact extends \Eloquent {}
}

