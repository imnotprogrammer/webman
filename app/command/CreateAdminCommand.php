<?php

namespace app\command;

use App\admin\service\Admin;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Input\InputOption;
use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Output\OutputInterface;


class CreateAdminCommand extends Command
{
    protected static $defaultName = 'admin:create';
    protected static $defaultDescription = 'Create Admin User For ADMIN';

    /**
     * @return void
     */
    protected function configure()
    {
        $this->addArgument('username', InputArgument::REQUIRED, 'Userame Is ADMIN Login Acount Name');
        $this->addArgument('name', InputArgument::REQUIRED, 'Name Is ADMIN Display Name');
        $this->addArgument('password', InputArgument::OPTIONAL, 'Password Is ADMIN Login Password');
    }

    /**
     * @param InputInterface $input
     * @param OutputInterface $output
     * @return int|void
     */
    public function interact(InputInterface $input, OutputInterface $output)
    {
        if (!$input->getArgument('username')) {
            $output->writeln('<info>No Set Username, Please Input Username For Login.</info>');
            fwrite(STDOUT, '>');
            $stdin = fopen('php://stdin', 'r');
            $username = preg_replace('/[\n|\r]+/' , '', fgets($stdin));
            if (!$username) {
                $output->writeln(sprintf('<error>%s</error>', 'Not Input the Username, Will Exit.'));
                return self::FAILURE;
            }
            $input->setArgument('username', $username);
        }

        if (!$input->getArgument('name')) {
            $output->writeln('<info>No Set Name, Please Input Name.</info>');
            fwrite(STDOUT, '>');
            $stdin = fopen('php://stdin', 'r');
            $name = preg_replace('/[\n|\r]+/' , '', fgets($stdin));
            if (!$name) {
                $output->writeln(sprintf('<error>%s</error>', 'Not Input the Name, Will Exit.'));
                return self::FAILURE;
            }

            $input->setArgument('name', $name);
        }

        if (!$input->getArgument('password')) {
            $output->writeln('<info>No Set Password, Please Input Password For Login. If Input Is NUll, Will Generate Random Password</info>');
            fwrite(STDOUT, '>');
            $stdin = fopen('php://stdin', 'r');
            $password = preg_replace('/[\n|\r]+/' , '', fgets($stdin));
            if (!$password) {
                $password = generate_random_string(10);
            }
            $input->setArgument('password', $password);
        }
    }

    /**
     * @param InputInterface $input
     * @param OutputInterface $output
     * @return int
     */
    protected function execute(InputInterface $input, OutputInterface $output)
    {
        $name = $input->getArgument('name');
        $username = $input->getArgument('username');
        $password = $input->getArgument('password');

        if (Admin::createAdmin($username, $name, $password)) {
            $output->writeln([
                '<info>Create Admin Success!</info>',
                '<info>=====================</info>',
                '<info>Username:</info> '. $username,
                '<info>Name:</info> '. $name,
                '<info>Password:</info> '. $password,
            ]);
        } else {
            $output->writeln('<error>Create User Failed.</error>');
        }


        return self::SUCCESS;
    }

}
