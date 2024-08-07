<%-- 
    Document   : editproduct.jsp
    Created on : Jun 14, 2024, 1:22:32 PM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>BLAZO | EDIT PRODUCT</title>
        <link rel="icon" href="media/icons8-edit-94.png"/>
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
    </head>
    <body>
        <div class="container-scroller"> 
            <!-- partial:partials/_navbar.html -->
            <nav class="navbar default-layout col-lg-12 col-12 p-0 fixed-top d-flex align-items-top flex-row">
                <div class="text-center navbar-brand-wrapper d-flex align-items-center justify-content-start">
                    <div class="me-3">
                        <button class="navbar-toggler navbar-toggler align-self-center" type="button" data-bs-toggle="minimize">
                            <span class="icon-menu"></span>
                        </button>
                    </div>
                    <div>
                        <a class="navbar-brand brand-logo" href="index.html">
                            <img src="images/logo.svg" alt="logo" />
                        </a>
                        <a class="navbar-brand brand-logo-mini" href="index.html">
                            <img src="images/logo-mini.svg" alt="logo" />
                        </a>
                    </div>
                </div>
                <div class="navbar-menu-wrapper d-flex align-items-top"> 
                    <ul class="navbar-nav">
                        <li class="nav-item font-weight-semibold d-none d-lg-block ms-0">
                            <h1 class="welcome-text">Hello, <span class="text-black fw-bold">John Doe</span></h1>
                            <h3 class="welcome-sub-text">Have a good day! </h3>
                        </li>
                    </ul>
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item d-none d-lg-block">
                            <div id="datepicker-popup" class="input-group date datepicker navbar-date-picker">
                                <span class="input-group-addon input-group-prepend border-right">
                                    <span class="icon-calendar input-group-text calendar-icon"></span>
                                </span>
                                <input type="text" class="form-control">
                            </div>
                        </li>
                        <li class="nav-item dropdown d-none d-lg-block user-dropdown">
                            <a class="nav-link" id="UserDropdown" href="#" data-bs-toggle="dropdown" aria-expanded="false">
                                <img class="img-xs rounded-circle" src="images/faces/face8.jpg" alt="Profile image"> </a>
                            <div class="dropdown-menu dropdown-menu-right navbar-dropdown" aria-labelledby="UserDropdown">
                                <div class="dropdown-header text-center">
                                    <img class="img-md rounded-circle" src="images/faces/face8.jpg" alt="Profile image">
                                    <p class="mb-1 mt-3 font-weight-semibold">Allen Moreno</p>
                                    <p class="fw-light text-muted mb-0">allenmoreno@gmail.com</p>
                                </div>
                                <a class="dropdown-item"><i class="dropdown-item-icon mdi mdi-power text-primary me-2"></i>Sign Out</a>
                            </div>
                        </li>
                    </ul>
                    <button class="navbar-toggler navbar-toggler-right d-lg-none align-self-center" type="button" data-bs-toggle="offcanvas">
                        <span class="mdi mdi-menu"></span>
                    </button>
                </div>
            </nav>
            <!-- partial -->
            <div class="container-fluid page-body-wrapper">
                <!-- partial:partials/_sidebar.html -->
                <nav class="sidebar sidebar-offcanvas" id="sidebar">
                    <ul class="nav">
                        <li class="nav-item">
                            <a class="nav-link" href="index.html">
                                <i class="mdi mdi-grid-large menu-icon"></i>
                                <span class="menu-title">Dashboard</span>
                            </a>
                        </li>
                        <li class="nav-item nav-category">User Management</li>
                        <li class="nav-item">
                            <a class="nav-link" data-bs-toggle="collapse" href="#userlist" aria-expanded="false" aria-controls="userlist">
                                <i class="menu-icon mdi mdi-account-box"></i>
                                <span class="menu-title">User List</span>
                                <i class="menu-arrow"></i> 
                            </a>
                            <div class="collapse" id="userlist">
                                <ul class="nav flex-column sub-menu">
                                    <li class="nav-item"> <a class="nav-link" href="customerlist">Customers List</a></li>
                                    <li class="nav-item"> <a class="nav-link" href="customerlist">Managers List</a></li>
                                </ul>
                            </div>
                        </li>
                        <li class="nav-item nav-category">Products Management</li>
                        <li class="nav-item">
                            <a class="nav-link" data-bs-toggle="collapse" href="#productlist" aria-expanded="false" aria-controls="productlist">
                                <i class="menu-icon mdi mdi-briefcase-check"></i>
                                <span class="menu-title">Products Management</span>
                                <i class="menu-arrow"></i> 
                            </a>
                            <div class="collapse" id="productlist">
                                <ul class="nav flex-column sub-menu">
                                    <li class="nav-item"> <a class="nav-link" href="manageproduct">Products List</a></li>
                                    <li class="nav-item"> <a class="nav-link" href="managevoucher">Vouchers List</a></li>
                                    <li class="nav-item"> <a class="nav-link" href="managediscount">Discount List</a></li>
                                    <li class="nav-item"> <a class="nav-link" href="managecategory">Category List</a></li>
                                    <li class="nav-item"> <a class="nav-link" href="manageservice">Service Tag List</a></li>
                                </ul>
                            </div>
                        </li>
                        <li class="nav-item nav-category">Orders Management</li>
                        <li class="nav-item">
                            <a class="nav-link" data-bs-toggle="collapse" href="#order" aria-expanded="false" aria-controls="order">
                                <i class="menu-icon mdi mdi-package-variant-closed"></i>
                                <span class="menu-title">Orders Management</span>
                                <i class="menu-arrow"></i> 
                            </a>
                            <div class="collapse" id="order">
                                <ul class="nav flex-column sub-menu">
                                    <li class="nav-item"> <a class="nav-link" href="manageorder">Orders List</a></li>
                                </ul>
                            </div>
                        </li>

                    </ul>
                </nav>
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
                                                    <h5 class="card-title">Edit Product</h5>
                                                    <a href="manageproduct"><span class="closeBtn">&times;</span></a>
                                                    <form id="productForm" action="editproduct" class="form" method="post" enctype="multipart/form-data">
                                                        <h3>Edit product</h3>
                                                        <input type="text" style="display: none;" name="id" id="productId" value="${product.getProductId()}" required>
                                                        <div class="form-group">
                                                            <label for="productName">Product name</label>
                                                            <input type="text" id="productName" name="title" value="${product.getTitle()}" class="form-control" required>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="productCategory">Category</label>
                                                            <select id="productCategory" name="cid" class="form-select" required>
                                                                <c:forEach items="${requestScope.categories}" var="category">
                                                                    <option value="${category.getCategoryId()}" ${product.getCategoryId() eq category.getCategoryId() ? 'selected':''}>${category.getTitle()}</option>
                                                                </c:forEach>
                                                            </select>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="productStock">Product Stock</label>
                                                            <input type="number" id="productStock" min="0" value="${product.getStock()}" name="stock" class="form-control" required>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="productDiscount">Product Discount</label>
                                                            <select id="productDiscount" name="did" class="form-select">
                                                                <option value="0" ${product.discountId == 0 ? 'selected' : ''}>None</option>
                                                                <c:forEach items="${requestScope.discounts}" var="discount">
                                                                    <c:if test="${discount.productId == 0 || discount.productId == product.productId}">
                                                                        <option value="${discount.discountId}" ${discount.discountId == product.discountId ? 'selected' : ''}>${discount.title}</option>
                                                                    </c:if>
                                                                </c:forEach>
                                                            </select>
                                                        </div>

                                                        <div class="form-group">
                                                            <label for="productPrice">Product Price</label>
                                                            <input step="0.01" type="number" id="productPrice" name="price" value="${product.getPrice()}" class="form-control" required>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="productDescription">Description</label>
                                                            <textarea id="productDescription" name="description" class="form-control vh-25" required>${product.getDescription()}</textarea>
                                                        </div>

                                                        <div class="form-group">
                                                            <label>Current Images: (check the box if you want to delete image)</label>
                                                            <div id="currentImages" class="image-gallery">
                                                                <c:forEach items="${submittedfile}" var="ima">
                                                                    <div class="image-container">
                                                                        <img src="media/product/${ima}" alt="Product Image" width="80" height="80"/>
                                                                        <input type="hidden" name="currentImages" value="${ima}"/>
                                                                        <input type="checkbox" name="deleteImages" class="deleteCheckbox" value="${ima}"/>
                                                                    </div>
                                                                </c:forEach>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="productImage">Images (Accept file formats: xbm, tif, apng, pjp, svgz, jpg, jpeg, ico, tiff, gif, svg, jfif, webp, png, bmp, pjpeg, avif)</label>
                                                            <input id="productImage" value="${submittedfile}" type="file" name="image" class="form-control" accept=".xbm, .tif, .apng, .pjp, .svgz, .jpg, .jpeg, .ico, .tiff, .gif, .svg, .jfif, .webp, .png, .bmp, .pjpeg, .avif"/>
                                                        </div>
                                                        <div class="form-group">
                                                            <img id="previewImage" src="" alt="Image preview" style="display: none;" width="80" height="80"/>
                                                        </div>
                                                        <span alt="Add more image" id="addImageBtn" class="addBtn">+</span>
                                                        <button type="submit" id="submitBtn" class="btn btn-success">Save</button>
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
        document.addEventListener('DOMContentLoaded', function () {
            const checkboxes = document.querySelectorAll('.deleteCheckbox');
            checkboxes.forEach(checkbox => {
                checkbox.addEventListener('change', function () {
                    const checkedCheckboxes = document.querySelectorAll('.deleteCheckbox:checked');
                    if (checkedCheckboxes.length >= checkboxes.length) {
                        alert('At least one image must remain.');
                        this.checked = false;
                    }
                });
            });
        });
    </script>

    <script>
        document.getElementById('productImages').addEventListener('change', function (event) {
            var preview = document.getElementById('previewImage');
            if (event.target.files) {
                for (var i = 0; i < event.target.files.length; i++) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        var img = document.createElement('img');
                        img.src = e.target.result;
                        preview.appendChild(img);
                    }
                    reader.readAsDataURL(event.target.files[i]);
                }
            }
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


