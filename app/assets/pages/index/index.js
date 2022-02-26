import deleteAfterRange from "./delete-after-range";
import encryptionToggle from "./encryption-toggle";
import generatedLinks from "./generated-links";
import fileUpload from "./file-upload";
import passwordComplexityChecker from "../../packages/password-complexity-checker";

$(document).ready(() => {
   deleteAfterRange();
   encryptionToggle();
   generatedLinks();
   fileUpload();
   passwordComplexityChecker('passwordInput');
});
