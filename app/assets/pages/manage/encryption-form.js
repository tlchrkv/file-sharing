const encryptionForm = () => {
    const $encryptFileForm = $('#encryptFileForm');
    const $modal = new bootstrap.Modal($('#encryptionModal'));

    $('#encryptOpenModal').on('click', () => $modal.show());

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
