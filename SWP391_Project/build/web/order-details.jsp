<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.model.Order" %>
<%@ page import="com.model.Customer" %>
<%@ page import="com.model.OrderItem" %>
<%@ page import="java.util.List" %><%--

  Created by IntelliJ IDEA.
  User: WuanTun
  Date: 6/25/2024
  Time: 10:23:59 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>BLAZO | ORDER</title>
        <link rel="icon" href="media/icon/icons8-order-48.png"/>
        <link rel="stylesheet" href="CSS/dashboardcss/vertical-layout-light/style.css"/>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
        <!-- Bao gồm jQuery -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <!-- Bao gồm Bootstrap Bundle (bao gồm cả Popper.js) -->
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/0.5.0-beta4/html2canvas.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f4f4f4;
                padding-top: 50px;
            }

            .container {
                width: 80%;
                margin: 0 auto;
                padding: 20px;
                background-color: #fff;
                box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
                border-radius: 10px;
                padding-top: 50px;
            }

            .order-info {
                background-color: #f9f9f9;
                padding: 20px;
                margin-bottom: 20px;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 20px;
            }

            .order-info p {
                margin: 10px 0;
                font-size: 1.1em;
                color: #333;
                padding: 10px;
                background-color: #fff;
                border: 1px solid #ddd;
                border-radius: 5px;
            }

            .order-info p span {
                font-weight: bold;
                color: #555;
            }

            header, footer {
                background-color: #333;
                color: #fff;
                padding: 10px 0;
                text-align: center;
            }

            header h1, footer p {
                margin: 0;
            }

            .submit-button {
                background-color: #28a745;
                color: #fff;
                border: none;
                padding: 10px 20px;
                border-radius: 5px;
                cursor: pointer;
                font-size: 1em;
                margin-top: 10px;
                margin-bottom: 10px;
                transition: background-color 0.3s;
            }

            .submit-button:hover {
                background-color: #218838;
            }
            #orderstatus {
                font-size: 1.2em;
                color: #333;
                padding: 10px;
                background-color: #e9ecef;
                border: 1px solid #ddd;
                border-radius: 5px;
                text-align: center;
            }
            .modal-content {
                border-radius: 10px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.5);
            }
            .modal-header {
                background-color: white;
                color: white;
                border-top-left-radius: 10px;
                border-top-right-radius: 10px;
            }
            .modal-header .btn-close {
                background-color: white;
            }
            .modal-body {
                padding: 20px;
            }
            .modal-footer {
                padding: 10px 20px;
                border-top: 1px solid #e9ecef;
            }
            .modal-footer .btn {
                border-radius: 50px;
            }
            #serialNumberList {
                list-style-type: none;
                padding: 0;
            }
            #serialNumberList li {
                padding: 10px;
                background-color: #f8f9fa;
                margin-bottom: 5px;
                border-radius: 5px;
            }
            .menu-link {
                color: black;
                text-decoration: none;
                font-size: 14px;
            }
        </style>
        <script>
            function loadSerialNumbers(productId, orderItemId) {
                $.ajax({
                    url: 'getSerialNumbers',
                    method: 'GET',
                    data: {
                        productId: productId,
                        orderItemId: orderItemId
                    },
                    success: function (response) {
                        if (response) {
                            const serialNumberList = $('#serialNumberList');
                            serialNumberList.empty(); // Xóa nội dung cũ

                            // Hiển thị danh sách số serial và tạo form cho mỗi mã
                            $.each(response.psn_list, function (index, serial) {
                                const listItem = $('<li>').addClass('list-group-item').text(serial.serviceTag);

                                // Tạo form ẩn cho mỗi số serial
                                const formId = 'sendRequest' + serial.serialNumberId;
                                const form = $('<form>')
                                        .attr('id', formId)
                                        .attr('method', 'post')
                                        .attr('action', 'requestWarranty')
                                        .css('display', 'none');

                                // Thêm trường input ẩn vào form
                                $('<input>')
                                        .attr('type', 'hidden')
                                        .attr('name', 'psnId')
                                        .attr('value', serial.serialNumberId)
                                        .appendTo(form);

                                // Thêm form vào body
                                $('body').append(form);

                                // Tạo nút "Warranty Request"
                                const warrantyButton = $('<button>')
                                        .addClass('btn btn-warning btn-sm ms-2')
                                        .html('<i class="bi bi-shield"></i> Warranty Request')
                                        .on('click', function () {
                                            confirmSend(formId);
                                        });

                                listItem.append(warrantyButton);
                                serialNumberList.append(listItem);
                            });

                            $('#productName').text(response.product.title);
                            $('#serialNumberModal').modal('show');
                        } else {
                            console.error('Error: Empty response');
                        }
                    },
                    error: function (xhr, status, error) {
                        console.error('Error fetching serial numbers:', error);
                    }
                });
            }

            function confirmSend(formId) {
                // Hiển thị hộp thoại xác nhận
                if (confirm('Are you sure you want to create a warranty request?')) {
                    // Nếu người dùng chọn OK, gửi form
                    $('#' + formId).submit();
                } else {
                    // Người dùng đã hủy bỏ yêu cầu
                    console.log('Warranty request cancelled');
                }
            }

            function closeModal() {
                $('#serialNumberModal').modal('hide');
            }
        </script>
    </head>
    <body>

        <jsp:include page="header.jsp"/>
        <div class="container-fluid">
            <div class="container">
                <div class="modal-header">
                    <div style="margin-bottom: 1%; text-align: right;">
                        <a href="orderlist"><i class="fa-solid fa-backward"></i></a>
                    </div>
                </div>
                <div class="modal-body">
                    <div class="text-center mb-3">
                        <h3 class="mb-1">BLAZO GAS/STOVE ONLINE STORE</h3>
                        <p>Address: 1 Trung Hoa Street, Cau Giay, Ha Noi</p>
                        <p>Tel: 097894859990</p>
                    </div>
                    <div class="d-flex justify-content-between mb-3">
                        <h3 id="orderid">ORDER: #${order.getOrderId()}</h3>
                        <p id="orderdate">Date: ${order.getOrderDate()}</p>
                    </div>
                    <h6>CUSTOMER INFO</h6>
                    <p id="customername">Customer: ${sessionScope.user.first_name} ${sessionScope.user.last_name} </p>
                    <p id="ordertel">Tel: ${sessionScope.user.phone_number}</p>
                    <p id="orderaddress1">Address 1: ${sessionScope.user.address_line1}</p>
                    <p id="orderaddress2">Address 2: ${sessionScope.user.address_line2}</p>
                    <hr>
                    <h6>ORDER INFORMATION</h6>
                    <p class="mb-2"><em>Price Unit: VNĐ</em></p>
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>Product</th>
                                    <th>Price/Item</th>
                                    <th>Quantity</th>
                                        <c:if test="${order.status == 3}">
                                        <th>
                                            Action
                                        </th>
                                    </c:if>
                                </tr>
                            </thead>
                            <tbody id="tableBodyOrder">
                                <c:forEach items="${requestScope.orderItems}" var="oi">
                                    <tr>
                                        <td>${oi.getOrderItemId()}</td>
                                        <td><a class="menu-link" href="product?id=${oi.getProductId()}">${oi.getProductTitle()}</a></td>
                                        <td><fmt:formatNumber value="${oi.getPrice()}" type="number" maxFractionDigits="2" minFractionDigits="2"/></td>
                                        <td>${oi.getQuantity()}</td>
                                        <c:if test="${order.status == 3}">
                                            <td>
                                                <button class="btn btn-success me-2" data-bs-toggle="modal" data-bs-target="#serialNumberModal" onclick="loadSerialNumbers('${oi.getProductId()}', '${oi.getOrderItemId()}')">
                                                    <i class="bi bi-shield-plus"></i> Serial Number
                                                </button>
                                            </td>
                                        </c:if>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <p class="text-right" id="totalPrice">Total: <fmt:formatNumber value="${order.getTotalPrice()}" type="number" maxFractionDigits="2" minFractionDigits="2"/>&#8363;</p>
                    </div>
                    <div class="text-center mt-3">
                        <button class="btn btn-primary me-2" id="pdf_export" onclick="exportOrder()"><i class="bi bi-file-earmark-pdf"></i> Export to PDF</button>
                        <c:if test="${(order.status ne 3) || (order.status eq 1)}">
                            <button class="btn btn-danger" id="reject_order" onclick="rejectOrder()"><i class="bi bi-x"></i> Reject Order</button>
                            <form id="formReject" action="rejectorder" method="post">
                                <input type="hidden" name="rejectorderid" value="${order.getOrderId()}"/>
                            </form>
                        </c:if>
                    </div>
                    <p>
                        <strong>Status:</strong>
                        <c:if test="${order.getStatus() eq 1}">Rejected</c:if>
                        <c:if test="${order.getStatus() eq 2}">Delivering</c:if>
                        <c:if test="${order.getStatus() eq 3}">Done</c:if>
                        </p>
                    </div>
                </div>
            </div>
            <!-- Modal -->
            <div class="modal fade" id="serialNumberModal" tabindex="-1" aria-labelledby="serialNumberModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title text-black" id="serialNumberModalLabel">Product Serial Numbers</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" onclick="closeModal()"></button>
                        </div>
                        <div class="modal-body">
                            <h6 id="productName" style="font-weight: bold;"></h6>
                            <ul id="serialNumberList">
                                <!-- Serial numbers will be populated here -->
                            </ul>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="closeModal()">Close</button>
                        </div>
                    </div>
                </div>
            </div>

        <jsp:include page="footer.jsp"/>
        <script>
