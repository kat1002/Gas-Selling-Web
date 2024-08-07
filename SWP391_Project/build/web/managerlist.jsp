<!DOCTYPE html>
<html lang="en">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1, shrink-to-fit=no" name="viewport">
    <title>Manager List </title>
    <!-- plugins:css -->
    <link href="vendors/feather/feather.css" rel="stylesheet">
    <link href="vendors/mdi/css/materialdesignicons.min.css" rel="stylesheet">
    <link href="vendors/ti-icons/css/themify-icons.css" rel="stylesheet">
    <link href="vendors/typicons/typicons.css" rel="stylesheet">
    <link href="vendors/simple-line-icons/css/simple-line-icons.css" rel="stylesheet">
    <link href="vendors/css/vendor.bundle.base.css" rel="stylesheet">
    <!-- endinject -->
    <!-- Plugin css for this page -->
    <%--    <link href="vendors/datatables.net-bs4/dataTables.bootstrap4.css" rel="stylesheet">--%>
    <link href="js/dashboard/select.dataTables.min.css" rel="stylesheet">
    <!-- End plugin css for this page -->
    <!-- inject:css -->
    <link href="CSS/dashboardcss/vertical-layout-light/style.css" rel="stylesheet">
    <!-- endinject -->
    <link href="images/favicon.png" rel="shortcut icon"/>
    <script src="js/dashboard_custom/managerlist.js"/>
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
                    <a class="nav-link" data-bs-toggle="collapse" href="#user-list" aria-expanded="false" aria-controls="user-list">
                        <i class="menu-icon mdi mdi-account-box"></i>
                        <span class="menu-title">User List</span>
                        <i class="menu-arrow"></i>
                    </a>
                    <div class="collapse" id="user-list">
                        <ul class="nav flex-column sub-menu">
                            <li class="nav-item"> <a class="nav-link" onclick="window.location.href='customerlist'">Customers List</a></li>
                            <li class="nav-item"> <a class="nav-link" onclick="window.location.href='managerlist'">Managers List</a></li>
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
                            <li class="nav-item"> <a class="nav-link" href="pages/ui-features/buttons.html">Products List</a></li>
                            <li class="nav-item"> <a class="nav-link" href="pages/ui-features/buttons.html">Vouchers List</a></li>
                            <li class="nav-item"> <a class="nav-link" href="pages/ui-features/buttons.html">Discount List</a></li>
                            <li class="nav-item"> <a class="nav-link" href="pages/ui-features/buttons.html">Category List</a></li>
                            <li class="nav-item"> <a class="nav-link" href="pages/ui-features/buttons.html">Service Tag List</a></li>
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
                            <li class="nav-item"> <a class="nav-link" href="pages/ui-features/buttons.html">Orders List</a></li>
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
                                        <a aria-controls="customerlist" aria-selected="false" class="nav-link ps-0"
                                           data-bs-toggle="tab" href="customerlist" id="home-tab"
                                           role="tab" onclick="window.location.href='customerlist'">Customers List</a>
                                    </li>
                                    <li class="nav-item">
                                        <a  class="nav-link active" aria-selected="true" class="nav-link" data-bs-toggle="tab"
                                           href="managerlist" id="profile-tab" role="tab" onclick="window.location.href='managerlist'">Managers List</a>
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
                                <div aria-labelledby="managerlist" class="tab-pane fade show active" id="managerlist" role="tabpanel">
                                    <div class="col-lg-12 grid-margin stretch-card">
                                        <div class="card">
                                            <div class="card-body">
                                                <h4 class="card-title">Managers List</h4>
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <div class="input-group">
                                                                <div class="input-group-prepend">
                                                                    <button aria-expanded="false" aria-haspopup="true" class="btn btn-sm btn-outline-primary dropdown-toggle" data-bs-toggle="dropdown" type="button">
                                                                        Search by
                                                                    </button>
                                                                    <div class="dropdown-menu" value="">
                                                                        <a class="dropdown-item" href="#" onclick="setSearchType('manager_id')">Search by Id</a>
                                                                        <a class="dropdown-item" href="#" onclick="setSearchType('username')">Search by Username</a>
                                                                        <a class="dropdown-item" href="#" onclick="setSearchType('email')">Search by Email</a>
                                                                        <a class="dropdown-item" href="#" onclick="setSearchType('first_name')">Search by First Name</a>
                                                                    </div>
                                                                </div>
                                                                <input class="form-control" id="searchQuery" placeholder="Search" type="text">
                                                                <div class="input-group-append">
                                                                    <button class="btn btn-sm btn-primary" onclick="searchManagers()" style="color: white;" type="button">Search</button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <div class="form-group row">
                                                            <label class="col-sm-3 col-form-label">Sort by</label>
                                                            <div class="col-sm-9">
                                                                <select class="form-control" id="sortBy" onchange="fetchManagers()" style="color: black;">
                                                                    <option selected="selected" value="manager_id">Id</option>
                                                                    <option value="role_id">Role</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <div class="form-group row">
                                                            <label class="col-sm-6 col-form-label">Managers per page</label>
                                                            <div class="col-sm-6">
                                                                <select class="form-control" id="rowsPerPage" onchange="fetchManagers()" style="color: black;">
                                                                    <option selected="selected" value="10">10</option>
                                                                    <option value="20">20</option>
                                                                    <option value="50">50</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <button type="button" class="btn btn-primary"
                                                            style="color: white" data-bs-toggle="modal"
                                                            data-bs-target="#addCustomerModal"
                                                            onclick="openAddManagerForm()">Add New Admin
                                                    </button>
                                                </div>
                                                <div class="table-responsive pt-3">
                                                    <table class="table table-hover" id="managerTable">
                                                        <thead>
                                                        <tr>
                                                            <th>Manager Id</th>
                                                            <th>Username</th>
                                                            <th>Role</th>
                                                            <th>Email</th>
                                                            <th>Phone</th>
                                                            <th>First Name</th>
                                                            <th>Last Name</th>
                                                            <th>Actions</th>
                                                        </tr>
                                                        </thead>
                                                        <tbody>
                                                        <!-- Manager rows will be injected here by JavaScript -->
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


                            <!-- Manager Modal Structure -->
                            <div aria-hidden="true" aria-labelledby="managerDetailsModalLabel" class="modal fade" id="managerDetailsModal" tabindex="-1">
                                <div class="modal-dialog modal-dialog-centered modal-lg">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="managerDetailsModalLabel">Manager Details</h5>
                                            <button aria-label="Close" class="btn-close" data-bs-dismiss="modal" type="button"></button>
                                        </div>
                                        <div class="modal-body">
                                            <form class="form-sample" id="managerDetailsForm">
                                                <p class="card-description">Personal info</p>
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group row">
                                                            <label class="col-sm-3 col-form-label">Username</label>
                                                            <div class="col-sm-9">
                                                                <input class="form-control" id="username" type="text" readonly/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-group row">
                                                            <label class="col-sm-3 col-form-label">Manager ID</label>
                                                            <div class="col-sm-9">
                                                                <input class="form-control" id="managerId" readonly type="text"/>
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
                                                            <label class="col-sm-3 col-form-label">Email</label>
                                                            <div class="col-sm-9">
                                                                <input class="form-control" id="email" type="text"/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-group row">
                                                            <label class="col-sm-3 col-form-label">Phone Number</label>
                                                            <div class="col-sm-9">
                                                                <input class="form-control" id="phoneNumber" type="text"/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group row">
                                                            <label class="col-sm-3 col-form-label">Role ID</label>
                                                            <div class="col-sm-9">
                                                                <select class="form-control" id="role"
                                                                        style="color: black;">
                                                                    <option value="0">Admin</option>
                                                                    <option value="1">Manager</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-6"></div>
                                                    <div class="col-md-6">
                                                        <button class="btn btn-primary btn-lg" onclick="saveManagerDetails()">Save changes </button>
                                                        <button class="btn btn-secondary btn-lg" data-bs-dismiss="modal" type="button">Close</button>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Add New Manager Modal Structure -->
                            <div aria-hidden="true" aria-labelledby="addManagerModalLabel" class="modal fade" id="addManagerModal" tabindex="-1">
                                <div class="modal-dialog modal-dialog-centered modal-lg">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="addManagerModalLabel">Add New Manager</h5>
                                            <button aria-label="Close" class="btn-close" data-bs-dismiss="modal" type="button"></button>
                                        </div>
                                        <div class="modal-body">
                                            <form class="form-sample" id="addManagerForm">
                                                <p class="card-description">Personal info</p>
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group row">
                                                            <label class="col-sm-3 col-form-label">Username</label>
                                                            <div class="col-sm-9">
                                                                <input class="form-control" id="newUsername" type="text" required onchange="checkUsernameValid()"/>
                                                                <div id="usernameMessage"></div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-group row">
                                                            <div class="input-group">
                                                                <label class="col-sm-3 col-form-label">Password</label>
                                                                <input class="form-control" id="newPassword" type="password" required onchange="checkPasswordValid()"/>
                                                                <div class="input-group-append">
                                        <span class="input-group-text" onclick="togglePasswordVisibility()">
                                            <i id="togglePasswordVisibilityIcon" class="mdi mdi-eye" style="color: black"></i>
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
                                                                <input class="form-control" id="newFirstName" type="text" required/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-group row">
                                                            <label class="col-sm-3 col-form-label">Last Name</label>
                                                            <div class="col-sm-9">
                                                                <input class="form-control" id="newLastName" type="text" required/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group row">
                                                            <label class="col-sm-3 col-form-label">Email</label>
                                                            <div class="col-sm-9">
                                                                <input class="form-control" id="newEmail" type="email" required onchange="checkGmailValid()"/>
                                                                <div id="gmailMessage"></div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-group row">
                                                            <label class="col-sm-3 col-form-label">Phone Number</label>
                                                            <div class="col-sm-9">
                                                                <input class="form-control" id="newPhoneNumber" type="text" required onchange="checkPhoneValid()"/>
                                                                <div id="phoneMessage"></div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group row">
                                                            <label class="col-sm-3 col-form-label">Manager Type</label>
                                                            <div class="col-sm-9">
                                                                <select class="form-control" id="newRole" style="color: black;">
                                                                    <option value="0">Admin</option>
                                                                    <option value="1">Manager</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row mt-3">
                                                    <div class="col-md-6"></div>
                                                    <div class="col-md-6 d-flex justify-content-end">
                                                        <button class="btn btn-primary btn-lg" type="submit" onclick="addNewManager()">Add</button>
                                                        <button class="btn btn-secondary btn-lg ms-2" data-bs-dismiss="modal" type="button">Close</button>
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
                <script src="js/dashboard_custom/managerlist.js"></script>


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
                <!-- End custom js for this page-->

</body>

</html>

