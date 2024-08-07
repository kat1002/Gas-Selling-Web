<%--
  Created by IntelliJ IDEA.
  User: taola
  Date: 6/13/2024
  Time: 9:59 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Admin Dashboard</title>
    <!-- plugins:css -->
    <link rel="stylesheet" href="vendors/feather/feather.css">
    <link rel="stylesheet" href="vendors/mdi/css/materialdesignicons.min.css">
    <link rel="stylesheet" href="vendors/ti-icons/css/themify-icons.css">
    <link rel="stylesheet" href="vendors/typicons/typicons.css">
    <link rel="stylesheet" href="vendors/simple-line-icons/css/simple-line-icons.css">
    <link rel="stylesheet" href="vendors/css/vendor.bundle.base.css">
    <!-- endinject -->
    <!-- Plugin css for this page -->
    <link rel="stylesheet" href="vendors/datatables.net-bs4/dataTables.bootstrap4.css">
    <link rel="stylesheet" href="js/dashboard/select.dataTables.min.css">
    <!-- End plugin css for this page -->
    <!-- inject:css -->
    <link rel="stylesheet" href="CSS/dashboardcss/vertical-layout-light/style.css">
    <!-- endinject -->
    <link rel="shortcut icon" href="media/dashboard/favicon.png" />
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
                  <a class="dropdown-item" href="logout"><i class="dropdown-item-icon mdi mdi-power text-primary me-2"></i>Sign Out</a>
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
                    <li class="nav-item"> <a class="nav-link" href="managerlist">Managers List</a></li>
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
                    <li class="nav-item"> <a class="nav-link" href="productlist">Products List</a></li>
                    <li class="nav-item"> <a class="nav-link" href="voucherlist">Vouchers List</a></li>
                    <li class="nav-item"> <a class="nav-link" href="discountlist">Discount List</a></li>
                    <li class="nav-item"> <a class="nav-link" href="categorylist">Category List</a></li>
                    <li class="nav-item"> <a class="nav-link" href="servicetaglist">Service Tag List</a></li>
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
                          <a class="nav-link active ps-0" id="home-tab" data-bs-toggle="tab" href="#overview" role="tab" aria-controls="overview" aria-selected="true">Overview</a>
                        </li>
                        <li class="nav-item">
                          <a class="nav-link" id="profile-tab" data-bs-toggle="tab" href="#audiences" role="tab" aria-selected="false">Audiences</a>
                        </li>
                        <li class="nav-item">
                          <a class="nav-link" id="contact-tab" data-bs-toggle="tab" href="#demographics" role="tab" aria-selected="false">Demographics</a>
                        </li>
                        <li class="nav-item">
                          <a class="nav-link border-0" id="more-tab" data-bs-toggle="tab" href="#more" role="tab" aria-selected="false">More</a>
                        </li>
                      </ul>
                    </div>
                    <div class="tab-content tab-content-basic">
                      <div class="tab-pane fade show active" id="overview" role="tabpanel" aria-labelledby="overview"> 
                        <div class="row">
                            <div class="col-sm-12">
                              <div class="statistics-details d-flex align-items-center justify-content-between">
                                <div>
                                  <p class="statistics-title">Total Sales</p>
                                  <h3 class="rate-percentage">$32.53</h3>
                                  <p class="text-danger d-flex"><i class="mdi mdi-menu-down"></i><span>-0.5%</span></p>
                                </div>
                                <div>
                                  <p class="statistics-title">Total Orders</p>
                                  <h3 class="rate-percentage">7,682</h3>
                                  <p class="text-success d-flex"><i class="mdi mdi-menu-up"></i><span>+0.1%</span></p>
                                </div>
                                <div>
                                  <p class="statistics-title">Total Revenue</p>
                                  <h3 class="rate-percentage">$68.8</h3>
                                  <p class="text-danger d-flex"><i class="mdi mdi-menu-down"></i><span>68.8</span></p>
                                </div>
                                <div class="d-none d-md-block">
                                  <p class="statistics-title">Total Customers</p>
                                  <h3 class="rate-percentage">100</h3>
                                  <p class="text-success d-flex"><i class="mdi mdi-menu-up"></i><span>+0.8%</span></p>
                                </div>
                                
                                <div class="d-none d-md-block">
                                </div>
                                <div class="d-none d-md-block">
                                </div>
                              </div>
                            </div>
                          </div>
                        <div class="row">
                          <div class="row flex-grow">
                            <div class="col-12 grid-margin stretch-card">
                              <div class="card">
                                  <div class="card-body">
                                    <h4 class="card-title">Orders</h4>
                                    <p class="card-description">
                                      Newest Orders</code>
                                    </p>
                                    <div class="table-responsive">
                                      <table class="table">
                                        <thead>
                                          <tr>
                                            <th>Customer</th>
                                            <th>Order Id</th>
                                            <th>Created</th>
                                            <th>Total</th>
                                          </tr>
                                        </thead>
                                        <tbody>
                                          <tr>
                                            <td>Jacob</td>
                                            <td>53275531</td>
                                            <td>12 May 2017</td>
                                          </tr>
                                        </tbody>
                                      </table>
                                    </div>
                                    <div class="list align-items-center pt-3">
                                      <div class="wrapper w-100">
                                        <p class="mb-0">
                                          <a href="#" class="fw-bold text-primary">Show all <i class="mdi mdi-arrow-right ms-2"></i></a>
                                        </p>
                                      </div>
                                    </div>
                                  </div>
                                </div>
                            </div>
                          </div>
                          <div class="col-lg-11 d-flex flex-column">
                            <div class="row flex-grow">
                              <div class="col-md-6 col-lg-6 grid-margin stretch-card">
                                <div class="card">
                                  <div class="card-body">
                                    <h4 class="card-title">Voucher List</h4>
                                    <p class="card-description">
                                      Newest Voucher</code>
                                    </p>
                                    <div class="table-responsive">
                                      <table class="table">
                                        <thead>
                                          <tr>
                                            <th>Voucher Code</th>
                                            <th>Voucher Name</th>
                                            <th>Created</th>
                                          </tr>
                                        </thead>
                                        <tbody>
                                          <tr>
                                            <td>Jacob</td>
                                            <td>53275531</td>
                                            <td>12 May 2017</td>
                                          </tr>
                                        </tbody>
                                      </table>
                                    </div>
                                    <div class="list align-items-center pt-3">
                                      <div class="wrapper w-100">
                                        <p class="mb-0">
                                          <a href="#" class="fw-bold text-primary">Show all <i class="mdi mdi-arrow-right ms-2"></i></a>
                                        </p>
                                      </div>
                                    </div>
                                  </div>
                                </div>
                              </div>
                              <div class="col-md-6 col-lg-6 grid-margin stretch-card">
                                <div class="card">
                                  <div class="card-body">
                                    <h4 class="card-title">Customer List</h4>
                                    <p class="card-description">
                                      Newest Customer</code>
                                    </p>
                                    <div class="table-responsive">
                                      <table class="table">
                                        <thead>
                                          <tr>
                                            <th>Customer</th>
                                            <th>Username</th>
                                            <th>Gmail</th>
                                            <th>Phone</th>
                                          </tr>
                                        </thead>
                                        <tbody>
                                          <tr>
                                            <td>Jacob</td>
                                            <td>53275531</td>
                                            <td>12 May 2017</td>
                                          </tr>
                                        </tbody>
                                      </table>
                                    </div>
                                    <div class="list align-items-center pt-3">
                                      <div class="wrapper w-100">
                                        <p class="mb-0">
                                          <a href="#" class="fw-bold text-primary">Show all <i class="mdi mdi-arrow-right ms-2"></i></a>
                                        </p>
                                      </div>
                                    </div>
                                  </div>
                                </div>
                              </div>
                            </div>
                          </div>
                            
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
<script src="js/dashboard/todolist.js"></script>
<!-- endinject -->
<!-- Custom js for this page-->
<script src="js/dashboard/dashboard.js"></script>
<script src="js/dashboard/Chart.roundedBarCharts.js"></script>
<!-- End custom js for this page-->
</body>

</html>


</html>
