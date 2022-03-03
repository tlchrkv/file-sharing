import ComplexityView from "../../components/Shared/PasswordComplexity/ComplexityView";

const encryptionForm = () => {
    const $encryptFileForm = $('#encryptFileForm');
    const $modal = new bootstrap.Modal($('#encryptionModal'));

    const $passwordInput = $('#encryptFilePasswordInput');
    const $passwordMessage = $('#encryptFilePasswordMessage');
    const complexityView = new ComplexityView($passwordInput, $passwordMessage);

    $passwordInput.on('keyup change', () => complexityView.clear());

    $('#encryptOpenModal').on('click', () => {
        $modal.show();
        $passwordInput.focus();
    });

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
                $('#encryptionStatusDecrypted').hide();
                $('#encryptionStatusEncrypted').show();
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

export default encryptionForm;
