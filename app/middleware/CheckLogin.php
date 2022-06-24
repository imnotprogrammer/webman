<?php
namespace app\middleware;

use App\admin\service\Menu;
use App\admin\service\Token;
use app\constant\Error;
use app\exception\AdminException;
use app\model\AdminUser;
use Webman\MiddlewareInterface;
use Webman\Http\Response;
use Webman\Http\Request;

class CheckLogin implements MiddlewareInterface
{
    private $notCheckLoginRouteName = [
        'login',
    ];

    private $notCheckPermissionRoute = [
        'user-info',
    ];

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
            $request->user = AdminUser::find($userId);

            /**
             * 不需要进行权限验证的路由
             */
            if (in_array($request->route->getName(), $this->notCheckPermissionRoute)) {
                return $next($request);
            }

            $userPermissionSlugs = Menu::getUserPermissions($userId)->toArray();
            if (!$userPermissionSlugs || !in_array($request->route->getName(), $userPermissionSlugs)) {
                throw new AdminException(Error::PermissionDeny);
            }   
        }

        return $next($request);
    }
}
