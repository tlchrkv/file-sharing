<?php 

use Phalcon\Db\Column;
use Phalcon\Db\Index;
use Phalcon\Db\Reference;
use Phalcon\Mvc\Model\Migration;

/**
 * Class FilesMigration_100
 */
class FilesMigration_100 extends Migration
{
    /**
     * Define the table structure
     *
     * @return void
     */
    public function morph()
    {
        $this->morphTable('files', [
                'columns' => [
                    new Column(
                        'id',
                        [
                            'type' => Column::TYPE_CHAR,
                            'notNull' => true,
                            'size' => 36,
                            'first' => true
                        ]
                    ),
                    new Column(
                        'original_name',
                        [
                            'type' => Column::TYPE_VARCHAR,
                            'notNull' => true,
                            'size' => 255,
                            'after' => 'id'
                        ]
                    ),
                    new Column(
                        'is_encrypted',
                        [
                            'type' => Column::TYPE_BOOLEAN,
                            'default' => "false",
                            'notNull' => true,
                            'after' => 'original_name'
                        ]
                    ),
                    new Column(
                        'public_short_code',
                        [
                            'type' => Column::TYPE_VARCHAR,
                            'notNull' => true,
                            'size' => 255,
                            'after' => 'is_encrypted'
                        ]
                    ),
                    new Column(
                        'private_short_code',
                        [
                            'type' => Column::TYPE_VARCHAR,
                            'notNull' => true,
                            'size' => 255,
                            'after' => 'public_short_code'
                        ]
                    ),
                    new Column(
                        'stored_before',
                        [
                            'type' => Column::TYPE_TIMESTAMP,
                            'notNull' => true,
                            'size' => 1,
                            'after' => 'private_short_code'
                        ]
                    ),
                    new Column(
                        'placement',
                        [
                            'type' => Column::TYPE_VARCHAR,
                            'notNull' => true,
                            'size' => 255,
                            'after' => 'stored_before'
                        ]
                    )
                ],
                'indexes' => [
                    new Index('files_pkey', ['id'], null)
                ],
            ]
        );
    }
}
