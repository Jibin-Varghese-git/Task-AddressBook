 <div class="modal fade" id="modalUpload" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <form method="post" enctype="multipart/form-data" id="uploadXslForm">
                            <div class="modalUploadBox modal-content p-2">

                                <div class="topBox d-flex">
                                        <button class="dataFileBtn me-1" onclick="funXls()">File With Data</button>
                                        <button class="plainFileBtn ms-2" onclick="funPlainXls()">Plain File</button>
                                </div>

                                <div class="midBox  p-3">
                                    <div class="heading my-4">
                                        <span>Upload Excel File</span>
                                    </div>
                                    <div class="uploadBox">
                                        <span>Upload Excel *</span><br>
                                        <input type="file" id="uploadedXls">
                                        <span class="fw-bold text-danger" id="uploadXlsError"></span>
                                    </div>
                                </div>

                                <div class="modal-footer btmBox">
                                    <button type="button" class="modalSubmitBtn" onclick="funReadXls()">Submit</button>
                                    <button type="button" class="modalCloseBtn" onclick="funCloseModal()" data-bs-dismiss="modal">Close</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                