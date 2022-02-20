const deleteForm = () => {
    const $deleteFileForm = $('#deleteFileForm');

    $deleteFileForm.on('submit', (e) => {
        e.preventDefault();

        $.ajax('/api/v1/files/' + $deleteFileForm.data('id'), {
            method: 'DELETE',
            processData: false,
            contentType: false,
            success: (data) => {
                // crush page
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
