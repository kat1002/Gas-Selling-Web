<%-- 
    Document   : managefeedback
    Created on : Jul 21, 2024, 11:25:51 AM
    Author     : ADMIN
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <link rel="icon" href="media/icon/feedback.png"/>
        <meta http-equiv="Content-Type" content="text/html" ; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>BLAZO | FEEDBACK MANAGEMENT</title>
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
            #modal-profile-picture {
                max-width: 50px; /* Điều chỉnh kích thước chiều rộng */
                height: auto; /* Chiều cao sẽ tự động điều chỉnh theo tỉ lệ */
                margin-right: 10px; /* Khoảng cách giữa ảnh và tên người dùng */
            }
            .gold-stars {
                color: gold; /* Đặt màu gold cho biểu tượng sao */
                font-size: 20px; /* Điều chỉnh kích thước nếu cần thiết */
            }
        </style>
        <script src="ckeditor5/ckeditor5-build-classic/ckeditor.js"></script>
        <script>
            function doDeleteFeedback(rateId) {
                // Confirm the deletion
                if (confirm("Are you sure you want to delete this feedback ?")) {
                    // Find and submit the specific form for this discountId
                    document.getElementById("deleteForm" + rateId).submit();
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
                if (form.id === 'filterRate' ||
                        form.id === 'filterComment' ||
                        form.id === 'filterCustomer' ||
                        form.id === 'filterProductFeedback' ||
                        form.id === 'filterCreatedTime' ||
                        form.id === 'filterModifiedTime' ||
                        form.id === 'filterSortModifiedTime' ||
                        form.id === 'filterPage') {
                    form.addEventListener('submit', function (event) {
                        event.preventDefault(); // Prevent default form submission
                        submitFormAndBuildURL(form.id); // Call your handler function
                    });
                }
            });
        </script>
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
                                                    <h5 class="card-title">Feedback List</h5>
                                                    <div class="row">
                                                        <div class="col-md-2">
                                                            <form action="managefeedback" method="get" id="filterRate">
                                                                <h5>Filter by Rating</h5>
                                                                <div class="form-group">
                                                                    <label for="rating">Rating:</label>
                                                                    <select name="rating" class="form-select" id="rating" onchange="submitFormAndBuildURL('filterRate')">
                                                                        <option value="" ${rating eq '' ? 'selected':''}>All</option>
                                                                        <option value="1" ${rating eq '1' ? 'selected':''}>1 Star</option>
                                                                        <option value="2" ${rating eq '2' ? 'selected':''}>2 Stars</option>
                                                                        <option value="3" ${rating eq '3' ? 'selected':''}>3 Stars</option>
                                                                        <option value="4" ${rating eq '4' ? 'selected':''}>4 Stars</option>
                                                                        <option value="5" ${rating eq '5' ? 'selected':''}>5 Stars</option>
                                                                    </select>
                                                                </div>
                                                                <button type="submit"><i class="fa fa-search"></i></button>
                                                            </form>
                                                        </div>

                                                        <div class="col-md-2">
                                                            <form action="managefeedback" method="get" id="filterComment">
                                                                <h5>Filter by Comment</h5>
                                                                <div class="form-group">
                                                                    <input type="text" value="${comment}" class="form-control" name="comment" placeholder="Search Comment" value="${comment}"/>
                                                                </div>
                                                                <button onclick="submitFormAndBuildURL('filterComment')"><i class="fa fa-search"></i></button>
                                                            </form>
                                                        </div>
                                                        <div class="col-md-2">
                                                            <form action="managefeedback" method="get" id="filterCustomer">
                                                                <h5>Filter by Customer</h5>
                                                                <div class="form-group">
                                                                    <input type="text" value="${customername}" class="form-control" name="customername" placeholder="Customer Username" value="${customerid}"/>
                                                                </div>
                                                                <button onclick="submitFormAndBuildURL('filterCustomer')"><i class="fa fa-search"></i></button>
                                                            </form>
                                                        </div>
                                                        <div class="col-md-2">
                                                            <form action="managefeedback" method="get" id="filterProductFeedback">
                                                                <h5>Filter by Product</h5>
                                                                <div class="form-group">
                                                                    <input type="text" value="${productname}" class="form-control" name="productname" placeholder="Product Name" value="${productid}"/>
                                                                </div>
                                                                <button onclick="submitFormAndBuildURL('filterProductFeedback')"><i class="fa fa-search"></i></button>
                                                            </form>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <form action="managefeedback" method="get" id="filterCreatedTime">
                                                                <h5>Filter by Created Time</h5>
                                                                <div class="form-group">
                                                                    <label for="createdfrom">From:</label>
                                                                    <input type="datetime-local" value="${createdfrom}" class="form-control" name="createdfrom" id="createdfrom" value="${createdfrom}" />
                                                                </div>
                                                                <div class="form-group">
                                                                    <label for="createdto">To:</label>
                                                                    <input type="datetime-local" value="${createdto}" class="form-control" name="createdto" id="createdto" value="${createdto}" />
                                                                </div>
                                                                <button type="submit" onclick="submitFormAndBuildURL('filterCreatedTime')"><i class="fa fa-search"></i></button>
                                                            </form>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <form action="managefeedback" method="get" id="filterModifiedTime">
                                                                <h5>Filter by Modified Time</h5>
                                                                <div class="form-group">
                                                                    <label for="modifiedfrom">From:</label>
                                                                    <input type="datetime-local" value="${modifiedfrom}" class="form-control" name="modifiedfrom" id="modifiedfrom" value="${modifiedfrom}" />
                                                                </div>
                                                                <div class="form-group">
                                                                    <label for="modifiedto">To:</label>
                                                                    <input type="datetime-local" value="${modifiedto}" class="form-control" name="modifiedto" id="modifiedto" value="${modifiedto}" />
                                                                </div>
                                                                <button type="submit" onclick="submitFormAndBuildURL('filterModifiedTime')"><i class="fa fa-search"></i></button>
                                                            </form>
                                                        </div>
                                                        <div class="col-md-2">
                                                            <form action="managefeedback" method="get" id="filterSortModifiedTime">
                                                                <h5>Sort by Modified Time</h5>
                                                                <div class="form-group">
                                                                    <select name="sortmodifiedtime" class="form-select" onchange="submitFormAndBuildURL('filterSortModifiedTime')">
                                                                        <option value="0" ${requestScope.sortmodifiedtime eq 0 ? 'selected':''}>
                                                                            No Sorting
                                                                        </option>
                                                                        <option value="1" ${requestScope.sortmodifiedtime eq 1 ? 'selected':''}>
                                                                            Oldest First
                                                                        </option>
                                                                        <option value="2" ${requestScope.sortmodifiedtime eq 2 ? 'selected':''}>
                                                                            Newest First
                                                                        </option>
                                                                    </select>
                                                                </div>
                                                            </form>
                                                        </div>
                                                        <div class="col-md-2">
                                                            <form action="managefeedback" method="get" id="filterCommentPerPage">
                                                                <h5>Filter by Comments Per Page</h5>
                                                                <div class="form-group">
                                                                    <label for="commentsPerPage">Comments Per Page:</label>
                                                                    <select name="commentsPerPage" class="form-select" id="commentsPerPage" onchange="submitFormAndBuildURL('filterCommentPerPage')">
                                                                        <option value="10" ${commentsPerPage eq '10' ? 'selected':''}>10</option>
                                                                        <option value="20" ${commentsPerPage eq '20' ? 'selected':''}>20</option>
                                                                        <option value="30" ${commentsPerPage eq '30' ? 'selected':''}>30</option>
                                                                        <option value="50" ${commentsPerPage eq '50' ? 'selected':''}>50</option>
                                                                        <option value="100" ${commentsPerPage eq '100' ? 'selected':''}>100</option>
                                                                    </select>
                                                                </div>
                                                            </form>
                                                        </div>

                                                    </div>

                                                    <hr>
                                                    <div class="table-responsive">
                                                        <c:choose>
                                                            <c:when test="${requestScope.rates.size() > 0}">
                                                                <table class="table table-hover">
                                                                    <thead>
                                                                        <tr>
                                                                            <th>Rate ID</th>
                                                                            <th>Customer</th>
                                                                            <th>Product</th>
                                                                            <th>Rate</th>
                                                                            <th>Created On</th>
                                                                            <th>Modified On</th>
                                                                            <th>Action</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                        <c:forEach items="${requestScope.rates}" var="rate">
                                                                            <tr>
                                                                                <td>${rate.rate_id}</td>
                                                                                <td>${rate.getCustomerById(rate.customer_id).username}</td>
                                                                                <td>${rate.getProductById(rate.product_id).title}</td>
                                                                                <td>
                                                                                    <span class="gold-stars">
                                                                                        <c:forEach begin="1" end="${rate.rate}">
                                                                                            &#9733; <!-- Ký hiệu sao đầy -->
                                                                                        </c:forEach>
                                                                                    </span>
                                                                                </td>
                                                                                <td>${rate.getFormattedCreatedOn()}</td>
                                                                                <td>${rate.getFormattedModifiedOn()}</td>
                                                                                <td>
                                                                                    <button class="btn btn-facebook" onclick="fetchFeedback('${rate.rate_id}')"><i class="fa fa-server"></i></button>
                                                                                    <button class="btn btn-danger" onclick="doDeleteFeedback('${rate.rate_id}')"><i class="fa fa-trash"></i></button>
                                                                                    <form action="deletefeedback" method="post" id="deleteForm${rate.rate_id}">
                                                                                        <input type="hidden" name="rate_id" value="${rate.rate_id}"/>
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
                                                                <button class="page-link" onclick="changePage('${page - 1}')">Prev</button>
                                                            </li>
                                                            <li class="page-item">
                                                                <form action="managefeedback" method="get" id="filterPage">
                                                                    <div class="form-group">
                                                                        <input onchange="submitFormAndBuildURL('filterPage')" class="form-control" id="pageInput" type="number" value="${page}" name="page" min="1" max="${num}" required=""/>
                                                                    </div>
                                                                </form>
                                                            </li>
                                                            <li class="page-item ${page ge num ? 'disabled':''}">
                                                                <button class="page-link" onclick="changePage('${page + 1}')">Next</button>
                                                            </li>
                                                            <li class="page-item ${page ge num ? 'disabled':''}">
                                                                <button class="page-link" onclick="changePage('${num}')">Last</button>
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

        <!-- Bootstrap Modal -->
        <div class="modal fade" id="commentModal" tabindex="-1" role="dialog" aria-labelledby="commentModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="commentModalLabel">Comment Details</h5>
                        <button type="button" id="close" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="d-flex align-items-center">
                            <img class="rounded-circle" id="modal-profile-picture" src="" alt="Profile Picture">
                            <p><strong>Username:</strong> <span id="modal-username"></span></p>
                        </div>
                        <p><strong>Product:</strong> <span id="modal-productName"></span></p>
                        <p><strong>Stars:</strong> <span id="modal-stars" style="color: gold;"></span></p>
                        <p><strong>Comment:</strong> <span id="modal-comment"></span></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
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
        <!-- jQuery and Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>

        <!-- Your JavaScript -->
        <script>
                                                                    // Đóng modal khi nút "Close" được nhấn
                                                                    $('#commentModal .btn-secondary').on('click', function () {
                                                                        $('#commentModal').modal('hide');
                                                                    });
                                                                    $('#commentModal #close').on('click', function () {
                                                                        $('#commentModal').modal('hide');
                                                                    });
                                                                    function fetchFeedback(rateId) {
                                                                        $.ajax({
                                                                            url: 'fetchcomment', // URL đến servlet của bạn
                                                                            method: 'GET',
                                                                            data: {rate_id: rateId},
                                                                            success: function (response) {
                                                                                if (response) {
                                                                                    let username = response.username;
                                                                                    let productName = response.productName;
                                                                                    let stars = response.stars;
                                                                                    let comment = response.comment;
                                                                                    let profilePicture = response.profilePicture;

                                                                                    let print = $('#commentModal .modal-body');
                                                                                    $('#modal-username').text(response.username);
                                                                                    $('#modal-productName').text(response.productName);
                                                                                    $('#modal-stars').text('★'.repeat(response.stars));
                                                                                    $('#modal-comment').html(response.comment);
                                                                                    $('#modal-profile-picture').attr('src', profilePicture);
                                                                                    // Hiển thị modal
                                                                                    $('#commentModal').modal('show');
                                                                                } else {
                                                                                    alert('Error fetching comment details');
                                                                                }
                                                                            },
                                                                            error: function (xhr, status, error) {
                                                                                alert('Error fetching comment details: ' + error);
                                                                            }
                                                                        });
                                                                    }
        </script>


    </body>
</html>
