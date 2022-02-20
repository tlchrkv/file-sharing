<?php

declare(strict_types=1);

use App\Models\File;
use Phalcon\Cli\Task;

final class ClearExpiredFilesTask extends Task
{
    public function mainAction()
    {
        $expiredFiles = File::findExpired(new \DateTime('now'));
        $count = count($expiredFiles);

        echo sprintf('Found %d expired files', $count);
        echo PHP_EOL;

        if ($count === 0) {
            exit;
        }

        foreach ($expiredFiles as $file) {
            $file->delete();
        }

        echo 'Cleared';
        echo PHP_EOL;
    }
}
