<?php
namespace app\middleware;

use App\admin\service\Menu;
use App\service\Token;
use app\constant\Error;
use App\constant\Permissions;
use app\exception\AdminException;
use app\model\AdminUser;
use Webman\MiddlewareInterface;
use Webman\Http\Response;
use Webman\Http\Request;

class CheckLogin implements MiddlewareInterface
{
    /**
     * @var string[] 不需要进行登录验证的路由
     */
    private $notCheckLoginRouteName = [
        Permissions::PERMISSION_LOGIN,
    ];

    /**
     * @var string[] 不需要进行权限验证的路由
     */
    private $notCheckPermissionRoute = [
        Permissions::PERMISSION_USER_INFO,
        Permissions::PERMISSION_USER_MENUS
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
