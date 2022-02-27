import File from "./File";
import ImagePreview from "./../../Shared/Image/ImagePreview";
import SubmitFormButton from "../SubmitFormButton";
import RemoveFileButton from "../RemoveFileButton";
import OpenCroppingModalButton from "../../Shared/Image/Cropping/OpenCroppingModalButton";

export default class FileInput {
  constructor() {
    this.el = document.getElementById('file-upload__file-input');
    this.wrapper = document.getElementById('file-upload__file-input-wrapper');
    this.validation = document.getElementById('file-upload__file-input-validation');
    this.help = document.getElementById('file-upload__file-input-help');
    this.maxFileSize = parseInt(this.el.dataset.maxFileMegabytes);
    this.openCroppingModalButton = new OpenCroppingModalButton();
    this.file = null;
    this.$passwordInput = $('#file-upload__password-input');
  }

  setupHandlerOnChanges() {
    this.el.addEventListener('change', (e) => {
      this.clearErrors();

      const files = e.target.files;

      if (files.length === 0) {
        return;
      }

      this.file = new File(files[0]);

      if (this.file.fileSize > this.maxFileSize) {
        this.showError(`${this.file.fileSize} MB file size is too large. Max allowed size is ${this.maxFileSize} MB`);
        this.clearInput();
        return;
      }

      if (this.file.isImage) {
        this.hide();
        ImagePreview.render(this.file);
        RemoveFileButton.show();
        this.openCroppingModalButton.show();
      }

      if (this.$passwordInput.prop('disabled') || (!this.$passwordInput.prop('disabled') && this.$passwordInput.val().length >= 6)) {
        SubmitFormButton.enable();
      }
    });
  }

  hide() {
    this.wrapper.style.display = 'none';
  }

  clearInput() {
    this.el.value = '';
    this.file = null;
  }

  showError(message) {
    this.el.classList.add('is-invalid');
    this.validation.innerHTML = message;
    this.validation.style.display = '';
    this.help.style.display = 'none';
  }

  clearErrors() {
    this.validation.style.display = 'none';
    this.help.style.display = '';
    this.el.classList.remove('is-invalid');
  }
}
