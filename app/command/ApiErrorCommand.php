<?php

namespace app\command;

use app\constant\ApiError;
use app\constant\Error;
use App\utils\ErrorCode;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Input\InputOption;
use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Output\OutputInterface;


class ApiErrorCommand extends Command
{
    protected static $defaultName = 'make:api-error';
    protected static $defaultDescription = 'Make Api Error code';

    /**
     * @return void
     */
    protected function configure()
    {
        $this->addArgument('name', InputArgument::OPTIONAL, 'Name description');
        $this->addArgument('lang', InputArgument::IS_ARRAY, 'Language,more need use, split.');
    }

    /**
     * @param InputInterface $input
     * @param OutputInterface $output
     * @return int
     */
    protected function execute(InputInterface $input, OutputInterface $output): int
    {
        $name = $input->getArgument('name');
        $lang = $input->getArgument('lang');

        ErrorCode::instance()
            ->setErrorClass(ApiError::class)
            ->setTransFile('api')
            ->create($name, $lang);

        $output->writeln("\n<info>Success!</info>");

        return self::SUCCESS;
    }

}
