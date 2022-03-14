const download = () => {
  const $downloadButton = $('#downloadButton');

  $downloadButton.on('click', () => {
    $('#downloadForm').submit();
  });
};

export default download;
