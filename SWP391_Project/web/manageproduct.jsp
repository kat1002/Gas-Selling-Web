<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <jsp:useBean id="managername" class="com.model.DAO.ManagerDAO" scope="request"></jsp:useBean>
        <jsp:useBean id="discounttitle" class="com.model.DAO.DiscountDAO" scope="request"></jsp:useBean>
        <jsp:useBean id="productt" class="com.model.DAO.ProductDAO" scope="request"></jsp:useBean>
        <jsp:useBean id="review" class="com.model.DAO.RateDAO" scope="request"></jsp:useBean>
            <!-- Required meta tags -->
            <meta http-equiv="Content-Type" content="text/html" ; charset=UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
            <link rel="icon" href="media/icon/configuration_12783710.png"/>
            <title>BLAZO | LIST PRODUCT</title>
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
            .gold-stars {
                color: gold; /* Đặt màu gold cho biểu tượng sao */
                font-size: 20px; /* Điều chỉnh kích thước nếu cần thiết */
            }

        </style>
        <script src="ckeditor5/ckeditor5-build-classic/ckeditor.js"></script>
        <script>

            function fetchProduct(title) {
                $.ajax({
                    url: 'editproduct',
                    method: 'GET',
                    data: {title: title},
                    dataType: 'json',
                    success: function (response) {
                        console.log("Response received:", response); // Gỡ lỗi: kiểm tra dữ liệu nhận được từ servlet
                        if (response) {
                            let Product = response.productt;
                            let Img = response.submittedfile;
                            let Categories = response.categories;
                            let Discount = response.discounts;

                            // Điền dữ liệu vào các trường của modal
                            $('#productEditId').val(Product.productId);
                            $('#productEditName').val(Product.title);
//                            $('#productEditCategory').val(Product.categoryId);
                            $('#productEditStock').val(Product.stock);
                            $('#productEditDiscount').val(Product.discountId);
                            $('#productEditPrice').val(Product.price);
                            $('#productEditDescription').val(Product.description);
                            $('#productEditCategory').empty();
                            $('#productEditDiscount').empty();
                            $.each(response.categories, function (index, cate) {
                                var selected = (Product.categoryId == cate.categoryId) ? 'selected' : '';
                                $('#productEditCategory').append('<option value="' + cate.categoryId + '" ' + selected + '>' + cate.title + '</option>');
                            });
                            $('#productEditDiscount').append('<option value="0">None</option>');
                            $.each(Discount, function (index, dis) {
                                if (Product.discountId == 0 || Product.discountId == dis.discountId) {
                                    var selected = (Product.discountId == dis.discountId) ? 'selected' : '';
                                    $('#productEditDiscount').append('<option value="' + dis.discountId + '" ' + selected + '>' + dis.title + '</option>');
                                }
                            });
                            $('#currentImages').empty(); // Xóa hình ảnh hiện tại trước khi thêm mới
                            $.each(Img, function (index, image) {
                                var imgContainer = '<div class="image-container">' +
                                        '<img src="media/product/' + image + '" alt="Product Image" width="80" height="80"/>' +
                                        '<input type="hidden" name="currentImages" value="' + image + '"/>' +
                                        '<input type="checkbox" name="deleteImages" class="deleteCheckbox" value="' + image + '"/>' +
                                        '</div>';
                                $('#currentImages').append(imgContainer);
                            });

                            // Hiển thị modal chỉnh sửa sản phẩm
                            $('#editProductModal').modal('show');
                        } else {
                            alert('Error fetching detail of ' + title);
                        }
                    },
                    error: function (xhr, status, error) {
                        alert('Error fetching detail of ' + title);
                    }
                });
            }


            window.editorProduct = function (title) {
                window.location = "editproduct?title=" + title;
            }

            window.addProductPage = function () {
                window.location = "addproduct";
            }

            function doDelete(id, name) {
                if (confirm('Bạn có chắc chắn xoá sản phẩm ' + name + ' không ?')) {
                    document.getElementById("deleteForm" + id).submit();
                }
            }

            function addQuantity(id) {
                $.ajax({
                    url: "addquantityproduct",
                    type: "POST",
                    data: {
                        pid: id,
                        quantity: 1
                    },
                    success: function (response) {
                        if (response.success) {
                            var newQuantity = response.newQuantity;
                            // Update the input field for the specific product
                            $("#productQuantity-" + id).val(newQuantity);
                        } else {
                            alert("Error updating quantity");
                        }
                    },
                    error: function (xhr, status, error) {
                        var errorMessage = xhr.status + ': ' + xhr.statusText;
                        console.log('Error - ' + errorMessage);
                        alert("Error with AJAX request: " + errorMessage);
                    }
                });
            }
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
                                                    <h5 class="card-title">Product List</h5>
                                                    <div class="row">

                                                        <div class="col-md-2">
                                                            <form action="manageproduct" id="filterRange" method="get">
                                                                <h5>Found product in price range ($)</h5>
                                                                <div class="form-group">
                                                                    <input type="number" class="form-control" name="fromprice"
                                                                           placeholder="From Price" value="${fromprice}"
                                                                           style="display:block;" step="0.01"/>
                                                                </div>
                                                                <div class="form-group">
                                                                    <input type="number" class="form-control" name="toprice"
                                                                           style="margin-top:1%;" placeholder="To Price"
                                                                           value="${toprice}" step="0.01"/>
                                                                </div>
                                                                <button onclick="submitFormAndBuildURL('filterRange')" class=""><i class="fa fa-search"></i></button>

                                                            </form>
                                                        </div>
                                                        <div class="col-md-2">
                                                            <form action="manageproduct" method="get" id="filterSearch">

                                                                <h5>Search items</h5>
                                                                <div class="form-group">
                                                                    <input type="text" class="form-control" name="search"
                                                                           placeholder="Search" value="${requestScope.search}"/>
                                                                </div>
                                                                <button onclick="submitFormAndBuildURL('filterSearch')"><i class="fa fa-search"></i></button>
                                                            </form>

                                                        </div>
                                                        <div class="col-md-2">
                                                            <form action="manageproduct" method="get" id="filterCreatedTime">
                                                                <h5>Input range created by time</h5>
                                                                <div class="form-group">
                                                                    <input type="date" class="form-control" name="datecreatedfrom"
                                                                           value="${datecreatedfrom}"/>
                                                                </div>
                                                                <div class="form-group">
                                                                    <input type="date" class="form-control" name="datecreatedto"
                                                                           value="${datecreatedto}"/>
                                                                </div>
                                                                <button onclick="submitFormAndBuildURL('filterCreatedTime')"><i class="fa fa-search"></i></button>

                                                            </form>
                                                        </div>
                                                        <div class='col-md-2'>
                                                            <form action="manageproduct" method="get" id="filterModifiedTime">
                                                                <h5>Input range modified by time</h5>
                                                                <div class="form-group">
                                                                    <input type="date" class="form-control" name="datemodifiedfrom"
                                                                           value="${datemodifiedfrom}"/>
                                                                </div>
                                                                <div class="form-group">
                                                                    <input type="date" class="form-control" name="datemodifiedto"
                                                                           value="${datemodifiedto}"/>
                                                                </div>
                                                                <button onclick="submitFormAndBuildURL('filterModifiedTime')"><i class="fa fa-search"></i></button>
                                                            </form>
                                                        </div>
                                                        <div class="col-md-2">
                                                            <form action="manageproduct" method="get" id="filterModifiedBy">
                                                                <h5>Modified by</h5>
                                                                <div class="form-group">
                                                                    <input type="text" class="form-control"
                                                                           placeholder="Modified By"
                                                                           value="${requestScope.modifiedby}"
                                                                           name="modifiedby"/>
                                                                    <button onclick="submitFormAndBuildURL('filterModifiedBy')" class=""><i class="fa fa-search"></i></button>
                                                                </div>
                                                            </form>

                                                        </div>
                                                        <div class="col-md-2">

                                                            <form action="manageproduct" method="get" id="filterCreatedBy">
                                                                <h5>Created by</h5>
                                                                <div class="form-group">
                                                                    <input type="text" class="form-control"
                                                                           placeholder="Created By"
                                                                           value="${requestScope.createdby}" name="createdby"/>
                                                                    <button onclick="submitFormAndBuildURL('filterCreatedBy')"><i class="fa fa-search"></i></button>
                                                                </div>


                                                            </form>
                                                        </div>
                                                        <div class="col-md-2">
                                                            <form action="manageproduct" method="get" id="filterNumPage">
                                                                <h5>items/ page</h5>
                                                                <div class="form-group">
                                                                    <input type="number" class="form-control"
                                                                           value="${requestScope.itemperpage}" min="1"
                                                                           name="itemperpage"/>

                                                                </div>
                                                                <button onclick="submitFormAndBuildURL('filterNumPage')">OK</button>
                                                            </form>
                                                        </div>
                                                        <div class="col-md-2">
                                                            <form action="manageproduct" id="filterProduct" method="get">
                                                                <h5>Categories</h5>
                                                                <div class="form-group">
                                                                    <select name="cid" class="form-select"
                                                                            onchange="submitFormAndBuildURL('filterProduct')">
                                                                        <option value="0" ${requestScope.cid eq 0 ? 'selected':''}>
                                                                            All
                                                                        </option>
                                                                        <c:forEach items="${requestScope.categories}"
                                                                                   var="category">
                                                                            <option value="${category.getCategoryId()}" ${category.getCategoryId() eq requestScope.cid ? 'selected':''}>${category.getTitle()}</option>
                                                                        </c:forEach>
                                                                    </select>
                                                                </div>
                                                            </form>
                                                        </div>
                                                        <div class="col-md-2">
                                                            <form action="manageproduct" id="filterStar" method="get">
                                                                <h5>Star</h5>
                                                                <div class="form-group">
                                                                    <select name="star" class="form-select" onchange="submitFormAndBuildURL('filterStar')">
                                                                        <option ${star eq "" ? 'selected':''} value="0">None</option>
                                                                        <option ${star eq "5" ? 'selected':''} value="5">⭐️⭐️⭐️⭐️⭐)</option>
                                                                        <option ${star eq "4" ? 'selected':''} value="4">⭐️⭐️⭐️⭐️</option>
                                                                        <option ${star eq "3" ? 'selected':''} value="3">⭐️⭐️⭐ </option>
                                                                        <option ${star eq "2" ? 'selected':''} value="2">⭐️⭐ </option>
                                                                        <option ${star eq "1" ? 'selected':''} value="1">⭐ </option>
                                                                        <option ${star eq "Unrated" ? 'selected':''} value="Unrated">Unrated</option> <!-- Corrected value here -->
                                                                    </select>
                                                                </div>
                                                            </form>
                                                        </div>
                                                        <div class="col-md-2">
                                                            <form action="manageproduct" id="filterSortPrice" method="get">
                                                                <h5>Sort by price</h5>
                                                                <div class="form-group">
                                                                    <select name="choicesortprice" class="form-select"
                                                                            onchange="submitFormAndBuildURL('filterSortPrice')">
                                                                        <option value="0" ${requestScope.choicesortprice eq 0 ? 'selected':''}>
                                                                            Constant
                                                                        </option>
                                                                        <option value="1" ${requestScope.choicesortprice eq 1 ? 'selected':''}>
                                                                            Decrease
                                                                        </option>
                                                                        <option value="2" ${requestScope.choicesortprice eq 2 ? 'selected':''}>
                                                                            Increase
                                                                        </option>
                                                                    </select>
                                                                </div>
                                                            </form>
                                                        </div>

                                                    </div>

                                                    <hr>
                                                    <p class="card-description">
                                                        <button id="addProductBtn" onclick="addProductPage()" class="btn btn-behance">Add product</button>
                                                    </p>
                                                    <div class="table-responsive">
                                                        <c:choose>
                                                            <c:when test="${requestScope.products.size() > 0}">
                                                                <table class="table table-hover">
                                                                    <thead>
                                                                        <tr>
                                                                            <th>ID</th>
                                                                            <th>Title</th>
                                                                            <th>Image</th>
                                                                            <th>Star Rated</th>
                                                                            <th>Category</th>
                                                                            <th>Discount</th>
                                                                            <th>Stock</th>
                                                                            <th>Price (VNĐ)</th>
                                                                            <th>Warranty<br>Period</th>
                                                                            <th>Price<br>Discount</th>
                                                                            <th>Created<br>Date</th>
                                                                            <th>Modified<br>on</th>
                                                                            <th>Created<br>By</th>
                                                                            <th>Modified<br>By</th>
                                                                            <th>Action</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody id="manageproduct">

                                                                        <c:forEach items="${requestScope.products}" var="product">
                                                                            <tr>
                                                                                <td>${product.getProductId()}</td>
                                                                                <td><a style="text-decoration: none;" href="product?id=${product.getProductId()}">${product.getTitle()}</a>
                                                                                </td>
                                                                                <td>
                                                                                    <a
                                                                                        href="product?id=${product.getProductId()}">
                                                                                        <img
                                                                                            title="${product.getTitle()}"
                                                                                            src="${product.getImages()[0]}"
                                                                                            class="imageproduct"/>
                                                                                    </a>
                                                                                </td>
                                                                                <td>
                                                                                    <c:choose>
                                                                                        <c:when test="${product.reviewsRate ne 0}">
                                                                                            <span class="gold-stars">
                                                                                                <c:forEach begin="1" end="${product.reviewsRate}">
                                                                                                    &#9733; <!-- Ký hiệu sao đầy -->
                                                                                                </c:forEach>
                                                                                                    (${review.getRateListByProductId(product.getProductId()).size()})
                                                                                            </span>
                                                                                        </c:when>
                                                                                        <c:otherwise>
                                                                                            Unrated
                                                                                        </c:otherwise>
                                                                                    </c:choose>

                                                                                </td>
                                                                                <td>${product.getCategory()}</td>
                                                                                <td>
                                                                                    <c:if test="${product.getDiscountId() eq 0}">None</c:if>
                                                                                    <c:if test="${product.getDiscountId() ne 0}">
                                                                                        ${discounttitle.getDiscount(product.getDiscountId()).getTitle()}
                                                                                    </c:if>
                                                                                </td>
                                                                                <td>
                                                                                    <form id="addQuantityForm-${product.getProductId()}" action="addquantityproduct" method="post">
                                                                                        <input type="text" style="display: none;" value="${product.getProductId()}" name="pid"/>
                                                                                        <div class="form-group-sm">
                                                                                            <input id="productQuantity-${product.getProductId()}" value="${product.getStock()}" type="number" style="width: 120%;" class="form-control" name="num" min="0" readonly/>
                                                                                        </div>
                                                                                        <br>
                                                                                        <span id="addButton" onclick="addQuantity('${product.getProductId()}')" class="btn btn-behance">+</span>
                                                                                    </form>
                                                                                </td>
                                                                                <td>${product.getPrice()} &#8363;</td>
                                                                                <td>${product.getWarranty_months()}</td>
                                                                                <td ><fmt:formatNumber
                                                                                        value="${product.getPrice() - product.getPrice() * discounttitle.getDiscountByProductId(product.getProductId()).getDiscountValue()}"
                                                                                        type="number"
                                                                                        maxFractionDigits="2"
                                                                                        minFractionDigits="2"/> &#8363;
                                                                                </td>
                                                                                <td>${product.getCreatedDate()}</td>
                                                                                <td>${product.getModifiedOn()}</td>
                                                                                <td>${managername.getManager(product.getCreatedBy()).getUsername()}</td>
                                                                                <td >${managername.getManager(product.getModifiedBy()).getUsername()}</td>
                                                                                <td>
                                                                                    <button class="btn btn-warning"
                                                                                            onclick="editorProduct('${product.getTitle()}')">
                                                                                        <i class="fa fa-pencil"></i></button>
                                                                                    <button class="btn btn-danger"
                                                                                            onclick="doDelete('${product.getProductId()}', '${product.getTitle()}')">
                                                                                        <i class="fa fa-trash"></i></button>
                                                                                    <form action="deleteproduct" method="post" id="deleteForm${product.getProductId()}">
                                                                                        <input type="hidden" name="pid" value="${productt.getProduct(product.getProductId()).getProductId()}"/>
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
                                                                <form action="manageproduct" method="get" id="filterPage">
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
        <!-- container-scroller -->

        <div aria-hidden="true" aria-labelledby="addProductModalLabel" class="modal fade"
             id="addProductModal" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addProductModalLabel">Add New Product</h5>
                        <button aria-label="Close" class="btn-close" data-bs-dismiss="modal"
                                type="button"></button>
                    </div>
                    <div class="modal-body">
                        <form id="productForm" action="addproduct" class="form-sample" method="post" enctype="multipart/form-data">
                            <div class="form-group">
                                <label for="productName">Product name</label>
                                <input type="text" id="productName" name="title" class="form-control" required>
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
                                <label for="productStock">Product Stock</label>
                                <input type="number" id="productStock" min="0" name="stock" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label for="productPrice">Product Price</label>
                                <input step="0.01" type="number" id="productPrice" min="0" name="price" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label for="productDescription">Description</label>
                                <textarea id="productDescription" name="description" class="form-control vh-25"></textarea>
                            </div>

                            <div class="form-group">
                                <label for="productImage">Images (Accept file formats: xbm, tif, apng, pjp, svgz, jpg, jpeg, ico,
                                    tiff, gif, svg, jfif, webp, png, bmp, pjpeg, avif)</label>
                                <input id="productImage" type="file" name="image" class="form-control"
                                       accept=".xbm, .tif, .apng, .pjp, .svgz, .jpg, .jpeg, .ico, .tiff, .gif, .svg, .jfif, .webp, .png, .bmp, .pjpeg, .avif"
                                       required/>
                            </div>
                            <div class="form-group">
                                <img id="previewImage" src="" alt="Image preview" style="display: none;" width="80" height="80"/>
                            </div>
                            <span id="addImageBtn" class="closeBtn" style="margin-top: 1%;">+</span>
                            <button type="submit" id="submitBtn" class="btn btn-success">Add product</button>

                        </form>
                    </div>
                </div>
            </div>
        </div>

        <div aria-hidden="true" aria-labelledby="editProductModal" class="modal fade"
             id="editProductModal" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editProductModal">Edit Product</h5>
                        <button aria-label="Close" class="btn-close" data-bs-dismiss="modal"
                                type="button"></button>
                    </div>
                    <div class="modal-body">
                        <form id="productEditForm" action="editproduct" class="form" method="post" enctype="multipart/form-data">
                            <input type="text" style="display: none;" name="id" id="productEditId" value="" required>
                            <div class="form-group">
                                <label for="productEditName">Product name</label>
                                <input type="text" id="productEditName" name="title" value="" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label for="productEditCategory">Category</label>
                                <select id="productEditCategory" name="cid" class="form-select" required>

                                </select>
                            </div>
                            <div class="form-group">
                                <label for="productEditStock">Product Stock</label>
                                <input type="number" id="productEditStock" min="0" value="" name="stock" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label for="productEditDiscount">Product Discount</label>
                                <select id="productEditDiscount" name="did" class="form-select">

                                </select>
                            </div>

                            <div class="form-group">
                                <label for="productEditPrice">Product Price</label>
                                <input step="0.01" type="number" id="productEditPrice" min="0" name="price" value="" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label for="productEditDescription">Description</label>
                                <textarea id="productEditDescription" name="description" class="form-control vh-25" required></textarea>
                            </div>

                            <div class="form-group">
                                <label>Current Images: (check the box if you want to delete image)</label>
                                <div id="currentImages" class="image-gallery">

                                </div>
                            </div>
                            <div class="form-group">
                                <label for="productEditImage">Images (Accept file formats: xbm, tif, apng, pjp, svgz, jpg, jpeg, ico, tiff, gif, svg, jfif, webp, png, bmp, pjpeg, avif)</label>
                                <input id="productEditImage" value="" type="file" name="image" class="form-control" accept=".xbm, .tif, .apng, .pjp, .svgz, .jpg, .jpeg, .ico, .tiff, .gif, .svg, .jfif, .webp, .png, .bmp, .pjpeg, .avif"/>
                            </div>
                            <div class="form-group">
                                <img id="previewImage" src="" alt="Image preview" style="display: none;" width="80" height="80"/>
                            </div>
                            <span alt="Add more image" id="addImageBtnEdit" class="addBtn">+</span>
                            <button type="submit" id="submitBtn" class="btn btn-success">Save</button>
                        </form>
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
        <script>
                                                                    // Khai báo hàm MyCustomUploadAdapterPlugin và MyUploadAdapter một lần duy nhất
                                                                    function MyCustomUploadAdapterPlugin(editor) {
                                                                        editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
                                                                            return new MyUploadAdapter(loader);
                                                                        };
                                                                    }

                                                                    class MyUploadAdapter {
                                                                        constructor(loader) {
                                                                            this.loader = loader;
                                                                            this.reader = new FileReader();
                                                                        }

                                                                        upload() {
                                                                            return this.loader.file
                                                                                    .then(file => new Promise((resolve, reject) => {
                                                                                            this._initListeners(resolve, reject);
                                                                                            this.reader.readAsDataURL(file);
                                                                                        }));
                                                                        }

                                                                        _initListeners(resolve, reject) {
                                                                            this.reader.onload = () => resolve({default: this.reader.result});
                                                                            this.reader.onerror = error => reject(error);
                                                                        }

                                                                        abort() {
                                                                            this.reader.abort();
                                                                        }
                                                                    }

                                                                    // Khởi tạo CKEditor cho productDescription

                                                                    ClassicEditor
                                                                            .create(document.querySelector('#productDescription'), {
                                                                                extraPlugins: [MyCustomUploadAdapterPlugin],
                                                                                image: {
                                                                                    toolbar: ['imageTextAlternative', 'imageStyle:full', 'imageStyle:side']
                                                                                }
                                                                            })
                                                                            .catch(error => {
                                                                                console.error(error);
                                                                            });



                                                                    // Khởi tạo CKEditor cho productEditDescription
                                                                    ClassicEditor
                                                                            .create(document.querySelector('#productEditDescription'), {
                                                                                extraPlugins: [MyCustomUploadAdapterPlugin],
                                                                                image: {
                                                                                    toolbar: ['imageTextAlternative', 'imageStyle:full', 'imageStyle:side']
                                                                                }
                                                                            })
                                                                            .catch(error => {
                                                                                console.error(error);
                                                                            });

                                                                    // Destroy CKEditor instance when the modal is closed

        </script>



        <script>
            function openAddProductForm() {
                // Show the modal
                $('#addProductModal').modal('show');
            }
        </script>


        <script>
            $(document).ready(function () {
                // Thêm sự kiện change cho checkbox .deleteCheckbox trong editProductModal
                $('#editProductModal').on('change', '.deleteCheckbox', function () {
                    var checkboxes = $('#editProductModal .deleteCheckbox');
                    var checkedCheckboxes = $('#editProductModal .deleteCheckbox:checked');
                    if (checkedCheckboxes.length >= checkboxes.length) {
                        alert('At least one image must remain.');
                        $(this).prop('checked', false); // Huỷ chọn checkbox nếu người dùng chọn quá nhiều
                    }
                });
            });
        </script>


        <script>
            document.getElementById('productForm').addEventListener('submit', function (event) {
                var descriptionField = document.getElementById('productDescription');
                descriptionField.value = descriptionField.value.replace(/\n/g, '<br>');
            });

            $(document).ready(function () {
                $('#editProductModal').on('show.bs.modal', function (e) {
                    var descriptionEdit = document.getElementById('productEditDescription');
                    descriptionEdit.value = descriptionEdit.value.replace(/<br>/g, '\n');
                });

                document.getElementById('productEditForm').addEventListener('submit', function (event) {
                    var descriptionEdit = document.getElementById('productEditDescription');
                    descriptionEdit.value = descriptionEdit.value.replace(/\n/g, '<br>');
                });
            });
