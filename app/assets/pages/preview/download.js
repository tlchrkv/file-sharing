const download = () => {
  const $downloadButton = $('#downloadButton');
  const $downloadEncryptedButton = $('#downloadEncryptedButton');
  const $downloadPasswordInput = $('#downloadFilePasswordInput');

  const modal = document.getElementById('downloadModal');
  const $modal = new bootstrap.Modal(modal);

  $downloadButton.on('click', () => {
    if ($downloadButton.data('encrypted') === 1) {
      $modal.show();
      $downloadPasswordInput.focus();

      return;
    }

    window.location = $downloadButton.data('url');
  });

  $downloadEncryptedButton.on('click', () => $modal.hide());
};

export default download;
