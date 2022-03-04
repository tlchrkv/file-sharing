<div id="deleted" style="display: none;">
    <div class="d-flex flex-column align-items-center justify-content-center">
        <div><span class="material-icons" style="font-size: 60px;vertical-align: bottom;margin-bottom: 20px;">done</span></div>
        <h1 class="mb-4">Deleted</h1>
        <div class="mt-3">
            <a href="/" type="button" class="btn btn-lg btn-outline-secondary">Upload new file</a>
        </div>
    </div>
</div>

<div id="manage">
    <div>
        <h1 style="text-align: center;" class="mb-4"><span style="color: #0d6efd;">A</span>dmin ar<span style="color: darkcyan;">e</span>a</h1>
        <div class="my-5"></div>
    </div>

    <div class="row pb-3 mb-3">
        <div class="col col-left">
            <div class="card h-100">

                {% if file.isImage() %}
                <div class="card-body" id="file-upload__preview-wrapper" style="display: flex;padding: 0;flex-direction: column;justify-content: flex-end;background-color: #e9ecef;">
                    <div class="justify-content-center d-flex mt-1" style="height: 100%;align-items: center;">
                        <img style="max-height: 200px;" id="preview" src="{{ file.getImageBase64Content() }}" alt="preview">
                    </div>
                    <div style="display: flex;justify-content: center;border-top: 1px solid #dfdfdf;background-color: white;">
                        <div style="display: flex;justify-content: space-between;width: 100%;">
                            <div id="downloadButton" class="btn-editor c-pointer" style="border-right: 1px solid #dfdfdf;width: 100%;text-align: center;padding: 10px;" data-url="/{{ file.public_short_code }}">
                                <span class="material-icons-outlined" style="vertical-align: sub;font-size: 17px;">file_download</span> Download
                            </div>
                            <div id="cropButton" class="btn-editor c-pointer" style="width: 100%;text-align: center;padding: 10px;">
                                <span class="material-icons-outlined" style="vertical-align: sub;font-size: 17px;">crop</span> Crop
                            </div>
                            <div id="updateButton" class="btn-editor c-pointer" data-id="{{ file.id }}" style="display: none;border-left: 1px solid #dfdfdf;width: 100%;text-align: center;padding: 10px;">
                                <span class="material-icons-outlined" style="vertical-align: sub;font-size: 17px;">file_upload</span> Update
                            </div>
                        </div>
                    </div>
                </div>
                {% else %}
                <div class="card-body" id="file-upload__file-wrapper" style="display: flex;padding: 0;flex-direction: column;justify-content: flex-end;background-color: #e9ecef;">
                    <div class="justify-content-center d-flex mt-1" style="height: 100%;align-items: center;">
                        <span class="material-icons-outlined" style="font-size: 34px;">insert_drive_file</span>
                        <span id="file-upload__file-name" style="margin-left: 10px;">{{ file.original_name }}</span>
                    </div>
                    <div style="display: flex;justify-content: center;border-top: 1px solid #dfdfdf;background-color: white;">
                        <div style="width: 100%;">
                            <div id="downloadButton" class="btn-editor c-pointer" style="width: 100%;text-align: center;padding: 10px;" data-url="/{{ file.public_short_code }}">
                                <span class="material-icons-outlined" style="vertical-align: sub;font-size: 17px;">file_download</span> Download
                            </div>
                        </div>
                    </div>
                </div>
                {% endif %}

            </div>
        </div>

        <div class="col">
            <div class="card mb-3">
                <div class="card-body">
                    <h5 class="card-title">Encryption</h5>
                    <h6 class="card-subtitle mb-2 mt-2 text-muted">
                        {% if file.is_encrypted %}
                            <span id="encryptionStatusEncrypted">File is encrypted</span>
                            <span id="encryptionStatusDecrypted" style="display: none">File is not encrypted</span>
                        {% else %}
                            <span id="encryptionStatusEncrypted" style="display: none">File is encrypted</span>
                            <span id="encryptionStatusDecrypted">File is not encrypted</span>
                        {% endif %}
                    </h6>
                    <div class="mt-3">
                        {% if file.is_encrypted %}
                            <button id="encryptOpenModal" type="button" class="btn btn-outline-dark" style="display: none;">
                                <span class="material-icons-outlined" style="vertical-align: bottom;">lock</span>
                                Encrypt
                            </button>
                            <button id="decryptOpenModal" type="button" class="btn btn-outline-dark">
                                <span class="material-icons-outlined" style="vertical-align: bottom;">lock_open</span>
                                Decrypt
                            </button>
                        {% else %}
                            <button id="encryptOpenModal" type="button" class="btn btn-outline-dark">
                                <span class="material-icons-outlined" style="vertical-align: bottom;">lock</span>
                                Encrypt
                            </button>
                            <button id="decryptOpenModal" type="button" class="btn btn-outline-dark" style="display: none;">
                                <span class="material-icons-outlined" style="vertical-align: bottom;">lock_open</span>
                                Decrypt
                            </button>
                        {% endif %}
                    </div>
                </div>
            </div>

            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Deletion</h5>
                    <h6 class="card-subtitle mb-2 mt-2 text-muted">File will be automatically deleted after {{ file.getExpiresInDaysHours() }}</h6>
                    <div class="mt-3">
                        <button type="button" class="btn btn-outline-danger" id="deleteNowButton">
                            <span class="material-icons-outlined" style="vertical-align: bottom;">delete</span>
                            Delete Now
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

