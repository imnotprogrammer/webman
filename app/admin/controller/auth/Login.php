<?php


namespace App\admin\controller\auth;

use App\service\Token;
use app\constant\Error;
use App\Controller;
use app\exception\AdminException;
use app\model\AdminRole;
use app\model\AdminUser;
use App\service\redis\LoginLimit;
use App\validate\AdminLogin;
use support\Request;

class Login extends Controller
{
    /**
     * @param Request $request
     * @return \support\Response
     * @throws AdminException
     */
    public function login(Request $request) {
        $validate = new AdminLogin();
        if (!$validate->scene('login')->check($request->all())) {
            throw new AdminException($validate->getError());
        }

        $username = $request->post('username');
        $password = $request->post('password');

        $user = AdminUser::where(['username' => $username])->first();

        if (!$user) {
            throw new AdminException(Error::LoginUserOrPasswordError);
        }

        $adminLimiter = new LoginLimit($user->admin_id);

        if (!$adminLimiter->isAllowLogin()) {
            throw new AdminException(Error::LoginRetryMaxNums);
        }

        if ($user->checkPassword($password)) {
            $token = Token::createToken($user->getAdminId(), $user->username);
            return $this->success([
                'token' => $token,
                'user' => [     
                    'name' => $user->name,
                    'avatar' => $user->getAvatar(),
                ]
            ]);
        } else {
            $adminLimiter->incr();
            throw new AdminException(Error::LoginUserOrPasswordError);
        }
    }

    /**
     * @return \support\Response
     */
    public function logout() {
        return $this->success();
    }
}