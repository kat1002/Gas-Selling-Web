<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.model.Warranty" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <!-- Required meta tags -->
        <meta http-equiv="Content-Type" content="text/html" ; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="icon" href="media/icon/configuration_12783710.png"/>
        <title>BLAZO | LIST Warranty</title>
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
        <link href="JS/dashboard/select.dataTables.min.css" rel="stylesheet">
        <!-- End plugin css for this page -->
        <!-- inject:css -->
        <link href="CSS/dashboardcss/vertical-layout-light/style.css" rel="stylesheet">
        <script src="ckeditor5/ckeditor5-build-classic/ckeditor.js"></script>
        <style>
            .center {
                text-align: center;
            }

            .pagination {
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

            .pagination a.active {
                background-color: #4CAF50;
                color: white;
                border: 1px solid #4CAF50;
            }

            .pagination a:hover:not(.active) {
                background-color: #ddd;
            }
        </style>
    </head>
    <body>
        <div class="container-scroller">
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

                                    <div class="tab-content tab-content-basic">
                                        <div class="tab-pane fade show active" id="overview" role="tabpanel"
                                             aria-labelledby="overview">
                                            <div class="card">
                                                <div class="card-body">
                                                    <h5 class="card-title">Warranty List</h5>

                                                    <form class="row" action="manageWarranty" id="submitForm">
                                                        <div class="col-md-3">
                                                            <h5>Warranty Type</h5>
                                                            <select onchange="this.form.submit()" class="form-select" id="news" name="warrantyType">
                                                                <option value="0" <c:if test="${requestScope.type eq 0}">selected</c:if>>All</option>
                                                                <option value="1" <c:if test="${requestScope.type eq 1}">selected</c:if>>Trong hạn</option>
                                                                <option value="2" <c:if test="${requestScope.type eq 2}">selected</c:if>>Ngoài hạn</option>
                                                                </select>
                                                                <h5 style="margin-top:10px">Warranty per page</h5>
                                                                <div class="form-group">
                                                                    <input onchange="this.form.submit()" 
                                                                           id="setPageNumber" type="number" name="set-page-number" 
                                                                           value="${requestScope.setPageNumber}">
                                                            </div>
                                                        </div>

                                                        <div class="col-md-3">
                                                            <h5>Search Product Status</h5>
                                                            <input onchange="this.form.submit()" type="text" placeholder="Search by status" name="searchStatus"
                                                                   value="${requestScope.searchStatus}"/>
                                                            <h5 style="margin-top:10px">isDone: </h5>
                                                            <select onchange="this.form.submit()" class="form-select" id="news" name="isDone">
                                                                <option value="true" <c:if test="${requestScope.isDone eq true}">selected</c:if>>yes</option>
                                                                <option value="false" <c:if test="${requestScope.isDone eq false}">selected</c:if>>no</option>
                                                                </select>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <h5>Search Serial Number Id</h5>
                                                                <input onchange="this.form.submit()" type="number" placeholder="Search by serial number id" name="serialNumberId"
                                                                       value="${requestScope.serialNumberId}"/>
                                                            <h5 style="margin-top:10px">Search manager id</h5>
                                                            <input onchange="this.form.submit()" type="number" placeholder="Search by manager id" name="managerId"
                                                                   value="${requestScope.managerId}"/>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <h5>Search warranty by time create</h5>
                                                            <input  type="date" name="createDateFrom"
                                                                    value="${requestScope.createDateFrom}" onkeypress="checkEnter(event)"/>
                                                            <input  type="date" name="createDateTo"
                                                                    value="${requestScope.createDateTo}" onkeypress="checkEnter(event)"/>
                                                        </div>

                                                        <div class="col-md-3">
                                                            <h5>Search warranty by time modify</h5>
                                                            <input  type="date" name="modifyDateFrom"
                                                                    value="${requestScope.modifyDateFrom}" onkeypress="checkEnter(event)"/>
                                                            <input  type="date" name="modifyDateTo"
                                                                    value="${requestScope.modifyDateTo}" onkeypress="checkEnter(event)"/>
                                                        </div>

                                                        <div class="col-md-3">
                                                            <h5>Search warranty that created by</h5>
                                                            <input onchange="this.form.submit()" type="number" name="createdBy"
                                                                   <c:if test="${requestScope.createdBy ne 0}">value="${requestScope.createdBy}"</c:if>
                                                                       />
                                                                   <h5>Search warranty that modified by</h5>
                                                                   <input onchange="this.form.submit()" type="number" name="modifitedBy"
                                                                   <c:if test="${requestScope.modifitedBy ne 0}">value="${requestScope.modifitedBy}"</c:if>
                                                                       />
                                                            </div>
                                                            <div class="col-md-3">
                                                                <h5>Guarantee Date:</h5>
                                                                <input onchange="this.form.submit()" type="date" name="guaranteeDate" 
                                                                       value="${requestScope.guaranteeDate}">
                                                        </div> 
                                                        <div class="col-md-3">
                                                            <h5>Clear all</h5>
                                                            <input type="reset" onclick="location.href = 'manageWarranty'"/>
                                                        </div> 
                                                    </form>

                                                    <hr>
                                                    <p class="card-description">
                                                        <a class="btn btn-behance" href="addWarranty.jsp">
                                                            Add warranty</a>
                                                    </p>
                                                    <div class="table-responsive">
                                                        <table class="table table-hover">
                                                            <thead>
                                                                <tr>
                                                                <tr>
                                                                    <th>ID</th>
                                                                    <th>Serial<br> Number Id</th>
                                                                    <th>Manager<br>Id</th>
                                                                    <th>Warranty<br>Type</th>
                                                                    <th>Guarantee<br> Date</th>
                                                                    <th>Status</th>
                                                                    <th>is<br>Done</th>
                                                                    <!--                                                                    <th>Warranty<br>Image</th>-->
                                                                    <th>Created<br>Date</th>
                                                                    <th>Modified<br>on</th>
                                                                    <th>Created<br>By</th>
                                                                    <th>Modified<br>By</th>
                                                                </tr>
                                                                </tr>
                                                            </thead>
                                                            <tbody id="manageNews">
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                    <div class="center">
                                                        <div class="pagination">
                                                            <a href="#" class="prev-page">&laquo;</a>
                                                            <!-- Pagination links will be dynamically added here -->
                                                            <a href="#" class="next-page">&raquo;</a>
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
    </body>


    <%             
            List<Warranty> listWarranty = (List<Warranty>) request.getAttribute("listWarranty");
            Gson gson = new GsonBuilder().create();
            String jsonListNews = gson.toJson(listWarranty);    
    %>
    <script>
        var listNews = <%= jsonListNews %>;
        document.addEventListener("DOMContentLoaded", function () {
            const prevPageLink = document.querySelector('.pagination a.prev-page');
            const nextPageLink = document.querySelector('.pagination a.next-page');
            const productContainer = document.querySelector('.product ul');
            const paginationContainer = document.querySelector('.pagination');
            var inputElement = document.getElementById("setPageNumber");
            const itemsPerPage = parseInt(inputElement.value, 10);
            let currentPage = 1;
            const totalItems = listNews.length;
            let totalPages = Math.ceil(totalItems / itemsPerPage);

            function updatePaginationLinks() {
                // Clear existing page numbers
                paginationContainer.querySelectorAll('.page-number, .page-input').forEach(link => link.remove());

                if (totalPages <= 5) {
                    // Add all page numbers if total pages <= 5
                    for (let i = 1; i <= totalPages; i++) {
                        addPageNumberLink(i);
                    }
                } else {
                    // Add first 2 pages
                    for (let i = 1; i <= 2; i++) {
                        addPageNumberLink(i);
                    }

                    // Add current page with input box
                    addPageInput(currentPage);

                    // Add last 2 pages
                    for (let i = totalPages - 1; i <= totalPages; i++) {
                        if (i > 2) {
                            addPageNumberLink(i);
                        }
                    }
                }

                // Attach event listeners to new page numbers
                paginationContainer.querySelectorAll('.page-number').forEach(link => {
                    link.addEventListener('click', function (event) {
                        event.preventDefault();
                        currentPage = parseInt(this.textContent);
                        updatePaginationLinks();
                        displayProducts(currentPage);
                    });
                });

                // Attach event listener to input box
                const pageInput = document.querySelector('a.page-input input');
                if (pageInput) {
                    pageInput.addEventListener('change', function () {
                        const pageNumber = parseInt(this.value);
                        if (pageNumber >= 1 && pageNumber <= totalPages) {
                            currentPage = pageNumber;
                            updatePaginationLinks();
                            displayProducts(currentPage);
                        }
                    });
                }
            }

            function addPageNumberLink(page) {
                const pageNumberLink = document.createElement('a');
                pageNumberLink.href = "#";
                pageNumberLink.className = "page-number";
                pageNumberLink.textContent = page;
                if (page === currentPage) {
                    pageNumberLink.classList.add('active');
                }
                paginationContainer.insertBefore(pageNumberLink, nextPageLink);
            }

            function addPageInput(page) {
                const pageInputContainer = document.createElement('a');
                pageInputContainer.className = "page-input";
                const pageInput = document.createElement('input');
                pageInput.type = "number";
                if (2 < page && page < totalPages - 1)
                    pageInput.value = page;
                pageInput.min = 1;
                pageInput.max = totalPages;
                pageInputContainer.appendChild(pageInput);
                paginationContainer.insertBefore(pageInputContainer, nextPageLink);
            }

            prevPageLink.addEventListener('click', function (event) {
                event.preventDefault();
                if (currentPage > 1) {
                    currentPage--;
                    updatePaginationLinks();
                    displayProducts(currentPage);
                }
            });

            nextPageLink.addEventListener('click', function (event) {
                event.preventDefault();
                if (currentPage < totalPages) {
                    currentPage++;
                    updatePaginationLinks();
                    displayProducts(currentPage);
                }
            });

            function displayProducts(page) {
                const manageNews = document.getElementById('manageNews');
                manageNews.innerHTML = '';
                const start = (page - 1) * itemsPerPage;
                const end = Math.min(start + itemsPerPage, totalItems);
                for (let i = start; i < end; i++) {
                    const product = listNews[i];
                    const productRow = document.createElement('tr');
                    productRow.id = `productRow-` + product.managerId;
                    productRow.innerHTML = `
            <td class="productId">` + product.warrantyId + `</td>
            <td class="productId">` + product.serialNumberId + `</td>
            <td class="productId">` + product.managerId + `</td>
            <td class="productId">` + (product.warrantyType == 1 ? 'Trong hạn' : 'Ngoài hạn') + `</td>
            <td class="productCategory">` + product.guaranteeDate + `</td>
            <td class="productCategory">` + product.status + `</td>
            <td class="productCategory">` + product.isDone + `</td>
            <td class="productCategory">` + product.createdAt + `</td>
            <td class="productCategory">` + product.modifiedAt + `</td>
            <td class="productCategory">` + product.createdBy + `</td>
            <td class="productCategory">` + product.modifiedBy + `</td>
            <td>
                
                    <a href="editWarranty?id=` + product.warrantyId + `">
                        <button class="btn btn-warning">
                            <i class="fa fa-pencil"></i>
                        </button>
                    </a>
                
                    <a href="deleteWarranty?id=` + product.warrantyId + `" onclick="return confirmDelete();">
                        <button class="btn btn-danger">
                            <i class="fa fa-trash"></i>
                        </button>
                    </a>
                    <a href="exportWarranty?id=` + product.warrantyId + `">
                        <button class="btn btn-danger">
                            <i class="icon-download"></i>
                        </button>
                    </a>
            </td>
        `;
                    manageNews.appendChild(productRow);
                }
            }

            // Initial setup
            updatePaginationLinks();
            displayProducts(currentPage);
        });

        function list() {
            updatePaginationLinks();
            displayProducts(currentPage);
        }
    </script>

    <script type="text/javascript">
        function confirmDelete() {
            return confirm("Are you sure you want to delete this warrant?");
        }
        function checkEnter(event) {
            if (event.key === 'Enter') {
                event.preventDefault(); // Prevents the default action of the Enter key
                document.getElementById('submitForm').submit();
            }
        }
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
    <script src="JS/off-canvas.js"></script>
    <script src="JS/hoverable-collapse.js"></script>
    <script src="JS/template.js"></script>
    <script src="JS/settings.js"></script>
    <script src="JS/todolist.js"></script>
    <!-- endinject -->
    <!-- Custom js for this page-->
    <script src="JS/dashboard.js"></script>
    <script src="JS/Chart.roundedBarCharts.js"></script>
    <!-- End custom js for this page-->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>


</html>
