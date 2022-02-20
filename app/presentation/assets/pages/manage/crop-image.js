import 'jquery-cropper';

const cropImage = () => {
    const modal = document.getElementById('cropImageModal');
    const preview = document.getElementById('preview');

    const $modal = new bootstrap.Modal(modal);

    let canvas;

    $('#cropButton').on('click', () => $modal.show());

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

        $('#updateButton').show();
    });

    const updateButton = $('#updateButton');

    updateButton.on('click', () => {
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
