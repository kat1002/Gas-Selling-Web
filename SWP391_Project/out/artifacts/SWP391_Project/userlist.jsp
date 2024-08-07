<!DOCTYPE html>
<html lang="en">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1, shrink-to-fit=no" name="viewport">
    <title>User List </title>
    <!-- plugins:css -->
    <link href="vendors/feather/feather.css" rel="stylesheet">
    <link href="vendors/mdi/css/materialdesignicons.min.css" rel="stylesheet">
    <link href="vendors/ti-icons/css/themify-icons.css" rel="stylesheet">
    <link href="vendors/typicons/typicons.css" rel="stylesheet">
    <link href="vendors/simple-line-icons/css/simple-line-icons.css" rel="stylesheet">
    <link href="vendors/css/vendor.bundle.base.css" rel="stylesheet">
    <!-- endinject -->
    <!-- Plugin css for this page -->
    <link href="vendors/datatables.net-bs4/dataTables.bootstrap4.css" rel="stylesheet">
    <link href="js/select.dataTables.min.css" rel="stylesheet">
    <!-- End plugin css for this page -->
    <!-- inject:css -->
    <link href="CSS/dashboardcss/vertical-layout-light/style.css" rel="stylesheet">
    <!-- endinject -->
    <link href="images/favicon.png" rel="shortcut icon"/>
