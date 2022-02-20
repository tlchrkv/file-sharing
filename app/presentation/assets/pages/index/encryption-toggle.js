const encryptionToggle = () => {
    $('#requireEncryptionCheckbox').on('click', (e) => {
        const passwordInput = $('#passwordInput');

        if (e.target.checked) {
            passwordInput.prop('disabled', false);
            passwordInput.prop('required', true);
            return;
        }

        passwordInput.prop('disabled', true);
        passwordInput.prop('required', false);
    });
};

export default encryptionToggle;
