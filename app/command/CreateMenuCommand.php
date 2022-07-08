<?php

namespace app\command;

use App\admin\service\Menu;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;

/**
 * 初始化系统后台菜单权限
 * Class CreateMenuCommand
 * @package app\command
 */
class CreateMenuCommand extends Command
{
    protected static $defaultName = 'menu:create';
    protected static $defaultDescription = 'Init admin menu list.';

    /**
     * @return void
     */
    protected function configure()
    {
        $this->addArgument('isClear', InputArgument::OPTIONAL, 'Is To Clear Old Menu Data?', true);
    }

    /**
     * @param InputInterface $input
     * @param OutputInterface $output
     * @return int
     */
    protected function execute(InputInterface $input, OutputInterface $output)
    {
        $isClear = $input->getArgument('isClear');

        Menu::init($isClear === true);
        return self::SUCCESS;
    }

}
