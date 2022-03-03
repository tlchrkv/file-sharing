export default class ImagePreview {
  static render(file) {
    const reader = new FileReader();
    reader.onload = (e) => ImagePreview.setSource(reader.result);
    reader.readAsDataURL(file.raw);

    document.getElementById('file-upload__preview-wrapper').style.display = 'flex';
  }

  static getSource() {
    return document.getElementById('file-upload__preview').src;
  }

  static setSource(url) {
    document.getElementById('file-upload__preview').src = url;
  }
}
