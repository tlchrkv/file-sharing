import 'jquery';
import 'bootstrap';
import './scss/app.scss';

$(document).ready(() => {
  const $requiredPassword = $('#passwordInput');

  if ($requiredPassword) {
    $requiredPassword.focus();
  }
});
