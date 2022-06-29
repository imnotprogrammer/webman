<?php

namespace app\command;

use App\admin\service\Admin;
use app\model\AdminUser;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Output\OutputInterface;


class ResetAdminPasswordCommand extends Command
{
    protected static $defaultName = 'admin:reset';
    protected static $defaultDescription = 'Init Admin User Account And Password.';

    /**
     * @return void
     */
    protected function configure()
    {
        $this->addArgument('username', InputArgument::OPTIONAL, 'Rset Admin User');
        $this->addArgument('password', InputArgument::OPTIONAL, 'Rest Admin Password');
    }

    /**
     * @param InputInterface $input
     * @param OutputInterface $output
     * @return int
     * @throws \app\exception\AdminException
     */
    protected function execute(InputInterface $input, OutputInterface $output): int
    {
        $username = $input->getArgument('username') ?: AdminUser::DEFAULT_ADMIN_USERNAME;
        $password = $input->getArgument('password') ?: '';
        $password = Admin::resetAdminPassword($username, $password);

        if ($password) {
            $output->writeln('Reset Admin Password Success!');
            $output->writeln('=============================');
            $output->writeln('Account: '. $username);
            $output->writeln('Password: '. $password);
        } else {
            $output->writeln('Rest Admin Password Failed.');
        }

        return self::SUCCESS;
    }

}
