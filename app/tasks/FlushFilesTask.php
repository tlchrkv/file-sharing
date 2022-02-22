<?php

declare(strict_types=1);

use App\Models\File;
use Phalcon\Cli\Task;

final class FlushFilesTask extends Task
{
    public function mainAction()
    {
        $expiredFiles = File::findExpired(new \DateTime('now'));

        echo sprintf('Found %d expired file(s)', $expiredFiles->count());
        echo PHP_EOL;

        if ($expiredFiles->count() === 0) {
            exit;
        }

        foreach ($expiredFiles as $file) {
            $file->fullDelete();
        }

        echo 'Cleared';
        echo PHP_EOL;
    }
}
