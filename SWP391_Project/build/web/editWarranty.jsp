<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Edit Warranty</title>
        <link href="CSS/main.css" rel="stylesheet" type="text/css"/>
        <link href="CSS/profile.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css"
              integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <meta charset="utf-8"/>
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <style>
            .mt-6 {
                margin-top: 4.5rem !important;
            }

            .mt-7 {
                margin-top: 6rem !important;
            }

            @media screen and (max-width: 576px) {
                .mt-7 {
                    margin-top: 8rem !important;
                }
            }

            @media screen and (max-width: 720px) {
                .mt-7 {
                    margin-top: 8rem !important;
                }
            }
            .image-preview-container {
                display: flex;
                flex-wrap: wrap;
                margin-top: 20px;
            }
            .image-preview {
                max-width: 100px;
                max-height: 100px;
                margin: 10px;
                object-fit: cover;
            }
            .custom-select {
                width: 20%;
                padding: 10px 15px;
                font-size: 16px;
                line-height: 1.5;
                color: #495057;
                background-color: #fff;
                background-clip: padding-box;
                border: 1px solid #ced4da;
                border-radius: 0.25rem;
                box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.075);
                transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
                margin-top: 10px;
                float:left;
            }
            .custom-select:focus {
                border-color: #80bdff;
                outline: 0;
                box-shadow: 0 0 5px rgba(128, 189, 255, 0.5);
            }
            .containerSpecial {
                display: flex;
                justify-content: space-between;
                align-items: center;
                width: 50%;
            }
            .label {
                margin-right: 10px; /* Adjust the spacing as needed */
            }
            .select {
                flex-grow: 1; /* This allows the select to take the remaining space */
            }
            .btn-return {
                display: inline-block;
                padding: 10px 20px;
                font-size: 16px;
                color: black;
                background-color: white;
                text-align: center;
                text-decoration: none;
                border-radius: 5px;
                position: absolute;
                top: 10px;
                left: 10px;
            }
        </style>
    </head>
    <body>
        <div class="container mt-7" style="min-height: 500px">
            <a href="manageWarranty" class="btn-return"><i class="fa-solid fa-backward"></i> Back to manage warranty</a>
            <!-- Edit Warranty Form -->
            <div class="col-lg-12 pb-5">
                <form class="row mt-lg-5" action="editWarranty?id=${requestScope.warranty.warrantyId}" method="post" enctype="multipart/form-data">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="serial-number-id">Serial Number</label>
                            <input class="form-control" type="text" id="serial-number-id" name="serviceTag" required=""
                                   value="${requestScope.serviceTag}">
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="manager-id">Manager ID</label>
                            <input class="form-control" type="number" id="manager-id" name="managerId" required=""
                                   value="${requestScope.warranty.managerId}">
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="warranty-type">Warranty Type</label>
                            <input class="form-control" type="number" id="warranty-type" name="warrantyType" required=""
                                   value="${requestScope.warranty.warrantyType}">
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="guarantee-date">Guarantee Date</label>
                            <input class="form-control" type="date" id="guarantee-date" name="guaranteeDate" required=""
                                   value="${requestScope.warranty.guaranteeDate}">
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="status">Status</label>
                            <input class="form-control" type="text" id="status" name="status" required=""
                                   value="${requestScope.warranty.status}">
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="isDone">isDone</label>
                            <select  class="form-select" id="news" name="isDone">
                                <option value="true" <c:if test="${requestScope.warranty.isDone eq true}">selected</c:if>>yes</option>
                                <option value="false" <c:if test="${requestScope.warranty.isDone eq false}">selected</c:if>>no</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="form-group">
                                <label for="fileInput">Choose product images:</label>
                                <input
                                    style="caret-color: black;"
                                    id="fileInput"
                                    type="file"
                                    accept="image/*"
                                    name="images"
                                    multiple
                                    />
                                <div id="imagePreviewContainer" class="image-preview-container">
                                <c:forEach var="image" items="${requestScope.warranty.images.split(',')}">
                                    <img src="${pageContext.request.contextPath}/${image}" class="image-preview" alt="Image Preview">
                                    <input type="hidden" name="existingImages" value="${image}">
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                    <div class="col-12">
                        <hr class="mt-2 mb-3">
                        <div class="d-flex flex-wrap justify-content-between align-items-center">
                            <button class="btn btn-style-1 btn-primary" type="submit">Update Warranty</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </body>
    <script>
        document.getElementById('fileInput').addEventListener('change', function (event) {
            const files = event.target.files;
            const imagePreviewContainer = document.getElementById('imagePreviewContainer');
            imagePreviewContainer.innerHTML = ''; // Clear any existing previews
            if (files.length > 0) {
                Array.from(files).forEach(file => {
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        const img = document.createElement('img');
                        img.src = e.target.result;
                        img.classList.add('image-preview');
                        imagePreviewContainer.appendChild(img);
                    }
                    reader.readAsDataURL(file);
                });
            }
        });

        document.querySelector('form').addEventListener('submit', function (event) {
            var fileInput = document.getElementById('fileInput');
            var files = fileInput.files;
            for (let i = 0; i < files.length; i++) {
                var fileType = files[i].type.split('/')[0];
                if (fileType !== 'image') {
                    alert('Please choose only image files.');
                    event.preventDefault(); // Prevent form submission
                    return;
                }
            }
        });
    </script>
</html>
