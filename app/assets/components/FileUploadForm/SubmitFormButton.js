export default class SubmitFormButton {
  static disable() {
    $('#file-upload__submit').prop('disabled', true);
  }

  static enable() {
    $('#file-upload__submit').prop('disabled', false);
  }
}