<!--        <div id="productFormModal" class="modaledit">
                        <div class="card w-50" style="margin: 5% auto;">
                            <div class="card-body">
                                <a href="manageproduct"><span class="closeBtn">&times;</span></a>
                                <form id="productForm" action="editproduct" class="form" method="post" enctype="multipart/form-data">
                                    <h3>Edit product</h3>
                                    <input type="text" style="display: none;" name="id" id="productId" value="${product.getProductId()}" required>
                                <div class="form-group">
                                    <label for="productName">Product name</label>
                                    <input type="text" id="productName" name="title" value="${product.getTitle()}" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label for="productCategory">Category</label>
                                    <select id="productCategory" name="cid" class="form-select" required>
    <c:forEach items="${requestScope.categories}" var="category">
        <option value="${category.getCategoryId()}" ${product.getCategoryId() eq category.getCategoryId() ? 'selected':''}>${category.getTitle()}</option>
    </c:forEach>
</select>
</div>
<div class="form-group">
<label for="productStock">Product Stock</label>
<input type="number" id="productStock" min="0" value="${product.getStock()}" name="stock" class="form-control" required>
</div>
<div class="form-group">
<label for="productDiscount">Product Discount</label>
<select id="productDiscount" name="did" class="form-select">
    <option value="0" ${product.discountId == 0 ? 'selected' : ''}>None</option>
    <c:forEach items="${requestScope.discounts}" var="discount">
        <c:if test="${discount.productId == 0 || discount.productId == product.productId}">
            <option value="${discount.discountId}" ${discount.discountId == product.discountId ? 'selected' : ''}>${discount.title}</option>
        </c:if>
    </c:forEach>
