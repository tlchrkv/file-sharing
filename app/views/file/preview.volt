<div class="p-5 h-100">
  <div class="card h-100" style="border: none;">

    {% if file.isImage() %}
      <div class="card-body" id="file-upload__preview-wrapper" style="display: flex;padding: 0;flex-direction: column;justify-content: flex-end;">
        <div class="justify-content-center d-flex mt-1" style="height: 100%;align-items: center;">
          <img style="max-width: 940px;max-height: calc(100vh - 10rem);" id="preview" src="{{ file.getImageBase64Content() }}" alt="preview">
        </div>
        <div style="display: flex;justify-content: center;background-color: white;">
          <div>
            <div data-encrypted="{{ file.is_encrypted ? 1 : 0 }}" id="downloadButton" class="mt-3 btn btn-primary c-pointer" style="border-right: 1px solid #dfdfdf;width: 100%;text-align: center;padding: 10px;" data-url="/{{ file.public_short_code }}/download">
              <span class="material-icons-outlined" style="vertical-align: sub;font-size: 17px;">file_download</span> Download
            </div>
          </div>
        </div>
      </div>
    {% else %}
      <div class="card-body" id="file-upload__file-wrapper" style="display: flex;padding: 0;flex-direction: column;justify-content: flex-end;">
        <div class="justify-content-center d-flex mt-1" style="height: 100%;align-items: center;">
          <span class="material-icons-outlined" style="font-size: 34px;">insert_drive_file</span>
          <span id="file-upload__file-name" style="margin-left: 10px;">{{ file.original_name }}</span>
        </div>
        <div style="display: flex;justify-content: center;background-color: white;">
          <div>
            <div data-encrypted="{{ file.is_encrypted ? 1 : 0 }}" id="downloadButton" class="mt-3 btn btn-primary c-pointer" style="width: 100%;text-align: center;padding: 10px;" data-url="/{{ file.public_short_code }}/download">
              <span class="material-icons-outlined" style="vertical-align: sub;font-size: 17px;">file_download</span> Download
            </div>
          </div>
        </div>
      </div>
    {% endif %}

  </div>
</div>

<div class="modal fade" id="downloadModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content p-4">
      <form id="download" data-id="{{ file.id }}" method="POST" action="/{{ file.public_short_code }}/download">
        <div class="modal-header" style="border-bottom: none;padding-bottom: 0;">
          <h5 class="modal-title" style="width: 100%;text-align: center;">Enter password</h5>
          {#                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>#}
        </div>
        <div class="modal-body">
          {#                    <h6 class="card-subtitle text-muted text-center mt-1 mb-3">Enter password</h6>#}
          <div class="input-group pt-2">
            <input type="password" class="form-control text-center" id="downloadFilePasswordInput" placeholder="type here..." name="password" style="padding-left: 14%;" required>
            <button type="submit" class="btn btn-primary" id="downloadEncryptedButton"><span class="material-icons">file_download</span></button>
            <div id="downloadFilePasswordMessage" style="display: block;text-align: center;"></div>
          </div>
        </div>
        <div class="modal-footer" style="border-top: none;justify-content: center;padding-top: 0;">
        </div>
      </form>
    </div>
  </div>
</div>
