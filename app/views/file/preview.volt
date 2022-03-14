<div class="p-5 h-100" data-csrf="{{ password64 }}">
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

<form action="/{{ file.public_short_code }}/download" method="post" id="downloadForm">
  <input type="hidden" value="{{ password64 }}" name="password64">
</form>
