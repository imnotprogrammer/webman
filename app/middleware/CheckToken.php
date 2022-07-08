<?php
namespace app\middleware;

use App\service\Token;
use app\constant\Error;
use app\exception\AdminException;
use App\service\UserService;
use Webman\MiddlewareInterface;
use Webman\Http\Response;
use Webman\Http\Request;

class CheckToken implements MiddlewareInterface
{
    /**
     * @var string[] 不需要进行登录验证的路由
     */
    private $notCheckLoginRouteName = [
       'loginPassword',
       'loginSms',
    ];

    /**
     * @throws AdminException
     */
    public function process(Request $request, callable $next) : Response
    {
        $token = $request->header('token');
        /**
         * 不需要验证登录的接口
         */
        if (!in_array($request->route->getName(), $this->notCheckLoginRouteName)) {
            if (!$token) {
                throw new AdminException(Error::TokenNotFound);
            }

            $userId = Token::checkToken($token);
            $request->user = UserService::getUserById($userId);

        }

        return $next($request);
    }
}
