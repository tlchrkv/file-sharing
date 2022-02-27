import ComplexityView from "./ComplexityView";
import SubmitFormButton from "../../FileUploadForm/SubmitFormButton";

export default class PasswordComplexity {
  static setupHandlerOnKeyup($passwordInput, $validationMessage) {
    const complexityView = new ComplexityView($passwordInput, $validationMessage);

    $passwordInput.on('keyup change', () => {
      const value = $passwordInput.val();

      if (value.length < 6) {
        complexityView.lowComplexity();
        SubmitFormButton.disable();
        return;
      }

      $.ajax('/api/v1/check-password-complexity?password=' + value, {
        method: 'GET',
        processData: false,
        contentType: false,
        success: (data) => {
          switch (data.complexity) {
            case 'low':
              complexityView.lowComplexity();
              SubmitFormButton.disable();
              break;
            case 'normal':
            case 'high':
              complexityView.goodComplexity(data.complexity);
              if (document.getElementById('file-upload__file-input').files.length > 0) {
                SubmitFormButton.enable();
              }
              break;
          }
        },
        error: (data) => {
          console.log(data);
        },
      });
    });
  }
}
