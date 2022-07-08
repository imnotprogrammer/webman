<?php

namespace App\admin\controller\system;

use App\Controller;

class Config extends Controller
{
    /**
     * @name 系统配置
     * @locale menu.system.config
     * @icon icon-dashboard
     * @slug config-view
     * @parentSlug system
     * @isMenu true
     * @return \support\Response
     */
    public function show() {
        return $this->success([
            'token' => 'adsdasddddddd'
        ]);
    }

    /**
     * @name 保存配置
     * @locale menu.system.config.save
     * @icon icon-dashboard
     * @slug config-save
     * @parentSlug config-view
     * @return \support\Response
     */
    public function save() {
        return $this->success([
            'token' => 'adsdasddddddd'
        ]);
    }

}