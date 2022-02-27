export default class ComplexityView {
  constructor($passwordInput, $validationMessage) {
    this.$input = $passwordInput;
    this.$validationMessage = $validationMessage;
  }

  clearComplexity() {
    this.$validationMessage.html('');
    this.$validationMessage.hide();
  }

  lowComplexity() {
    this.$input.removeClass('is-valid');
    this.$input.addClass('is-invalid');
    this.$validationMessage.removeClass('valid-feedback');
    this.$validationMessage.addClass('invalid-feedback');
    this.$validationMessage.html('Password complexity is low');
  }

  goodComplexity(complexity) {
    this.$input.removeClass('is-invalid');
    this.$input.addClass('is-valid');
    this.$validationMessage.removeClass('invalid-feedback');
    this.$validationMessage.addClass('valid-feedback');
    this.$validationMessage.html('Password complexity is ' + complexity);
  }
}
