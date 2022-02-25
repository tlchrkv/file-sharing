<div id="deleted" style="display: none">
    <div class="card">
        <div class="card-body">
            <h5 class="card-title">This file and links have been deleted</h5>
            <div class="mt-3">
                <a href="/" type="button" class="btn btn-primary">Upload New File</a>
            </div>
        </div>
    </div>
</div>

<div class="row pb-3 mb-3" id="manage">
    <div class="col">
        <div class="card">
            <div class="card-body">
                <h5 class="card-title">{{ file.original_name }}</h5>
                <div class="mt-4">
                    {% if file.isImage() %}
                        <div id="previewDiv">
                            <img class="w-100" id="preview" src="{{ file.getImageBase64Content() }}">
                        </div>
                    {% else %}
                        <span class="material-icons-outlined">insert_drive_file</span>
                    {% endif %}
                </div>
                <div class="mt-3">
                    {% if file.isImage() %}
                        <button type="button" class="btn btn-primary" id="cropButton">Crop</button>
                        <button type="button" class="btn btn-primary" id="updateButton" style="display: none;" data-id="{{ file.id }}">Update</button>
                    {% endif %}

                    <button type="button" class="btn btn-primary" id="downloadButton" data-url="/{{ file.public_short_code }}">Download</button>
                </div>
            </div>
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
                        <button id="encryptOpenModal" type="button" class="btn btn-primary" style="display: none;">
                            Encrypt
                        </button>
                        <button id="decryptOpenModal" type="button" class="btn btn-primary">
                            Decrypt
                        </button>
                    {% else %}
                        <button id="encryptOpenModal" type="button" class="btn btn-primary">
                            Encrypt
                        </button>
                        <button id="decryptOpenModal" type="button" class="btn btn-primary" style="display: none;">
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
                    <button type="button" class="btn btn-primary" id="deleteNowButton">
                        Delete Now
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="downloadModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form id="download" data-id="{{ file.id }}" method="POST" action="/{{ file.public_short_code }}">
                <div class="modal-header">
                    <h5 class="modal-title">Download file</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <label for="downloadFilePasswordInput">Enter password:</label>
                    <div class="mb-2 pt-2">
                        <input type="password" class="form-control" id="downloadFilePasswordInput" placeholder="Password" name="password" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary" id="downloadEncryptedButton">Download</button>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal fade" id="updateEncryptedModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form id="updateEncryptedFile" data-id="{{ file.id }}">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Update encrypted file</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <label for="updateEncryptedFilePasswordInput">Enter password:</label>
                    <div class="mb-2 pt-2">
                        <input type="password" class="form-control" id="updateEncryptedFilePasswordInput" placeholder="Password" name="password" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary" id="updateEncryptedButton">Update File</button>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal fade" id="encryptionModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form id="encryptFileForm" data-id="{{ file.id }}">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Encrypt file</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <label for="encryptFilePasswordInput">You need to set password:</label>
                    <div class="mb-2 pt-2">
                        <input type="password" class="form-control" id="encryptFilePasswordInput" placeholder="Password" name="password" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary">Encrypt</button>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal fade" id="decryptionModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form id="decryptFileForm" data-id="{{ file.id }}">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Decrypt file</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <label for="decryptFilePasswordInput">Enter password:</label>
                    <div class="mb-2 pt-2">
                        <input type="password" class="form-control" id="decryptFilePasswordInput" placeholder="Password" name="password" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary">Decrypt</button>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal fade" id="deleteNowModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form id="deleteFileForm" data-id="{{ file.id }}">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Delete file now</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    Are you sure want to delete current file and associated links?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">No</button>
                    <button type="submit" class="btn btn-primary">Yes, Delete</button>
                </div>
            </form>
        </div>
    </div>
</div>

{% if file.isImage() %}
<div class="modal fade" id="cropImageModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content" id="modalContent">
            <div class="modal-header">
                <h5 class="modal-title">Crop the image</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="img-container">
                    <img id="image" src="{{ file.getImageBase64Content() }}" class="w-100">
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="crop">Crop</button>
            </div>
        </div>
    </div>
</div>
{% endif %}

<script src="/assets/manage.js"></script>
