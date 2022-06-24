<?php
namespace app\middleware;

use App\utils\Install;
use Webman\MiddlewareInterface;
use Webman\Http\Response;
use Webman\Http\Request;

class CheckInstallState implements MiddlewareInterface
{

    private $status = false;

    public function process(Request $request, callable $next) : Response
    {
        $install = new Install();
        if ($this->status && !$install->isFinished()) {
            return redirect($install->getStepUrl());
        }

        return $next($request);
    }
}
