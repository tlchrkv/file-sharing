export default class File {
  constructor(file) {
    this.raw = file;
    this.fileName = file.name;
    this.fileSize = (file.size / 1024 / 1024).toFixed(2);
    this.isImage = file['type'].split('/')[0] === 'image';
  }
}
