<?php

declare(strict_types=1);

namespace App\Validators;

use Phalcon\Validation;
use Phalcon\Validation\Validator\Callback;
use Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Validation\Validator\File;
use Phalcon\Validation\Message;

final class StoreActionValidator extends Validation
{
    public function initialize()
    {
        $this->add(
            'file',
            new File(
                [
                    'message' => new Message('File field must contains a file'),
                ]
            )
        );

        $this->add(
            'file',
            new PresenceOf(
                [
                    'message' => new Message('File is required'),
                ]
            )
        );

        $this->add(
            'delete_after',
            new PresenceOf(
                [
                    'message' => new Message('Delete period is required'),
                ]
            )
        );

        $this->add(
            'delete_after',
            new Callback([
                'callback' => function (array $data): bool {
                    return in_array((int) $data['delete_after'], range(1, 14));
                },
                'message' => new Message('We can delete file after 1 day min and 14 days max'),
            ])
        );

        $this->add(
            'password',
            new Callback([
                'callback' => function (array $data): bool {
                    if (isset($data['require_encryption']) && $data['require_encryption'] === 'true') {
                        return isset($data['password']) && count($data['password']) > 0;
                    }

                    return true;
                },
                'message' => new Message('Password is required for encryption'),
            ])
        );
    }
}