{#    <div class="d-flex align-items-center mt-4 me-md-auto text-dark text-decoration-none" style="flex: 1;justify-content: center;">#}
{#        <span class="fs-4" style="color: #d0d0d0;font-family: monospace;font-size: 20px !important;font-weight: bold;">{{ appName }}</span>#}
{#    </div>#}
</div>

<div class="modal fade" id="downloadModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content p-4">
            <form id="download" data-id="{{ file.id }}" method="POST" action="/{{ file.public_short_code }}">
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

<div class="modal fade" id="updateEncryptedModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content p-4">
            <form id="updateEncryptedFile" data-id="{{ file.id }}">
                <div class="modal-header" style="border-bottom: none;padding-bottom: 0;">
                    <h5 class="modal-title" id="exampleModalLabel" style="width: 100%;text-align: center;">Enter password</h5>
{#                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>#}
                </div>
                <div class="modal-body">
{#                    <h6 class="card-subtitle text-muted text-center mt-1 mb-3">Enter password</h6>#}
                    <div class="input-group pt-2">
                        <input type="password" class="form-control text-center" id="updateEncryptedFilePasswordInput" placeholder="type here..." name="password" style="padding-left: 14%;" required>
                        <button type="submit" class="btn btn-primary" id="updateEncryptedButton"><span class="material-icons">navigate_next</span></button>
                        <div id="updateEncryptedFilePasswordMessage" style="display: block;text-align: center;"></div>
                    </div>
                </div>
                <div class="modal-footer" style="border-top: none;justify-content: center;padding-top: 0;">
                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal fade" id="encryptionModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content p-4">
            <form id="encryptFileForm" data-id="{{ file.id }}">
                <div class="modal-header" style="border-bottom: none;padding-bottom: 0;">
                    <h5 class="modal-title" id="exampleModalLabel" style="width: 100%;text-align: center;">You need to set password</h5>
{#                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>#}
                </div>
                <div class="modal-body">
{#                    <h6 class="card-subtitle text-muted text-center mt-1 mb-3">You need to set password</h6>#}
                    <div class="input-group pt-2">
                        <input type="password" class="form-control text-center" id="encryptFilePasswordInput" placeholder="type here..." name="password" style="padding-left: 14%;" required>
                        <button type="submit" class="btn btn-primary"><span class="material-icons">navigate_next</span></button>
                        <div id="encryptFilePasswordMessage" style="display: block;text-align: center;"></div>
                    </div>
                </div>
                <div class="modal-footer" style="border-top: none;justify-content: center;padding-top: 0;">
                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal fade" id="decryptionModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content p-4">
            <form id="decryptFileForm" data-id="{{ file.id }}">
                <div class="modal-header" style="border-bottom: none;padding-bottom: 0;">
                    <h5 class="modal-title" id="exampleModalLabel" style="width: 100%;text-align: center;">Enter password</h5>
{#                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>#}
                </div>
                <div class="modal-body">
{#                    <h6 class="card-subtitle text-muted text-center mt-1 mb-3">Enter password</h6>#}
                    <div class="input-group pt-2">
                        <input type="password" class="form-control text-center" id="decryptFilePasswordInput" placeholder="type here..." name="password" style="padding-left: 14%;" required>
                        <button type="submit" class="btn btn-primary"><span class="material-icons">navigate_next</span></button>
                        <div id="decryptFilePasswordMessage" style="display: block;text-align: center;"></div>
                    </div>
                </div>
                <div class="modal-footer" style="border-top: none;justify-content: center;padding-top: 0;">
                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal fade" id="deleteNowModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content p-4">
            <form id="deleteFileForm" data-id="{{ file.id }}">
                <div class="modal-header" style="border-bottom: none;padding-bottom: 0;">
                    <h5 class="modal-title" id="exampleModalLabel" style="width: 100%;text-align: center;">Delete file now</h5>
{#                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>#}
                </div>
                <div class="modal-body">
                    <h6 class="card-subtitle text-muted text-center mt-1 mb-3">Are you sure want to delete current file and associated links?</h6>
                </div>
                <div class="modal-footer" style="border-top: none;justify-content: center;padding-top: 0;">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                        <span class="material-icons-outlined" style="vertical-align: bottom;">block</span>
                        No
                    </button>
                    <button type="submit" class="btn btn-outline-danger">
                        <span class="material-icons-outlined" style="vertical-align: bottom;">delete</span>
                        Yes, Delete
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

{% if file.isImage() %}
<div class="modal fade" id="cropImageModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content" id="modalContent">
            <div class="modal-header" style="border-bottom: none;padding-bottom: 0;">
                <h5 class="modal-title" style="width: 100%;text-align: center;">Crop the image</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="img-container">
                    <img id="image" src="{{ file.getImageBase64Content() }}" class="w-100">
                </div>
            </div>
            <div class="modal-footer" style="border-top: none;justify-content: center;padding-top: 0;">
                <button type="button" class="btn btn-primary" id="crop"><span class="material-icons">check</span> Apply</button>
            </div>
        </div>
    </div>
</div>
{% endif %}

<script src="/assets/admin.js"></script>
