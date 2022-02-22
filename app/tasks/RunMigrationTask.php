<?php

declare(strict_types=1);

use Phalcon\Cli\Task;

final class RunMigrationTask extends Task
{
    public function mainAction()
    {
        $this->createMigrationsTableIfNotExist();

        $candidates = array_map(
            static function (string $file): int {
                return (int) explode('.', $file)[0];
            },
            array_diff(scandir($this->config->application->migrationsDir), ['..', '.'])
        );

        sort($candidates);

        $last = $this->getLastExecuted();
        $counter = 0;

        foreach ($candidates as $candidate) {
            if ($candidate > $last) {
                $filename = $this->config->application->migrationsDir . '/' . $candidate . '.sql';
                $this->db->execute(file_get_contents($filename));
                $this->setLastExecuted($candidate);
                $counter++;
            }
        }

        echo sprintf('Migrated %d', $counter);
        echo PHP_EOL;
    }

    private function createMigrationsTableIfNotExist()
    {
        $this->db->execute('CREATE TABLE IF NOT EXISTS migrations (version BIGINT NOT NULL, PRIMARY KEY(version))');
    }

    private function getLastExecuted(): int
    {
        return (int) $this->db->fetchColumn('SELECT version FROM migrations ORDER BY version DESC LIMIT 1');
    }

    private function setLastExecuted(int $version): void
    {
        $this->db->execute(sprintf('INSERT INTO migrations VALUES (%d)', $version));
    }
}
