import CroppingModal from "./CroppingModal";
import ImagePreview from "../ImagePreview";

export default class OpenCroppingModalButton {
  constructor() {
    this.$button = $('#file-upload__open-crop-modal');
    this.modal = new CroppingModal();
    this.setupHandlerOnClick();
  }

  show() {
    this.$button.show();
  }

  setupHandlerOnClick() {
    this.$button.on('click', () => {
      this.modal.show(ImagePreview.getSource());
    });
  }
}
