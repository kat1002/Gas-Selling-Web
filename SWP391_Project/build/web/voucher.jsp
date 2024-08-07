<%-- 
    Document   : voucher
    Created on : Jun 13, 2024, 10:29:41 AM
    Author     : WuanTun
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>BLAZO | VOUCHER</title>
        <link rel="icon" href="media/icon/icons8-voucher-48.png"/>
        <link href="CSS/main.css" rel="stylesheet" type="text/css"/>
        <link href="CSS/profile.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="CSS/bootstrap.min.css" type="text/css"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css"
              integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <style>
            .author-card-avatar img{
                z-index: 1;
            }
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
                transform: scale(1.5);
                margin: 5px;
            }

            button {
                padding: 10px 20px;
                background-color: #4CAF50;
                color: white;
                border: none;
                cursor: pointer;
            }

            .modal {
                display: none;
                position: fixed;
                z-index: 2;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                overflow: auto;
                background-color: rgba(0, 0, 0, 0.4);
            }

            .modal-content {
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                background-color: #fefefe;
                padding: 20px;
                border: 1px solid #888;
                width: 80%;
                max-width: 600px; /* Giới hạn chiều rộng tối đa */
                max-height: 80vh; /* Giới hạn chiều cao tối đa */
                overflow-y: auto; /* Thêm scroll bar dọc nếu nội dung quá dài */
            }

            .close {
                color: #aaa;
                float: right;
                font-size: 28px;
                font-weight: bold;
            }

            .close:hover,
            .close:focus {
                color: black;
                text-decoration: none;
                cursor: pointer;
            }

            .modal-open {
                overflow: hidden;
            }

            .list-group-item.active:not(.disabled) {
                z-index: 2;
                color: #007bff;
                background-color: #fff;
                border-color: #fff;
                cursor: default;
            }

            .modal-open .list-group-item.active:not(.disabled) {
                z-index: 2;
                color: #fff;
                background-color: #007bff;
                border-color: #007bff;
            }

            .modal-overlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.3);
                z-index: 1000;
                display: none;
            }
        </style>
        <style>
            .voucher-notice {
                color: #28a745; /* Màu xanh lá cây để biểu thị thông báo tích cực */
                font-weight: bold;
                margin-bottom: 10px;
            }
            .voucher-warning {
                color: #dc3545; /* Màu đỏ để biểu thị cảnh báo */
                font-weight: bold;
                margin-bottom: 20px;
            }
            .voucher-container {
                border: 1px solid #ddd;
                padding: 15px;
                margin-bottom: 20px;
                background-color: #f9f9f9;
                border-radius: 5px;
            }
            .voucher-details h5 {
                color: #007bff; /* Màu xanh dương cho tiêu đề */
                margin-bottom: 10px;
            }
            .voucher-details p {
                margin: 5px 0;
            }
            .voucher-save-btn {
                background-color: #007bff;
                color: white;
                border: none;
                padding: 10px 20px;
                text-align: center;
                text-decoration: none;
                display: inline-block;
                font-size: 14px;
                margin: 10px 0;
                cursor: pointer;
                border-radius: 5px;
            }
            .voucher-save-btn:hover {
                background-color: #0056b3;
            }
        </style>

        <script>
            function openVoucherModal() {
                var modal = document.getElementById('voucherModal');
                var btn = document.getElementById("openModalBtn");
                var span = document.getElementsByClassName("close")[0];

                btn.onclick = function () {
                    modal.style.display = "block";
                }

                span.onclick = function () {
                    modal.style.display = "none";
                }

                window.onclick = function (event) {
                    if (event.target == modal) {
                        modal.style.display = "none";
                    }
                }
            }

            function closeVoucherModal() {
                var modal = document.getElementById('voucherModal');
                modal.style.display = "none";
            }
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
                                <a class="list-group-item" href="orderlist">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <div>
                                            <div class="d-inline-block font-weight-medium text-uppercase">Orders List</div>
                                        </div>
                                    </div>
                                </a>
                                <a class="list-group-item" href="profile">Profile Settings</a>
                                <a class="list-group-item active" href="voucher">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <div>
                                            <div class="d-inline-block font-weight-medium text-uppercase">My Vouchers</div>
                                        </div>
                                    </div>
                                </a>
                            </nav>
                            <button style="padding: 2%;" id="openModalBtn" onclick="openVoucherModal()">Voucher Available</button>
                        </div>
                        <jsp:useBean id="inventoryitem" class="com.model.DAO.InventoryItemDAO" scope="request"></jsp:useBean>
                        <jsp:useBean id="voucher_using" class="com.model.DAO.VoucherDAO" scope="request"></jsp:useBean>
                            <div id="voucherModal" class="modal">
                                <div class="modal-content">
                                    <span class="close text-right" onclick="closeVoucherModal()">&times;</span>
                                    <h2 class="text-center">Voucher Available</h2>
                                    <div id="voucherList" class="voucher-content">
                                    <c:choose>
                                        <c:when test="${requestScope.vouchers_available.size() > 0}">
                                            <p class="text-center voucher-notice">You can use this voucher twice if saved.</p>
                                            <p class="text-center voucher-warning">Vouchers may run out of stock than expected</p>
                                            <c:forEach items="${requestScope.vouchers_available}" var="v">
                                                <c:if test="${v.quantity > 0}">
                                                    <div class="voucher-container">
                                                        <div class="voucher-details">
                                                            <h5>${v.getTitle()}</h5>
                                                            <p>Description ${v.description}</p>
                                                            <p>Type: 
                                                                <c:if test="${v.discountType eq 1}">Percentage</c:if>
                                                                <c:if test="${v.discountType eq 2}">Specific value</c:if>
                                                                </p>
                                                                <p>Expiry: ${v.expiry}</p>
                                                            <p>Amount: ${v.quantity}</p>
                                                        </div>
                                                        <!-- Check if voucher is already saved -->
                                                        <c:if test="${inventoryitem.getInventoryItemByInventoryAndVoucher(inventory.inventoryId, v.voucherId) eq null}">
                                                            <form action="savevoucher" method="post" id="voucherSave${v.voucherId}">
                                                                <input type="hidden" name="voucherid" value="${v.voucherId}"/>
                                                                <button class="voucher-save-btn">Save</button>
                                                            </form>
                                                        </c:if>

                                                    </div>
                                                </c:if>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="voucher-container">
                                                <div class="voucher-details">
                                                    <h5>No voucher available</h5>
                                                </div>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-8 pb-5 row">
                        <div class="table-responsive">
                            <table class="table table-hover mb-0">
                                <thead>
                                    <tr>
                                        <th>Voucher Title</th>
                                        <th>Voucher Code</th>
                                        <th>Voucher Type</th>
                                        <th>Discount Value</th>
                                        <th>Remaining</th>
                                        <th>Condition (From any price level upwards)</th>
                                        <th>Expiry</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${inventoryitem.getInventoryItemByInventoryId(inventory.inventoryId).size() > 0}">
                                            <c:forEach items="${inventoryitem.getInventoryItemByInventoryId(inventory.inventoryId)}" var="item">
                                                <c:if test="${item.amount > 0}">
                                                    <tr>
                                                        <td>${item.getVoucherById(item.getVoucherId()).getTitle()}</td>
                                                        <td>${item.getVoucherById(item.getVoucherId()).voucherCode}</td>
                                                        <td>
                                                            <c:if test="${item.getVoucherById(item.getVoucherId()).discountType eq 1}">Percentage</c:if>
                                                            <c:if test="${item.getVoucherById(item.getVoucherId()).discountType eq 2}">Specific value</c:if>
                                                            </td>
                                                            <td>
                                                            <c:if test="${item.getVoucherById(item.getVoucherId()).discountType eq 1}">
                                                                ${item.getVoucherById(item.getVoucherId()).discountValue * 100}%
                                                            </c:if>
                                                            <c:if test="${item.getVoucherById(item.getVoucherId()).discountType eq 2}">
                                                                ${item.getVoucherById(item.getVoucherId()).discountValue} &#8363;
                                                            </c:if>
                                                            
                                                        </td>
                                                        <td>${item.getAmount()}</td>
                                                        <td>${item.getVoucherById(item.getVoucherId()).condition}</td>
                                                        <td>${item.getVoucherById(item.getVoucherId()).getExpiry()}</td>
                                                    </tr>
                                                </c:if>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="5">No vouchers found.</td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <jsp:include page="footer.jsp"/>
    </body>
</html>

