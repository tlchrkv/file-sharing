const encryptionToggle = () => {
    $('#requireEncryptionCheckbox').on('click', (e) => {
        const passwordInput = $('#passwordInput');
        const passwordComplexityMessage = $('#passwordComplexityMessage');
        const $saveAndGetPublicLink = $('#saveAndGetPublicLink');

        if (e.target.checked) {
            passwordInput.prop('disabled', false);
            passwordInput.prop('required', true);
            passwordComplexityMessage.show();

            if (passwordInput.val().length === 0) {
                $saveAndGetPublicLink.prop('disabled', true);
            }

            return;
        }

        passwordInput.prop('disabled', true);
        passwordInput.prop('required', false);
        passwordInput.val('');
        passwordInput.removeClass('is-valid');
        passwordInput.removeClass('is-invalid');
        passwordComplexityMessage.hide();

        if (document.getElementById('fileInput').files.length > 0) {
            $saveAndGetPublicLink.prop('disabled', false);
        }
    });
};

export default encryptionToggle;
