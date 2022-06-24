<?php

use Webman\Route;

/**
 * app接口路由
 */
Route::group('/api', function () {
    /** 上传 */
    Route::post('/upload', [\App\api\controller\User::class, 'upload']);
    /** 系统配置*/
    Route::get('/config', [\App\api\controller\Config::class, 'index']);
    /** 首页 */
    Route::get('/home', [\App\api\controller\Home::class, 'index']);

    /** 验证码发送 */
    Route::post('/sms/send', [\App\api\controller\Captcha::class, 'sms']);
    /** 密码登录 */
    Route::post('/login/password', [\App\api\controller\Login::class, 'password']);
    /** 验证码登录/注册 */
    Route::post('/login/sms', [\App\api\controller\Login::class, 'sms']);
    /** 注销用户 */
    Route::post('/user/logout', [\App\api\controller\User::class, 'logout']);

    /** 用户信息 */
    Route::get('/user/info', [\App\api\controller\User::class, 'info']);
    /** 用户提额券 */
    Route::get('/user/coupons', [\App\api\controller\User::class, 'coupons']);
    /** 用户订单 */
    Route::get('/user/orders', [\App\api\controller\User::class, 'orders']);
    /** 用户密码设置 */
    Route::post('/user/setPassword', [\App\api\controller\User::class, 'setPassword']);
    /** 用户密码设置 */
    Route::post('/user/push', [\App\api\controller\User::class, 'push']);

    /** 贷款试算 */
    Route::post('/order/caluate', [\App\api\controller\Order::class, 'caluate']);
    /** 贷款申请 */
    Route::post('/order/apply', [\App\api\controller\Order::class, 'apply']);
     /** 贷款详情 */
    Route::get('/order/detail', [\App\api\controller\Order::class, 'detail']);

     /** 贷款详情 */
    Route::get('/repay/getRepayMethodList', [\App\api\controller\Repay::class, 'getRepayMethodList']);
     /** 还款 */
    Route::post('/repay', [\App\api\controller\Repay::class, 'repay']);

     /** 通知列表 */
    Route::get('/notice/list', [\App\api\controller\Notice::class, 'list']);
     /** 通知已读 */
    Route::post('/notice/read', [\App\api\controller\Notice::class, 'read']);

     /** 验证第一步- 个人信息*/
    Route::post('/verify/stepOne', [\App\api\controller\Verify::class, 'stepOne']);
     /** 验证第二步- 联系人信息*/
    Route::post('/verify/stepTwo', [\App\api\controller\Verify::class, 'stepTwo']);
     /** 验证第三步- 教育&雇佣信息*/
    Route::post('/verify/stepThree', [\App\api\controller\Verify::class, 'stepThree']);
     /** 验证第四步- 银行信息*/
    Route::post('/verify/stepFour', [\App\api\controller\Verify::class, 'stepFour']);

     /** 活体检测 */
    Route::post('/verify/live', [\App\api\controller\Verify::class, 'live']);
  
});