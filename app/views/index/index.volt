<div id="file-upload">
  <form action="/files" method="POST" enctype="multipart/form-data" id="file-upload__form" class="pb-5">
    <div class="row pb-3 mb-3">
      <div class="col">
        <div class="card h-100">
          <div class="card-body">
            <h5 class="card-title">Upload file</h5>
            <div class="mt-4">
              <div id="file-upload__file-input-wrapper" class="mb-2">
                <input required class="form-control" type="file" id="file-upload__file-input" name="file" data-max-file-megabytes="{{ maxFileMegabytes }}" aria-describedby="filesizeRestrictions">
                <div class="invalid-feedback" id="file-upload__file-input-validation" style="display: none"></div>
                <div id="file-upload__file-input-help" class="form-text">The maximum file size is {{ maxFileMegabytes }} MB.</div>
              </div>

              <div id="file-upload__preview-wrapper" style="display: none;">
                <img class="w-100" id="file-upload__preview" src="" alt="preview">
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="col">
        <div class="card mb-3">
          <div class="card-body">
            <h5 class="card-title">Delete after</h5>
            <div class="mt-2">
              <div class="mb-3 pt-2">
                <input type="range" class="form-range" min="1" max="14" step="1" id="file-upload__days-range" value="14" name="delete_after">
                <div><span id="file-upload__day-number">14</span> <span id="file-upload__day">days</span></div>
              </div>
            </div>
          </div>
        </div>

        <div class="card">
          <div class="card-body">
            <h5 class="card-title">Encryption</h5>
            <div class="mt-2">
              <div class="form-check">
                <input class="form-check-input" type="checkbox" value="1" id="file-upload__encrypt-checkbox" name="require_encryption">
                <label class="form-check-label" for="file-upload__encrypt-checkbox">Enable</label>
              </div>
              <div class="mb-2 pt-2">
                <input type="password" class="form-control" id="file-upload__password-input" placeholder="Password" name="password" disabled aria-describedby="file-upload__password-validation">
                <div id="file-upload__password-validation" style="display: block"></div>
              </div>
            </div>
          </div>
        </div>

      </div>
    </div>

    <div class="btn btn-secondary c-pointer" id="file-upload__remove" style="display: none;">Remove File</div>
    <div class="btn btn-primary c-pointer" id="file-upload__open-crop-modal" style="display: none;">Crop</div>
    <button type="submit" class="btn btn-primary" id="file-upload__submit" disabled>Save & Get Public Link</button>
  </form>

  <div class="modal fade" id="file-upload__crop-modal" tabindex="-1" aria-labelledby="modalLabel" aria-hidden="true" style="display: none;">
    <div class="modal-dialog" role="document">
      <div class="modal-content" id="file-upload__crop-modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Crop the image</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <div class="img-container">
            <img id="file-upload__crop-image" src="" class="w-100">
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-primary" id="file-upload__crop-apply">Crop</button>
        </div>
      </div>
    </div>
  </div>
</div>

<div id="file-upload__result" style="display: none;">
  <div class="pb-3 mb-3">
    <div class="card">
      <div class="card-body">
        <h5 class="card-title ta-c">File saved successfully!</h5>
        <h6 class="card-subtitle mb-2 text-muted ta-c">Copy this links for share and manage file</h6>
        <div class="mt-2 d-flex justify-content-center">

          <div class="p-3 mw-600 flex-1">
            <label for="file-upload__public-link">Public link:</label>
            <div class="input-group mb-4">
              <input type="text" class="form-control" id="file-upload__public-link" value="" disabled>
              <button class="btn btn-primary" type="button" id="file-upload__copy-public-link">
                <span class="material-icons va-m">content_copy</span>
              </button>
            </div>

            <label for="file-upload__private-link">Private link for manage file:</label>
            <div class="input-group mb-3">
              <input type="text" class="form-control" id="file-upload__private-link" value="" disabled>
              <button class="btn btn-primary" type="button" id="file-upload__copy-private-link">
                <span class="material-icons va-m">content_copy</span>
              </button>
            </div>
          </div>

        </div>
      </div>
    </div>

    <div class="d-flex justify-content-center mt-3">
      <button class="btn btn-primary" id="file-upload__add-another-file">Add Another One</button>
    </div>
  </div>
</div>

<script src="/assets/index.js"></script>
