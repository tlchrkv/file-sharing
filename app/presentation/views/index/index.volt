<div id="form">
  <form action="/files" method="POST" enctype="multipart/form-data" id="upload-form">
    <div class="row pb-3 mb-3">
      <div class="col">
        <div class="card h-100">
          <div class="card-body">
            <h5 class="card-title">Upload file</h5>
            <div class="mt-4">
              <div id="fileInputDiv" class="mb-2">
                <input class="form-control" type="file" id="fileInput" name="file">
              </div>

              <div id="avatarDiv" style="display: none;">
                <img class="w-100" id="avatar" src="" alt="avatar">
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
                <input type="range" class="form-range" min="1" max="14" step="1" id="deleteAfterRange" value="14" name="delete_after">
                <div><span id="rangeNumber">14</span> day(s)</div>
              </div>
            </div>
          </div>
        </div>

        <div class="card">
          <div class="card-body">
            <h5 class="card-title">Encryption</h5>
            <div class="mt-2">
              <div class="form-check">
                <input class="form-check-input" type="checkbox" value="1" id="requireEncryptionCheckbox" name="require_encryption">
                <label class="form-check-label" for="requireEncryptionCheckbox">Enable</label>
              </div>
              <div class="mb-2 pt-2">
                <input type="password" class="form-control" id="passwordInput" placeholder="Password" name="password" disabled>
              </div>
            </div>
          </div>
        </div>

      </div>
    </div>

    <div class="btn btn-secondary c-pointer" id="removeFile" style="display: none;">Remove File</div>
    <button type="submit" class="btn btn-primary">Save & Get Public Link</button>
  </form>

  <div class="modal fade" id="modal" tabindex="-1" aria-labelledby="modalLabel" aria-hidden="true" style="display: none;">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Crop the image</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <div class="img-container">
            <img id="image" src="" class="w-100">
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-primary" id="crop">Crop</button>
        </div>
      </div>
    </div>
  </div>
</div>

<div id="links" style="display: none;">
  <div class="pb-3 mb-3">
    <div class="card">
      <div class="card-body">
        <h5 class="card-title ta-c">File saved successfully!</h5>
        <h6 class="card-subtitle mb-2 text-muted ta-c">Copy this links for share and manage file</h6>
        <div class="mt-2 d-flex justify-content-center">

          <div class="p-3 mw-600 flex-1">
            <label for="publicLink">Public link:</label>
            <div class="input-group mb-4">
              <input type="text" class="form-control" id="publicLink" value="" disabled>
              <button class="btn btn-primary" type="button" id="copyPublicLink">
                <span class="material-icons va-m">content_copy</span>
              </button>
            </div>

            <label for="privateLink">Private link for manage file:</label>
            <div class="input-group mb-3">
              <input type="text" class="form-control" id="privateLink" value="" disabled>
              <button class="btn btn-primary" type="button" id="copyPrivateLink">
                <span class="material-icons va-m">content_copy</span>
              </button>
            </div>
          </div>

        </div>
      </div>
    </div>

    <div class="d-flex justify-content-center mt-3">
      <button class="btn btn-primary" id="addAnotherOne">Add Another One</button>
    </div>
  </div>
</div>
