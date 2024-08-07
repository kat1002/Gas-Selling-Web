<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html" ; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>BLAZO | ADD WARRANTY</title>
        <link rel="icon" href="media/icon/quality.png"/>
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
        </style>
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
                                    <div class="tab-content tab-content-basic">
                                        <div class="tab-pane fade show active" id="overview" role="tabpanel" aria-labelledby="overview"> 
                                            <div class="card">
                                                <div class="card-body">
                                                    <a href="manageWarranty">
                                                        <span class="closeBtn">
                                                            <img title="Back to voucher management page" src="media/icon/previous.png" width="40" height="40"/>
                                                        </span>
                                                    </a>
                                                    <h5 class="card-title">Add Warranty</h5>

                                                    <form id="warrantyForm" action="addWarranty" class="form-sample" method="post" enctype="multipart/form-data">


                                                        <div class="form-group">
                                                            <label for="serial-number-id">Serial Number</label>
                                                            <input class="form-control" type="text" id="serial-number" name="serviceTag" required="">
                                                        </div>

                                                        <div class="form-group">
                                                            <label for="guarantee-date">Guarantee Date</label>
                                                            <input class="form-control" type="date" id="guarantee-date" name="guaranteeDate" required="">
                                                        </div>

                                                        <div class="form-group">
                                                            <label for="status">Status</label>
                                                            <input class="form-control" type="text" id="status" name="status" required="">
                                                        </div>


                                                        <div class="form-group">
                                                            <label for="fileInput">Choose product image:</label>
                                                            <input
                                                                style="caret-color: black;"
                                                                id="fileInput"
                                                                type="file"
                                                                accept="image/*"
                                                                name="images"
                                                                multiple
                                                                required
                                                                />
                                                            <div id="imagePreviewContainer" class="image-preview-container"></div>
                                                        </div>


                                                        <hr class="mt-2 mb-3">
                                                        <div class="d-flex flex-wrap justify-content-between align-items-center">
                                                            <button class="btn btn-style-1 btn-primary" type="submit">Add Warranty</button>
                                                        </div>


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



        <!--        <div class="container mt-7" style="min-height: 500px">
                     Add Warranty Form 
                    <div class="col-lg-12 pb-5">
                        <form class="row mt-lg-5" action="addWarranty" method="post" enctype="multipart/form-data">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="serial-number-id">Serial Number</label>
                                    <input class="form-control" type="text" id="serial-number" name="serviceTag" required="">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="guarantee-date">Guarantee Date</label>
                                    <input class="form-control" type="date" id="guarantee-date" name="guaranteeDate" required="">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="status">Status</label>
                                    <input class="form-control" type="text" id="status" name="status" required="">
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label for="fileInput">Choose product image:</label>
                                    <input
                                        style="caret-color: black;"
                                        id="fileInput"
                                        type="file"
                                        accept="image/*"
                                        name="images"
                                        multiple
                                        required
                                        />
                                    <div id="imagePreviewContainer" class="image-preview-container"></div>
                                </div>
                            </div>
                            <div class="col-12">
                                <hr class="mt-2 mb-3">
                                <div class="d-flex flex-wrap justify-content-between align-items-center">
                                    <button class="btn btn-style-1 btn-primary" type="submit">Add Warranty</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>-->
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
