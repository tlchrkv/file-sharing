<div id="file-upload__result">
  <div class="pb-3 mb-3">
    <div class="card" style="border: none;">
      <div class="card-body">
        <h1 class="card-title ta-c">F<span style="color: mediumturquoise;">i</span>le s<span style="color: darkorange;">a</span>ve<span style="color: brown;">d</span></h1>
        <h6 class="card-subtitle mb-2 text-muted ta-c">Copy and save this links</h6>
        <div class="mt-2 d-flex justify-content-center">

          <div class="p-3 mw-600 mt-3 flex-1">
            <div class="input-group mb-4">
              <span class="input-group-text" id="file-upload__public-label" style="background-color: #212529;color: white;border-color: #212529;">Share</span>
              <input type="text" class="form-control text-center" id="file-upload__public-link" aria-describedby="file-upload__public-label" value="{{ publicLink }}" disabled>
              <button class="btn btn-primary" type="button" id="file-upload__copy-public-link">
                <span class="material-icons va-m">content_copy</span>
              </button>
            </div>

            <div class="input-group mb-3">
              <span class="input-group-text" id="file-upload__private-label">Admin</span>
              <input type="text" class="form-control text-center" id="file-upload__private-link" aria-describedby="file-upload__private-label" value="{{ privateLink }}" disabled>
              <button class="btn btn-outline-primary" type="button" id="file-upload__copy-private-link">
                <span class="material-icons va-m">content_copy</span>
              </button>
            </div>
          </div>

        </div>
      </div>
    </div>

    <div class="d-flex justify-content-center">
      <a href="/" class="btn btn-outline-secondary btn-lg" id="file-upload__add-another-file">Add another one</a>
    </div>
  </div>
</div>

<script src="/assets/result.js"></script>
