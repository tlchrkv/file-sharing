export default class DaysRange {
  static showLabel() {
    const $rangeDimension = $('#file-upload__day');

    $('#file-upload__days-range').on('input change', (e) => {
      $('#file-upload__day-number').html(e.target.value);

      if (e.target.value === '1') {
        $rangeDimension.html('day');
      }

      if (e.target.value > 1) {
        $rangeDimension.html('days');
      }
    });
  }
}
