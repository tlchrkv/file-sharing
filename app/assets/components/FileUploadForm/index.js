import Encryption from "./Encryption";
import DaysRange from "./DaysRange";
import FileInput from "./FileInput";
import PasswordComplexity from "../Shared/PasswordComplexity";
import Result from "./Result";

export default class FileUploadForm {
  constructor() {
    this.fileInput = new FileInput();
    this.encryption = new Encryption();
  }

  main() {
    this.fileInput.setupHandlerOnChanges();
    this.encryption.setupHandlerOnCheckbox();

    DaysRange.showLabel();
    PasswordComplexity.setupHandlerOnKeyup($('#file-upload__password-input'), $('#file-upload__password-validation'));
    Result.setupHandlersOnClick();

    this.setupHandlerOnSubmit();
  }

  setupHandlerOnSubmit() {
    $('#file-upload__form').on('submit', (e) => {
      e.preventDefault();
      const canvas = this.fileInput.openCroppingModalButton.modal.canvas;

      if (this.fileInput.file.isImage && canvas) {
        canvas.toBlob((blob) => this.send(this.createForm(blob, this.fileInput.file.fileName)));

        return;
      }

      this.send(this.createForm(this.fileInput.file.raw, this.fileInput.file.fileName));
    });
  }

  createForm(file, fileName) {
    const formData = new FormData();

    formData.append('file', file, fileName);
    formData.append('delete_after', $('#file-upload__days-range').val());
    formData.append('require_encryption', $('#file-upload__encrypt-checkbox').is(':checked'));
    formData.append('password', $('#file-upload__password-input').val());

    return formData;
  };

  send(formData) {
    $.ajax('/api/v1/files', {
      method: 'POST',
      data: formData,
      processData: false,
      contentType: false,
      success: (data) => {
        $('#file-upload__password-input').val('');
        $('#file-upload').hide();
        $('#file-upload__result').show();

        $('#file-upload__public-link').val(data.data.public_link);
        $('#file-upload__private-link').val(data.data.private_link);
      },
      error: (data) => {
        console.log(data);
      },
    });
  };
}
