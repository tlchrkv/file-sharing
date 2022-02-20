<?php

declare(strict_types=1);

namespace App\Models\Filters;

final class ExifFilter
{
    public static function clear(string $filePath): void
    {
        $img = new \Imagick(realpath($filePath));
        $profiles = $img->getImageProfiles('icc', true);
        $img->stripImage();

        if (!empty($profiles)) {
            $img->profileImage('icc', $profiles['icc']);
        }
    }
}
