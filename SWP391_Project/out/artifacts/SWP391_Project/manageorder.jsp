<%-- 
    Document   : manageorder
    Created on : Jun 21, 2024, 1:18:24 PM
    Author     : ADMIN
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html" ; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="icon" href="media/icon/ordericon.webp"/>
        <title>BLAZO | LIST ORDER</title>
        <!-- plugins:css -->
        <link href="CSS/bootstrap.min.css" rel="stylesheet"/>
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

            .container:hover input ~ .checkmark {
                background-color: #ccc;
            }

            .container input:checked ~ .checkmark {
                background-color: #9f8a46;
            }

            .checkmark:after {
                content: '';
                position: absolute;
                display: none;
            }

            .container input:checked ~ .checkmark:after {
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
                display: none;
                position: fixed;
                z-index: 1;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                overflow: auto;
                background-color: rgba(0, 0, 0, 0.5);
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

            .modaladd {
                display: none;
                position: fixed;
                z-index: 1;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                overflow: auto;
                background-color: rgba(0, 0, 0, 0.5);
                padding-top: 80px;
            }

            .modaladd-content {
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
                /*                position: fixed;*/
                bottom: 0;
                width: 100%;
            }

            .center {
                text-align: center;
            }


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

            .containercheck:hover input ~ .checkmark {
                background-color: #ccc;
            }

            .containercheck input:checked ~ .checkmark {
                background-color: #9f8a46;
            }

            .checkmark:after {
                content: '';
                position: absolute;
                display: none;
            }

            .containercheck input:checked ~ .checkmark:after {
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

            .dropdown, .dropup {
                position: relative
            }

            .dropdown-toggle::after {
                display: inline-block;
                width: 0;
                height: 0;
                margin-left: .255em;
                vertical-align: .255em;
                content: "";
                border-top: .3em solid;
                border-right: .3em solid transparent;
                border-bottom: 0;
                border-left: .3em solid transparent
            }

            .dropdown-toggle:empty::after {
                margin-left: 0
            }

            .dropdown-menu {
                position: absolute;
                top: 100%;
                left: 0;
                z-index: 1000;
                display: none;
                float: left;
                min-width: 10rem;
                padding: .5rem 0;
                margin: .125rem 0 0;
                font-size: 1rem;
                color: #212529;
                text-align: left;
                list-style: none;
                background-color: #fff;
                background-clip: padding-box;
                border: 1px solid rgba(0, 0, 0, .15);
                border-radius: .25rem
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

            .writeform {
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

            @media screen and (max-width: 576px) {
                .column1 {
                    width: 100%;
                }

                .column2 {
                    width: 100%;
                }

            }

            .table td .imageproduct {
                width: 80px;
                height: 80px;
                border-radius: 100%;
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
                                                <a href="#" class="btn btn-otline-dark align-items-center"><i
                                                        class="icon-share"></i> Share</a>
                                                <a href="#" class="btn btn-otline-dark"><i class="icon-printer"></i> Print</a>
                                                <a href="#" class="btn btn-primary text-white me-0"><i
                                                        class="icon-download"></i> Export</a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tab-content tab-content-basic">
                                        <div class="tab-pane fade show active" id="overview" role="tabpanel"
                                             aria-labelledby="overview">
                                            <div class="card">
                                                <div class="card-body">
                                                    <h5 class="card-title">Product List</h5>
                                                    <div class="row">
                                                        
                                                    </div>

                                                    <hr>
                                                    <p class="card-description">
                                                        <button id="addProductBtn" class="btn btn-primary"
                                                                onclick="openAddProductModal()">Add product
                                                        </button>
                                                    </p>
                                                    <div class="table-responsive">
                                                        <table class="table table-bordered">
                                                            <thead>
                                                                <tr>
                                                                    <th>Order ID</th>
                                                                    <th>Customer</th>
                                                                    <th>Voucher</th>
                                                                    <th>Total Price</th>
                                                                    <th>Order<br>Date</th>
                                                                    <th>Payment Method</th>
                                                                    <th>Address 1</th>
                                                                    <th>Address 2</th>
                                                                    <th>Postal Code</th>
                                                                    <th>City</th>
                                                                    <th>Phone<br>Number</th>
                                                                    <th>Created<br>At</th>
                                                                    <th>Action</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody id="manageproduct">
                                                                
                                                            <c:forEach items="${requestScope.orders}" var="order">
                                                                <tr>
                                                                    <td></td>
                                                                    <td></td>
                                                                    <td></td>
                                                                    <td></td>
                                                                    <td></td>
                                                                    <td></td>
                                                                    <td></td>
                                                                    <td></td>
                                                                    <td></td>
                                                                    <td></td>
                                                                    <td></td>
                                                                    <td></td>
                                                                    <td></td>
                                                                </tr>
                                                            </c:forEach>

                                                            </tbody>
                                                        </table>

                                                    </div>
                                                    <nav class="mt-2">
                                                        <ul class="pagination justify-content-center">
                                                            <li class="page-item disabled">
                                                                <button class="page-link" onclick="changePage(1)">First</button>
                                                            </li>
                                                            <li class="page-item disabled">
                                                                <button class="page-link" onclick="changePage(0)">Prev</button>
                                                            </li>
                                                            <li class="page-item">
                                                                <form action="manageproduct" method="get" id="filterPage">
                                                                    <div class="form-group">
                                                                        <input onchange="submitFormAndBuildURL('filterPage')" class="form-control" id="pageInput" type="number" value="1" name="page" min="1" max="3" required="">
                                                                    </div>
                                                                </form>
                                                            </li>
                                                            <li class="page-item ">
                                                                <button class="page-link" onclick="changePage(2)">Next</button>
                                                            </li>
                                                            <li class="page-item ">
                                                                <button class="page-link" onclick="changePage(3)">Last</button>
                                                            </li>
                                                        </ul>
                                                    </nav>
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


        <div id="productFormModal" class="modaladd">

            <div class="card w-50" style="margin: 5% auto;">
                <div class="card-body">
                    <h4 class="card-title">Add product</h4>

                    <form id="productForm" action="addproduct" class="form-sample" method="post" enctype="multipart/form-data">
                        <input type="text" style="display: none;" name="id" id="productId" value="" required>
                        <div class="form-group">
                            <label for="productName">Product name</label>
                            <input type="text" id="productName" name="title" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="productStock">Product Stock</label>
                            <input type="number" id="productStock" min="0" name="stock" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="productPrice">Product Price</label>
                            <input step="0.01" type="number" id="productPrice" name="price" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="productDescription">Description</label>
                            <textarea id="productDescription" name="description" class="form-control vh-25"></textarea>
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
                            <label for="productImage">Images (Accept file formats: xbm, tif, apng, pjp, svgz, jpg, jpeg, ico,
                                tiff, gif, svg, jfif, webp, png, bmp, pjpeg, avif)</label>
                            <input id="productImage" type="file" name="image" class="form-control"
                                   accept=".xbm, .                                                              tif, .apng, .pjp, .svgz, .jpg, .jpeg, .ico, .tiff, .gif, .svg, .jfif, .webp, .png, .bmp, .pjpeg, .avif"
                                   required/>
                        </div>
                        <div class="form-group">
                            <img id="previewImage" src="" alt="Image preview" style="display: none;" width="80" height="80"/>
                        </div>
                        <span id="addImageBtn" class="closeBtn" style="margin-top: 1%;">+</span>
                        <button type="submit" onclick="submitForm('productForm')" id="submitBtn" class="btn btn-success">Add product</button>
                        <span class="btn btn-light" id="closeBtnAdd">Cancel</span>
                    </form>
                </div>
            </div>
        </div>



        <!-- plugins:js -->
        <script src="vendors/js/vendor.bundle.base.js"></script>
        <!-- endinject -->
        <!-- Plugin js for this page -->
        <script src="vendors/chart.js/Chart.min.js"></script>
        <script src="vendors/bootstrap-datepicker/bootstrap-datepicker.min.js"></script>
        <script src="vendors/progressbar.js/progressbar.min.js"></script>

        <!-- End plugin js for this page -->
        <!-- inject:js -->
        <script src="js/off-canvas.js"></script>
        <script src="js/hoverable-collapse.js"></script>
        <script src="js/template.js"></script>
        <script src="js/settings.js"></script>
        <script src="js/todolist.js"></script>
        <!-- endinject -->
        <!-- Custom js for this page-->
        <script src="js/dashboard.js"></script>
        <script src="js/Chart.roundedBarCharts.js"></script>
        <!-- End custom js for this page-->
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
