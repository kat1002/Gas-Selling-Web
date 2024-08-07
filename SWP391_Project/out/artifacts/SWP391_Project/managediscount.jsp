<%-- 
    Document   : managediscount
    Created on : Jun 23, 2024, 2:09:30 PM
    Author     : ADMIN
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>BLAZO | DISCOUNT LIST</title>
        <link rel="icon" href="media/icon/icons8-discount.gif"/>
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

            /*            .table td .imageproduct {
                            width: 80px;
                            height: 80px;
                            border-radius: 100%;
                        }*/

/*            .table td, .table th {
                word-wrap: break-word;
                width: 700px;
                white-space: normal;
            }*/
        </style>
        <script>
            function validateDiscountValue() {
                var discountValue = document.getElementById('discountValue').value;
                if (discountValue > 1) {
                    alert("Discount value must be between 0 and 1.");
                    return false;
                }
                return true;
            }

            function doDeleteDiscount(discountId, discountTitle) {
                // Confirm the deletion
                if (confirm("Are you sure you want to delete the discount: " + discountTitle + " ?")) {
                    // Find and submit the specific form for this discountId
                    document.getElementById("deleteForm" + discountId).submit();
                }
            }

            function openAddDiscountForm() {
                console.log("openAddDiscountForm");
                // Show the modal
                $('#addDiscountModal').modal('show');
            }

            function closeAddDiscountForm() {
                $('#addDiscountModal').modal('hide');
            }

            function fetchDiscount(discountId) {
                $.ajax({
                    url: 'editdiscount',
                    method: 'GET',
                    data: {id: discountId},
                    success: function (response) {
                        if (response) {
                            $('#editDiscountId').val(response.discount.discountId);
                            $('#editDiscountTitle').val(response.discount.title);
                            $('#editDiscountDescription').val(response.discount.description);
                            $('#editDiscountValue').val(response.discount.discountValue);
                            $('#editDiscountProductId').val(response.discount.productId);
                            $('#editDiscountProductId').empty();
                            // Thêm tùy chọn "None"
                            $('#editDiscountProductId').append('<option value="0">None</option>');

                            // Thêm các tùy chọn sản phẩm
                            $.each(response.products, function (index, product) {
                                if (product.discountId == 0 || product.productId == response.discount.productId) {
                                    var selected = (product.productId == response.discount.productId) ? 'selected' : '';
                                    $('#editDiscountProductId').append('<option value="' + product.productId + '" ' + selected + '>' + product.title + '</option>');
                                }
                            });
                            $('#editDiscountModal').modal('show');
                        } else {
                            // Handle error or empty response
                            console.error('Error fetching discount details');
                        }
                    },
                    error: function (xhr, status, error) {
                        // Handle AJAX error
                        console.error('Error fetching discount details:', error);
                    }
                });
            }


            function openEditDiscountModal(id, title, description, discountValue, productId) {
                // Mở modal
                $('#editDiscountModal').modal('show');

                // Giải mã description trước khi in vào form
                description = unescape(description);

                // In thông tin discount vào form
                $('#editDiscountId').val(id);
                $('#editDiscountTitle').val(title);
                $('#editDiscountDescription').val(description);
                $('#editDiscountValue').val(discountValue);

                if (productId === 'None') {
                    productId = 0;
                }

                $('select[name="pid"]').val(productId); // Chọn option trong dropdown sản phẩm
            }

            function closeEditDiscountForm() {
                $('#editDiscountModal').modal('hide');
            }

        </script>
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
                                                    <h5 class="card-title">Discount List</h5>
                                                    <div class="row">

                                                        <div class="col-md-2">
                                                            <h5>Search discount</h5>
                                                            <form action="managediscount" id="filterTitle" method="get">
                                                                <div class="form-group">
                                                                    <input placeholder="Title" value="${title}" class="form-control" type="text" name="title"/>
                                                                </div>
                                                                <button onclick="submitFormAndBuildURL('filterTitle')" class=""><i class="fa fa-search"></i></button>
                                                            </form>
                                                        </div>
                                                        <div class="col-md-2">
                                                            <h5>Discount value range</h5>
                                                            <form action="managediscount" id="filterRangeDiscount" method="get">
                                                                <div class="form-group">
                                                                    <input type="number" placeholder="From" class="form-control" name="discountvaluefrom" min="0" max="1" step="0.01" value="${discountValueFrom}"/>
                                                                    <br>
                                                                    <input type="number" placeholder="To" class="form-control" name="discountvalueto" min="0" max="1" step="0.01" value="${discountValueTo}"/>
                                                                </div>
                                                                <button onclick="submitFormAndBuildURL('filterRangeDiscount')" class=""><i class="fa fa-search"></i></button>
                                                            </form>
                                                        </div>
                                                        <div class="col-md-2">
                                                            <h5>Sort value</h5>
                                                            <form action="managediscount" id="filterSortDiscount" method="get">
                                                                <div class="form-group">
                                                                    <select name="sortchoice" class="form-select" onchange="submitFormAndBuildURL('filterSortDiscount')">
                                                                        <option ${sortchoice eq '' ? 'selected':''} value="">Constant</option>
                                                                        <option ${sortchoice eq 'Increase' ? 'selected':''}  value="Increase">Increase</option>
                                                                        <option ${sortchoice eq 'Decrease' ? 'selected':''} value="Decrease">Decrease</option>
                                                                    </select>
                                                                </div>
                                                            </form>
                                                        </div>
                                                        <div class="col-md-2">
                                                            <h5>Created at</h5>
                                                            <form action="managediscount" method="get" id="filterCreatedAt">
                                                                <div class="form-group">
                                                                    <input type="date" name="createdatfrom" class="form-control" value="${createdAtFrom}"/>        
                                                                </div>
                                                                <div class="form-group">
                                                                    <input type="date" name="createdatto" class="form-control" value="${createdAtTo}"/>
                                                                </div>
                                                                <button onclick="submitFormAndBuildURL('filterCreatedAt')" class=""><i class="fa fa-search"></i></button>
                                                            </form>
                                                        </div>
                                                        <div class="col-md-2">
                                                            <h5>Modified at</h5>
                                                            <form action="managediscount" method="get" id="filterModifiedAt">
                                                                <div class="form-group">
                                                                    <input type="date" name="modifiedatfrom" class="form-control" value="${modifiedAtFrom}"/>        
                                                                </div>
                                                                <div class="form-group">
                                                                    <input type="date" name="modifiedatfrom" class="form-control" value="${modifiedAtTo}"/>
                                                                </div>
                                                                <button onclick="submitFormAndBuildURL('filterModifiedAt')" class=""><i class="fa fa-search"></i></button>
                                                            </form>
                                                        </div>
                                                        <div class="col-md-2">
                                                            <h5>Created By</h5>
                                                            <form action="managediscount" method="get" id="filterCreatedBy">
                                                                <div class="form-group">
                                                                    <input type="text" name="createdby" class="form-control" value="${createdBy}"/>
                                                                </div>
                                                                <button onclick="submitFormAndBuildURL('filterCreatedBy')" class=""><i class="fa fa-search"></i></button>
                                                            </form>
                                                            <h5>Modified By</h5>
                                                            <form action="managediscount" method="get" id="filterModifiedBy">
                                                                <div class="form-group">
                                                                    <input type="text" name="modifiedby" class="form-control" value="${modifiedBy}"/>
                                                                </div>
                                                            </form>
                                                            <button onclick="submitFormAndBuildURL('filterModifiedBy')" class=""><i class="fa fa-search"></i></button>
                                                        </div>
                                                        <div class="col-md-2">
                                                            <h5>Discounts / page</h5>
                                                            <form action="managediscount" method="get" id="filterNumPage">
                                                                <div class="form-group">
                                                                    <input type="number" min="1" name="itemperpage" value="${itemperpage}"/>
                                                                </div>
                                                                <button onclick="submitFormAndBuildURL('filterNumPage')"><i class="fa fa-search"></i></button>
                                                            </form>
                                                        </div>
                                                    </div>


                                                    <hr>
                                                    <p class="card-description">
                                                        <button id="addDiscountBtn" class="btn btn-behance"
                                                                onclick="openAddDiscountForm()">Add discount
                                                        </button>
                                                    </p>
                                                    <div class="table-responsive">
                                                        <c:choose>
                                                            <c:when test="${requestScope.discounts.size() > 0}">
                                                                <table class="table table-hover">
                                                                    <thead>
                                                                        <tr>
                                                                            <th>ID</th>
                                                                            <th>Title</th>
                                                                            <th>Product</th>
                                                                            <th>Description</th>
                                                                            <th>Value</th>
                                                                            <th>Created<br>By</th>
                                                                            <th>Modified<br>By</th>                                                                    
                                                                            <th>Created<br>At</th>
                                                                            <th>Modified<br>At</th>
                                                                            <th>Action</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>

                                                                        <c:forEach items="${requestScope.discounts}" var="discount">
                                                                            <jsp:useBean id="manager" class="com.model.DAO.ManagerDAO" scope="request"></jsp:useBean>
                                                                            <jsp:useBean id="product" class="com.model.DAO.ProductDAO" scope="request"></jsp:useBean>
                                                                            <jsp:useBean id="discountt" class="com.model.DAO.DiscountDAO" scope="request"></jsp:useBean>
                                                                                <tr>
                                                                                    <td>${discount.getDiscountId()}</td>
                                                                                <td>${discount.getTitle()}</td>
                                                                                <td>
                                                                                    <c:if test="${discount.getProductId() eq 0}">None</c:if>
                                                                                    <c:if test="${discount.getProductId() ne 0}">${product.getProduct(discount.getProductId()).getTitle()}</c:if>
                                                                                    </td>

                                                                                    <td>
                                                                                    <c:if test="${discount.getDescription() eq null}">None</c:if>
                                                                                    <c:if test="${discount.getDescription() ne null}">${discount.getDescription()}</c:if>
                                                                                    </td>
                                                                                    <td><fmt:formatNumber value="${discount.getDiscountValue() * 100}" 
                                                                                                  type="number" 
                                                                                                  maxFractionDigits="2" 
                                                                                                  minFractionDigits="2" />%</td>
                                                                                <td>${manager.getManager(discount.getCreatedBy()).getUsername()}</td>
                                                                                <td>${manager.getManager(discount.getModifiedBy()).getUsername()}</td>
                                                                                <td>${discount.getCreatedAt()}</td>
                                                                                <td>${discount.getModifiedAt()}</td>
                                                                                <td>
                                                                                    <button class="btn btn-warning"
                                                                                            onclick="fetchDiscount('${discount.getDiscountId()}')">
                                                                                        <i class="fa fa-pencil"></i></button>
                                                                                    <button class="btn btn-danger"
                                                                                            onclick="doDeleteDiscount('${discount.getDiscountId()}', '${discount.getTitle()}')">
                                                                                        <i class="fa fa-trash"></i></button>
                                                                                    <form action="deletediscount" method="post" id="deleteForm${discount.getDiscountId()}">
                                                                                        <input type="hidden" name="id" value="${discount.getDiscountId()}"/>
                                                                                    </form>
                                                                                </td>
                                                                            </tr>
                                                                        </c:forEach>
                                                                    </tbody>
                                                                </table>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <jsp:include page="notsearch_admin.jsp"/>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                    <nav class="mt-2">
                                                        <ul class="pagination justify-content-center">
                                                            <li class="page-item ${page le 1 ? 'disabled':''}">
                                                                <button class="page-link" onclick="changePage(1)">First</button>
                                                            </li>
                                                            <li class="page-item ${page le 1 ? 'disabled':''}">
                                                                <button class="page-link" onclick="changePage(${page - 1})">Prev</button>
                                                            </li>
                                                            <li class="page-item">
                                                                <form action="manageproduct" method="get" id="filterPage">
                                                                    <div class="form-group">
                                                                        <input onchange="submitFormAndBuildURL('filterPage')" class="form-control" id="pageInput" type="number" value="${page}" name="page" min="1" max="${num}" required=""/>
                                                                    </div>
                                                                </form>
                                                            </li>
                                                            <li class="page-item ${page ge num ? 'disabled':''}">
                                                                <button class="page-link" onclick="changePage(${page + 1})">Next</button>
                                                            </li>
                                                            <li class="page-item ${page ge num ? 'disabled':''}">
                                                                <button class="page-link" onclick="changePage(${num})">Last</button>
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
        <div aria-hidden="true" aria-labelledby="addDiscountModalLabel" class="modal fade"
             id="addDiscountModal" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addDiscountModalLabel">Add New Discount</h5>
                        <button aria-label="Close" class="btn-close" data-bs-dismiss="modal" type="button" onclick="closeAddDiscountForm()"></button>
                    </div>
                    <div class="modal-body">
                        <form id="discountForm" action="adddiscount" class="form-sample" method="post">
                            <input type="text" style="display: none;" name="id" id="discountId" value="">     
                            <div class="form-group">
                                <label for="discountTitle">Title</label>
                                <input type="text" id="discountTitle" name="title" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label for="discountDescription">Description</label>
                                <textarea id="discountDescription" name="description" class="form-control vh-25"></textarea>
                            </div>
                            <div class="form-group">
                                <label for="discountValue">Discount Value</label>
                                <input id="discountValue" type="number" step="0.01" min="0" max="1" name="discountValue" class="form-control" required=""/>
                            </div>
                            <div class="form-group">
                                <label for="discountProductId">Product</label>
                                <select id="discountProductId" name="pid" class="form-select">
                                    <option value="0">None</option>
                                    <c:forEach items="${products}" var="p">
                                        <c:if test="${p.getDiscountId() eq 0}">
                                            <option value="${p.getProductId()}">${p.getTitle()}</option>
                                        </c:if>
                                    </c:forEach>
                                </select>
                            </div>
                            <button type="submit" id="submitBtn" class="btn btn-success">Add discount</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>  


        <div class="modal fade" id="editDiscountModal" tabindex="-1" aria-labelledby="editDiscountModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editDiscountModalLabel">Edit Discount</h5>
                        <button type="button" onclick="closeEditDiscountForm()" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form id="editDiscountForm" action="editdiscount" method="post" class="form-sample">
                            <input type="hidden" name="id" id="editDiscountId">
                            <div class="form-group">
                                <label for="editDiscountTitle">Title</label>
                                <input type="text" id="editDiscountTitle" name="title" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label for="editDiscountDescription">Description</label>
                                <textarea id="editDiscountDescription" name="description" class="form-control vh-25" style="height: auto; resize: vertical;"></textarea>
                            </div>
                            <div class="form-group">
                                <label for="editDiscountValue">Discount Value</label>
                                <input type="number" id="editDiscountValue" name="discountValue" class="form-control" step="0.01" min="0" max="1" required>
                            </div>
                            <div class="form-group">
                                <label for="editDiscountProductId">Product</label>
                                <select id="editDiscountProductId" name="pid" class="form-select">
                                    <%--     <option value="0">None</option>
                                         <c:forEach items="${products}" var="p">
                                             <c:if test="${p.getDiscountId() eq 0}">
                                                 <option value="${p.getProductId()}">${p.getTitle()}</option>
                                             </c:if>
                                         </c:forEach>  --%>
                                </select>
                            </div>
                            <button id="editSubmitBtn" class="btn btn-primary" >Save changes</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
        document.getElementById('discountForm').addEventListener('submit', function (event) {
                var descriptionField = document.getElementById('discountDescription');
                descriptionField.value = descriptionField.value.replace(/\n/g, '<br>');
            });
            
            $(document).ready(function () {
                $('#editDiscountModal').on('show.bs.modal', function (e) {
                    var descriptionEdit = document.getElementById('editDiscountDescription');
                    descriptionEdit.value = descriptionEdit.value.replace(/<br>/g, '\n');
                });

                document.getElementById('editDiscountForm').addEventListener('submit', function (event) {
                    var descriptionEdit = document.getElementById('editDiscountDescription');
                    descriptionEdit.value = descriptionEdit.value.replace(/\n/g, '<br>');
                });
            });
    </script>
    <script>
                            function changePage(newPage) {
                                // Get the current URL and its search parameters
                                var url = new URL(window.location.href);

                                // Update the page parameter
                                url.searchParams.set('page', newPage);

                                // Redirect to the updated URL
                                window.location.href = url.toString();
                            }

                            function submitFormAndBuildURL(formId) {
                                var form = document.getElementById(formId);
                                var url = new URL(window.location.href);
                                var formData = new FormData(form);

                                // Loop through all form inputs
                                for (var [key, value] of formData.entries()) {
                                    if (value.trim() !== "") {
                                        if (value !== '0') {
                                            url.searchParams.set(key, value);
                                        } else {
                                            url.searchParams.delete(key);
                                        }
                                    } else {
                                        url.searchParams.delete(key);
                                    }
                                }

                                // Redirect to the new URL
                                window.location.href = url.toString();
                            }

                            // Add submit event listener to all forms
                            document.querySelectorAll('form').forEach(function (form) {
                                if (form.id === 'filterProduct'
                                        || form.id === 'filterTitle'
                                        || form.id === 'filterRangeDiscount'
                                        || form.id === 'filterSortDiscount'
                                        || form.id === 'filterModifiedAt'
                                        || form.id === 'filterCreatedAt'
                                        || form.id === 'filterNumPage'
                                        || form.id === 'filterCreatedBy'
                                        || form.id === 'filterModifiedBy'
                                        || form.id === 'filterPage') {
                                    form.addEventListener('submit', function (event) {
                                        event.preventDefault(); // Prevent default form submission
                                        submitFormAndBuildURL(form.id); // Call your handler function
                                    });
                                }
                            });
    </script>
</html>
