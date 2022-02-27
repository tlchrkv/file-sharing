import PasswordInput from "./PasswordInput";

export default class Encryption {
  constructor() {
    this.checkbox = document.getElementById('file-upload__encrypt-checkbox');
    this.passwordInput = new PasswordInput();
  }

  setupHandlerOnCheckbox() {
    this.checkbox.addEventListener('click', (e) => {
      if (e.target.checked) {
        this.passwordInput.enable();
        return;
      }

      this.passwordInput.disable();
    });
  }
}
