const passwordComplexityChecker = (inputId) => {
    const $passwordInput = $('#' + inputId);
    const $passwordComplexityMessage = $('#passwordComplexityMessage');
    const $saveAndGetPublicLink = $('#saveAndGetPublicLink');

    $passwordInput.on('keyup change', () => {
        const value = $passwordInput.val();

        if (value.length < 6) {
            $passwordInput.addClass('is-invalid');
            $passwordComplexityMessage.addClass('invalid-feedback');
            $passwordComplexityMessage.html('Password complexity is low');
            $saveAndGetPublicLink.prop('disabled', true);
        }

        if (value.length >= 6) {
            $.ajax('/api/v1/check-password-complexity?password=' + value, {
                method: 'GET',
                processData: false,
                contentType: false,
                success: (data) => {
                    if (data.complexity === 'low') {
                        $passwordInput.removeClass('is-valid');
                        $passwordInput.addClass('is-invalid');
                        $passwordComplexityMessage.removeClass('valid-feedback');
                        $passwordComplexityMessage.addClass('invalid-feedback');
                        $passwordComplexityMessage.html('Password complexity is low');
                        $saveAndGetPublicLink.prop('disabled', true);
                    }

                    if (data.complexity === 'normal' || data.complexity === 'high') {
                        $passwordInput.removeClass('is-invalid');
                        $passwordInput.addClass('is-valid');
                        $passwordComplexityMessage.removeClass('invalid-feedback');
                        $passwordComplexityMessage.addClass('valid-feedback');
                        $passwordComplexityMessage.html('Password complexity is ' + data.complexity);

                        if (document.getElementById('fileInput').files.length > 0) {
                            $saveAndGetPublicLink.prop('disabled', false);
                        }
                    }
                },
                error: function (data) {
                    console.log(data);
                },
                complete: function () {
                    // hide progress bar
                },
            });
        }
    });
};

export default passwordComplexityChecker;
