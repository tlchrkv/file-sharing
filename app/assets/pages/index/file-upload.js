import Cropper from "cropperjs";

const fileUpload = () => {
    const preview = document.getElementById('preview');
    const image = document.getElementById('image');
    const fileInput = document.getElementById('fileInput');

    const modalDiv = document.getElementById('modal');
    const $modal = new bootstrap.Modal(modalDiv, { backdrop: 'static' });

    let canvas;
    let cropper;
    let fileName;
    let file;
    let isImageUploaded;

    fileInput.addEventListener('change', (e) => {
        const files = e.target.files;
        const $fileInputInvalidFeedback = $('#fileInputInvalidFeedback');
        const $filesizeRestrictions = $('#filesizeRestrictions');
        const done = (url) => {
            preview.src = url;
        };

        $fileInputInvalidFeedback.hide();
        $filesizeRestrictions.show();

        isImageUploaded = files[0]['type'].split('/')[0] === 'image';

        if (files && files.length > 0) {
            file = files[0];
            fileName = file.name;
        }

        const filesize = (file.size / 1024 / 1024).toFixed(2);

        if (filesize > parseInt(fileInput.dataset.maxFileMegabytes)) {
            $('#uploadForm').addClass('was-validated');

            $fileInputInvalidFeedback.html(`${filesize} MB file size is too large. Max allowed size is ${fileInput.dataset.maxFileMegabytes} MB`);
            $fileInputInvalidFeedback.show();
            $filesizeRestrictions.hide();

            fileInput.value = '';
            file = null;

            return;
        }

        if (files && files.length > 0 && isImageUploaded) {
            const reader = new FileReader();
            reader.onload = (e) => done(reader.result);
            reader.readAsDataURL(file);
        }

        if (isImageUploaded) {
            $('#fileInputDiv').hide();
            $('#previewDiv').show();
            $('#removeFile').show();
            $('#cropImageButton').show();
        }
    });

    $('#cropImageButton').on('click', () => {
        image.src = preview.src;
        $modal.show();
    });

    window.addEventListener('mousedown', (e) => {
        if (!document.getElementById('modalContent').contains(e.target)) {
            $modal.hide();
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
            preview.src = canvas.toDataURL();
        }
    });

    $('#removeFile').on('click', () => {
        file = null;
        fileName = null;
        fileInput.value = '';
        $('#previewDiv').hide();
        $('#fileInputDiv').show();
        $('#removeFile').hide();
        $('#cropImageButton').hide();
    });

    $('#uploadForm').on('submit', (e) => {
        e.preventDefault();

        if (isImageUploaded && canvas) {
            canvas.toBlob((blob) => submitForm(makeFormData(blob, fileName)));

            return;
        }

        submitForm(makeFormData(file, fileName));
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
