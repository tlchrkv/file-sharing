const encryptionForm = () => {
    const $encryptFileForm = $('#encryptFileForm');
    const modalDiv = document.getElementById('encryptionModal');
    const $modal = new bootstrap.Modal(modalDiv);

    $encryptFileForm.on('submit', (e) => {
        e.preventDefault();

        $.ajax('/api/v1/files/' + $encryptFileForm.data('id') + '/encrypt', {
            method: 'PATCH',
            data: $encryptFileForm.serialize(),
            processData: false,
            contentType: false,
            success: (data) => {
                $modal.hide();
                $('#encryptOpenModal').hide();
                $('#decryptOpenModal').show();
            },
            error: function (data) {
                console.log(data);
            },
            complete: function () {
                // hide progress bar
            },
        });
    });
};

export default encryptionForm;
