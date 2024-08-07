<%--
  Created by IntelliJ IDEA.
  User: taola
  Date: 6/13/2024
  Time: 9:59 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Admin Dashboard</title>
        <link rel="icon" href="media/icon/dashboard.png"/>
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
        <!--        <link rel="shortcut icon" href="media/dashboard/favicon.png" />-->
        <style>
            .gold-stars {
                color: gold; /* Đặt màu gold cho biểu tượng sao */
                font-size: 20px; /* Điều chỉnh kích thước nếu cần thiết */
            }
        </style>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
            // Biểu đồ đường (Line Chart)
            var ctxLine = document.getElementById('areaChart').getContext('2d');
                    var areaData = {
                    labels: ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"],
                            datasets: [
                            {
                            label: 'Done',
                                    data: [${totalSaledMonth1}, ${totalSaledMonth2}, ${totalSaledMonth3}, ${totalSaledMonth4}, ${totalSaledMonth5}, ${totalSaledMonth6}, ${totalSaledMonth7}, ${totalSaledMonth8}, ${totalSaledMonth9}, ${totalSaledMonth10}, ${totalSaledMonth11}, ${totalSaledMonth12}],
                                    backgroundColor: 'rgba(40, 167, 69, 0.2)', // Success green with transparency
                                    borderColor: 'rgba(40, 167, 69, 1)', // Success green
                                    borderWidth: 1,
                                    fill: true // fill the area under the line
                            },
                            {
                            label: 'Delivering',
                                    data: [${totalDeliveryMonth1}, ${totalDeliveryMonth2}, ${totalDeliveryMonth3}, ${totalDeliveryMonth4}, ${totalDeliveryMonth5}, ${totalDeliveryMonth6}, ${totalDeliveryMonth7}, ${totalDeliveryMonth8}, ${totalDeliveryMonth9}, ${totalDeliveryMonth10}, ${totalDeliveryMonth11}, ${totalDeliveryMonth12}],
                                    backgroundColor: 'rgba(255, 193, 7, 0.2)', // Warning yellow with transparency
                                    borderColor: 'rgba(255, 193, 7, 1)', // Warning yellow
                                    borderWidth: 1,
                                    fill: true // fill the area under the line
                            }
                            ]
                    };
                    var areaOptions = {
                    plugins: {
                    filler: {
                    propagate: true
                    }
                    },
                            scales: {
                            y: {
                            beginAtZero: true
                            }
                            }
                    };
                    var areaChart = new Chart(ctxLine, {
                    type: 'line', // specify the chart type
                            data: areaData,
                            options: areaOptions
                    });
                    // Biểu đồ quạt (Pie Chart)
                    var ctxPie = document.getElementById('pieChart').getContext('2d');
                    var pieChartData = {
                    datasets: [{
                    data: [${total_gas_revenue}, ${total_stove_revenue}, ${total_accessories_revenue}], // Dữ liệu các phần của pie chart
                            backgroundColor: [
                                    'rgba(255, 99, 132, 0.5)', // Màu nền cho từng phần
                                    'rgba(75, 192, 192, 0.5)',
                                    'rgba(123, 104, 238, 0.5)',
                                    'rgba(72, 209, 204, 0.5)',
                                    'rgba(255, 165, 0, 0.5)',
                                    'rgba(0, 191, 255, 0.5)',
                                    'rgba(255, 99, 71, 0.5)',
                                    'rgba(34, 139, 34, 0.5)',
                                    'rgba(255, 215, 0, 0.5)',
                                    'rgba(138, 43, 226, 0.5)',
                                    'rgba(210, 105, 30, 0.5)',
                                    'rgba(100, 149, 237, 0.5)'
                            ],
                            borderColor: [
                                    'rgba(255,99,132,1)', // Màu viền cho từng phần
                                    'rgba(75, 192, 192, 1)',
                                    'rgba(123, 104, 238, 0.5)',
                                    'rgba(72, 209, 204, 0.5)',
                                    'rgba(255, 165, 0, 0.5)',
                                    'rgba(0, 191, 255, 0.5)',
                                    'rgba(255, 99, 71, 0.5)',
                                    'rgba(34, 139, 34, 0.5)',
                                    'rgba(255, 215, 0, 0.5)',
                                    'rgba(138, 43, 226, 0.5)',
                                    'rgba(210, 105, 30, 0.5)',
                                    'rgba(100, 149, 237, 0.5)'
                            ]
                    }],
                            labels: [<c:forEach items="${requestScope.list_category_product}" var="c" varStatus="loop">
                            "${c.title}"<c:if test="${!loop.last}">, </c:if>
            </c:forEach>],
                    };
                    var pieChartOptions = {
                    responsive: true,
                            plugins: {
                            legend: {
                            position: 'top',
                            },
                                    tooltip: {
                                    callbacks: {
                                    label: function (tooltipItem) {
                                    return tooltipItem.label + ': ' + tooltipItem.raw + '%';
                                    }
                                    }
                                    }
                            }
                    };
                    var pieChart = new Chart(ctxPie, {
                    type: 'pie', // specify the chart type
                            data: pieChartData,
                            options: pieChartOptions
                    });
            });
        </script>
    </head>
    <body>
        <jsp:useBean id="voucherr" class="com.model.DAO.VoucherDAO" scope="request"></jsp:useBean>
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
                            <a class="navbar-brand brand-logo" href="home">
                                <img style="height: 80px;width: 80px" src="media/LOGO.png" alt="logo" />
                            </a>
                            <a class="navbar-brand brand-logo-mini" href="home">
                                <img src="media/LOGO.png" alt="logo" />
                            </a>
                        </div>
                    </div>
                    <div class="navbar-menu-wrapper d-flex align-items-top"> 
                        <ul class="navbar-nav">
                            <li class="nav-item font-weight-semibold d-none d-lg-block ms-0">
                                <h1 class="welcome-text">Hello, <span class="text-black fw-bold">${sessionScope.manager.username}</span></h1>
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
                                <img class="img-xs rounded-circle" src="media/2304226.png" alt="Profile image"> </a>
                            <div class="dropdown-menu dropdown-menu-right navbar-dropdown" aria-labelledby="UserDropdown">
                                <div class="dropdown-header text-center">
                                    <img class="img-xs rounded-circle" src="media/2304226.png" alt="Profile image">
                                    <p class="mb-1 mt-3 font-weight-semibold">${sessionScope.manager.username}</p>
                                    <p class="fw-light text-muted mb-0">Role: 
                                        <c:if test="${sessionScope.manager.role eq 1}">Manager</c:if>
                                        <c:if test="${sessionScope.manager.role eq 2}">Sale Staff</c:if>
                                        <c:if test="${sessionScope.manager.role eq 3}">Customer Service Staff</c:if>    
                                        </p>
                                        <p class="fw-light text-muted mb-0">${sessionScope.manager.email}</p>
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
                <jsp:include page="dashboardLeftPart.jsp"/>
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
                                            <!--                                            <li class="nav-item">
                                                                                            <a class="nav-link" id="profile-tab" data-bs-toggle="tab" href="#audiences" role="tab" aria-selected="false">Audiences</a>
                                                                                        </li>
                                                                                        <li class="nav-item">
                                                                                            <a class="nav-link" id="contact-tab" data-bs-toggle="tab" href="#demographics" role="tab" aria-selected="false">Demographics</a>
                                                                                        </li>
                                                                                        <li class="nav-item">
                                                                                            <a class="nav-link border-0" id="more-tab" data-bs-toggle="tab" href="#more" role="tab" aria-selected="false">More</a>
                                                                                        </li>-->
                                        </ul>
                                    </div>
                                    <div class="tab-content tab-content-basic">
                                        <div class="tab-pane fade show active" id="overview" role="tabpanel" aria-labelledby="overview"> 
                                            <div class="card">
                                                <div class="card-body"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
                                                    <h4 class="card-title">Revenue</h4>
                                                    <form action="dashboard" method="get">
                                                        <div class="form-group">
                                                            <p>Select year</p>
                                                            <select name="year" class="form-select-sm" onchange="this.form.submit()">
                                                                <c:forEach var="year" items="${recentYears}">
                                                                    <option ${yearr eq year ? 'selected':''} value="${year}">${year}</option>
                                                                </c:forEach>
                                                            </select>
                                                        </div>
                                                    </form>
                                                    <canvas id="areaChart" width="752" height="376" style="display: block; width: 752px; height: 376px;" class="chartjs-render-monitor"></canvas>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <div class="statistics-details d-flex align-items-center justify-content-between">
                                                        <div>
                                                            <p class="statistics-title">Total Sales</p>
                                                            <h3 class="rate-percentage">
                                                                <fmt:formatNumber value="${total_saled}" type="number" maxFractionDigits="2" minFractionDigits="2"/> &#8363;
                                                            </h3>
                                                            <p class="${sales_change >= 0 ? 'text-success' : 'text-danger'} d-flex">
                                                                <i class="${sales_change >= 0 ? 'mdi mdi-menu-up' : 'mdi mdi-menu-down'}"></i>
                                                                <span>
                                                                    <fmt:formatNumber value="${sales_change}" type="number" maxFractionDigits="1" minFractionDigits="1"/>%
                                                                </span>
                                                            </p>
                                                        </div>
                                                        <div>
                                                            <p class="statistics-title">Total Orders</p>
                                                            <h3 class="rate-percentage">${total_orders}</h3>
                                                            <p class="${orders_change >= 0 ? 'text-success' : 'text-danger'} d-flex">
                                                                <i class="${orders_change >= 0 ? 'mdi mdi-menu-up' : 'mdi mdi-menu-down'}"></i>
                                                                <span>
                                                                    <fmt:formatNumber value="${orders_change}" type="number" maxFractionDigits="1" minFractionDigits="1"/>%
                                                                </span>
                                                            </p>
                                                        </div>

                                                        <div>
                                                            <p class="statistics-title">Total Revenue</p>
                                                            <h3 class="rate-percentage"><fmt:formatNumber value="${total_revenue}" type="number" maxFractionDigits="2" minFractionDigits="2"/> &#8363;</h3>
                                                            <p class="${revenue_change >= 0 ? 'text-success' : 'text-danger'} d-flex">
                                                                <i class="${revenue_change >= 0 ? 'mdi mdi-menu-up' : 'mdi mdi-menu-down'}"></i>
                                                                <span>
                                                                    <fmt:formatNumber value="${revenue_change}" type="number" maxFractionDigits="1" minFractionDigits="1"/>%
                                                                </span>
                                                            </p>
                                                        </div>
                                                        <div class="d-none d-md-block">
                                                            <p class="statistics-title">Total Feedbacks</p>
                                                            <h3 class="rate-percentage">${total_feedbacks}</h3>
                                                            <p class="${feedbacks_change >= 0 ? 'text-success' : 'text-danger'} d-flex">
                                                                <i class="${feedbacks_change >= 0 ? 'mdi mdi-menu-up' : 'mdi mdi-menu-down'}"></i>
                                                                <span>
                                                                    <fmt:formatNumber value="${feedbacks_change}" type="number" maxFractionDigits="1" minFractionDigits="1"/>%
                                                                </span>
                                                            </p>
                                                        </div>

                                                        <div class="d-none d-md-block">
                                                            <p class="statistics-title">Total Customers</p>
                                                            <h3 class="rate-percentage">${total_customers}</h3>
                                                        </div>
                                                        <c:if test="${sessionScope.manager.role eq 1}">
                                                            <div class="d-none d-md-block">
                                                                <p class="statistics-title">Total Managers</p>
                                                                <h3 class="rate-percentage">${total_managers}</h3>
                                                            </div>
                                                        </c:if>



                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-6 grid-margin stretch-card">
                                                <div class="card">
                                                    <div class="card-body">
                                                        <div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
                                                        <h4 class="card-title">Revenue by type of product</h4>
                                                        <canvas id="pieChart" width="558" height="278" style="display: block; width: 279px; height: 139px;" class="chartjs-render-monitor"></canvas>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="row flex-grow">

                                                    <div class="col-6 grid-margin stretch-card">
                                                        <div class="card">
                                                            <div class="card-body">
                                                                <h4 class="card-title">Orders</h4>
                                                                <p class="card-description">
                                                                    <code>Newest Orders</code>
                                                                </p>
                                                                <div class="table-responsive">
                                                                    <table class="table">
                                                                        <thead>
                                                                            <tr>
                                                                                <th>Order ID</th>
                                                                                <th>Customer</th>
                                                                                <th>Voucher</th>
                                                                                <th>Total Price</th>
                                                                                <th>Order<br>Date</th>                                 
                                                                            </tr>
                                                                        </thead>
                                                                        <tbody>
                                                                            <c:choose>
                                                                                <c:when test="${newest_order ne null}">
                                                                                    <tr>
                                                                                        <td>${newest_order.orderId}</td>
                                                                                        <td>${newest_order.getCustomer().getUsername()}</td>
                                                                                        <td>
                                                                                            <c:if test="${newest_order.getVoucher() eq null}">
                                                                                                None
                                                                                            </c:if>
                                                                                            <c:if test="${newest_order.getVoucher() ne null}">
                                                                                                ${newest_order.getVoucher().getTitle()}
                                                                                            </c:if>

                                                                                        </td>
                                                                                        <td>${newest_order.totalPrice}</td>
                                                                                        <td>${newest_order.orderDate}</td>
                                                                                    </tr>
                                                                                </c:when>
                                                                                <c:otherwise>
                                                                                    <tr>
                                                                                        <td>No order found</td>
                                                                                    </tr>
                                                                                </c:otherwise>
                                                                            </c:choose>
                                                                        </tbody>
                                                                    </table>
                                                                </div>
                                                                <div class="list align-items-center pt-3">
                                                                    <div class="wrapper w-100">
                                                                        <p class="mb-0">
                                                                            <a href="manageorder" class="fw-bold text-primary">Show all <i class="mdi mdi-arrow-right ms-2"></i></a>
                                                                        </p>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-6 grid-margin stretch-card">
                                                        <div class="card">
                                                            <div class="card-body">
                                                                <h4 class="card-title">Orders</h4>
                                                                <p class="card-description">
                                                                    <code>Biggest Orders</code>
                                                                </p>
                                                                <div class="table-responsive">
                                                                    <table class="table">
                                                                        <thead>
                                                                            <tr>
                                                                                <th>Order ID</th>
                                                                                <th>Customer</th>
                                                                                <th>Voucher</th>
                                                                                <th>Total Price</th>
                                                                                <th>Order<br>Date</th>                                 
                                                                            </tr>
                                                                        </thead>
                                                                        <tbody>
                                                                            <c:choose>
                                                                                <c:when test="${biggest_order ne null}">
                                                                                    <tr>
                                                                                        <td>${biggest_order.orderId}</td>
                                                                                        <td>${biggest_order.getCustomer().getUsername()}</td>
                                                                                        <td>
                                                                                            <c:if test="${biggest_order.getVoucher() eq null}">
                                                                                                None
                                                                                            </c:if>
                                                                                            <c:if test="${biggest_order.getVoucher() ne null}">
                                                                                                ${newest_order.getVoucher().getTitle()}
                                                                                            </c:if>
                                                                                        </td>
                                                                                        <td>${biggest_order.totalPrice}</td>
                                                                                        <td>${biggest_order.orderDate}</td>
                                                                                    </tr>
                                                                                </c:when>
                                                                                <c:otherwise>
                                                                                    <tr>
                                                                                        <td>No order found</td>
                                                                                    </tr>
                                                                                </c:otherwise>
                                                                            </c:choose>
                                                                        </tbody>
                                                                    </table>
                                                                </div>
                                                                <div class="list align-items-center pt-3">
                                                                    <div class="wrapper w-100">
                                                                        <p class="mb-0">
                                                                            <a href="manageorder" class="fw-bold text-primary">Show all <i class="mdi mdi-arrow-right ms-2"></i></a>
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
                                                                        <code>Newest Voucher</code>
                                                                    </p>
                                                                    <div class="table-responsive">
                                                                        <table class="table">
                                                                            <thead>
                                                                                <tr>
                                                                                    <th>Voucher Code</th>
                                                                                    <th>Voucher Name</th>
                                                                                    <th>Created</th>
                                                                                    <th>Quantity</th>
                                                                                    <th>Expiry</th>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                                <c:choose>
                                                                                    <c:when test="${newest_voucher ne null}">
                                                                                        <tr>
                                                                                            <td>${newest_voucher.title}</td>
                                                                                            <td>${newest_voucher.voucherCode}</td>
                                                                                            <td>${newest_voucher.createdAt}</td>
                                                                                            <td>${newest_voucher.quantity}</td>
                                                                                            <td>${newest_voucher.expiry}</td>
                                                                                        </tr>
                                                                                    </c:when>
                                                                                    <c:otherwise>
                                                                                        <tr>
                                                                                            <td>No voucher found</td>
                                                                                        </tr>
                                                                                    </c:otherwise>
                                                                                </c:choose>
                                                                            </tbody>
                                                                        </table>
                                                                    </div>
                                                                    <div class="list align-items-center pt-3">
                                                                        <div class="wrapper w-100">
                                                                            <p class="mb-0">
                                                                                <a href="manageVoucher" class="fw-bold text-primary">Show all <i class="mdi mdi-arrow-right ms-2"></i></a>
                                                                            </p>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 col-lg-6 grid-margin stretch-card">
                                                            <div class="card">
                                                                <div class="card-body">
                                                                    <h4 class="card-title">Feedback list</h4>
                                                                    <p class="card-description">
                                                                        <code>Newest Feedback</code>
                                                                    </p>
                                                                    <div class="table-responsive">
                                                                        <table class="table">
                                                                            <thead>
                                                                                <tr>
                                                                                    <th>Username</th>
                                                                                    <th>Product<br>Name</th>
                                                                                    <th>Stars</th>
                                                                                    <th>Created<br>On</th>
                                                                                    <th>Modified<br>On</th>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                                <c:choose>
                                                                                    <c:when test="${newest_feedback ne null}">
                                                                                        <tr>
                                                                                            <td>${newest_feedback.getCustomerById(newest_feedback.customer_id).username}</td>
                                                                                            <td>${newest_feedback.getProductById(newest_feedback.product_id).title}</td>
                                                                                            <td>
                                                                                                <span class="gold-stars">
                                                                                                    <c:forEach begin="1" end="${newest_feedback.rate}">
                                                                                                        &#9733; <!-- Ký hiệu sao đầy -->
                                                                                                    </c:forEach>
                                                                                                </span>
                                                                                            </td>
                                                                                            <td>${newest_feedback.getFormattedCreatedOn()}</td>
                                                                                            <td>${newest_feedback.getFormattedModifiedOn()}</td>
                                                                                        </tr>
                                                                                    </c:when>
                                                                                    <c:otherwise>
                                                                                        <tr>
                                                                                            <td>No feedback found</td>
                                                                                        </tr>
                                                                                    </c:otherwise>
                                                                                </c:choose>

                                                                            </tbody>
                                                                        </table>
                                                                    </div>
                                                                    <div class="list align-items-center pt-3">
                                                                        <div class="wrapper w-100">
                                                                            <p class="mb-0">
                                                                                <a href="managefeedback" class="fw-bold text-primary">Show all <i class="mdi mdi-arrow-right ms-2"></i></a>
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
                                                                        <code>Newest Customer</code>
                                                                    </p>
                                                                    <div class="table-responsive">
                                                                        <table class="table">
                                                                            <thead>
                                                                                <tr>
                                                                                    <th>Username</th>
                                                                                    <th>First<br>Name</th>
                                                                                    <th>Last<br>Name</th>
                                                                                    <th>Gmail</th>
                                                                                    <th>Phone</th>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                                <c:choose>
                                                                                    <c:when test="${newest_customer ne null}">
                                                                                        <tr>
                                                                                            <td>${newest_customer.username}</td>
                                                                                            <td>${newest_customer.first_name}</td>
                                                                                            <td>${newest_customer.last_name}</td>
                                                                                            <td>${newest_customer.gmail}</td>
                                                                                            <td>${newest_customer.phone_number}</td>
                                                                                        </tr>
                                                                                    </c:when>
                                                                                    <c:otherwise>
                                                                                        <tr>
                                                                                            <td>No order found</td>
                                                                                        </tr>
                                                                                    </c:otherwise>
                                                                                </c:choose>

                                                                            </tbody>
                                                                        </table>
                                                                    </div>
                                                                    <div class="list align-items-center pt-3">
                                                                        <div class="wrapper w-100">
                                                                            <p class="mb-0">
                                                                                <a href="manageCustomer" class="fw-bold text-primary">Show all <i class="mdi mdi-arrow-right ms-2"></i></a>
                                                                            </p>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <c:if test="${sessionScope.manager.role eq 2}">
                                                            <div class="col-md-6 col-lg-6 grid-margin stretch-card">
                                                                <div class="card">
                                                                    <div class="card-body">
                                                                        <h4 class="card-title">Manager List</h4>
                                                                        <p class="card-description">
                                                                            <code>Newest Manager</code>
                                                                        </p>
                                                                        <div class="table-responsive">
                                                                            <table class="table">
                                                                                <thead>
                                                                                    <tr>
                                                                                        <th>Username</th>
                                                                                        <th>First<br>Name</th>
                                                                                        <th>Last<br>Name</th>
                                                                                        <th>Gmail</th>
                                                                                        <th>Phone</th>
                                                                                    </tr>
                                                                                </thead>
                                                                                <tbody>
                                                                                    <c:choose>
                                                                                        <c:when test="${newest_manager ne null}">
                                                                                            <tr>
                                                                                                <td>${newest_manager.username}</td>
                                                                                                <td>${newest_manager.first_name}</td>
                                                                                                <td>${newest_manager.last_name}</td>
                                                                                                <td>${newest_manager.email}</td>
                                                                                                <td>${newest_manager.phone_number}</td>
                                                                                            </tr>
                                                                                        </c:when>
                                                                                        <c:otherwise>
                                                                                            <tr>
                                                                                                <td>No manager found</td>
                                                                                            </tr>
                                                                                        </c:otherwise>
                                                                                    </c:choose>

                                                                                </tbody>
                                                                            </table>
                                                                        </div>
                                                                        <div class="list align-items-center pt-3">
                                                                            <div class="wrapper w-100">
                                                                                <p class="mb-0">
                                                                                    <a href="manageManager" class="fw-bold text-primary">Show all <i class="mdi mdi-arrow-right ms-2"></i></a>
                                                                                </p>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </c:if>
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
