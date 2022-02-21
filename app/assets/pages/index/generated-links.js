const generatedLinks = () => {
    $('#copyPublicLink').on('click', () => copyToClipboard('public'));
    $('#copyPrivateLink').on('click', () => copyToClipboard('private'));

    const copyToClipboard = (linkVisibility) => {
        const copyLink = document.getElementById(linkVisibility + 'Link');
        navigator.clipboard.writeText(copyLink.value);
    };

    $('#addAnotherOne').on('click', () => {
        $('#fileInput').val('');
        $('#removeFile').hide();
        $('#links').hide();
        $('#form').show();
        $('#fileInputDiv').show();
        $('#avatarDiv').hide();
    });
};

export default generatedLinks;
