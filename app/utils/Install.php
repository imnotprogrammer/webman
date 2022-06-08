<?php


namespace App\utils;


use http\Exception\RuntimeException;
use support\Db;
use support\Log;

class Install
{
    public $installFilePath = '';
    public $installData = [];
    private $defaultStep = 1;

    /**
     * 步骤一 写入基本配置信息
     */
    const STEP_ONE = 1;

    /**
     * 步骤二 写入 数据库配置信息
     */
    const STEP_TWO = 2;

    /**
     * 步骤三 写入redis配置
     */
    const STEP_THREE = 3;

    /**
     * 步骤四  开始配置
     */
    const STEP_FOUR = 4;

    public function __construct($installFilePath = '')
    {
        if (!$installFilePath) {
            $this->installFilePath = runtime_path() . DIRECTORY_SEPARATOR . 'install.json';
        } else {
            $this->installFilePath = $installFilePath;
        }
            }

    public function init() {
        if ($this->installFilePath && file_exists($this->installFilePath)) {
            $content = file_get_contents($this->installFilePath);
            $this->installData = json_decode($content, true);
        }
    }

    public function writeData() {
        if ($this->installData && $this->installFilePath)  {
            file_put_contents($this->installFilePath, json_encode($this->installData, JSON_PRETTY_PRINT|JSON_UNESCAPED_UNICODE));
        }
    }

    /**
     * 当前系统是否完成
     * @return bool
     */
    public function isFinished(): bool
    {
        return isset($this->installData['finishedState']) && 1 == $this->installData['finishedState'];
    }

    /**
     * 获取当前step
     * @return bool|int
     */
    public function getCurrentStep() {
        return array_key_exists('step', $this->installData) ? $this->installData['step'] : $this->defaultStep;
    }

    /**
     * 创建验证token
     * @return string
     */
    public function createToken(): string
    {
        return md5(microtime(true). '_token');
    }

    /**
     * 获取当前步骤路径
     * @return string
     */
    public function getStepUrl(): string
    {
        $step = $this->getCurrentStep();
        if ($step == self::STEP_ONE) {
            $token = $this->createToken();

            $this->installData = array_merge($this->installData, [
                'step' => $this->defaultStep,
                'token' => $token
            ]);

            $this->writeData();
        } else {
            $token = $this->installData['token'] ?? '';
        }

        return sprintf('/install?token=%s&step=%s', $token, $step);
    }


    /**
     * 设置当前步骤
     * @param $step
     */
    public function setStep($step) {
        $this->installData['step'] = $step;

    }

    /**
     * 标记状态
     * @param false $state
     */
    public function setFinished(bool $state = false) {
        $this->installData['finishedState'] = $state ? 1 : 0;
    }

    /**
     * 是否能够安装
     * @return bool
     */
    public function canInstall(): bool
    {
        return $this->getCurrentStep() == self::STEP_FOUR;
    }

    /**
     * @param $token
     * @return bool
     */
    public function checkToken($token): bool
    {
        return ($this->installData['token'] ?? '') == $token;
    }

    /**
     * 写入数据库配置
     * @param $host
     * @param $name
     * @param $port
     * @param $username
     * @param $password
     */
    public function writeDatabase($host, $name, $port, $username, $password) {
        $this->installData['config'] = [
            'DB_HOST' => $host,
            'DB_NAME' => $name,
            'DB_PASSWORD' => $password,
            'DB_USER' => $username,
            'DB_PORT' => $port
        ];

        $this->installData['step'] = self::STEP_THREE;
        $this->writeData();
    }

    /**
     * 写入redis配置信息
     * @param $host
     * @param $port
     * @param $auth
     */
    public function writeRedis($host, $port, $auth) {
        $this->installData['config'] = [
            'REDIS_HOST' => $host,
            'REDIS_AUTH' => $auth,
            'DB_PORT' => $port
        ];

        $this->setStep(self::STEP_FOUR);
        $this->writeData();
    }

    /**
     * 写入基本消息
     * @param $name
     * @param string $timezone
     * @param string $defaultLocale
     * @param int $serverPort
     */
    public function writeBase($name, $timezone = 'Asia/Shanghai', $defaultLocale = 'zh_CN', $serverPort = 8787) {
        $this->installData['config'] = [
            'APP_NAME' => $name,
            'APP_LOCALE' => $defaultLocale,
            'TIMEZONE' => $timezone,
            'SERVER_PORT' => $serverPort
        ];

        $this->installData['step'] = self::STEP_TWO;
        $this->writeData();
    }

    public function install() {
        $this->writeConfig();
        $this->importData();

        $this->setFinished(true);
        $this->writeData();
    }

    /**
     * 导入数据库数据
     */
    public function importData() {
        $sqlPath = storage_path() . DIRECTORY_SEPARATOR. 'database/loan.sql';
        if (file_exists($sqlPath)) {
            try {
                Db::connection()->query(sprintf('CREATE DATABASE %s;', env('DB_NAME')));
            } catch (\Throwable $t) {
                Log::info('init database failed:' . $t->getMessage());
            }
            Db::connection()->query(file_get_contents($sqlPath));
        } else {
            throw new RuntimeException('Import Data to Mysql Failed');
        }
    }

    public function writeConfig() {
        $configStr = '';

        foreach ($this->installData['config']  as $key => $value) {
            $configStr .= "$key=$value\n";
        }

        file_put_contents(app_path() .DIRECTORY_SEPARATOR .'.env', $configStr);

    }
}