const deleteAfterRange = () => {
    const $rangeDimension = $('#rangeDimension');

    $('#deleteAfterRange').on('input change', (e) => {
        $('#rangeNumber').html(e.target.value);

        if (e.target.value == 1) {
            $rangeDimension.html('day');
        }

        if (e.target.value > 1) {
            $rangeDimension.html('days');
        }
    });
};

export default deleteAfterRange;
