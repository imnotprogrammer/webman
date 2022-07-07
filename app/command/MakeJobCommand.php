<?php

namespace app\command;

use App\crontab\AbstractJob;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Input\InputOption;
use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Output\OutputInterface;


class MakeJobCommand extends Command
{
    protected static $defaultName = 'make:job';
    protected static $defaultDescription = 'Make crontab job';

    protected $jobDir = 'crontab';

    /**
     * @return void
     */
    protected function configure()
    {
        $this->addArgument('name', InputArgument::OPTIONAL, 'Name description');
    }

    /**
     * @param InputInterface $input
     * @param OutputInterface $output
     * @return int
     */
    protected function execute(InputInterface $input, OutputInterface $output): int
    {
        $name = $input->getArgument('name');
        if (empty($name)) {
            $output->writeln(sprintf('Miss Params name'));
            return self::SUCCESS;
        }

        $baseDir = app_path() .DIRECTORY_SEPARATOR . $this->jobDir .DIRECTORY_SEPARATOR;

        $name = $name . 'Job';
        $file = str_replace('/', '\\', $baseDir) . $name . '.php';

        if (file_exists($file)) {
            $output->writeln(sprintf('Crontab Job %s exist', $name));
            return self::SUCCESS;
        }

        file_put_contents($file, $this->getJobTemplate($name));

        $output->writeln(sprintf('Create Crontab Job %s Success', $name));
        return self::SUCCESS;
    }

    public function getJobTemplate($name): string
    {
        return <<<EOT
<?php


namespace App\crontab;


class {$name} extends AbstractJob
{

    public function execute()
    {
        //TODO SOMETHING
    }


    public function getRule(): string
    {
        return "* * * * *";
    }
}
EOT;

    }
}
