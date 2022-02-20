const decryptionForm = () => {
    const $decryptFileForm = $('#decryptFileForm');
    const modalDiv = document.getElementById('decryptionModal');
    const $modal = new bootstrap.Modal(modalDiv);

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
