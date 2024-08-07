<!DOCTYPE html>
<html lang="en">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1, shrink-to-fit=no" name="viewport">
    <title>Customer List </title>
    <!-- plugins:css -->
    <link href="vendors/feather/feather.css" rel="stylesheet">
    <link href="vendors/mdi/css/materialdesignicons.min.css" rel="stylesheet">
    <link href="vendors/ti-icons/css/themify-icons.css" rel="stylesheet">
    <link href="vendors/typicons/typicons.css" rel="stylesheet">
    <link href="vendors/simple-line-icons/css/simple-line-icons.css" rel="stylesheet">
    <link href="vendors/css/vendor.bundle.base.css" rel="stylesheet">
    <!-- endinject -->
    <!-- End plugin css for this page -->
    <!-- inject:css -->
    <link href="CSS/dashboardcss/vertical-layout-light/style.css" rel="stylesheet">
    <!-- endinject -->
    <link href="images/favicon.png" rel="shortcut icon"/>
    <script src="js/dashboard_custom/customerlist.js"></script>

    <style>
        @media print {
            .no-print {
                display: none !important;
            }
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
                <a class="navbar-brand brand-logo" href="dashboard">
                    <img src="media/LOGO.png" alt="logo"/>
                </a>
                <a class="navbar-brand brand-logo-mini" href="dashboard">
                    <img src="images/LOGO.png" alt="logo"/>
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
                        <a class="dropdown-item"><i class="dropdown-item-icon mdi mdi-power text-primary me-2"></i>Sign
                            Out</a>
                    </div>
                </li>
            </ul>
            <button class="navbar-toggler navbar-toggler-right d-lg-none align-self-center" type="button"
                    data-bs-toggle="offcanvas">
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
                    <a class="nav-link" href="dashboard">
                        <i class="mdi mdi-grid-large menu-icon"></i>
                        <span class="menu-title">Dashboard</span>
                    </a>
                </li>
                <li class="nav-item nav-category">User Management</li>
                <li class="nav-item">
                    <a class="nav-link" data-bs-toggle="collapse" href="#user-list" aria-expanded="false"
                       aria-controls="user-list">
                        <i class="menu-icon mdi mdi-account-box"></i>
                        <span class="menu-title">User List</span>
                        <i class="menu-arrow"></i>
                    </a>
                    <div class="collapse" id="user-list">
                        <ul class="nav flex-column sub-menu">
                            <li class="nav-item"><a class="nav-link" onclick="window.location.href='customerlist'">Customers
                                List</a></li>
                            <li class="nav-item"><a class="nav-link" onclick="window.location.href='managerlist'">Managers
                                List</a></li>
                        </ul>
                    </div>
                </li>
                <li class="nav-item nav-category">Products Management</li>
                <li class="nav-item">
                    <a class="nav-link" data-bs-toggle="collapse" href="#productlist" aria-expanded="false"
                       aria-controls="productlist">
                        <i class="menu-icon mdi mdi-briefcase-check"></i>
                        <span class="menu-title">Products Management</span>
                        <i class="menu-arrow"></i>
                    </a>
                    <div class="collapse" id="productlist">
                        <ul class="nav flex-column sub-menu">
                            <li class="nav-item"><a class="nav-link" href="productlist">Products
                                List</a></li>
                            <li class="nav-item"><a class="nav-link" href="voucherlist">Vouchers
                                List</a></li>
                            <li class="nav-item"><a class="nav-link" href="discountlist">Discount
                                List</a></li>
                            <li class="nav-item"><a class="nav-link" href="categorylist">Category
                                List</a></li>
                            <li class="nav-item"><a class="nav-link" href="servicetaglist">Service Tag
                                List</a></li>
                        </ul>
                    </div>
                </li>
                <li class="nav-item nav-category">Orders Management</li>
                <li class="nav-item">
                    <a class="nav-link" data-bs-toggle="collapse" href="#order" aria-expanded="false"
                       aria-controls="order">
                        <i class="menu-icon mdi mdi-package-variant-closed"></i>
                        <span class="menu-title">Orders Management</span>
                        <i class="menu-arrow"></i>
                    </a>
                    <div class="collapse" id="order">
                        <ul class="nav flex-column sub-menu">
                            <li class="nav-item"><a class="nav-link" href="orderlist">Orders
                                List</a></li>
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
                                <ul class="nav nav-tabs" role="tablist">
                                    <li class="nav-item">
                                        <a class="nav-link active ps-0" id="home-tab" data-bs-toggle="tab"
                                           href="customerlist" role="tab" aria-controls="overview" aria-selected="true"
                                           onclick="window.location.href='customerlist'">Customer List</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" id="profile-tab" data-bs-toggle="tab" href="managerlist"
                                           role="tab" aria-selected="false"
                                           onclick="window.location.href='managerlist'">Manager List</a>
                                    </li>
                                </ul>
                                <div>
                                    <div class="btn-wrapper">
                                        <a class="btn btn-outline-dark align-items-center" href="#" id="shareBtn"
                                           onclick="shareAllCustomerData()"><i class="icon-share"></i> Share</a>
                                        <a class="btn btn-outline-dark" href="#" id="printBtn"
                                           onclick="printAllCustomerData()"><i class="icon-printer"></i> Print</a>
                                        <a class="btn btn-primary text-white me-0" href="#" id="exportBtn"
                                           onclick="exportAllDataToCSV()"><i class="icon-download"></i> Export</a>
                                    </div>
                                </div>
                            </div>
                            <div class="tab-content tab-content-basic">
                                <div aria-labelledby="customerlist" class="tab-pane fade show active" id="customerlist"
                                     role="tabpanel">
                                    <div class="col-lg-12 grid-margin stretch-card">
                                        <div class="card">
                                            <div class="card-body">
                                                <h4 class="card-title">Customers List</h4>
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <div class="input-group">
                                                                <div class="input-group-prepend">
                                                                    <button aria-expanded="false"
                                                                            aria-haspopup="true"
                                                                            class="btn btn-sm btn-outline-primary dropdown-toggle"
                                                                            data-bs-toggle="dropdown" type="button">
                                                                        Search by
                                                                    </button>
                                                                    <div class="dropdown-menu" value="">
                                                                        <a class="dropdown-item" href="#"
                                                                           onclick="setSearchType('customer_id')">Search
                                                                            by Id</a>
                                                                        <a class="dropdown-item" href="#"
                                                                           onclick="setSearchType('username')">Search by
                                                                            Username</a>
                                                                        <a class="dropdown-item" href="#"
                                                                           onclick="setSearchType('gmail')">Search by
                                                                            Gmail</a>
                                                                        <a class="dropdown-item" href="#"
                                                                           onclick="setSearchType('first_name')">Search
                                                                            by First Name</a>
                                                                    </div>
                                                                </div>
                                                                <input class="form-control" id="searchQuery"
                                                                       placeholder="Search"
                                                                       type="text" onchange="searchCustomers()">
                                                                <div class="input-group-append">
                                                                    <button class="btn btn-sm btn-primary"
                                                                            onclick="searchCustomers()"
                                                                            style="color: white;" type="button">Search
                                                                    </button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <div class="form-group row">
                                                            <label class="col-sm-3 col-form-label">Sort by</label>
                                                            <div class="col-sm-9">
                                                                <select class="form-control" id="sortBy"
                                                                        onchange="fetchCustomers()"
                                                                        style="color: black;">
                                                                    <option selected="selected" value="customer_id">Id
                                                                    </option>
                                                                    <option value="customer_type">Customer Type</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <div class="form-group row">
                                                            <label class="col-sm-6 col-form-label">Customer per
                                                                page</label>
                                                            <div class="col-sm-3">
                                                                <select class="form-control" id="rowsPerPage"
                                                                        onchange="fetchCustomers()"
                                                                        style="color: black;">
                                                                    <option selected="selected" value="10">10</option>
                                                                    <option value="20">20</option>
                                                                    <option value="50">50</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <button type="button" class="btn btn-primary"
                                                                style="color: white" data-bs-toggle="modal"
                                                                data-bs-target="#addCustomerModal"
                                                                onclick="openAddCustomerForm()">Add New Customer
                                                        </button>
                                                    </div>
<%--                                                    <div class="col-md-3">--%>
<%--                                                        <button type="button" class="btn btn-primary"--%>
<%--                                                                style="color: white">Add New Customers from csv--%>
<%--                                                        </button>--%>
<%--                                                    </div>--%>
                                                </div>
                                                <div class="table-responsive pt-3">
                                                    <table class="table table-bordered" id="customerTable">
                                                        <thead>
                                                        <tr>
                                                            <th>#</th>
                                                            <th>User id</th>
                                                            <th>Username</th>
                                                            <th>Gmail</th>
                                                            <th>Phone</th>
                                                            <th>First Name</th>
                                                            <th>Last Name</th>
                                                            <th class="no-print">Actions</th>
                                                        </tr>
                                                        </thead>
                                                        <tbody>
                                                        <!-- Customer rows will be injected here by JavaScript -->
                                                        </tbody>
                                                    </table>
                                                </div>
                                                <nav>
                                                    <ul class="pagination justify-content-center" id="pagination">
                                                        <!-- Pagination controls will be injected here by JavaScript -->
                                                    </ul>
                                                </nav>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Customer Modal Structure -->
                            <div aria-hidden="true" aria-labelledby="customerDetailsModalLabel" class="modal fade"
                                 id="customerDetailsModal" tabindex="-1">
                                <div class="modal-dialog modal-dialog-centered modal-lg">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="customerDetailsModalLabel">Customer Details</h5>
                                            <button aria-label="Close" class="btn-close" data-bs-dismiss="modal"
                                                    type="button"></button>
                                        </div>
                                        <div class="modal-body">
                                            <form class="form-sample" id="customerDetailsForm">
                                                <p class="card-description">Personal info</p>
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group row">
                                                            <label class="col-sm-3 col-form-label">Username</label>
                                                            <div class="col-sm-9">
                                                                <input class="form-control" id="username" readonly
                                                                       type="text"/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-group row">
                                                            <label class="col-sm-3 col-form-label">User Id</label>
                                                            <div class="col-sm-9">
                                                                <input class="form-control" id="userId" readonly
                                                                       type="text"/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group row">
                                                            <label class="col-sm-3 col-form-label">First Name</label>
                                                            <div class="col-sm-9">
                                                                <input class="form-control" id="firstName" type="text"/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-group row">
                                                            <label class="col-sm-3 col-form-label">Last Name</label>
                                                            <div class="col-sm-9">
                                                                <input class="form-control" id="lastName" type="text"/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group row">
                                                            <label class="col-sm-3 col-form-label">Gmail</label>
                                                            <div class="col-sm-9">
                                                                <input class="form-control" id="email" readonly
                                                                       type="text"/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-group row">
                                                            <label class="col-sm-3 col-form-label">Phone Number</label>
                                                            <div class="col-sm-9">
                                                                <input class="form-control" id="phoneNumber"
                                                                       type="text"/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group row">
                                                            <label class="col-sm-3 col-form-label">Customer Type</label>
                                                            <div class="col-sm-9">
                                                                <select class="form-control" id="customerType"
                                                                        style="color: black;">
                                                                    <option value="1">New Customer</option>
                                                                    <option value="2">Current customer</option>
                                                                    <option value="3">Former customer</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-group row">
                                                            <label class="col-sm-3 col-form-label">Email</label>
                                                            <div class="col-sm-4">
                                                                <div class="form-check">
                                                                    <input class="form-check-input" id="receiveEmail"
                                                                           type="checkbox">
                                                                    <label class="form-check-label" for="receiveEmail">Receive
                                                                        Email</label>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <p class="card-description">Address</p>
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group row">
                                                            <label class="col-sm-3 col-form-label">Address line
                                                                1</label>
                                                            <div class="col-sm-9">
                                                                <input class="form-control" id="address1" type="text"/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-group row">
                                                            <label class="col-sm-3 col-form-label">Postal Code</label>
                                                            <div class="col-sm-9">
                                                                <input class="form-control" id="postalCode"
                                                                       type="text"/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group row">
                                                            <label class="col-sm-3 col-form-label">Address line
                                                                2</label>
                                                            <div class="col-sm-9">
                                                                <input class="form-control" id="address2" type="text"/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-group row">
                                                            <label class="col-sm-3 col-form-label">City</label>
                                                            <div class="col-sm-9">
                                                                <input class="form-control" id="city" type="text"/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-6"></div>
                                                    <div class="col-md-6">
                                                        <button class="btn btn-primary btn-lg"
                                                                onclick="saveChangeDetails()">Save changes
                                                        </button>
                                                        <button class="btn btn-secondary btn-lg" data-bs-dismiss="modal"
                                                                type="button">Close
                                                        </button>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Add New Customer Modal Structure -->
                            <div aria-hidden="true" aria-labelledby="addCustomerModalLabel" class="modal fade"
                                 id="addCustomerModal" tabindex="-1">
                                <div class="modal-dialog modal-dialog-centered modal-lg">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="addCustomerModalLabel">Add New Customer</h5>
                                            <button aria-label="Close" class="btn-close" data-bs-dismiss="modal"
                                                    type="button"></button>
                                        </div>
                                        <div class="modal-body">
                                            <form class="form-sample" id="addCustomerForm">
                                                <p class="card-description">Personal info</p>
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group row">
                                                            <label class="col-sm-3 col-form-label">Username</label>
                                                            <div class="col-sm-9">
                                                                <input class="form-control" id="newUsername" type="text"
                                                                       required onchange="checkUsernameValid()"/>
                                                                <div id="usernameMessage"></div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-group row">
                                                            <div class="input-group">
                                                                <input class="form-control" id="newPassword"
                                                                       type="password" required
                                                                       onchange="checkPasswordValid()"/>
                                                                <div class="input-group-append">
                                                                    <span class="input-group-text" onclick="togglePasswordVisibility()">
                                                                        <i id="togglePasswordVisibility" class="mdi mdi-eye" style="color: black"></i>
                                                                    </span>
                                                                </div>
                                                            </div>
                                                            <div id="passwordMessage"></div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group row">
                                                            <label class="col-sm-3 col-form-label">First Name</label>
                                                            <div class="col-sm-9">
                                                                <input class="form-control" id="newFirstName"
                                                                       type="text" required/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-group row">
                                                            <label class="col-sm-3 col-form-label">Last Name</label>
                                                            <div class="col-sm-9">
                                                                <input class="form-control" id="newLastName" type="text"
                                                                       required/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group row">
                                                            <label class="col-sm-3 col-form-label">Email</label>
                                                            <div class="col-sm-9">
                                                                <input class="form-control" id="newEmail" type="email"
                                                                       required onchange="checkGmailValid()"/>

                                                                <div id="gmailMessage"></div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-group row">
                                                            <label class="col-sm-3 col-form-label">Phone Number</label>
                                                            <div class="col-sm-9">
                                                                <input class="form-control" id="newPhoneNumber"
                                                                       type="text" required onchange="checkPhoneValid()"/>

                                                                <div id="phoneMessage"></div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group row">
                                                            <label class="col-sm-3 col-form-label">Customer Type</label>
                                                            <div class="col-sm-9">
                                                                <select class="form-control" id="newCustomerType"
                                                                        style="color: black;">
                                                                    <option value="1">New Customer</option>
                                                                    <option value="2">Current Customer</option>
                                                                    <option value="3">Former Customer</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <p class="card-description">Address</p>
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group row">
                                                            <label class="col-sm-3 col-form-label">Address line
                                                                1</label>
                                                            <div class="col-sm-9">
                                                                <input class="form-control" id="newAddress1" type="text"
                                                                       />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-group row">
                                                            <label class="col-sm-3 col-form-label">Postal Code</label>
                                                            <div class="col-sm-9">
                                                                <input class="form-control" id="newPostalCode"
                                                                       type="text" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group row">
                                                            <label class="col-sm-3 col-form-label">Address line
                                                                2</label>
                                                            <div class="col-sm-9">
                                                                <input class="form-control" id="newAddress2"
                                                                       type="text"/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-group row">
                                                            <label class="col-sm-3 col-form-label">City</label>
                                                            <div class="col-sm-9">
                                                                <input class="form-control" id="newCity" type="text"
                                                                       />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-6"></div>
                                                    <div class="col-md-6">
                                                        <button class="btn btn-primary btn-lg" type="submit" onclick="addNewCustomer()">Add
                                                        </button>
                                                        <button class="btn btn-secondary btn-lg" data-bs-dismiss="modal"
                                                                type="button">Close
                                                        </button>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>


                            <!-- partial -->
                        </div>
                        <!-- main-panel ends -->
                    </div>
                    <!-- page-body-wrapper ends -->
                </div>
                <!-- container-scroller -->

                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

                <!-- plugins:js -->
                <script src="vendors/js/vendor.bundle.base.js"></script>
                <!-- endinject -->
                <!-- Plugin js for this page -->
                <script src="vendors/bootstrap-datepicker/bootstrap-datepicker.min.js"></script>

                <!-- End plugin js for this page -->
                <!-- inject:js -->
                <script src="js/dashboard/off-canvas.js"></script>
                <script src="js/dashboard/hoverable-collapse.js"></script>
                <script src="js/dashboard/template.js"></script>
                <script src="js/dashboard/settings.js"></script>
                <!-- endinject -->
                <!-- Custom js for this page-->
                <script src="js/dashboard/dashboard.js"></script>
<%--                <script src="js/dashboard/Chart.roundedBarCharts.js"></script>--%>
                <!-- End custom js for this page-->

</body>

</html>

