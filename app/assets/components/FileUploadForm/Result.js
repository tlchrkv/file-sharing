import PasswordInput from "./Encryption/PasswordInput";
import SubmitFormButton from "./SubmitFormButton";

export default class Result {
  static setupHandlersOnClick() {
    if (navigator.clipboard && window.isSecureContext) {
      $('#file-upload__copy-public-link').on('click', () => Result.copyToClipboard('public'));
      $('#file-upload__copy-private-link').on('click', () => Result.copyToClipboard('private'));
    }

    if (typeof navigator.clipboard === 'undefined' || !window.isSecureContext) {
      $('#file-upload__copy-public-link').hide();
      $('#file-upload__copy-private-link').hide();
      $('.input-group').removeClass('input-group');
    }

    $('#file-upload__add-another-file').on('click', () => {
      $('#file-upload__file-input').val('');
      $('#file-upload__remove').hide();
      $('#file-upload__result').hide();
      $('#file-upload').show();
      $('#file-upload__file-input-wrapper').show();
      $('#file-upload__preview-wrapper').hide();
      $('#file-upload__open-crop-modal').hide();
      new PasswordInput().disable();
      SubmitFormButton.disable();
    });
  }

  static copyToClipboard(visibility) {
    const copyLink = document.getElementById('file-upload__' + visibility + '-link');
    navigator.clipboard.writeText(copyLink.value);
  }
}
