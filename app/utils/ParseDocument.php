<?php


namespace App\utils;


class ParseDocument
{
    /**
     * @var array $path 指定解析的目录
     */
    private $path;

    /**
     * @var array 解析结果
     */
    private $result = [];

    /**
     * @var string[] 不需要解析的方法
     */
    private $skipMethods = [
        'apiResponse',
        'success',
        'failed',
        'upload'
    ];

    /**
     * 是否输出解析内容
     * @var bool
     */
    private $stdout = true;

    /**
     * 解析tag
     * eg: {
     *     @name 用户信息
     *     @isMenu true
     *     @locale menu.user.info
     *     @icon icon_search
     *     @path GET /home/info
     *     @slug user-info
     *     @order 255
     *     @parentSlug  null
     *     @skip true
     * }
     */
    private $parseTags = [
        'name' => '',
        'isMenu' => false,
        'locale' => '',
        'icon' => '',
        'path' => '',
        'slug' => '',
        'order' => 255,
        'parentSlug' => '',
        'skip' => false,
    ];

    /**
     * @var array 解析规则，由正则表达式构成
     * eg: array('name' => '/\@{name}\s+(.*)[\x0a]*\/');
     */
    private $parseRule = [];

    public function __construct($path) {
        $this->path = $path;
    }

    /**
     *
     * 设置需要跳过的方法
     * @param $methods
     * @return $this
     */
    public function setSkipMethods($methods): ParseDocument
    {
        $this->skipMethods = $methods;
        return $this;
    }

    /**
     * 获取跳过的方法列表
     * @return string[]
     */
    public function getSkipMethods(): array
    {
        return $this->skipMethods;
    }

    /**
     * 遍历目录菜单
     * @return $this
     */
    public function lookup(): ParseDocument
    {
        foreach ($this->path as $path) {
            $this->readDir($path);
        }
        return $this;
    }

    public function readDir($path): ParseDocument
    {
        $dirIterator = new \RecursiveDirectoryIterator($path);
        $iterator = new \RecursiveIteratorIterator($dirIterator);

        foreach ($iterator as $file) {
            // 忽略目录和非php文件
            if (is_dir($file) || $file->getExtension() != 'php') {
                continue;
            }

            $filePath = str_replace('\\', '/',$file->getPathname());
            $className = str_replace('/', '\\',substr(substr($filePath, strlen(base_path())), 0, -4));

            if (!class_exists($className)) {
                if ($this->isStdout()) {
                    echo "Class $className not found, skip route for it\n";
                }

                continue;
            }

            // 通过反射找到这个类的所有共有方法作为action
            $class = new \ReflectionClass($className);

            $classDoc = $this->parse($class->getDocComment());
            if ($classDoc) {
                $this->result[] = $classDoc;
                $this->formateOut($classDoc, $className);
            }

            $methods = $class->getMethods();

            foreach ($methods as $method) {
                if ($method->isPrivate() || $method->isProtected() || $method->isStatic()) {
                    continue;
                }

                if (in_array($method->getName(), $this->skipMethods)) {
                    continue;
                }

                $doc = $method->getDocComment();
                $doc = $this->parse($doc);
                if (!$doc) {
                    continue;
                }
                $this->result[] = $doc;
                $this->formateOut($doc, $className);
            }
        }
        return $this;
    }

    /**
     * 获取注释结果
     * @return array
     */
    public function getResult(): array
    {
        return $this->result;
    }

    /**
     * @param $doc
     * @return array
     */
    public function parse($doc) {
        $result = [];
        $tags = array_keys($this->parseTags);
        foreach ($tags as $tag) {
            $result[$tag] = $this->parseTags[$tag] ?? '';
            $partten = "/\@{$tag}\s+(.*)[\x0a]*/";
            if (isset($this->parseRule[$tag])) {
                $partten = $this->parseRule[$tag];
            }

            if (preg_match($partten, $doc, $match)) {
                $result[$tag] = trim($match[1]);
            }
        }

        if (empty($result['slug']) || $result['skip'] == true) {
            return [];
        }

        return $result;
    }

    /**
     * @param $tag
     * @param string $defaultValue
     * @param string $partten
     * @return $this
     */
    public function extend($tag, $defaultValue = '', $partten = '') {
        $this->parseTags[$tag] = $defaultValue;
        if ($partten) {
            $this->parseRule[$tag] = $partten;
        }

        return $this;
    }

    /**
     * 格式化输出
     * @param $result
     */
    private function formateOut($result, $className) {
        if ($this->isStdout()) {
            echo sprintf('[%s] type: [%s], slug: [%s], name: [%s], locale: [%s], parentSlug: [%s];',
                    $className,
                    $result['isMenu'] ? 'menu' : 'permission',
                    $result['slug'],
                    $result['name'],
                    $result['locale'],
                    $result['parentSlug']
                ).PHP_EOL;
        }
    }

    /**
     * @return bool
     */
    public function isStdout(): bool
    {
        return $this->stdout;
    }

    /**
     * @param bool $stdout
     */
    public function setStdout(bool $stdout)
    {
        $this->stdout = $stdout;
        return $this;
    }
}