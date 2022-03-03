import 'jquery-cropper';
import ComplexityView from "../../components/Shared/PasswordComplexity/ComplexityView";

const cropImage = () => {
    const modal = document.getElementById('cropImageModal');

    if (!modal) {
        return;
    }

    const modalUpdate = document.getElementById('updateEncryptedModal');
    const image = document.getElementById('image');
    const preview = document.getElementById('preview');
    const encryptOpenModal = document.getElementById('encryptOpenModal');

    const $modal = new bootstrap.Modal(modal, { backdrop: 'static' });
    const $modalUpdate = new bootstrap.Modal(modalUpdate, { backdrop: 'static' });

    const $passwordInput = $('#updateEncryptedFilePasswordInput');
    const $passwordMessage = $('#updateEncryptedFilePasswordMessage');
    const complexityView = new ComplexityView($passwordInput, $passwordMessage);

    $passwordInput.on('keyup change', () => complexityView.clear());

    let canvas;

    $('#cropButton').on('click', () => {
        $modal.show();
        $passwordInput.focus();
    });

    window.addEventListener('mousedown', (e) => {
        if (!document.getElementById('modalContent').contains(e.target)) {
            $modal.hide();
        }
    });

    modal.addEventListener('shown.bs.modal', function () {
        $('#image').cropper({viewMode: 3});
    });

    modal.addEventListener('hidden.bs.modal', function () {
        $('#image').cropper('destroy');
    });

    document.getElementById('crop').addEventListener('click', () => {
        $modal.hide();

        canvas = $('#image').cropper('getCroppedCanvas');
        preview.src = canvas.toDataURL();
        image.src = preview.src;

        $('#updateButton').show();
    });

    const updateButton = $('#updateButton');
    const updateEncryptedFile = $('#updateEncryptedFile');

    updateButton.on('click', () => {
        const style = window.getComputedStyle(encryptOpenModal);
        const display = style.getPropertyValue('display');

        if (display === 'none') {
            $modalUpdate.show();

            return;
        }

        canvas.toBlob((blob) => {
            const formData = new FormData();

            formData.append('file', blob);

            $.ajax('/api/v1/files/' + updateButton.data('id'), {
                method: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                success: (data) => {
                    updateButton.hide();
                },
                error: function (data) {
                    complexityView.error(data.responseJSON.error);
                },
                complete: function () {
                    // hide progress bar
                },
            });
        });
    });

    updateEncryptedFile.on('submit', (e) => {
        e.preventDefault();

        canvas.toBlob((blob) => {
            const formData = new FormData();

            formData.append('file', blob);
            formData.append('password', $('#updateEncryptedFilePasswordInput').val());

            $.ajax('/api/v1/files/' + updateEncryptedFile.data('id'), {
                method: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                success: (data) => {
                    $modalUpdate.hide();
                    updateButton.hide();
                },
                error: function (data) {
                    console.log(data);
                },
                complete: function () {
                    // hide progress bar
                },
            });
        });
    });
}

export default cropImage;
