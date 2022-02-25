import 'jquery-cropper';

const cropImage = () => {
    const modal = document.getElementById('cropImageModal');
    const image = document.getElementById('image');
    const preview = document.getElementById('preview');

    const $modal = new bootstrap.Modal(modal, { backdrop: 'static' });

    let canvas;

    $('#cropButton').on('click', () => $modal.show());

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
