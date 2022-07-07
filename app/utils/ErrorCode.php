<?php


namespace App\utils;


use app\constant\Error;

class ErrorCode
{
    /**
     * @var int 错误码开始数值
     */
    private $startNumber = 50001;

    /**
     * @var int 成功错误码
     */
    private $successCode = 0;

    /**
     * @var int 默认系统错误码
     */
    private $defaultFailedCode = 50000;

    /** @var bool  是否分布式控制错误码 */
    private $isHadoop = false;


    private $path = '';

    /** @var NumberDriverInterface $numberDriver */
    private $numberDriver = null;

    private $prePrint = false;

    private $errorClass = Error::class;

    /** @var $instance 实例 */
    static $instance;

    private function __construct() {

    }

    public function setPrePrint($status) {
        $this->prePrint = $status;
        return $this;
    }

    public function setNumberDriver(NumberDriverInterface $driver) {
        $this->numberDriver = $driver;
        $this->isHadoop = true;
    }

    public static function instance() {
        if (static::$instance) {
            return static::$instance;
        }

        return static::$instance = new static();
    }

    public function setErrorClass($class) {
        $this->errorClass = $class;
    }

    public function setConfig($config): ErrorCode
    {
        $this->config = $config;
        return $this;
    }

    public function setPath($path) {
        $this->path = $path;
        return $this;
    }

    public function create($name, $lang = [], $spec = '', $code = 0) {
        if ($name) {
            $this->appendErrorCode($name, $code, $spec);
        }

        $this->appendLang($name, $lang);
    }



    /**
     * @throws \ReflectionException
     */
    public function appendErrorCode($name, $code = 0, $spec = '') {

        if (!class_exists($this->errorClass)) {
            throw new \RuntimeException('Class "Error" not found');
        }

        $ref = new \ReflectionClass($this->errorClass);
        $constants = $ref->getConstants();

        if (in_array($name, array_keys($constants))) {
            throw new \RuntimeException(sprintf('const %s exisit', $name));
        }

        $lastNumber = $this->isHadoop ? $this->getNumber() : max($constants);
        $content = file_get_contents($this->path);

        $firstPos = strpos($content, '{');
        $endPos = strpos($content, $lastNumber.';');
        $constStr = substr($content, $firstPos+1, ($endPos - $firstPos) + strlen($lastNumber));
        $spec = $spec ?: $name;
        $spec = <<<EOT
    /** @var int {$spec} */
EOT;

        $code = $code ?: $lastNumber + 1;
        if (in_array($code, array_values($constants))) {
            throw new \RuntimeException(sprintf('Error code repeat: %s', $code));
        }

        $constStr = ltrim($constStr . PHP_EOL . sprintf("%s\n    const %s = %s;", $spec, $name, $code));
        $template = <<<EOT
<?php

namespace app\\constant;

class Error {
    {$constStr}
    /**
     * 获取错误码信息通过错误码
     * @param int \$code  错误码
     * @param array \$extra 其它信息
     */
    public static function getMessageByCode(\$code, \$extra = []): ?string
    {
        return trans( \$code, \$extra, self::TRANS_FILE );
    }
}
EOT;

        if ($this->prePrint) {
            echo $template;
        } else {
            file_put_contents($this->path, $template);
        }

    }

    /**
     * 获取最大错误码
     * @return mixed
     */
    public function getNumber() {
        return $this->numberDriver->getLastNumber();
    }

    public function appendLang($name, $lang = []) {
        $fallbackLocale = config('translation.fallback_locale', ['zh-CN', 'en']);
        $langPath = config('translation.path', base_path() . '/resource/translations');

        $ref = new \ReflectionClass($this->errorClass);
        $constants = $ref->getConstants();

        $transFile = config('translation.error_trans', 'error');
        $i = 0;
        foreach ($fallbackLocale as $locale) {
            $langFile = $langPath .DIRECTORY_SEPARATOR . $locale . DIRECTORY_SEPARATOR . $transFile . '.php';

            $errors = require_once $langFile;
            $str = '';

            foreach ($constants as $key => $val) {

                if ($val == $this->defaultFailedCode) {
                    continue;
                }

                $text = preg_replace('/([a-z])([A-Z])/', "$1 $2", $key);
                $text = $errors[$val] ?? $text;

                if ($key == $name && $lang) {
                    $text = $lang[$i] ?? $text;
                }
                $str .= sprintf("    %s => '%s',\n", 'Error::'. $key, $text);
            }

            if (!in_array($name, array_keys($constants))) {
                $text = preg_replace('/([a-z])([A-Z])/', "$1 $2", $name);

                if ($lang) {
                    $text = str_replace('_', ' ', $lang[$i] ?? $text);
                }

                $str .= sprintf("    %s => '%s',", 'Error::'. $name, $text);
            }

            $i++;

            $template = <<<EOT
<?php

use app\constant\Error;

return [
{$str}
];
EOT;

            if ($this->prePrint) {
                echo $template;
            } else {
                file_put_contents($langFile, $template);
            }

        }
    }
}