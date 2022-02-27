import SubmitFormButton from "./SubmitFormButton";

export default class RemoveFileButton {
  static show() {
    $('#file-upload__remove').show();
    RemoveFileButton.setupHandlerOnClick();
  }

  static setupHandlerOnClick() {
    $('#file-upload__remove').on('click', () => {
      $('#file-upload__preview-wrapper').hide();
      $('#file-upload__file-input-wrapper').show();
      $('#file-upload__remove').hide();
      $('#file-upload__open-crop-modal').hide();
      $('#file-upload__file-input').val('');
      SubmitFormButton.disable();
    });
  }
}
