import ComplexityView from "../../components/Shared/PasswordComplexity/ComplexityView";

const decryptionForm = () => {
    const $decryptFileForm = $('#decryptFileForm');
    const $modal = new bootstrap.Modal($('#decryptionModal'));

    const $passwordInput = $('#decryptFilePasswordInput');
    const $passwordMessage = $('#decryptFilePasswordMessage');
    const complexityView = new ComplexityView($passwordInput, $passwordMessage);

    $passwordInput.on('keyup change', () => complexityView.clear());

    $('#decryptOpenModal').on('click', () => {
        $modal.show();
        $passwordInput.focus();
    });

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
                complexityView.error(data.responseJSON.error);
            },
            complete: function () {
                // hide progress bar
            },
        });
    });
};

export default decryptionForm;
