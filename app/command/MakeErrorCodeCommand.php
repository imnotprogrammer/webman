<?php

namespace app\command;

use App\utils\ErrorCode;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Input\InputOption;
use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Output\OutputInterface;


class MakeErrorCodeCommand extends Command
{
    protected static $defaultName = 'make:error-code';
    protected static $defaultDescription = 'Make error code and error language.';

    /**
     * @return void
     */
    protected function configure()
    {
        $this->addArgument('name', InputArgument::OPTIONAL, 'Name description');
        $this->addArgument('lang', InputArgument::IS_ARRAY, 'Language,more need use , split.');
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

        ErrorCode::instance()->setPath(
            app_path() . DIRECTORY_SEPARATOR . 'constant' .DIRECTORY_SEPARATOR. 'Error.php'
        )->create($name, $lang);
        $output->writeln("\n<info>Success!</info>");
        return self::SUCCESS;
    }

}
