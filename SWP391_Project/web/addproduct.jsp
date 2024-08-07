<%-- 
    Document   : addproduct
    Created on : Jul 9, 2024, 10:56:12 PM
    Author     : ADMIN
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html" ; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>BLAZO | ADD PRODUCT</title>
        <link rel="icon" href="media/icon/addproduct.png"/>
        <link href="vendors/feather/feather.css" rel="stylesheet">
        <link href="vendors/mdi/css/materialdesignicons.min.css" rel="stylesheet">
        <link href="vendors/ti-icons/css/themify-icons.css" rel="stylesheet">
        <link href="vendors/typicons/typicons.css" rel="stylesheet">
        <link href="vendors/simple-line-icons/css/simple-line-icons.css" rel="stylesheet">
        <link href="vendors/css/vendor.bundle.base.css" rel="stylesheet">
        <link href="vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet"/>
        <!-- endinject -->
        <!-- Plugin css for this page -->
        <%--    <link href="vendors/datatables.net-bs4/dataTables.bootstrap4.css" rel="stylesheet">--%>
        <link href="js/dashboard/select.dataTables.min.css" rel="stylesheet">
        <!-- End plugin css for this page -->
        <!-- inject:css -->
        <link href="CSS/dashboardcss/vertical-layout-light/style.css" rel="stylesheet">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>

        <style>
            .vh-25 {
                height: 25vh !important;
            }
            main {
                margin: 2% 5%;
            }

            .title {
                margin: 2% 0 !important;
            }

            .refinement-list {
                width: 200px;
                padding: 10px;
            }

            .list {
                list-style: none;
            }

            .container {
                display: block;
                position: relative;
                padding-left: 35px;
                margin-bottom: 5px;
                cursor: pointer;
                font-size: 14px;
                -webkit-user-select: none;
                -moz-user-select: none;
                -ms-user-select: none;
                user-select: none;
            }

            .container input {
                position: absolute;
                opacity: 0;
                cursor: pointer;
                height: 0;
                width: 0;
            }


            .checkmark {
                position: absolute;
                top: 0;
                left: 0;
                height: 16px;
                width: 16px;
                background-color: #eee;
            }

            .container:hover input~.checkmark {
                background-color: #ccc;
            }

            .container input:checked~.checkmark {
                background-color: #9f8a46;
            }

            .checkmark:after {
                content: '';
                position: absolute;
                display: none;
            }

            .container input:checked~.checkmark:after {
                display: block;
            }

            .container .checkmark:after {
                left: 5px;
                top: 1.5px;
                width: 3px;
                height: 7px;
                border: solid white;
                border-width: 0 3px 3px 0;
                -webkit-transform: rotate(45deg);
                -ms-transform: rotate(45deg);
                transform: rotate(45deg);
            }

            /*            .column1 {
                            float: left;
                            width: 20%;
                        }
            
                        .column2 {
                            float: right;
                            width: 80%;
                            padding: 10px;
                        }*/

            /*            .row:after {
                            content: '';
                            display: table;
                            clear: both;
                        }*/

            h3 {
                margin: 2% 0;
            }

            .page-btn {
                display: flex;
                justify-content: center;
            }

            .page-btn a {
                text-decoration: none;
                display: inline-block;
                padding: 8px 14px;
                font-size: 15px;
            }

            .page-btn a:hover {
                background-color: #ddd;
                color: black;
            }

            .page-btn .previous,
            .page-btn .next1 {
                border-radius: 5px;
                border: 1px solid black;
                color: black;
                width: 110px;
                text-align: center;
                margin: 1%;
            }

            .center {
                text-align: center;
            }
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f8f9fa;
            }

            .navbar {
                background-color: #343a40;
                color: white;
                padding: 1em;
                text-align: center;
            }

            /*            .container {
                            padding: 5em;
                            position: relative;
                        }*/

            .table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 1em;
            }

            th, td {
                border: 1px solid #dee2e6;
                padding: 8px;
                text-align: left;
            }

            th {
                background-color: #e9ecef;
            }

            .modaledit {
                display: block;
                /*                position: fixed;*/
                z-index: 1;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                overflow: auto;
                /*                background-color: rgba(0,0,0,0.5);*/
                padding-top: 1em;
            }

            .modaledit-content {
                background-color: #fff;
                margin: 5% auto;
                padding: 20px;
                border: 1px solid #888;
                border-radius: 4px;
                width: 80%;
                max-width: 600px;
            }

            .closeBtn {
                color: #aaa;
                float: right;
                font-size: 28px;
                /*                margin-bottom: 10%;*/
                font-weight: bold;
            }

            .addBtn {
                color: #aaa;
                float: right;
                font-size: 28px;
                font-weight: bold;
            }

            .addBtn:hover,
            .addBtn:focus {
                color: black;
                text-decoration: none;
                cursor: pointer;
            }

            .closeBtn:hover,
            .closeBtn:focus {
                color: black;
                text-decoration: none;
                cursor: pointer;
            }

            .form {
                display: flex;
                flex-direction: column;
            }

            .form-group {
                margin-bottom: 1em;
            }

            .form-control {
                width: 100%;
                padding: 0.5em;
                font-size: 1em;
                border: 1px solid #ced4da;
                border-radius: 4px;
            }

            .footer {
                background-color: #343a40;
                color: white;
                text-align: center;
                padding: 1em;
                /*                                position: fixed;*/
                bottom: 0;
                width: 100%;
            }
            .center {
                text-align: center;
            }

            /*            .pagination {
                            display: inline-block;
                        }
            
                        .pagination a {
                            color: black;
                            float: left;
                            padding: 8px 16px;
                            text-decoration: none;
                            transition: background-color .3s;
                            border: 1px solid #ddd;
                            margin: 0 4px;
                        }
            
            */                        .pagination a.active {
                background-color: #4CAF50;
                color: white;
                border: 1px solid #4CAF50;
            }/*

            .pagination a:hover:not(.active) {
                background-color: #ddd;
            }*/
            .mt-1, .editable-container.editable-inline .editableform .control-group .editable-buttons .editable-submit, .editable-container.editable-inline .editableform .control-group .editable-buttons .editable-cancel {
                margin-top: 0.25rem !important;
            }
            /*            .row {
                            flex-direction: column;
                        }*/
            .title {
                text-align: left;
                font-size: 24px;
                /*                margin: 0 11%;*/
                margin-top: 2%;
                padding: 1%;
                color: #D20062;
                font-weight: 700;
                text-transform: uppercase;
                border-style: none none inset none;
            }
            .list {
                list-style: none;
            }
            .containercheck {
                display: block;
                position: relative;
                padding-left: 35px;
                margin-bottom: 5px;
                cursor: pointer;
                font-size: 14px;
                -webkit-user-select: none;
                -moz-user-select: none;
                -ms-user-select: none;
                user-select: none;
            }

            .containercheck input {
                position: absolute;
                opacity: 0;
                cursor: pointer;
                height: 0;
                width: 0;
            }


            .checkmark {
                position: absolute;
                top: 0;
                left: 0;
                height: 16px;
                width: 16px;
                background-color: #eee;
            }

            .containercheck:hover input~.checkmark {
                background-color: #ccc;
            }

            .containercheck input:checked~.checkmark {
                background-color: #9f8a46;
            }

            .checkmark:after {
                content: '';
                position: absolute;
                display: none;
            }

            .containercheck input:checked~.checkmark:after {
                display: block;
            }

            .containercheck .checkmark:after {
                left: 5px;
                top: 1.5px;
                width: 3px;
                height: 7px;
                border: solid white;
                border-width: 0 3px 3px 0;
                -webkit-transform: rotate(45deg);
                -ms-transform: rotate(45deg);
                transform: rotate(45deg);
            }
            .dropdown,.dropup{
                position:relative
            }
            .dropdown-toggle::after{
                display:inline-block;
                width:0;
                height:0;
                margin-left:.255em;
                vertical-align:.255em;
                content:"";
                border-top:.3em solid;
                border-right:.3em solid transparent;
                border-bottom:0;
                border-left:.3em solid transparent
            }
            .dropdown-toggle:empty::after{
                margin-left:0
            }
            .dropdown-menu{
                position:absolute;
                top:100%;
                left:0;
                z-index:1000;
                display:none;
                float:left;
                min-width:10rem;
                padding:.5rem 0;
                margin:.125rem 0 0;
                font-size:1rem;
                color:#212529;
                text-align:left;
                list-style:none;
                background-color:#fff;
                background-clip:padding-box;
                border:1px solid rgba(0,0,0,.15);
                border-radius:.25rem
            }
            .column1 {
                float: left;
                width: 20%;
            }

            .column2 {
                float: left;
                width: 80%;
                padding: 1em;
            }
            .writeform{
                width: 80%;
                padding: 10px;
                box-sizing: border-box;
                background: none;
                outline: none;
                resize: none;
                border: 0;
                transition: all 0.3s;
                border-bottom: 3px inset;
            }
            @media screen and (max-width:576px){
                .column1 {
                    width: 100%;
                }

                .column2 {
                    width: 100%;
                }

            }

            .image-gallery {
                display: flex;
                flex-wrap: wrap;
                gap: 10px; /* khoảng cách giữa các hình ảnh */
            }

            .image-container {
                flex: 0 0 auto;
                display: flex;
                flex-direction: column;
                align-items: center;
            }
        </style>
        <script src="ckeditor5/ckeditor5-build-classic/ckeditor.js"></script>
    </head>
    <body>
        <div class="container-scroller"> 
            <!-- partial:partials/_navbar.html -->
            <jsp:include page="dashboardHeadPart.jsp" />
            <!-- partial -->
            <div class="container-fluid page-body-wrapper">
                <!-- partial:partials/_sidebar.html -->
                <jsp:include page="dashboardLeftPart.jsp" />
                <!-- partial -->
                <div class="main-panel">
                    <div class="content-wrapper">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="home-tab">
                                    <div class="d-sm-flex align-items-center justify-content-between border-bottom">
                                        <div>
                                            <div class="btn-wrapper">
                                                <a href="#" class="btn btn-otline-dark align-items-center"><i class="icon-share"></i> Share</a>
                                                <a href="#" class="btn btn-otline-dark"><i class="icon-printer"></i> Print</a>
                                                <a href="#" class="btn btn-primary text-white me-0"><i class="icon-download"></i> Export</a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tab-content tab-content-basic">
                                        <div class="tab-pane fade show active" id="overview" role="tabpanel" aria-labelledby="overview"> 
                                            <div class="card">
                                                <div class="card-body">
                                                    <a href="manageproduct">
                                                        <span class="closeBtn">
                                                            <img title="Back to product management page" src="media/icon/previous.png" width="40" height="40"/>
                                                        </span>
                                                    </a>
                                                    <h5 class="card-title">Add Product</h5>
                                                    
                                                    <form id="productForm" action="addproduct" class="form-sample" method="post" enctype="multipart/form-data">
                                                        <div class="form-group">
                                                            <label for="productName">Product name</label>
                                                            <input type="text" id="productName" name="title" class="form-control" required>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="productCategory">Category</label>
                                                            <select id="productCategory" name="cid" class="form-select" required>
                                                                <c:forEach items="${requestScope.categories}" var="category">
                                                                    <option value="${category.getCategoryId()}">${category.getTitle()}</option>
                                                                </c:forEach>
                                                            </select>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="productStock">Product Stock</label>
                                                            <input type="number" id="productStock" min="0" name="stock" class="form-control" required>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="productPrice">Product Price (VNĐ)</label>
                                                            <input step="0.01" type="number" id="productPrice" min="0" name="price" class="form-control" required>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="productDescription">Description</label>
                                                            <textarea id="productDescription" name="description" class="form-control vh-25"></textarea>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="productPeriod">Warranty Period (months)</label>
                                                            <input name="period" type="number" min="0" id="productPeriod" required class="form-control"/>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="productImage">Images (Accept file formats: xbm, tif, apng, pjp, svgz, jpg, jpeg, ico,
                                                                tiff, gif, svg, jfif, webp, png, bmp, pjpeg, avif)</label>
                                                            <input id="productImage" type="file" name="image" class="form-control"
                                                                   accept=".xbm, .tif, .apng, .pjp, .svgz, .jpg, .jpeg, .ico, .tiff, .gif, .svg, .jfif, .webp, .png, .bmp, .pjpeg, .avif"
                                                                   required/>
                                                        </div>
                                                        <div class="form-group">
                                                            <img id="previewImage" src="" alt="Image preview" style="display: none;" width="80" height="80"/>
                                                        </div>
                                                        <span id="addImageBtn" class="closeBtn" style="margin-top: 1%;">+</span>
                                                        <button type="submit" id="submitBtn" class="btn btn-success">Add product</button>

                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- content-wrapper ends -->
                </div>
                <!-- main-panel ends -->
            </div>
            <!-- page-body-wrapper ends -->
        </div>
        <!-- container-scroller -->
    </body>
    <script>
        document.getElementById('productForm').addEventListener('submit', function (event) {
            var descriptionField = document.getElementById('productDescription');
            descriptionField.value = descriptionField.value.replace(/\n/g, '<br>');
        });
    </script>
    <script>

        document.addEventListener('change', function (event) {
            if (event.target && event.target.className === 'form-control' && event.target.type === 'file') {
                const file = event.target.files[0];
                const allowedTypes = ['image/xbm', 'image/tif', 'image/apng', 'image/pjp', 'image/svgz', 'image/jpg', 'image/jpeg', 'image/ico', 'image/tiff', 'image/gif', 'image/svg', 'image/jfif', 'image/webp', 'image/png', 'image/bmp', 'image/pjpeg', 'image/avif'];

                if (!allowedTypes.includes(file.type)) {
                    alert('Vui lòng chọn đúng định dạng file hình ảnh.');
                    event.target.value = '';
                }
            }
        });
    </script>
    <script>
        document.getElementById('productImage').addEventListener('change', function (event) {
            handleFileSelect(event);
        });

        document.getElementById('addImageBtn').addEventListener('click', function () {
            // Tạo một div chứa trường chọn tệp và nút xoá
            const inputGroup = document.createElement('div');
            inputGroup.className = 'form-group';

            // Tạo một trường chọn tệp mới
            const newInput = document.createElement('input');
            newInput.type = 'file';
            newInput.name = 'image';
            newInput.className = 'form-control';
            newInput.required = false;
            newInput.accept = '.xbm, .tif, .apng, .pjp, .svgz, .jpg, .jpeg, .ico, .tiff, .gif, .svg, .jfif, .webp, .png, .bmp, .pjpeg, .avif';

            // Gán sự kiện change để xử lý hiển thị ảnh xem trước
            newInput.addEventListener('change', function (event) {
                handleFileSelect(event);
            });

            // Tạo nút xoá
            const minusBtn = document.createElement('span');
            minusBtn.textContent = '-';
            minusBtn.className = 'addBtn';
            minusBtn.style.cursor = 'pointer';
            minusBtn.style.fontSize = '28px';
            minusBtn.addEventListener('click', function () {
                inputGroup.remove(); // Xoá div chứa trường chọn tệp và nút xoá khi nút '-' được nhấn
            });

            // Gắn trường chọn tệp và nút xoá vào div inputGroup
            inputGroup.appendChild(newInput);
            inputGroup.appendChild(minusBtn);

            // Lấy form và thêm div chứa trường chọn tệp và nút xoá vào form
            const form = document.getElementById('productForm');
            form.insertBefore(inputGroup, addImageBtn); // Chèn trước nút 'Thêm Ảnh'

            const outputGroup = document.createElement('div');
            outputGroup.className = 'form-group';

            const newOutput = document.createElement('img');
            newOutput.src = '';
            newOutput.alt = 'Image preview';
            newOutput.style.display = 'none';
            newOutput.width = 80;
            newOutput.height = 80;

            outputGroup.appendChild(newOutput);

            form.insertBefore(outputGroup, addImageBtn);
        });

        function handleFileSelect(event) {
            const file = event.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function (e) {
                    let previewImage = event.target.nextElementSibling;
                    if (!previewImage || previewImage.tagName !== 'IMG') {
                        previewImage = document.createElement('img');
                        previewImage.style.display = 'block';
                        previewImage.width = 80;
                        previewImage.height = 80;
                        event.target.parentNode.insertBefore(previewImage, event.target.nextSibling);
                    }
                    previewImage.src = e.target.result;
                    previewImage.style.display = 'block';
                }
                reader.readAsDataURL(file);
            }
        }
    </script>

    <script>
        // Khai báo hàm MyCustomUploadAdapterPlugin và MyUploadAdapter một lần duy nhất
        function MyCustomUploadAdapterPlugin(editor) {
            editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
                return new MyUploadAdapter(loader);
            };
        }

        class MyUploadAdapter {
            constructor(loader) {
                this.loader = loader;
                this.reader = new FileReader();
            }

            upload() {
                return this.loader.file
                        .then(file => new Promise((resolve, reject) => {
                                this._initListeners(resolve, reject);
                                this.reader.readAsDataURL(file);
                            }));
            }

            _initListeners(resolve, reject) {
                this.reader.onload = () => resolve({default: this.reader.result});
                this.reader.onerror = error => reject(error);
            }

            abort() {
                this.reader.abort();
            }
        }

        // Khởi tạo CKEditor cho productDescription
        ClassicEditor
                .create(document.querySelector('#productDescription'), {
                    extraPlugins: [MyCustomUploadAdapterPlugin],
                    image: {
                        toolbar: ['imageTextAlternative', 'imageStyle:full', 'imageStyle:side']
                    }
                })
                .catch(error => {
                    console.error(error);
                });


    </script>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</html>
