import Cropper from "cropperjs";

const fileUpload = () => {
    const avatar = document.getElementById('avatar');
    const image = document.getElementById('image');
    const fileInput = document.getElementById('fileInput');

    const modalDiv = document.getElementById('modal');
    const $modal = new bootstrap.Modal(modalDiv);

    let canvas;
    let cropper;
    let fileName;
    let file;
    let isImageUploaded;

    fileInput.addEventListener('change', (e) => {
        const files = e.target.files;
        isImageUploaded = files[0]['type'].split('/')[0] === 'image';
        const done = (url) => {
            fileInput.value = '';
            image.src = url;
            $modal.show();
        };

        if (files && files.length > 0) {
            file = files[0];
            fileName = file.name;
        }

        if (files && files.length > 0 && isImageUploaded) {
            const reader = new FileReader();
            reader.onload = (e) => done(reader.result);
            reader.readAsDataURL(file);
        }
    });

    modalDiv.addEventListener('shown.bs.modal', function () {
        cropper = new Cropper(image, {
            viewMode: 3,
        });
    });

    modalDiv.addEventListener('hidden.bs.modal', function () {
        cropper.destroy();
        cropper = null;
    });

    document.getElementById('crop').addEventListener('click', () => {
        $modal.hide();

        if (cropper) {
            canvas = cropper.getCroppedCanvas();

            $('#fileInputDiv').hide();
            $('#avatarDiv').show();

            avatar.src = canvas.toDataURL();

            $('#removeFile').show();
        }
    });

    $('#removeFile').on('click', () => {
        $('#avatarDiv').hide();
        $('#fileInputDiv').show();
        $('#removeFile').hide();
    });

    $('#upload-form').on('submit', (e) => {
        e.preventDefault();

        if (isImageUploaded) {
            canvas.toBlob((blob) => submitForm(makeFormData(blob, fileName)));
        }

        if (!isImageUploaded) {
            submitForm(makeFormData(file, fileName));
        }
    });
};

const makeFormData = (file, fileName) => {
    const formData = new FormData();

    formData.append('file', file, fileName);
    formData.append('delete_after', $('#deleteAfterRange').val());
    formData.append('require_encryption', $('#requireEncryptionCheckbox').is(':checked'));
    formData.append('password', $('#passwordInput').val());

    return formData;
};

const submitForm = (formData) => {
    $.ajax('/api/v1/files', {
        method: 'POST',
        data: formData,
        processData: false,
        contentType: false,
        success: (data) => {
            $('#passwordInput').val('');
            $('#form').hide();
            $('#links').show();

            $('#publicLink').val(data.data.public_link);
            $('#privateLink').val(data.data.private_link);
        },
        error: function (data) {
            console.log(data);
        },
        complete: function () {
            // hide progress bar
        },
    });
};

export default fileUpload;
