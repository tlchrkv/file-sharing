<div class="row pb-3 mb-3">
    <div class="col">
        <div class="card">
            <div class="card-body">
                <h5 class="card-title">File</h5>
                <div class="mt-4">
                    <div id="previewDiv">
                        <img class="w-100" id="preview" src="{{ file.getImageBase64Content() }}">
                    </div>
                </div>
                <div class="mt-3">
                    <button type="submit" class="btn btn-primary">Crop</button>
                    <button type="submit" class="btn btn-primary">Download</button>
                </div>
            </div>
        </div>
    </div>

    <div class="col">
        <div class="card mb-3">
            <div class="card-body">
                <h5 class="card-title">Encryption</h5>
                <div class="mt-3">
                    <button type="submit" class="btn btn-primary">Encrypt</button>
                </div>
            </div>
        </div>

        <div class="card">
            <div class="card-body">
                <h5 class="card-title">Deletion</h5>
                <h6 class="card-subtitle mb-2 mt-2 text-muted">File will be deleted after {{ file.getExpiresInDaysHours() }}</h6>
                <div class="mt-3">
                    <button type="submit" class="btn btn-primary">Delete Now</button>
                </div>
            </div>
        </div>
    </div>
</div>

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
                <button type="button" class="btn btn-primary" id="crop">Crop & Update File</button>
            </div>
        </div>
    </div>
</div>