</head>
<body>
<div class="container-scroller">
    <!-- partial:partials/_navbar.html -->
    <nav class="navbar default-layout col-lg-12 col-12 p-0 fixed-top d-flex align-items-top flex-row">
        <div class="text-center navbar-brand-wrapper d-flex align-items-center justify-content-start">
            <div class="me-3">
                <button class="navbar-toggler navbar-toggler align-self-center" data-bs-toggle="minimize" type="button">
                    <span class="icon-menu"></span>
                </button>
            </div>
            <div>
                <a class="navbar-brand brand-logo" href="index.html">
                    <img alt="logo" src="images/logo.svg"/>
                </a>
                <a class="navbar-brand brand-logo-mini" href="index.html">
                    <img alt="logo" src="images/logo-mini.svg"/>
                </a>
            </div>
        </div>
        <div class="navbar-menu-wrapper d-flex align-items-top">
            <ul class="navbar-nav">
                <li class="nav-item font-weight-semibold d-none d-lg-block ms-0">
                    <h1 class="welcome-text">Good Morning, <span class="text-black fw-bold">John Doe</span></h1>
                    <h3 class="welcome-sub-text">Your performance summary this week </h3>
                </li>
            </ul>
            <ul class="navbar-nav ms-auto">

                <li class="nav-item d-none d-lg-block">
                    <div class="input-group date datepicker navbar-date-picker" id="datepicker-popup">
              <span class="input-group-addon input-group-prepend border-right">
                <span class="icon-calendar input-group-text calendar-icon"></span>
              </span>
                        <input class="form-control" type="text">
                    </div>
                </li>
                <li class="nav-item dropdown d-none d-lg-block user-dropdown">
                    <a aria-expanded="false" class="nav-link" data-bs-toggle="dropdown" href="#" id="UserDropdown">
                        <img alt="Profile image" class="img-xs rounded-circle" src="images/faces/face8.jpg"> </a>
                    <div aria-labelledby="UserDropdown" class="dropdown-menu dropdown-menu-right navbar-dropdown">
                        <div class="dropdown-header text-center">
                            <img alt="Profile image" class="img-md rounded-circle" src="images/faces/face8.jpg">
                            <p class="mb-1 mt-3 font-weight-semibold">Allen Moreno</p>
                            <p class="fw-light text-muted mb-0">allenmoreno@gmail.com</p>
                        </div>
                        <a class="dropdown-item"><i
                                class="dropdown-item-icon mdi mdi-account-outline text-primary me-2"></i> My Profile
                            <span class="badge badge-pill badge-danger">1</span></a>
                        <a class="dropdown-item"><i
                                class="dropdown-item-icon mdi mdi-message-text-outline text-primary me-2"></i> Messages</a>
                        <a class="dropdown-item"><i
                                class="dropdown-item-icon mdi mdi-calendar-check-outline text-primary me-2"></i>
                            Activity</a>
                        <a class="dropdown-item"><i
                                class="dropdown-item-icon mdi mdi-help-circle-outline text-primary me-2"></i> FAQ</a>
                        <a class="dropdown-item"><i class="dropdown-item-icon mdi mdi-power text-primary me-2"></i>Sign
                            Out</a>
                    </div>
                </li>
            </ul>
            <button class="navbar-toggler navbar-toggler-right d-lg-none align-self-center" data-bs-toggle="offcanvas"
                    type="button">
                <span class="mdi mdi-menu"></span>
            </button>
        </div>
    </nav>
    <!-- partial -->
    <div class="container-fluid page-body-wrapper">
        <!-- partial -->
        <!-- partial:partials/_sidebar.html -->
        <nav class="sidebar sidebar-offcanvas" id="sidebar">
            <ul class="nav">
                <li class="nav-item">
                    <a class="nav-link" href="dashboard">
                        <i class="mdi mdi-grid-large menu-icon"></i>
                        <span class="menu-title">Dashboard</span>
                    </a>
                </li>
                <li class="nav-item nav-category">UI Elements</li>
                <li class="nav-item">
                    <a aria-controls="ui-basic" aria-expanded="false" class="nav-link" data-bs-toggle="collapse"
                       href="#ui-basic">
                        <i class="menu-icon mdi mdi-floor-plan"></i>
                        <span class="menu-title">UI Elements</span>
                        <i class="menu-arrow"></i>
                    </a>
                    <div class="collapse" id="ui-basic">
                        <ul class="nav flex-column sub-menu">
                            <li class="nav-item"><a class="nav-link" href="pages/ui-features/buttons.html">Buttons</a>
                            </li>
                            <li class="nav-item"><a class="nav-link"
                                                    href="pages/ui-features/dropdowns.html">Dropdowns</a></li>
                            <li class="nav-item"><a class="nav-link"
                                                    href="pages/ui-features/typography.html">Typography</a></li>
                        </ul>
                    </div>
                </li>
                <li class="nav-item nav-category">Forms and Datas</li>
                <li class="nav-item">
                    <a aria-controls="form-elements" aria-expanded="false" class="nav-link" data-bs-toggle="collapse"
                       href="#form-elements">
                        <i class="menu-icon mdi mdi-card-text-outline"></i>
                        <span class="menu-title">Form elements</span>
                        <i class="menu-arrow"></i>
                    </a>
                    <div class="collapse" id="form-elements">
                        <ul class="nav flex-column sub-menu">
                            <li class="nav-item"><a class="nav-link" href="pages/forms/basic_elements.html">Basic
                                Elements</a></li>
                        </ul>
                    </div>
                </li>
                <li class="nav-item">
                    <a aria-controls="charts" aria-expanded="false" class="nav-link" data-bs-toggle="collapse"
                       href="#charts">
                        <i class="menu-icon mdi mdi-chart-line"></i>
                        <span class="menu-title">Charts</span>
                        <i class="menu-arrow"></i>
                    </a>
                    <div class="collapse" id="charts">
                        <ul class="nav flex-column sub-menu">
                            <li class="nav-item"><a class="nav-link" href="pages/charts/chartjs.html">ChartJs</a></li>
                        </ul>
                    </div>
                </li>
                <li class="nav-item">
                    <a aria-controls="tables" aria-expanded="false" class="nav-link" data-bs-toggle="collapse"
                       href="#tables">
                        <i class="menu-icon mdi mdi-table"></i>
                        <span class="menu-title">Tables</span>
                        <i class="menu-arrow"></i>
                    </a>
                    <div class="collapse" id="tables">
                        <ul class="nav flex-column sub-menu">
                            <li class="nav-item"><a class="nav-link" href="pages/tables/basic-table.html">Basic
                                table</a></li>
                        </ul>
                    </div>
                </li>
                <li class="nav-item">
                    <a aria-controls="icons" aria-expanded="false" class="nav-link" data-bs-toggle="collapse"
                       href="#icons">
                        <i class="menu-icon mdi mdi-layers-outline"></i>
                        <span class="menu-title">Icons</span>
                        <i class="menu-arrow"></i>
                    </a>
                    <div class="collapse" id="icons">
                        <ul class="nav flex-column sub-menu">
                            <li class="nav-item"><a class="nav-link" href="pages/icons/mdi.html">Mdi icons</a></li>
                        </ul>
                    </div>
                </li>
                <li class="nav-item nav-category">pages</li>
                <li class="nav-item">
                    <a aria-controls="auth" aria-expanded="false" class="nav-link" data-bs-toggle="collapse"
                       href="#auth">
                        <i class="menu-icon mdi mdi-account-circle-outline"></i>
                        <span class="menu-title">User Pages</span>
                        <i class="menu-arrow"></i>
                    </a>
                    <div class="collapse" id="auth">
                        <ul class="nav flex-column sub-menu">
                            <li class="nav-item"><a class="nav-link" href="pages/samples/login.html"> Login </a></li>
                        </ul>
                    </div>
                </li>
                <li class="nav-item nav-category">help</li>
                <li class="nav-item">
                    <a class="nav-link" href="http://bootstrapdash.com/demo/star-admin2-free/docs/documentation.html">
                        <i class="menu-icon mdi mdi-file-document"></i>
                        <span class="menu-title">Documentation</span>
                    </a>
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
                                        <a aria-controls="overview" aria-selected="true" class="nav-link active ps-0"
                                           data-bs-toggle="tab" href="userlist?view=customer" id="home-tab"
                                           role="tab">Customers List</a>
                                    </li>
                                    <li class="nav-item">
                                        <a aria-selected="false" class="nav-link" data-bs-toggle="tab"
                                           href="userlist?view=manager" id="profile-tab" role="tab">Staffs List</a>
                                    </li>
                                </ul>
                                <div>
                                    <div class="btn-wrapper">
                                        <a class="btn btn-otline-dark align-items-center" href="#"><i
                                                class="icon-share"></i> Share</a>
                                        <a class="btn btn-otline-dark" href="#"><i class="icon-printer"></i> Print</a>
                                        <a class="btn btn-primary text-white me-0" href="#"><i
                                                class="icon-download"></i> Export</a>
                                    </div>
                                </div>
                            </div>
                            <div class="tab-content tab-content-basic">
                                <div aria-labelledby="userlist" class="tab-pane fade show active" id="userlist"
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
                                                                            aria-haspopup="true" class="btn btn-sm btn-outline-primary dropdown-toggle"
                                                                            data-bs-toggle="dropdown" type="button">
                                                                        Search by
                                                                    </button>
                                                                    <div class="dropdown-menu" value="">
                                                                        <a class="dropdown-item" href="#" onclick="setSearchType('id')">Search by Id</a>
                                                                        <a class="dropdown-item" href="#" onclick="setSearchType('username')">Search by Username</a>
                                                                        <a class="dropdown-item" href="#" onclick="setSearchType('firstName')">Search by First Name</a>
                                                                    </div>
                                                                </div>
                                                                <input class="form-control" id="searchQuery" placeholder="Search"
                                                                       type="text">
                                                                <div class="input-group-append">
                                                                    <button class="btn btn-sm btn-primary" onclick="searchCustomers()" style="color: white;" type="button">Search </button>
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
                                                                    <option selected="selected" value="id">Id</option>
                                                                    <option value="customerType">Customer Type</option>
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
                                                </div>
                                                <div class="table-responsive pt-3">
                                                    <table class="table table-bordered" id="customerTable">
                                                        <thead>
                                                        <tr>
                                                            <th>User id</th>
                                                            <th>Username</th>
                                                            <th>Gmail</th>
                                                            <th>Phone</th>
                                                            <th>First Name</th>
                                                            <th>Last Name</th>
                                                            <th>Actions</th>
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

                            <div class="tab-content tab-content-basic">
                                <div aria-labelledby="overview" class="tab-pane fade show active" id="overview"
                                     role="tabpanel">
                                    <div class="col-lg-12 grid-margin stretch-card">
                                        <div class="card">
                                            <div class="card-body">
                                                <h4 class="card-title">Manager List</h4>
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <div class="input-group">
                                                                <div class="input-group-prepend">
                                                                    <button aria-expanded="false"
                                                                            aria-haspopup="true" class="btn btn-sm btn-outline-primary dropdown-toggle"
                                                                            data-bs-toggle="dropdown" type="button">
                                                                        Search by
                                                                    </button>
                                                                    <div class="dropdown-menu">
                                                                        <a class="dropdown-item" href="#">Search by Id</a>
                                                                        <a class="dropdown-item" href="#">Search by Username</a>
                                                                        <a class="dropdown-item" href="#">Search by Name</a>
                                                                    </div>
                                                                </div>
                                                                <input aria-label="Recipient's username" class="form-control"
                                                                       placeholder="Recipient's username"
                                                                       type="text">
                                                                <div class="input-group-append">
                                                                    <button class="btn btn-sm btn-primary" style="color: white;" type="button">Search </button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-3"></div>
                                                    <div class="col-md-3">
                                                        <div class="form-group row">
                                                            <label class="col-sm-6 col-form-label">Customer per page</label>
                                                            <div class="col-sm-3">
                                                                <select class="form-control" id="showType" style="color: black;">
                                                                    <option>10</option>
                                                                    <option>20</option>
                                                                    <option>50</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="table-responsive pt-3">
                                                    <table class="table table-bordered">
                                                        <thead>
                                                        <tr>
                                                            <th>Manager id</th>
                                                            <th>Role</th>
                                                            <th>Username</th>
                                                            <th>Gmail</th>
                                                            <th>Phone</th>
                                                            <th>First Name</th>
                                                            <th>Last Name</th>
                                                            <th>Actions</th>
                                                        </tr>
                                                        </thead>
                                                        <tbody>
                                                        <tr>
                                                            <td>1</td>
                                                            <td>Manager</td>
                                                            <td>test</td>
                                                            <td>nguyenphuc10022004@gmail.com</td>
                                                            <td>0382474954</td>
                                                            <td>Phuc</td>
                                                            <td>Nguyen</td>
                                                            <td>
                                                                <button class="btn btn-info btn-sm" data-bs-target="#userDetailsModal"
                                                                        data-bs-toggle="modal"
                                                                        onclick="populateUserDetails(1)"
                                                                        type="button">Details
                                                                </button>
                                                                <button class="btn btn-danger btn-sm" type="button">
                                                                    Delete
                                                                </button>
                                                            </td>
                                                        </tr>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Customer Modal Structure -->
                            <div aria-hidden="true" aria-labelledby="customerDetailsModalLabel" class="modal fade" id="customerDetailsModal" tabindex="-1">
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
                                                                <input class="form-control" id="username" readonly type="text"/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-group row">
                                                            <label class="col-sm-3 col-form-label">User Id</label>
                                                            <div class="col-sm-9">
                                                                <input class="form-control" id="userId" readonly type="text"/>
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
                                                                <input class="form-control" id="email" readonly type="text"/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-group row">
                                                            <label class="col-sm-3 col-form-label">Phone Number</label>
                                                            <div class="col-sm-9">
                                                                <input class="form-control" id="phoneNumber" readonly type="text"/>
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
                                                            <label class="col-sm-3 col-form-label">Email/SMS</label>
                                                            <div class="col-sm-4">
                                                                <div class="form-check">
                                                                    <input class="form-check-input" id="receiveEmail" type="checkbox">
                                                                    <label class="form-check-label" for="receiveEmail">Receive
                                                                        Email</label>
                                                                </div>
                                                            </div>
                                                            <div class="col-sm-5">
                                                                <div class="form-check">
                                                                    <input class="form-check-input" id="receiveSMS" type="checkbox">
                                                                    <label class="form-check-label" for="receiveSMS">Receive
                                                                        SMS</label>
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
                                                                <input class="form-control" id="postalCode" type="text"/>
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
                                                        <button class="btn btn-primary btn-lg" type="submit">Save
                                                            changes
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

                            <!-- Manager Modal Structure -->
                            <div aria-hidden="true" aria-labelledby="managerDetailsModalLabel" class="modal fade" id="managerDetailsModal" tabindex="-1">
                              <div class="modal-dialog modal-dialog-centered modal-lg">
                                  <div class="modal-content">
                                      <div class="modal-header">
                                          <h5 class="modal-title" id="managerDetailsModalLabel">Manager Details</h5>
                                          <button aria-label="Close" class="btn-close" data-bs-dismiss="modal"
                                                  type="button"></button>
                                      </div>
                                      <div class="modal-body">
                                          <form class="form-sample" id="managerDetailsForm">
                                              <p class="card-description">Personal info</p>
                                              <div class="row">
                                                  <div class="col-md-6">
                                                      <div class="form-group row">
                                                          <label class="col-sm-3 col-form-label">Username</label>
                                                          <div class="col-sm-9">
                                                              <input class="form-control" id="username" readonly type="text"/>
                                                          </div>
                                                      </div>
                                                  </div>
                                                  <div class="col-md-6">
                                                      <div class="form-group row">
                                                          <label class="col-sm-3 col-form-label">Manager Id</label>
                                                          <div class="col-sm-9">
                                                              <input class="form-control" id="userId" readonly type="text"/>
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
                                                              <input class="form-control" id="email" readonly type="text"/>
                                                          </div>
                                                      </div>
                                                  </div>
                                                  <div class="col-md-6">
                                                      <div class="form-group row">
                                                          <label class="col-sm-3 col-form-label">Phone Number</label>
                                                          <div class="col-sm-9">
                                                              <input class="form-control" id="phoneNumber" readonly type="text"/>
                                                          </div>
                                                      </div>
                                                  </div>
                                              </div>
                                              <div class="row">
                                                  <div class="col-md-6">
                                                      <div class="form-group row">
                                                          <label class="col-sm-3 col-form-label">Manager Type</label>
                                                          <div class="col-sm-9">
                                                              <select class="form-control" id="role"
                                                                      style="color: black;">
                                                                  <option value="1">Manager</option>
                                                                  <option value="2">Admin</option>
                                                              </select>
                                                          </div>
                                                      </div>
                                                  </div>
                                              </div>
                                              <div class="row">
                                                  <div class="col-md-6"></div>
                                                  <div class="col-md-6">
                                                      <button class="btn btn-primary btn-lg" type="submit">Save
                                                          changes
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

                <script>
                    //#region Customer

                    function openCustomerDetails(userId) {
                        // AJAX request to fetch user details from servlet
                        $.ajax({
                            url: 'userlist?action=customerDetails',  // Replace with your servlet URL
                            type: 'GET',
                            data: {userId: userId},
                            success: function (response) {
                                // Populate modal with fetched data
                                $('#username').val(response.username);
                                $('#userId').val(response.userId);
                                $('#firstName').val(response.firstName);
                                $('#lastName').val(response.lastName);
                                $('#email').val(response.email);
                                $('#phoneNumber').val(response.phoneNumber);
                                $('#customerType').val(response.customerType);
                                $('#receiveEmail').prop('checked', response.receiveEmail);
                                $('#receiveSMS').prop('checked', response.receiveSMS);
                                $('#address1').val(response.addressLine1);
                                $('#address2').val(response.addressLine2);
                                $('#postalCode').val(response.postalCode);
                                $('#city').val(response.city);

                                // Show the modal
                                $('#customerDetailsModal').modal('show');
                            },
                            error: function (xhr, status, error) {
                                // Handle errors if any
                                console.error('Error fetching customer details:', error);
                            }
                        });
                    }

                    let currentPage = 1;
                    let total = 0;
                    let rowsPerPage = 10;
                    let searchType = '';
                    let searchQuery = '';
                    let sortBy = 'id';

                    document.addEventListener("DOMContentLoaded", function () {
                        fetchCustomers();
                    });

                    function fetchCustomers() {
                        const queryParams = new URLSearchParams({
                            page: currentPage,
                            rowsPerPage: document.getElementById('rowsPerPage').value,
                            searchType: searchType,
                            searchQuery: searchQuery,
                            sortBy: document.getElementById('sortBy').value
                        });

                        fetch(`/CustomerServlet?${queryParams.toString()}`)
                            .then(response => response.json())
                            .then(data => {
                                total = data.totalCustomers;
                                populateCustomerTable(data.customers);
                                updatePagination();
                            })
                            .catch(error => console.error('Error fetching customer data:', error));
                    }

                    function populateCustomerTable(customers) {
                        const tbody = document.querySelector('#customerTable tbody');
                        tbody.innerHTML = '';

                        customers.forEach(customer => {
                            const row = document.createElement('tr');

                            row.innerHTML = `
                                              <td>${customer.id}</td>
                                              <td>${customer.username}</td>
                                              <td>${customer.email}</td>
                                              <td>${customer.phone}</td>
                                              <td>${customer.firstName}</td>
                                              <td>${customer.lastName}</td>
                                              <td>
                                                  <button type="button" class="btn btn-info btn-sm" data-bs-toggle="modal" data-bs-target="#userDetailsModal" onclick="openCustomerDetails(${customer.id})">Details</button>
                                                  <button type="button" class="btn btn-danger btn-sm" onclick="deleteCustomer(${customer.id})">Delete</button>
                                              </td>
                                          `;

                            tbody.appendChild(row);
                        });
                    }

                    function updatePagination() {
                        const totalPages = Math.ceil(total / rowsPerPage);
                        const pagination = document.getElementById('pagination');
                        pagination.innerHTML = '';

                        for (let i = 1; i <= totalPages; i++) {
                            const li = document.createElement('li');
                            li.classList.add('page-item');
                            if (i === currentPage) li.classList.add('active');

                            const a = document.createElement('a');
                            a.classList.add('page-link');
                            a.href = '#';
                            a.textContent = i;
                            a.addEventListener('click', (e) => {
                                e.preventDefault();
                                currentPage = i;
                                fetchCustomers();
                            });

                            li.appendChild(a);
                            pagination.appendChild(li);
                        }
                    }

                    function searchCustomers() {
                        searchQuery = document.getElementById('searchQuery').value;
                        currentPage = 1;
                        fetchCustomers();
                    }

                    function setSearchType(type) {
                        searchType = type;
                    }

                    function deleteCustomer(customerId) {
                        // Implement this function to delete a customer
                    }

                    //#endregion

                    //#region Manager

                    document.addEventListener("DOMContentLoaded", function () {
                        fetchManagers();
                    });

                    function fetchManagers() {
                        const queryParams = new URLSearchParams({
                            page: currentPage,
                            rowsPerPage: rowsPerPage,
                            searchType: searchType,
                            searchQuery: searchQuery,
                            sortBy: sortBy
                        });

                        fetch(`/ManagerServlet?${queryParams.toString()}`)
                            .then(response => response.json())
                            .then(data => {
                                total = data.totalManagers;
                                populateManagerTable(data.managers);
                                updatePagination();
                            })
                            .catch(error => console.error('Error fetching manager data:', error));
                    }

                    function populateManagerTable(managers) {
                        const tbody = document.querySelector('#managerTable tbody');
                        tbody.innerHTML = '';

                        managers.forEach(manager => {
                            const row = document.createElement('tr');

                            row.innerHTML = `
                                          <td>${manager.id}</td>
                                          <td>${manager.role}</td>
                                          <td>${manager.username}</td>
                                          <td>${manager.email}</td>
                                          <td>${manager.phone}</td>
                                          <td>${manager.firstName}</td>
                                          <td>${manager.lastName}</td>
                                          <td>
                                              <button type="button" class="btn btn-info btn-sm" data-bs-toggle="modal" data-bs-target="#userDetailsModal" onclick="openManagerDetails(${manager.id})">Details</button>
                                              <button type="button" class="btn btn-danger btn-sm" onclick="deleteManager(${manager.id})">Delete</button>
                                          </td>
                                      `;

                            tbody.appendChild(row);
                        });
                    }

                    function searchManagers() {
                        searchQuery = document.getElementById('searchQuery').value;
                        currentPage = 1;
                        fetchManagers();
                    }

                    function setSearchType(type) {
                        searchType = type;
                    }

                    function openManagerDetails(managerId) {
                        $.ajax({
                            url: 'managerlist?action=managerDetails',  // Replace with your servlet URL
                            type: 'GET',
                            data: {managerId: managerId},
                            success: function (response) {
                                // Populate modal with fetched data
                                $('#username').val(response.username);
                                $('#userId').val(response.userId);
                                $('#firstName').val(response.firstName);
                                $('#lastName').val(response.lastName);
                                $('#email').val(response.email);
                                $('#phoneNumber').val(response.phoneNumber);
                                $('#managerType').val(response.managerType);
                                // Show the modal
                                $('#managerDetailsModal').modal('show');
                            },
                            error: function (xhr, status, error) {
                                // Handle errors if any
                                console.error('Error fetching manager details:', error);
                            }
                        });
                    }

                    function deleteManager(managerId) {
                        // Implement this function to delete a manager
                        // Example:
                        $.ajax({
                            url: 'managerlist?action=deleteManager',
                            type: 'POST',
                            data: {managerId: managerId},
                            success: function (response) {
                                // Handle success
                                fetchManagers(); // Refresh manager list after deletion
                            },
                            error: function (xhr, status, error) {
                                // Handle errors
                                console.error('Error deleting manager:', error);
                            }
                        });
                    }


                    //#endregion

                </script>


                <!-- plugins:js -->
                <script src="vendors/js/vendor.bundle.base.js"></script>
                <!-- endinject -->
                <!-- Plugin js for this page -->
                <script src="vendors/chart.js/Chart.min.js"></script>
                <script src="vendors/bootstrap-datepicker/bootstrap-datepicker.min.js"></script>
                <script src="vendors/progressbar.js/progressbar.min.js"></script>

                <!-- End plugin js for this page -->
                <!-- inject:js -->
                <script src="js/dashboard/off-canvas.js"></script>
                <script src="js/dashboard/hoverable-collapse.js"></script>
                <script src="js/dashboard/template.js"></script>
                <script src="js/dashboard/settings.js"></script>
                <script src="js/dashboard/todolist.js"></script>
                <!-- endinject -->
                <!-- Custom js for this page-->
                <script src="js/dashboard/dashboard.js"></script>
                <script src="js/dashboard/Chart.roundedBarCharts.js"></script>
                <!-- End custom js for this page-->
</body>

</html>

