const decryptionForm = () => {
    const $decryptFileForm = $('#decryptFileForm');
    const $modal = new bootstrap.Modal($('#decryptionModal'));

    $('#decryptOpenModal').on('click', () => $modal.show());

    $decryptFileForm.on('submit', (e) => {
        e.preventDefault();

        $.ajax('/api/v1/files/' + $decryptFileForm.data('id') + '/decrypt', {
            method: 'PATCH',
            data: $decryptFileForm.serialize(),
            processData: false,
            contentType: false,
            success: (data) => {
                $modal.hide();
                $('#decryptOpenModal').hide();
                $('#encryptOpenModal').show();
                $('#encryptionStatusEncrypted').hide();
                $('#encryptionStatusDecrypted').show();
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

export default decryptionForm;
