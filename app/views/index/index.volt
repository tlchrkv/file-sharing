<div id="file-upload">
  <div>
    <h1 style="text-align: center;" class="mb-4"><span style="color: green;">L</span>et's up<span style="color: orange;">l</span>oa<span style="color: cadetblue;">d</span> the f<span style="color: purple;">i</span>le</h1>
    <ul style="text-align: center;color: gray;" class="list-inline my-5">
      <li class="list-inline-item">We don't store your personal data and encryption password.</li>
      <li class="list-inline-item">Automatic cleaning of image meta-information before saving.</li>
      <li class="list-inline-item">Share file via public link, apply changes via admin link.</li>
    </ul>
  </div>

  <form action="/files" method="POST" enctype="multipart/form-data" id="file-upload__form" class="pb-5">
    <div class="row pb-3 mb-3">
      <div class="col col-left">
        <div class="card h-100">
          <div id="file-upload__file-input-wrapper" class="card-body" style="display: flex;justify-content: center;align-content: center;height: 100%;position: relative;cursor: pointer;">
            <div style="text-align: center;display: flex;align-items: center;color: #6c757d;">
              <div>
                <span class="material-icons-outlined" style="font-size: 34px;">search</span>
                <h5>Click to choose file</h5>
                <input required hidden class="form-control" type="file" id="file-upload__file-input" name="file" data-max-file-megabytes="{{ maxFileMegabytes }}" aria-describedby="filesizeRestrictions">
                <div class="invalid-feedback" id="file-upload__file-input-validation" style="display: none"></div>
                <div id="file-upload__file-input-help" class="form-text">The maximum file size is {{ maxFileMegabytes }} MB.</div>
              </div>
            </div>
          </div>


          <div class="card-body" id="file-upload__preview-wrapper" style="display: none;padding: 0;flex-direction: column;justify-content: flex-end;background-color: #e9ecef;">
            <div class="justify-content-center d-flex mt-1" style="height: 100%;align-items: center;">
              <img style="max-height: 200px;" id="file-upload__preview" src="" alt="preview">
            </div>
            <div style="display: flex;justify-content: center;border-top: 1px solid #dfdfdf;background-color: white;">
              <div style="display: flex;justify-content: space-between;width: 100%;">
                <div id="file-upload__open-crop-modal" class="btn-editor c-pointer" style="border-right: 1px solid #dfdfdf;width: 100%;text-align: center;padding: 10px;">
                  <span class="material-icons-outlined" style="vertical-align: sub;font-size: 17px;">crop</span> Crop
                </div>
                <div class="btn-editor c-pointer file-upload__remove" style="width: 100%;text-align: center;padding: 10px;">
                  <span class="material-icons-outlined" style="vertical-align: sub;font-size: 17px;">delete</span> Remove File
                </div>
              </div>
            </div>
          </div>

          <div class="card-body" id="file-upload__file-wrapper" style="display: none;padding: 0;flex-direction: column;justify-content: flex-end;background-color: #e9ecef;">
            <div class="justify-content-center d-flex mt-1" style="height: 100%;align-items: center;">
              <span class="material-icons-outlined" style="font-size: 34px;">insert_drive_file</span>
              <span id="file-upload__file-name" style="margin-left: 10px;"></span>
            </div>
            <div style="display: flex;justify-content: center;border-top: 1px solid #dfdfdf;background-color: white;">
              <div style="width: 100%;">
                <div class="btn-editor c-pointer file-upload__remove" style="width: 100%;text-align: center;padding: 10px;">
                  <span class="material-icons-outlined" style="vertical-align: sub;font-size: 17px;">delete</span> Remove File
                </div>
              </div>
            </div>
          </div>

        </div>
      </div>

      <div class="col">
        <div class="card mb-3">
          <div class="card-body">
            <h5 class="card-title"><span class="material-icons-outlined" style="vertical-align: sub;">auto_delete</span> Self-destruct on expiration</h5>
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
            <div class="card-title d-flex justify-content-between">
              <h5>
                <span class="material-icons-outlined" style="vertical-align: sub;">lock</span> Encryption
              </h5>
              <div class="form-check">
                <input class="form-check-input c-pointer" type="checkbox" value="1" id="file-upload__encrypt-checkbox" name="require_encryption">
                <label class="form-check-label c-pointer" for="file-upload__encrypt-checkbox">Enable</label>
              </div>
            </div>
            <div class="mt-2">
              <div class="mb-2 pt-2">
                <input type="password" class="form-control" id="file-upload__password-input" placeholder="password" name="password" disabled aria-describedby="file-upload__password-validation">
                <div id="file-upload__password-validation" style="display: block"></div>
              </div>
            </div>
          </div>
        </div>

      </div>
    </div>

    <div style="display: flex;justify-content: center;">
      <button type="submit" id="file-upload__submit" class="btn btn-primary btn-lg" disabled><span class="material-icons-outlined" style="vertical-align: sub;margin-right: 3px;">cloud_upload</span> Upload File</button>
    </div>
  </form>

  <div class="modal fade" id="file-upload__crop-modal" tabindex="-1" aria-labelledby="modalLabel" aria-hidden="true" style="display: none;">
    <div class="modal-dialog modal-dialog-centered" role="document">
      <div class="modal-content" id="file-upload__crop-modal-content">
        <div class="modal-header" style="border-bottom: none;padding-bottom: 0;">
          <h5 class="modal-title" style="width: 100%;text-align: center;">Crop the image</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <div class="img-container">
            <img id="file-upload__crop-image" src="" class="w-100">
          </div>
        </div>
        <div class="modal-footer" style="border-top: none;justify-content: center;padding-top: 0;">
          <button type="button" class="btn btn-primary" id="file-upload__crop-apply"><span class="material-icons">check</span> Apply</button>
        </div>
      </div>
    </div>
  </div>
</div>

<div id="file-upload__result" style="display: none;">
  <div class="pb-3 mb-3">
    <div class="card" style="border: none;">
      <div class="card-body">
        <h1 class="card-title ta-c">F<span style="color: mediumturquoise;">i</span>le s<span style="color: darkorange;">a</span>ve<span style="color: brown;">d</span></h1>
        <h6 class="card-subtitle mb-2 text-muted ta-c">Copy and save this links</h6>
        <div class="mt-2 d-flex justify-content-center">

          <div class="p-3 mw-600 mt-3 flex-1">
            <div class="input-group mb-4">
              <span class="input-group-text" id="file-upload__public-label" style="background-color: #212529;color: white;border-color: #212529;">Share</span>
              <input type="text" class="form-control text-center" id="file-upload__public-link" aria-describedby="file-upload__public-label" value="" disabled>
              <button class="btn btn-primary" type="button" id="file-upload__copy-public-link">
                <span class="material-icons va-m">content_copy</span>
              </button>
            </div>

            <div class="input-group mb-3">
              <span class="input-group-text" id="file-upload__private-label">Admin</span>
              <input type="text" class="form-control text-center" id="file-upload__private-link" aria-describedby="file-upload__private-label" value="" disabled>
              <button class="btn btn-outline-primary" type="button" id="file-upload__copy-private-link">
                <span class="material-icons va-m">content_copy</span>
              </button>
            </div>
          </div>

        </div>
      </div>
    </div>

    <div class="d-flex justify-content-center">
      <button class="btn btn-outline-secondary btn-lg" id="file-upload__add-another-file">Add another one</button>
    </div>
  </div>
</div>

<script src="/assets/index.js"></script>
