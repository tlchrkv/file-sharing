const deleteAfterRange = () => {
    const range = $('#deleteAfterRange');
    const rangeNumber = $('#rangeNumber');

    range.on('input', (e) => rangeNumber.html(e.target.value));
    range.on('change', (e) => rangeNumber.html(e.target.value));
};

export default deleteAfterRange;
