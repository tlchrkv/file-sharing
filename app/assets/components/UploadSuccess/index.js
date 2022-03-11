export default class UploadSuccess {
  static setupHandlersOnClick() {
    if (navigator.clipboard && window.isSecureContext) {
      $('#file-upload__copy-public-link').on('click', () => UploadSuccess.copyToClipboard('public'));
      $('#file-upload__copy-private-link').on('click', () => UploadSuccess.copyToClipboard('private'));
    }

    if (typeof navigator.clipboard === 'undefined' || !window.isSecureContext) {
      $('#file-upload__copy-public-link').hide();
      $('#file-upload__copy-private-link').hide();
      $('.input-group').addClass('input-group__no-buttons');
    }

    $('#file-upload__add-another-file').on('click', () => {
      window.location = '/';
    });
  }

  static copyToClipboard(visibility) {
    const copyLink = document.getElementById('file-upload__' + visibility + '-link');
    navigator.clipboard.writeText(copyLink.value);
  }
}
