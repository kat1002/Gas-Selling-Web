<%-- 
    Document   : orderlist
    Created on : May 16, 2024, 5:59:12 AM
    Author     : kat1002
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.model.Order" %>
<!DOCTYPE html>
<html>
    <head>
        <title>BLAZO | ORDER</title>
        <link href="CSS/main.css" rel="stylesheet" type="text/css"/>
        <link href="CSS/profile.css" rel="stylesheet" type="text/css"/>
        <link rel="icon" href="media/icon/user.png"/>
        <!--        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css"
              integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">

        <meta charset="utf-8"/>
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <style>
            .mt-6 {
                margin-top: 4.5rem !important;

            }

            .mt-7 {
                margin-top: 6rem !important;
            }

            @media screen and (max-width: 576px) {
                .mt-7 {
                    margin-top: 8rem !important;
                }
            }

            @media screen and (max-width: 720px) {
                .mt-7 {
                    margin-top: 8rem !important;
                }
            }
            input[type="checkbox"] {
                transform: scale(1.5); /* Adjust the scale value to make the checkbox bigger */
                margin: 5px; /* Optional: Adjust the margin to better align with the text */
            }
        </style>
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
                if (form.id === 'filterPaymentMethod' ||
                        form.id === 'filterOrderDate' ||
                        form.id === 'filterPrice' ||
                        form.id === 'filterPage' ||
                        form.id === 'filterSortPrice' ||
                        form.id === 'filterStatus' ||
                        form.id === 'filterOrderPerPage') {
                    form.addEventListener('submit', function (event) {
                        event.preventDefault(); // Prevent default form submission
                        submitFormAndBuildURL(form.id); // Call your handler function
                    });
                }
            });
        </script>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <main>
            <div class="container mb-4 main-container mt-7" style="min-height: 500px">
                <div class="row">
                    <div class="col-lg-4 pb-5">
                        <div class="author-card pb-3">
                            <div class="author-card-profile">
                                <div class="author-card-avatar">
                                    <img src="${sessionScope.user.getCustomerImage()}" alt="Daniel Adams">
                                </div>
                                <div class="author-card-details">
                                    <h5 class="author-card-name text-lg">${sessionScope.user.getName()}</h5>
                                </div>
                            </div>
                        </div>
                        <div class="wizard">
                            <nav class="list-group list-group-flush">
                                <a class="list-group-item active" href="#">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <div>
                                            <div class="d-inline-block font-weight-medium text-uppercase">Orders List</div>
                                        </div>
                                    </div>
                                </a>
                                <a class="list-group-item" href="profile">Profile Settings</a>
                                <a class="list-group-item" href="voucher">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <div>
                                            <div class="d-inline-block font-weight-medium text-uppercase">My Vouchers</div>
                                        </div>
                                    </div>
                                </a>
                            </nav>
                        </div>
                    </div>
                    <!-- Orders Table-->
                    <div class="col-lg-8 pb-5 row">
                        <div class="col-md-2">
                            <form method="get" action="orderlist" id="filterStatus">
                                <label for="status">Status</label>
                                <select id="status" name="status" class="form-control" onchange="submitFormAndBuildURL('filterStatus')">
                                    <option value="">All</option>
                                    <option value="1" ${statuss == 1 ? 'selected' : ''}>Rejected</option>
                                    <option value="2" ${statuss == 2 ? 'selected' : ''}>Delivering</option>
                                    <option value="3" ${statuss == 3 ? 'selected' : ''}>Done</option>
                                </select>
                            </form>
                        </div>
                        <div class="col-md-2">
                            <form method="get" action="orderlist" id="filterPaymentMethod">
                                <div class="form-group">
                                    <label for="paymentMethod">Payment Method</label>
                                    <select id="paymentMethod" name="paymentMethod" class="form-control" onchange="submitFormAndBuildURL('filterPaymentMethod')">
                                        <option value="0" ${paymentMethod == 0 ? 'selected' : ''}>All</option>
                                        <option value="1" ${paymentMethod == 1 ? 'selected' : ''}>Cash on Delivery (COD)</option>
                                        <option value="2" ${paymentMethod == 2 ? 'selected' : ''}>Pay Online</option>                                   
                                    </select>
                                </div>
                            </form>
                        </div>
                        <div class="col-md-3">
                            <form method="get" action="orderlist" id="filterOrderDate">
                                <div class="form-group">
                                    <label for="startDate">Start Date</label>
                                    <input type="date" id="startDate" name="startDate" class="form-control" value="${startDate}">
                                </div>
                                <div class="form-group">
                                    <label for="endDate">End Date</label>
                                    <input type="date" id="endDate" name="endDate" class="form-control" value="${endDate}">
                                </div>
                                <button type="submit" onclick="submitFormAndBuildURL('filterOrderDate')"><i class="fa-solid fa-search"></i></button>
                            </form>
                        </div>
                        <div class="col-md-2">
                            <form method="get" action="orderlist" id="filterPrice">
                                <div class="form-group">
                                    <label for="minPrice">Min Price</label>
                                    <input type="number" id="minPrice" name="minPrice" class="form-control" value="${minPrice}">
                                </div>
                                <div class="form-group">
                                    <label for="maxPrice">Max Price</label>
                                    <input type="number" id="maxPrice" name="maxPrice" class="form-control" value="${maxPrice}">
                                </div>
                                <button type="submit" onclick="submitFormAndBuildURL('filterPrice')"><i class="fa-solid fa-search"></i></button>
                            </form>
                        </div>
                        <div class="col-md-2">
                            <form method="get" action="orderlist" id="filterSortPrice">
                                <div class="form-group">
                                    <label for="sortPrice">Sort By Price</label>
                                    <select id="sortPrice" name="sortprice" class="form-control" onchange="submitFormAndBuildURL('filterSortPrice')">
                                        <option value="0" ${sortprice == 0 ? 'selected' : ''}>None</option>
                                        <option value="1" ${sortprice == 1 ? 'selected' : ''}>Decrease</option>
                                        <option value="2" ${sortprice == 2 ? 'selected' : ''}>Increase</option>            
                                    </select>
                                </div>
                            </form>
                        </div>
                        <div class="col-md-2">
                            <form method="get" action="orderlist" id="filterOrderPerPage">
                                <div class="form-group">
                                    <label for="orderPerPage">Orders / Page</label>
                                    <select id="orderPerPage" name="orderperpage" class="form-control" onchange="submitFormAndBuildURL('filterOrderPerPage')">
                                        <option value="5" ${orderPerPage == 5 ? 'selected' : ''}>5</option>
                                        <option value="10" ${orderPerPage == 10 ? 'selected' : ''}>10</option>
                                        <option value="15" ${orderPerPage == 15 ? 'selected' : ''}>15</option>   
                                        <option value="20" ${orderPerPage == 20 ? 'selected' : ''}>20</option>   
                                        <option value="25" ${orderPerPage == 25 ? 'selected' : ''}>25</option>   
                                    </select>
                                </div>
                            </form>
                        </div>
                        <div class="table-responsive">
                            <table class="table table-hover mb-0">
                                <thead>
                                    <tr>
                                        <th>Order ID</th>
                                        <th>Date Purchased</th>
                                        <th>Payment Method</th>
                                        <th>Total<br>Price</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${requestScope.orderList.size() > 0}">
                                            <c:forEach items="${requestScope.orderList}" var="o">
                                                <tr>
                                                    <td>
                                                        ${o.getOrderId()}
                                                    </td>
                                                    <td>
                                                        ${o.getOrderDate()}
                                                    </td>
                                                    <td>
                                                        ${o.getPaymentMethodName()}
                                                    </td>
                                                    <td>
                                                        <fmt:formatNumber value="${o.getTotalPrice()}" type="number" maxFractionDigits="2" minFractionDigits="2"/> &#8363;
                                                    </td>
                                                    <td>
                                                        <c:if test="${o.getStatus() eq 1}">
                                                            <span class="btn-sm btn-danger">Rejected</span>
                                                        </c:if>
                                                        <c:if test="${o.getStatus() eq 2}">
                                                            <span class="btn-sm btn-warning">Delivering</span>
                                                        </c:if>
                                                        <c:if test="${o.getStatus() eq 3}">
                                                            <span class="btn-sm btn-success">Done</span>
                                                        </c:if>
                                                    </td>
                                                    <td>
                                                        <a href="OrderDetails?orderId=${o.getOrderId()}" class="btn btn-primary">View<br>Detail</a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="5">No orders found.</td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
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
                                    <form action="orderlist" method="get" id="filterPage">
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
        </main>


        <jsp:include page="footer.jsp"/>

    </body>
</html>
