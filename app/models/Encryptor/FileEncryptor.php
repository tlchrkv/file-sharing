<?php

declare(strict_types=1);

namespace App\Models\Encryptor;

use App\Models\Encryptor\Exceptions\CanNotOpenFile;
use App\Models\Encryptor\Exceptions\WrongPassword;

final class FileEncryptor
{
    private const
        FILE_ENCRYPTION_BLOCKS = 10000,
        ALGORITHM = 'AES-256-CBC',
        INIT_VECTOR_LENGTH = 32
    ;

    /**
     * @throws CanNotOpenFile
     */
    public static function encrypt(string $inputFilePath, string $password, string $outFilePath): void
    {
        $key = hash('sha256', $password);

        $inputFileHandle = fopen($inputFilePath, 'rb');
        if (!$inputFileHandle) {
            throw new CanNotOpenFile($inputFilePath);
        }

        $outFileHandle = fopen($outFilePath, 'w');
        if (!$outFileHandle) {
            fclose($inputFileHandle);

            throw new CanNotOpenFile($outFilePath);
        }

        $initVector = openssl_random_pseudo_bytes(self::INIT_VECTOR_LENGTH);
        fwrite($outFileHandle, $initVector);

        while (!feof($inputFileHandle)) {
            $plaintext = fread($inputFileHandle, self::INIT_VECTOR_LENGTH * self::FILE_ENCRYPTION_BLOCKS);
            $ciphertext = openssl_encrypt($plaintext, self::ALGORITHM, $key, OPENSSL_RAW_DATA, $initVector);
            $initVector = substr($ciphertext, 0, self::INIT_VECTOR_LENGTH);
            fwrite($outFileHandle, $ciphertext);
        }

        fclose($inputFileHandle);
        fclose($outFileHandle);
    }

    /**
     * @throws CanNotOpenFile
     * @throws WrongPassword
     */
    public static function decrypt(string $inputFilePath, string $password, string $outFilePath): void
    {
        $key = hash('sha256', $password);

        $inputFileHandle = fopen($inputFilePath, 'rb');
        if (!$inputFileHandle) {
            throw new CanNotOpenFile($inputFilePath);
        }

        $outFileHandle = fopen($outFilePath, 'w');
        if (!$outFileHandle) {
            fclose($inputFileHandle);

            throw new CanNotOpenFile($outFilePath);
        }

        $initVector = fread($inputFileHandle, self::INIT_VECTOR_LENGTH);

        while (!feof($inputFileHandle)) {
            $ciphertext = fread($inputFileHandle, self::INIT_VECTOR_LENGTH * (self::FILE_ENCRYPTION_BLOCKS + 1));
            $plaintext = openssl_decrypt($ciphertext, self::ALGORITHM, $key, OPENSSL_RAW_DATA, $initVector);

            if ($plaintext === false) {
                fclose($inputFileHandle);
                fclose($outFileHandle);

                throw new WrongPassword();
            }

            $initVector = substr($ciphertext, 0, self::INIT_VECTOR_LENGTH);
            fwrite($outFileHandle, $plaintext);
        }

        fclose($inputFileHandle);
        fclose($outFileHandle);
    }
}
