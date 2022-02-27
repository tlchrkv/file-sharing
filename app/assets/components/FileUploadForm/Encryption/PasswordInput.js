import SubmitFormButton from "../SubmitFormButton";

export default class PasswordInput {
  constructor() {
    this.$input = $('#file-upload__password-input');
    this.$validationMessage = $('#file-upload__password-validation');
  }

  enable() {
    this.$input.prop('disabled', false);
    this.$input.prop('required', true);
    this.$validationMessage.show();

    if (this.$input.val().length === 0) {
      SubmitFormButton.disable();
    }
  }

  disable() {
    this.$input.prop('disabled', true);
    this.$input.prop('required', false);
    this.$input.val('');
    this.$input.removeClass('is-valid');
    this.$input.removeClass('is-invalid');
    this.$validationMessage.html('');
    this.$validationMessage.hide();

    if (document.getElementById('file-upload__file-input').files.length > 0) {
      SubmitFormButton.enable();
    }
  }
}