//            function exportOrder() {
//                const {jsPDF} = window.jspdf;
//
//                html2canvas(document.querySelector('.container'), {scale: 2}).then(canvas => {
//                    const imgData = canvas.toDataURL('image/png');
//                    const pdf = new jsPDF('p', 'px', [canvas.width, canvas.height]);
//
//                    pdf.addImage(imgData, 'PNG', 0, 0, canvas.width, canvas.height);
//
//                    pdf.setFontSize(12);
//                    pdf.text(12, 15, 'Order ID: #12345');
//                    pdf.text(15, 20, 'Order Date: 2022-12-01');
//                    pdf.text(15, 30, 'Customer: John Doe');
//                    pdf.text(15, 40, 'Total Price: $250.00');
//                    // Thêm nội dung khác tương tự
//
//                    pdf.save('order_details.pdf');
//                });
//            }
            async function exportOrder() {
                // Hide elements that should not be included in the PDF
                const actionColumns = document.querySelectorAll('#tableBodyOrder .action-column');
                const buttons = document.querySelectorAll('#tableBodyOrder .btn');
                const exportButton = document.getElementById('pdf_export');
                const navigationLink = document.querySelector('.modal-header a');

                // Temporarily hide the buttons, action columns, and navigation link
                actionColumns.forEach(column => column.style.display = 'none');
                buttons.forEach(button => button.style.display = 'none');
                if (exportButton)
                    exportButton.style.display = 'none';
                if (navigationLink)
                    navigationLink.style.display = 'none';

                // Use html2canvas to capture the HTML content
                const element = document.querySelector('.container');
                const canvas = await html2canvas(element);
                const imgData = canvas.toDataURL('image/png');

                // Create a new PDF document
                const {jsPDF} = window.jspdf;
                const pdf = new jsPDF('p', 'mm', 'a4');

                // Add the image to the PDF
                const imgWidth = 210; // A4 width in mm
                const pageHeight = 295; // A4 height in mm
                const imgHeight = canvas.height * imgWidth / canvas.width;
                let heightLeft = imgHeight;
                let position = 0;

                pdf.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);
                heightLeft -= pageHeight;

                // Add a new page if necessary
                while (heightLeft >= 0) {
                    position = heightLeft - imgHeight;
                    pdf.addPage();
                    pdf.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);
                    heightLeft -= pageHeight;
                }

                // Save the PDF
                pdf.save('order.pdf');

                // Show hidden elements again
                actionColumns.forEach(column => column.style.display = 'table-cell');
                buttons.forEach(button => button.style.display = 'inline-block');
                if (exportButton)
                    exportButton.style.display = 'inline-block';
                if (navigationLink)
                    navigationLink.style.display = 'inline-block';
            }
            function rejectOrder() {
                if (confirm('Are you sure to reject this order ?')) {
                    document.getElementById('formReject').submit();
                }
            }
        </script>
        <script>
            function submitOrder() {
                alert('Your package will deliver soon');
                // Optionally redirect to a confirmation page or update UI
            }
        </script>
    </body>
</html>