</select>
</div>

<div class="form-group">
<label for="productPrice">Product Price</label>
<input step="0.01" type="number" id="productPrice" name="price" value="${product.getPrice()}" class="form-control" required>
</div>
<div class="form-group">
<label for="productDescription">Description</label>
<textarea id="productDescription" name="description" class="form-control vh-50" required>${product.getDescription()}</textarea>
</div>
                    <div class="form-group">
                        <label for="productSerialNumber">Product Service</label>
                        <input type="text" name="service" value="${productname.getProductSerialNumber(product.getProductId()).service_tag}" class="form-control"/>
                    </div>
<div class="form-group">
<label>Current Images: (check the box if you want to delete image)</label>
<div id="currentImages" class="image-gallery">
    <c:forEach items="${submittedfile}" var="ima">
        <div class="image-container">
            <img src="media/product/${ima}" alt="Product Image" width="80" height="80"/>
            <input type="hidden" name="currentImages" value="${ima}"/>
            <input type="checkbox" name="deleteImages" class="deleteCheckbox" value="${ima}"/>
        </div>
    </c:forEach>
</div>
</div>
<div class="form-group">
<label for="productImage">Images (Accept file formats: xbm, tif, apng, pjp, svgz, jpg, jpeg, ico, tiff, gif, svg, jfif, webp, png, bmp, pjpeg, avif)</label>
<input id="productImage" value="${submittedfile}" type="file" name="image" class="form-control" accept=".xbm, .tif, .apng, .pjp, .svgz, .jpg, .jpeg, .ico, .tiff, .gif, .svg, .jfif, .webp, .png, .bmp, .pjpeg, .avif"/>
</div>
<div class="form-group">
<img id="previewImage" src="" alt="Image preview" style="display: none;" width="80" height="80"/>
</div>
<span alt="Add more image" id="addImageBtn" class="addBtn">+</span>
<button type="submit" id="submitBtn" class="btn btn-success">Save</button>
</form>
</div>
</div>





</div>-->
</html>
