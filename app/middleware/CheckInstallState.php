<?php
namespace app\middleware;

use App\utils\Install;
use Webman\MiddlewareInterface;
use Webman\Http\Response;
use Webman\Http\Request;

class CheckInstallState implements MiddlewareInterface
{

    public function process(Request $request, callable $next) : Response
    {
        $install = new Install();
        if (!$install->isFinished()) {
            return redirect($install->getStepUrl());
        }

        return $next($request);
    }
}
