<div class="row pb-3 mb-3">
  <div class="card">
    <div class="card-body">
      <h5 class="card-title">{{ file.original_name }}</h5>
      <div class="mt-4">
        <div id="previewDiv">
          <img class="w-100" id="preview" src="{{ file.getImageBase64Content() }}">
        </div>
      </div>
    </div>
  </div>
</div>
