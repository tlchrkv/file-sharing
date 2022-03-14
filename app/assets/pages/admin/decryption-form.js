const decryptionForm = () => {
  const $decryptButton = $('#decryptButton');

  $decryptButton.on('click', (e) => {
    e.preventDefault();

    $.ajax('/api/v1/files/' + $decryptButton.data('id') + '/decrypt', {
      headers: {
        'Authorization': $('#manage').data('csrf')
      },
      method: 'PATCH',
      data: null,
      processData: false,
      contentType: false,
      success: (data) => {
        $decryptButton.hide();
        $('#encryptOpenModal').show();
        $('#encryptionStatusEncrypted').hide();
        $('#encryptionStatusDecrypted').show();
      },
      error: function (data) {
        console.log(data.responseJSON.error);
      },
      complete: function () {
        // hide progress bar
      },
    });
  });
};

export default decryptionForm;
