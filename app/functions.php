<?php
/**
 * Here is your custom functions.
 */

if (!function_exists('generate_random_string')) {
    /**
     * @desc 生成指定随机字符串
     * @param int $length
     * @param string $prefix
     * @param bool $isFront
     * @return string
     * @date 2021/4/23
     */
    function generate_random_string($length = 6 , $prefix = '', $isFront = true)
    {
        $str = null;
        $strPol = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz";
        $max = strlen($strPol) - 1;

        for ($i = 0; $i < $length; $i++) {
            $str .= $strPol[rand(0, $max)];
        }


        return $isFront ? $prefix . $str : $str . $prefix;
    }
}