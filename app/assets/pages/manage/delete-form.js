const deleteForm = () => {
    const $deleteFileForm = $('#deleteFileForm');
    const $modal = new bootstrap.Modal($('#deleteNowModal'));

    $('#deleteNowButton').on('click', () => $modal.show());

    $deleteFileForm.on('submit', (e) => {
        e.preventDefault();

        $.ajax('/api/v1/files/' + $deleteFileForm.data('id'), {
            method: 'DELETE',
            processData: false,
            contentType: false,
            success: (data) => {
                $modal.hide();
                $('#manage').hide();
                $('#deleted').show();
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

export default deleteForm;