//            function submitForm(formId) {
//                var form = document.getElementById(formId);
//                // Kiểm tra xem các trường input đã được nhập đúng cách hay chưa
//                if (form.checkValidity()) {
//                    // Thực hiện xử lý dữ liệu và gửi form nếu mọi thứ hợp lệ
//                    form.submit();
//                } else {
//                    // Nếu có lỗi, bạn có thể hiển thị thông báo hoặc thực hiện hành động khác ở đây
//                    console.log("Form contains invalid data. Please check your inputs.");
//                }
//            }
        </script>

        <script>
            document.addEventListener('change', function (event) {
                if (event.target && event.target.className === 'form-control' && event.target.type === 'file' &&
                        (event.target.id === 'productEditImage' || event.target.id === 'productImage')) {
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
                if (form.id === 'filterProduct' ||
                        form.id === 'filterRange' ||
                        form.id === 'filterSearch' ||
                        form.id === 'filterSortPrice' ||
                        form.id === 'filterCreatedTime' ||
                        form.id === 'filterModifiedTime' ||
                        form.id === 'filterModifiedBy' ||
                        form.id === 'filterNumPage' ||
                        form.id === 'filterCreatedBy' ||
                        form.id === 'filterPage' ||
                        form.id === 'filterStar') {
                    form.addEventListener('submit', function (event) {
                        event.preventDefault(); // Prevent default form submission
                        submitFormAndBuildURL(form.id); // Call your handler function
                    });
                }
            });


        </script>

        <script>
            //editimage
            document.getElementById('productEditImage').addEventListener('change', function (event) {
                handleFileSelect(event);
            });
            document.getElementById('addImageBtnEdit').addEventListener('click', function () {
                // Tạo một div chứa trường chọn tệp và nút xoá
                const inputGroup = document.createElement('div');
                inputGroup.className = 'form-group';
                // Tạo một trường chọn tệp mới
                const newInput = document.createElement('input');
                newInput.type = 'file';
                newInput.id = 'productEditImage';
                newInput.name = 'image';
                newInput.className = 'form-control';
                newInput.required = true;
                newInput.accept = '.xbm, .tif, .apng, .pjp, .svgz, .jpg, .jpeg, .ico, .tiff, .gif, .svg, .jfif, .webp, .png, .bmp, .pjpeg, .avif';
                // Gán sự kiện change để xử lý hiển thị ảnh xem trước
                newInput.addEventListener('change', function (event) {
                    handleFileEditSelect(event);
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
                const form = document.getElementById('productEditForm');
                form.insertBefore(inputGroup, addImageBtnEdit); // Chèn trước nút 'Thêm Ảnh'

                const outputGroup = document.createElement('div');
                outputGroup.className = 'form-group';
                const newOutput = document.createElement('img');
                newOutput.src = '';
                newOutput.id = 'previewImage';
                newOutput.alt = 'Image preview';
                newOutput.style.display = 'none';
                newOutput.width = 80;
                newOutput.height = 80;
                outputGroup.appendChild(newOutput);
                form.insertBefore(outputGroup, addImageBtnEdit);
            });


            function handleFileEditSelect(event) {
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

        <script>
            //addimage
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
                newInput.id = 'productImage';
                newInput.className = 'form-control';
                newInput.required = true;
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
                form.insertBefore(inputGroup, document.getElementById('addImageBtn')); // Chèn trước nút 'Thêm Ảnh'

                const outputGroup = document.createElement('div');
                outputGroup.className = 'form-group';
                const newOutput = document.createElement('img');
                newOutput.src = '';
                newOutput.alt = 'Image preview';
                newOutput.style.display = 'none';
                newOutput.width = 80;
                newOutput.height = 80;
                newOutput.id = 'previewImage';
                outputGroup.appendChild(newOutput);
                form.insertBefore(outputGroup, document.getElementById('addImageBtn'));
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
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    </body>

</html>
