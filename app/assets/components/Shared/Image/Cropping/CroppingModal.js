import Cropper from "cropperjs";
import ImagePreview from "../ImagePreview";

export default class CroppingModal {
  constructor() {
    this.image = document.getElementById('file-upload__crop-image');
    this.modalDiv = document.getElementById('file-upload__crop-modal');
    this.$modal = new bootstrap.Modal(this.modalDiv, { backdrop: 'static' });

    this.cropper = null;
    this.canvas = null;

    this.setupHandlerOnSpecialEvents();
  }

  show(url) {
    this.image.src = url;
    this.$modal.show();
  }

  setupHandlerOnSpecialEvents() {
    window.addEventListener('mousedown', (e) => {
      if (!document.getElementById('file-upload__crop-modal-content').contains(e.target)) {
        this.$modal.hide();
      }
    });

    this.modalDiv.addEventListener('shown.bs.modal', () => {
      this.cropper = new Cropper(this.image, { viewMode: 3 });
    });

    this.modalDiv.addEventListener('hidden.bs.modal', () => {
      this.cropper.destroy();
      this.cropper = null;
    });

    document.getElementById('file-upload__crop-apply').addEventListener('click', () => {
      this.$modal.hide();

      if (this.cropper) {
        this.canvas = this.cropper.getCroppedCanvas();
        ImagePreview.setSource(this.canvas.toDataURL());
      }
    });
  }
}
