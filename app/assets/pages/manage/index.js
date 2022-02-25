import encryptionForm from "./encryption-form";
import decryptionForm from "./decryption-form";
import deleteForm from "./delete-form";
import cropImage from "./crop-image";
import download from "./download";

$(document).ready(() => {
    encryptionForm();
    decryptionForm();
    deleteForm();
    cropImage();
    download();
});
