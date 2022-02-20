import deleteAfterRange from "./delete-after-range";
import encryptionToggle from "./encryption-toggle";
import generatedLinks from "./generated-links";
import fileUpload from "./file-upload";

$(document).ready(() => {
   deleteAfterRange();
   encryptionToggle();
   generatedLinks();
   fileUpload();
});
