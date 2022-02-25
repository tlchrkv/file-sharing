const download = () => {
    const $downloadButton = $('#downloadButton');
    const $downloadEncryptedButton = $('#downloadEncryptedButton');
    const encryptOpenModal = document.getElementById('encryptOpenModal');

    const modal = document.getElementById('downloadModal');
    const $modal = new bootstrap.Modal(modal);

    $downloadButton.on('click', () => {
        const style = window.getComputedStyle(encryptOpenModal);
        const display = style.getPropertyValue('display');

        if (display === 'none') {
            $modal.show();

            return;
        }

        window.location = $downloadButton.data('url');
    });

    $downloadEncryptedButton.on('click', () => $modal.hide());
};

export default download;
