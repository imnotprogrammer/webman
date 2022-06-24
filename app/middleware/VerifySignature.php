<?php
namespace app\middleware;

use App\constant\ClientOs;
use App\utils\Signature;
use Webman\MiddlewareInterface;
use Webman\Http\Response;
use Webman\Http\Request;

/**
 * 接口签名验证
 */
class VerifySignature implements MiddlewareInterface
{

    /** @var bool $status */
    private $status = false;

    public function process(Request $request, callable $next) : Response
    {
        if ($this->status) {
            $os = $request->header('os', ClientOs::OS_ANDROID);
            $signatureVerify = new Signature(config('common.apiKey.'. $os));

            if ($signatureVerify->verify($request->all())) {
                return $next($request);
            } else {
                throw new \Exception('signature error');
            }
        }

        return $next($request);
    }
}
