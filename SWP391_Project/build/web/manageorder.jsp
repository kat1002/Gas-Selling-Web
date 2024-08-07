<%--
    Document   : manageorder
    Created on : Jun 21, 2024, 1:18:24 PM
    Author     : ADMIN
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
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
                                                    <h5 class="card-title">Order List</h5>
                                                    <div class="row">
                                                        <div class="col-md-2">
                                                            <form action="manageorder" method="get" id="filterCustomer">
                                                                <h5>Find customer</h5>
                                                                <div class="form-group">
                                                                    <input type="text" placeholder="Search customer" name="customersearch" class="form-control" value="${customersearch}"/>
                                                                </div>
                                                                <button onclick="submitFormAndBuildURL('filterCustomer')"><i class="fa fa-search"></i></button>
                                                            </form>
                                                        </div>
                                                        <div class="col-md-2">
                                                            <form action="manageorder" method="get" id="filterRangeTotalPrice">
                                                                <h5>Total Price Range</h5>
                                                                <div class="form-group">
                                                                    <input type="number" placeholder="Price From" step="0.01" name="totalpricefrom" class="form-control" value="${totalpricefrom}"/>
                                                                    <br>
                                                                    <input type="number" placeholder="Price To" step="0.01" name="totalpriceto" class="form-control" value="${totalpriceto}"/>
                                                                </div>
                                                                <button onclick="submitFormAndBuildURL('filterRangeTotalPrice')"><i class="fa fa-search"></i></button>
                                                            </form>
                                                        </div>
                                                        <div class="col-md-2">
                                                            <form action="manageorder" method="get" id="filterOrderDate">
                                                                <h5>Order Date</h5>
                                                                <div class="form-group">
                                                                    <input type="date" name="orderdatefrom" class="form-control" value="${orderdatefrom}"/>
                                                                    <br>
                                                                    <input type="date" name="orderdateto" class="form-control" value="${orderdateto}"/>
                                                                </div>
                                                                <button onclick="submitFormAndBuildURL('filterOrderDate')"><i class="fa fa-search"></i></button>
                                                            </form>
                                                        </div>
                                                        <div class="col-md-2">
                                                            <form action="manageorder" method="get" id="filterPhoneNumber">
                                                                <h5>Phone number</h5>
                                                                <div class="form-group">
                                                                    <input type="tel" placeholder="Phone Number" name="phonenumber" class="form-control" value="${phonenumber}"/>
                                                                </div>
                                                                <button onclick="submitFormAndBuildURL('filterPhoneNumber')"><i class="fa fa-search"></i></button>
                                                            </form>
                                                        </div>
                                                        <div class="col-md-2">
                                                            <form action="manageorder" method="get" id="filterCity">
                                                                <h5>City</h5>
                                                                <div class="form-group">
                                                                    <input type="text" placeholder="City" name="city" class="form-control" value="${city}"/>
                                                                </div>
                                                                <button onclick="submitFormAndBuildURL('filterCity')"><i class="fa fa-search"></i></button>
                                                            </form>
                                                            <form action="manageorder" method="get" id="filterOrderPerPage">
                                                                <h5>Orders / page</h5>
                                                                <div class="form-group">
                                                                    <input type="number" name="orderperpage" class="form-control" value="${orderperpage}"/>
                                                                </div>
                                                                <button onclick="submitFormAndBuildURL('filterOrderPerPage')"><i class="fa fa-search"></i></button>
                                                            </form>
                                                        </div>
                                                        <div class="col-md-2">
                                                            <form action="manageorder" method="get" id="filterPayment">
                                                                <h5>Payment</h5>
                                                                <select onchange="submitFormAndBuildURL('filterPayment')" name="payment" class="form-select">
                                                                    <option ${payment eq 0 ? 'selected':''} value="0">None</option>
                                                                    <option ${payment eq 1 ? 'selected':''} value="1">Cash On Delivery</option>
                                                                    <option ${payment eq 2 ? 'selected':''} value="2">Pay Online</option>
                                                                </select>
                                                            </form>
                                                        </div>
                                                        <div class="col-md-2">
                                                            <form action="manageorder" method="get" id="filterSortPrice">
                                                                <h5>Sort Price</h5>
                                                                <select name="choicesortprice" class="form-select" onchange="submitFormAndBuildURL('filterSortPrice')">
                                                                    <option ${choicesortprice eq '' ? 'selected':''} value="">Constant</option>
                                                                    <option ${choicesortprice eq 'Increase' ? 'selected':''} value="Increase">Increase</option>
                                                                    <option ${choicesortprice eq 'Decrease' ? 'selected':''} value="Decrease">Decrease</option>
                                                                </select>
                                                            </form>
                                                        </div>
                                                        <div class="col-md-2">
                                                            <form action="manageorder" method="get" id="filterStatus">
                                                                <h5>Status</h5>
                                                                <select name="choicestatus" class="form-select" onchange="submitFormAndBuildURL('filterStatus')">
                                                                    <option ${choicestatus eq 0 ? 'selected':''} value="0">None</option>
                                                                    <option ${choicestatus eq 1 ? 'selected':''} value="1">Rejected</option>
                                                                    <option ${choicestatus eq 2 ? 'selected':''} value="2">Delivering</option>
                                                                    <option ${choicestatus eq 3 ? 'selected':''} value="3">Done</option>
                                                                </select>
                                                            </form>
                                                        </div>
                                                    </div>
                                                    <hr>

                                                    <jsp:useBean id="customer" class="com.model.DAO.CustomerDAO" scope="request"></jsp:useBean>
                                                    <jsp:useBean id="voucher" class="com.model.DAO.VoucherDAO" scope="request"></jsp:useBean>
                                                        <div class="table-responsive">
                                                        <c:choose>
                                                            <c:when test="${requestScope.orders.size() > 0}">
                                                                <table class="table table-hover">
                                                                    <thead>
                                                                        <tr>
                                                                            <th>Order ID</th>
                                                                            <th>Customer</th>
                                                                            <th>Voucher</th>
                                                                            <th>Total Price (VNĐ)</th>
                                                                            <th>Order<br>Date</th>
                                                                            <th>Payment<br>Method</th>
                                                                            <th>Address 1</th>
                                                                            <th>Address 2</th>
                                                                            <th>Postal Code</th>
                                                                            <th>City</th>
                                                                            <th>Phone<br>Number</th>
                                                                            <th>Created<br>At</th>
                                                                            <th>Status</th>
                                                                            <th>Action</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody id="manageorder">

                                                                        <c:forEach items="${requestScope.orders}" var="order">

                                                                            <tr>
                                                                                <td>${order.getOrderId()}</td>
                                                                                <td>${customer.getCustomer(order.getCustomerId()).getUsername()}</td>
                                                                                <td>
                                                                                    <c:if test="${voucher.getVoucher(order.getVoucherId()) eq null}">None</c:if>
                                                                                    <c:if test="${voucher.getVoucher(order.getVoucherId()) ne null}">
                                                                                        ${voucher.getVoucher(order.getVoucherId()).getTitle()}
                                                                                    </c:if>
                                                                                </td>
                                                                                <td><fmt:formatNumber value="${order.getTotalPrice()}" type="number" maxFractionDigits="2" minFractionDigits="2"/> &#8363;</td>
                                                                                <td>${order.getOrderDate()}</td>
                                                                                <td>
                                                                                    <c:if test="${order.getPaymentMethod() eq 1}">Cash On Delivery</c:if>
                                                                                    <c:if test="${order.getPaymentMethod() eq 2}">Pay online</c:if>
                                                                                    </td>
                                                                                    <td>${order.addressLine1}</td>
                                                                                <td>${order.addressLine2}</td>
                                                                                <td>${order.getPostalCode()}</td>
                                                                                <td>${order.getCity()}</td>
                                                                                <td>${order.getPhoneNumber()}</td>
                                                                                <td>${order.getCreatedAt()}</td>
                                                                                <td>
                                                                                    <form id="orderStatusForm${order.getOrderId()}" action="updateorderstatus" method="post">
                                                                                        <input type="hidden" value="${order.getOrderId()}" name="oid"/>
                                                                                        <select style="height: auto;" name="status" class="form-control-sm
                                                                                                ${order.status eq 1 ? 'bg-danger':''}
                                                                                                ${order.status eq 2 ? 'bg-warning':''}
                                                                                                ${order.status eq 3 ? 'bg-success':''}"
                                                                                                ${order.status eq 1 ? 'disabled':''}
                                                                                                ${order.status eq 3 ? 'disabled':''}
                                                                                                onchange="submitChangeStatus('${order.getOrderId()}')">
                                                                                            <option ${order.status eq 1 ? 'selected':''} value="1">Rejected</option>
                                                                                            <option ${order.status eq 2 ? 'selected':''} value="2">Delivering</option>
                                                                                            <option ${order.status eq 3 ? 'selected':''} value="3">Done</option>
                                                                                        </select>
                                                                                    </form>
                                                                                </td>
                                                                                <td>
                                                                                    <button class="btn btn-facebook" onclick="fetchOrder('${order.getOrderId()}', '${order.getCustomerId()}')"><i class="fa fa-server"></i></button>
                                                                                    <button class="btn btn-danger" onclick="doDeleteOrder('${order.getOrderId()}')"><i class="fa fa-trash"></i></button>
                                                                                    <form action="deleteorder" method="post" id="deleteForm${order.getOrderId()}">
                                                                                        <input type="hidden" value="${order.getOrderId()}" name="oid"/>
                                                                                    </form>
                                                                                </td>
                                                                            </tr>
                                                                        </c:forEach>

                                                                    </tbody>
                                                                </table>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <jsp:include page="notsearch_admin.jsp"></jsp:include>
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
                                                                <form action="manageorder" method="get" id="filterPage">
                                                                    <div class="form-group">
                                                                        <input onchange="submitFormAndBuildURL('filterPage')" class="form-control" id="pageInput" value="${page}" type="number" value="1" name="page" min="1" max="${num}" required="">
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
        <!-- container-scroller -->

        <div aria-hidden="true" aria-labelledby="orderDetail" class="modal fade" id="orderDetail" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered modal-lg" style="min-width: 80%;">
                <div class="modal-content" id="contentmodal">
                    <div class="modal-header">
                        <h5 class="modal-title" id="orderDetail">Order Detail</h5>
                        <button aria-label="Close" class="btn-close" data-bs-dismiss="modal" type="button"></button>
                    </div>
                    <div class="modal-body">
                        <div class="text-center mb-3">
                            <h3 class="mb-1">BLAZO GAS/STOVE ONLINE STORE</h3>
                            <p>Address: 1 Trung Hoa Street, Cau Giay, Ha Noi</p>
                            <p>Tel: 097894859990</p>
                        </div>
                        <div class="d-flex justify-content-between">
                            <h3 id="orderid">ORDER: </h3>
                            <p id="orderdate">Date: </p>
                        </div>
                        <div class="d-flex justify-content-end mb-3">
                            <button id="pdf_export" class="btn btn-primary text-white me-0"><i class="icon-download"></i> Export to PDF</button>
                        </div>
                        <h6>CUSTOMER INFO</h6>
                        <p id="customername"></p>
                        <p id="ordertel">Tel: </p>
                        <p id="orderaddress1">Address 1: </p>
                        <p id="orderaddress2">Address 2: </p>
                        <hr>
                        <h6>ORDER INFORMATION</h6>
                        <p class="mb-2"><em>Price Unit: VNĐ</em></p>
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>No</th>
                                        <th>Product</th>
                                        <th>Price/ Item</th>
                                        <th>Quantity</th>
                                        <th>Total Price</th>
                                    </tr>
                                </thead>
                                <tbody id="tableBodyOrder">
                                    <!-- Content will be dynamically inserted here -->
                                </tbody>
                            </table>
                        </div>
                        <p class="text-right" id="totalPrice">Total:  &#8363;</p>
                    </div>
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
        <script>
                                                                    function exportToPdf() {
                                                                        // Lấy dữ liệu từ các phần tử HTML
                                                                        const customerName = document.getElementById('customername').textContent;
                                                                        const customerTel = document.getElementById('ordertel').textContent;
                                                                        const customerAddress1 = document.getElementById('orderaddress1').textContent;
                                                                        const customerAddress2 = document.getElementById('orderaddress2').textContent;
                                                                        const orderId = document.getElementById('orderid').textContent;
                                                                        const orderDate = document.getElementById('orderdate').textContent;

                                                                        // Tạo một đối tượng dữ liệu để gửi đi
                                                                        const data = {
                                                                            customerName: customerName,
                                                                            customerTel: customerTel,
                                                                            customerAddress1: customerAddress1,
                                                                            customerAddress2: customerAddress2,
                                                                            orderId: orderId,
                                                                            orderDate: orderDate
                                                                                    // Thêm các dữ liệu khác nếu cần
                                                                        };

                                                                        // Gửi yêu cầu POST đến servlet để tạo PDF
                                                                        fetch('exportorderdetail', {
                                                                            method: 'POST',
                                                                            headers: {
                                                                                'Content-Type': 'application/json'
                                                                            },
                                                                            body: JSON.stringify(data)
                                                                        }).then(response => {
                                                                            if (!response.ok) {
                                                                                throw new Error('Network response was not ok');
                                                                            }
                                                                            return response.blob();
                                                                        }).then(blob => {
                                                                            // Tạo URL cho file PDF và mở nó trong một tab mới
                                                                            const url = window.URL.createObjectURL(blob);
                                                                            const a = document.createElement('a');
                                                                            a.style.display = 'none';
                                                                            a.href = url;
                                                                            a.download = 'order_detail.pdf';
                                                                            document.body.appendChild(a);
                                                                            a.click();
                                                                            window.URL.revokeObjectURL(url);
                                                                        }).catch(error => {
                                                                            console.error('Error exporting to PDF:', error);
                                                                        });
                                                                    }
        </script>

        <script>
            function generatePdf(orderId) {
                const {jsPDF} = window.jspdf;
                const generatePdfButton = document.getElementById('pdf_export');
                generatePdfButton.style.display = 'none';

                html2canvas(document.querySelector("#orderDetail .modal-content"), {scale: 4}).then(canvas => {
                    const imgData = canvas.toDataURL('image/png');
                    const pdf = new jsPDF('p', 'pt', 'a4');
                    const imgProps = pdf.getImageProperties(imgData);
                    const pdfWidth = pdf.internal.pageSize.getWidth();
                    const pdfHeight = (imgProps.height * pdfWidth) / imgProps.width;

                    // Set higher resolution image for better clarity
                    const scaleFactor = 2; // Adjust scale factor as needed for clarity
                    const scaledCanvas = document.createElement('canvas');
                    scaledCanvas.width = canvas.width * scaleFactor;
                    scaledCanvas.height = canvas.height * scaleFactor;
                    const context = scaledCanvas.getContext('2d');
                    context.scale(scaleFactor, scaleFactor);
                    context.drawImage(canvas, 0, 0);
                    const scaledImgData = scaledCanvas.toDataURL('image/png');

                    pdf.addImage(scaledImgData, 'PNG', 0, 0, pdfWidth, pdfHeight);
                    pdf.save('order_detail_id#' + orderId + '.pdf');
                    generatePdfButton.style.display = 'block';
                }).catch(err => {
                    console.error('Error generating PDF:', err);
                    generatePdfButton.style.display = 'block';
                });
            }
        </script>

        <script>
            function fetchOrder(orderId, customerId) {
                $.ajax({
                    url: 'manageorderitem',
                    method: 'GET',
                    data: {
                        oid: orderId,
                        cusid: customerId
                    },
                    success: function (response) {
                        if (response) {
                            let orderItems = response.orderitems;
                            let tableBody = $('#tableBodyOrder');  // Ensure the ID matches your HTML
                            let customer = response.customer;
                            let order = response.order;
                            let totalPrice = 0;
                            tableBody.empty();  // Clear existing content
                            let index = 1;

                            // Insert customer details into the modal

                            $('#orderDetail #orderid').text('ORDER: #' + order.orderId);
                            $('#orderDetail #orderdate').text('Date: ' + order.orderDate);
                            $('#orderDetail #customername').text(customer.username);
                            $('#orderDetail #ordertel').text('Tel: ' + customer.phone_number);
                            $('#orderDetail #orderaddress1').text('Address 1: ' + customer.address_line1);
                            $('#orderDetail #orderaddress2').text('Address 2: ' + customer.address_line2);
                            $.each(orderItems, function (index, item) {
                                let itemTotalPrice = item.price * item.quantity;
                                totalPrice += itemTotalPrice;

                                tableBody.append('<tr>' +
                                        '<td>' + (++index) + '</td>' +
                                        '<td>' + item.productTitle + '</td>' +
                                        '<td>' + item.price + '</td>' +
                                        '<td>' + item.quantity + '</td>' +
                                        '<td>' + item.price * item.quantity + '</td>' +
                                        '</tr>');
                            });
                            $('#orderDetail .text-right').text('Total: ' + totalPrice.toFixed(2) + ' $');
                            // Add onclick event to export PDF button
                            $('#pdf_export').attr('onclick', 'generatePdf(' + orderId + ')');
                            $('#orderDetail').modal('show');
                        } else {
                            alert('Error fetching order item detail');
                        }
                    },
                    error: function (xhr, status, error) {
                        alert('Error fetching order item detail: ' + error);
                    }
                });
            }

        </script>
        <script>
            function submitChangeStatus(orderId) {
                document.getElementById('orderStatusForm' + orderId).submit();
            }
        </script>
        <script>
            function doDeleteOrder(orderId) {
                // Confirm the deletion
                if (confirm("Are you sure you want to delete the order ID " + orderId + " ?")) {
                    // Find and submit the specific form for this discountId
                    document.getElementById("deleteForm" + orderId).submit();
                }
            }
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
                if (form.id === 'filterCustomer' ||
                        form.id === 'filterRangeTotalPrice' ||
                        form.id === 'filterOrderDate' ||
                        form.id === 'filterSortPrice' ||
                        form.id === 'filterPhoneNumber' ||
                        form.id === 'filterCreatedAt' ||
                        form.id === 'filterCity' ||
                        form.id === 'filterOrderPerPage' ||
                        form.id === 'filterPayment' ||
                        form.id === 'filterVoucher' ||
                        form.id === 'filterPage' ||
                        form.id === 'filterStatus') {
                    form.addEventListener('submit', function (event) {
                        event.preventDefault(); // Prevent default form submission
                        submitFormAndBuildURL(form.id); // Call your handler function
                    });
                }
            });
        </script>
    </body>
</html>
