<%-- 
    Document   : adddiscount
    Created on : Jul 10, 2024, 8:42:14 PM
    Author     : ADMIN
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html" ; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>BLAZO | ADD DISCOUNT</title>
        <link rel="icon" href="media/icon/icons8-discount.gif"/>
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
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>

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

            .container:hover input~.checkmark {
                background-color: #ccc;
            }

            .container input:checked~.checkmark {
                background-color: #9f8a46;
            }

            .checkmark:after {
                content: '';
                position: absolute;
                display: none;
            }

            .container input:checked~.checkmark:after {
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
                display: block;
                /*                position: fixed;*/
                z-index: 1;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                overflow: auto;
                /*                background-color: rgba(0,0,0,0.5);*/
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
                /*                                position: fixed;*/
                bottom: 0;
                width: 100%;
            }
            .center {
                text-align: center;
            }

            /*            .pagination {
                            display: inline-block;
                        }
            
                        .pagination a {
                            color: black;
                            float: left;
                            padding: 8px 16px;
                            text-decoration: none;
                            transition: background-color .3s;
                            border: 1px solid #ddd;
                            margin: 0 4px;
                        }
            
            */                        .pagination a.active {
                background-color: #4CAF50;
                color: white;
                border: 1px solid #4CAF50;
            }/*

            .pagination a:hover:not(.active) {
                background-color: #ddd;
            }*/
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

            .containercheck:hover input~.checkmark {
                background-color: #ccc;
            }

            .containercheck input:checked~.checkmark {
                background-color: #9f8a46;
            }

            .checkmark:after {
                content: '';
                position: absolute;
                display: none;
            }

            .containercheck input:checked~.checkmark:after {
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
            .dropdown,.dropup{
                position:relative
            }
            .dropdown-toggle::after{
                display:inline-block;
                width:0;
                height:0;
                margin-left:.255em;
                vertical-align:.255em;
                content:"";
                border-top:.3em solid;
                border-right:.3em solid transparent;
                border-bottom:0;
                border-left:.3em solid transparent
            }
            .dropdown-toggle:empty::after{
                margin-left:0
            }
            .dropdown-menu{
                position:absolute;
                top:100%;
                left:0;
                z-index:1000;
                display:none;
                float:left;
                min-width:10rem;
                padding:.5rem 0;
                margin:.125rem 0 0;
                font-size:1rem;
                color:#212529;
                text-align:left;
                list-style:none;
                background-color:#fff;
                background-clip:padding-box;
                border:1px solid rgba(0,0,0,.15);
                border-radius:.25rem
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
            .writeform{
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
            @media screen and (max-width:576px){
                .column1 {
                    width: 100%;
                }

                .column2 {
                    width: 100%;
                }

            }

            .image-gallery {
                display: flex;
                flex-wrap: wrap;
                gap: 10px; /* khoảng cách giữa các hình ảnh */
            }

            .image-container {
                flex: 0 0 auto;
                display: flex;
                flex-direction: column;
                align-items: center;
            }
            .scrollable-grid {
                max-height: 300px; /* Chiều cao tối đa của grid */
                overflow-y: auto; /* Kích hoạt scroll bar dọc khi vượt quá chiều cao */
            }

            .grid-inner {
                padding-right: 15px; /* Tạo khoảng cách bên phải để không che lấp scroll bar */
            }

        </style>
        <script src="ckeditor5/ckeditor5-build-classic/ckeditor.js"></script>
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
                                                <a href="#" class="btn btn-otline-dark align-items-center"><i class="icon-share"></i> Share</a>
                                                <a href="#" class="btn btn-otline-dark"><i class="icon-printer"></i> Print</a>
                                                <a href="#" class="btn btn-primary text-white me-0"><i class="icon-download"></i> Export</a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tab-content tab-content-basic">
                                        <div class="tab-pane fade show active" id="overview" role="tabpanel" aria-labelledby="overview"> 
                                            <div class="card">
                                                <div class="card-body">
                                                    <a href="managediscount">
                                                        <span class="closeBtn">
                                                            <img title="Back to discount management page" src="media/icon/previous.png" width="40" height="40"/>
                                                        </span>
                                                    </a>
                                                    <h5 class="card-title">Add Discount</h5>
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
                                                            <label for="expiryDate">Discount Expiry</label>
                                                            <input type="datetime-local" id="expiryDate" name="expiry" class="form-control" required>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="status">Status</label>
                                                            <select name="status" class="form-select">
                                                                <option value="1">Active</option>
                                                                <option value="2">Not active</option>
                                                            </select>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="categoryDiscount">Category To Discount</label>
                                                            <input onclick="categoryCheck('0')" class="form-check-input" type="radio" name="cid" id="categoryDiscountAll" value="0"/>All
                                                            <c:forEach items="${requestScope.categories}" var="category">
                                                                <input onclick="categoryCheck('${category.getCategoryId()}')" class="form-check-input" type="radio" name="cid" id="categoryDiscount${category.getCategoryId()}" value="${category.getCategoryId()}"/>${category.getTitle()}
                                                            </c:forEach>
                                                            <span class="btn btn-close" onclick="clearCheckedProducts()"></span>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="discountProductFound">Find product</label>
                                                            <input oninput="foundProduct()" name="search" id="discountProductFound" class="form-control"/>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="productDiscount">Product To Discount</label>
                                                            <!-- Products Container with Scrollable Grid -->
                                                            <div id="productContainer" class="scrollable-grid">
                                                                <div class="grid-inner">
                                                                    <div class="row" id="productRow">
                                                                        <c:forEach items="${requestScope.products}" var="product" varStatus="status">
                                                                            <div class="col-md-4 product-item">
                                                                                <input class="form-check-input" type="checkbox" id="productDiscount${product.productId}" name="pid" value="${product.getProductId()}"/>
                                                                                <label class="form-check-label" for="productDiscount${product.productId}">
                                                                                    ${product.title}
                                                                                </label>
                                                                            </div>
                                                                        </c:forEach>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <button type="submit" id="submitBtn" class="btn btn-success">Add discount</button>
                                                    </form>
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
    </body>
    <script>
        <jsp:useBean id="product" class="com.model.DAO.ProductDAO" scope="request"></jsp:useBean>
//        function categoryCheck(categoryId) {
//            if (categoryId === '0') {
//                // Check "All" option, select all products
//                document.getElementById('categoryDiscountAll').checked = true;
//                const allProductCheckboxes = document.querySelectorAll(`input[name="pid"]`);
//                allProductCheckboxes.forEach(checkbox => {
//                    checkbox.checked = true;
//                });
//            } else {
//                // Uncheck "All" option, select products with specific category
//                document.getElementById('categoryDiscountAll').checked = false;
//                const allProductCheckboxes = document.querySelectorAll(`input[name="pid"]`);
//                allProductCheckboxes.forEach(checkbox => {
//                    checkbox.checked = false;
//                });
//                const categoryProductCheckboxes = document.querySelectorAll(`input[name="pid"][value^="${categoryId}"]`);
//                categoryProductCheckboxes.forEach(checkbox => {
//                    checkbox.checked = true;
//                });
//            }
//        }
function foundProduct(){
     var searchKeyword = document.getElementById('discountProductFound').value;
    $.ajax({
        url: '/SWP391_Project/discountfoundproducthandle',  // Replace with the actual URL of the search servlet
        method: 'GET',
        data: { search: searchKeyword },
        success: function (data) {
           var row = document.getElementById("productRow");
           row.innerHTML = data;
        },
        error: function (xhr, status, error) {
            console.error('AJAX error:', error);
            // Handle errors and display error messages if needed
        }
    });
}
function categoryCheck(categoryId) {
    $.ajax({
        url: 'discountcategoryhandle?categoryId=' + categoryId,
        method: 'GET',
        dataType: 'json',
        success: function (data) {
            const productIds = data.productIds;
            
            // Loop through each product checkbox and check if it belongs to the productIds list
            $('input[name="pid"]').each(function() {
                const productId = $(this).val();
                $(this).prop('checked', productIds.includes(parseInt(productId)));
            });
        },
        error: function(xhr, status, error) {
            alert('AJAX error:', error);
            // Additional error handling can be added here, such as displaying an error message to the user
        }
    });
}


        function clearCheckedProducts() {
            const checkboxpid = document.querySelectorAll('input[name="pid"]');
            const radiocid = document.querySelectorAll('input[name="cid"]');
            checkboxpid.forEach(checkbox => {
                checkbox.checked = false;
            });
            radiocid.forEach(radio => {
                radio.checked = false;
            });
        }
    </script>
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
                .create(document.querySelector('#discountDescription'), {
                    extraPlugins: [MyCustomUploadAdapterPlugin],
                    image: {
                        toolbar: ['imageTextAlternative', 'imageStyle:full', 'imageStyle:side']
                    }
                })
                .catch(error => {
                    console.error(error);
                });


    </script>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</html>
