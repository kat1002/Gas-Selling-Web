<%@ page import="java.text.DecimalFormat" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <title>BLAZO | CART</title>
        <%--    <link href="CSS/cart2.css" rel="stylesheet" type="text/css"/>--%>
        <link href="CSS/main.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"/>
        <meta charset="utf-8"/>
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <link rel="icon" href="media/icon/shopping-cart.png"/>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        <jsp:useBean id="productDAO" class="com.model.DAO.ProductDAO" scope="request"/>
        <jsp:useBean id="categoryDAO" class="com.model.DAO.CategoryDAO" scope="request"/>
        <jsp:useBean id="discountDAO" class="com.model.DAO.DiscountDAO" scope="request"/>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f4f4f4;
            }
            .container {
                max-width: 800px;
                margin: 20px auto;
                padding: 20px;
                background-color: #fff;
                border: 1px solid #ccc;
                border-radius: 5px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            h1 {
                text-align: center;
                margin-bottom: 20px;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }
            th, td {
                padding: 10px;
                border-bottom: 1px solid #ddd;
                text-align: left;
                height: 85px; /* Set a fixed height for all cells */
                vertical-align: middle; /* Vertically center content */
            }
            th {
                background-color: #f2f2f2;
            }
            .total {
                font-weight: bold;
                text-align: right;
            }
            .btn {
                display: inline-block;
                background-color: #4CAF50;
                color: white;
                padding: 8px 10px;
                text-align: center;
                text-decoration: none;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }
            .btn:hover {
                background-color: #45a049;
            }
            .btn.secondary {
                background-color: #f0ad4e;
            }
            .btn.secondary:hover {
                background-color: #eea236;
            }
            .actions {
                text-align: right;
                margin-top: 20px;
            }
            .product-img {
                width: 60px;
                height: 60px;
                margin-right: 10px;
                border-radius: 5px;
            }
            .quantity {
                display: flex;
                align-items: center;
                height: 100%;
            }
            .quantity .btn {
                flex-shrink: 0;
            }
            .quantity input {
                width: 40px;
                text-align: center;
                margin: 0 5px;
                flex-grow: 1;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <main style="min-height: 500px">
            <div class="container">
                <h1>Shopping Cart</h1>
                <table>
                    <thead>
                        <tr>
                            <th>Image</th>
                            <th>Item</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>Total</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${cart_items}" var="p">
                            <tr>
                                <td>
                                    <a class="menu-link" href="product?id=${p.getProductId()}"><img src="${productDAO.getProduct(p.getProductId()).getImages()[0]}" alt="Product 1" class="product-img"></a>
                                </td>
                                <td>
                                    <a class="menu-link" href="product?id=${p.getProductId()}">${productDAO.getProduct(p.getProductId()).getTitle()}</a>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${productDAO.getProduct(p.getProductId()).getDiscountId() ne 0}">
                                            <fmt:formatNumber value="${productDAO.getProduct(p.getProductId()).getPrice() - productDAO.getProduct(p.getProductId()).getPrice() * discountDAO.getDiscount(productDAO.getProduct(p.getProductId()).getDiscountId()).getDiscountValue()}" type="number" minFractionDigits="2" maxFractionDigits="2"/>&#8363;
                                        </c:when>
                                        <c:otherwise>
                                            <fmt:formatNumber value="${productDAO.getProduct(p.getProductId()).getPrice()}" type="number" minFractionDigits="2" maxFractionDigits="2"/>&#8363;
                                        </c:otherwise>
                                    </c:choose>

                                </td>
                                <td class="quantity">
                                    <button type="button" class="btn decrease-btn">-</button>
                                    <input type="number" name="quantity_${p.getItemId()}" min="1" value="${p.getQuantity()}">
                                    <button type="button" class="btn increase-btn">+</button>
                                    <input type="hidden" name="stocklimit" value="${productDAO.getProduct(p.getProductId()).getStock()}"/>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${productDAO.getProduct(p.getProductId()).getDiscountId() ne 0}">
                                            <fmt:formatNumber value="${p.getQuantity() * (productDAO.getProduct(p.getProductId()).getPrice() - productDAO.getProduct(p.getProductId()).getPrice() * discountDAO.getDiscount(productDAO.getProduct(p.getProductId()).getDiscountId()).getDiscountValue())}" type="number" minFractionDigits="2" maxFractionDigits="2"/>&#8363;
                                        </c:when>
                                        <c:otherwise>
                                            <fmt:formatNumber value="${p.getQuantity() * productDAO.getProduct(p.getProductId()).getPrice()}" type="number" minFractionDigits="2" maxFractionDigits="2"/>&#8363;
                                        </c:otherwise>
                                    </c:choose>

                                </td>
                                <td><button type="button" class="btn remove-btn" onclick="window.location.href = 'cart?action=delete&ciid=${p.getItemId()}'"> Remove </button></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                    <tfoot>
                        <tr>
                            <td colspan="4" class="total">Total:</td>
                            <td id="grand-total"><fmt:formatNumber value="${total}" type="number" minFractionDigits="2" maxFractionDigits="2"/>&#8363;</td>
                            <td></td>
                        </tr>
                    </tfoot>
                </table>
                <div class="actions">
                    <button id="save-changes-btn" class="btn secondary" onclick="window.location.href = 'cart?action=update'">Save Changes</button>
                    <a href="checkout" class="btn">Checkout</a>
                </div>
            </div>
        </main>
        <script>
            document.getElementById('save-changes-btn').addEventListener('click', function () {
                const params = new URLSearchParams();
                document.querySelectorAll('tbody tr').forEach(function (row) {
                    const input = row.querySelector('input[type="number"]');
                    const name = input.getAttribute('name');
                    const itemId = name.split('_')[1]; // Extract itemId from the input name attribute
                    const quantity = input.value;
                    params.append(`quantity_` + itemId, quantity);
                });

                // Convert the URLSearchParams to a query string
                const queryString = params.toString();

                // Redirect to the cart update action with the query string
                window.location.href = 'cart?action=update&' + queryString;
            });

            // Function to initialize the event listeners
            function initializeEventListeners() {
                document.querySelectorAll('.quantity').forEach(function (quantity) {
                    var input = quantity.querySelector('input');
                    var decreaseBtn = quantity.querySelector('.decrease-btn');
                    var increaseBtn = quantity.querySelector('.increase-btn');
                    var stockLimit = parseInt(quantity.querySelector('input[name="stocklimit"]').value); // Lấy giá trị ngưỡng số lượng tồn kho
                    decreaseBtn.addEventListener('click', function () {
                        var value = parseInt(input.value);
                        if (value > 1) {
                            input.value = value - 1;
                            updateTotal();
                        } else {
                            alert('The minimum stock is 1, so you cannot reduce !');
                        }
                    });

                    increaseBtn.addEventListener('click', function () {
                        var value = parseInt(input.value);
                        if (value < stockLimit) {
                            input.value = value + 1;
                            updateTotal();
                        } else {
                            alert('Reached the limit of stocks !');
                        }
                    });

                    input.addEventListener('change', function () {
                        updateTotal();
                    });
                });

            }

//            // Function to update the total
//            function updateTotal() {
//                var total = 0;
//                document.querySelectorAll('tbody tr').forEach(function (row) {
//                    var price = parseFloat(row.cells[2].textContent.replace('$', ''));
//                    var quantity = parseInt(row.querySelector('.quantity input').value);
//                    var subtotal = price * quantity;
//                    row.cells[4].textContent = '$' + subtotal.toFixed(2);
//                    total += subtotal;
//                });
//                document.getElementById('grand-total').textContent = '$' + total.toFixed(2);
//            }
            function updateTotal() {
                var total = 0;
                document.querySelectorAll('tbody tr').forEach(function (row) {
                    var priceText = row.cells[2].textContent.replace(/[^0-9.-]+/g, '');
                    var price = parseFloat(priceText.replace(/,/g, ''));
                    var quantity = parseInt(row.querySelector('.quantity input').value);
                    var subtotal = price * quantity * 1000;

                    // Format subtotal to VND with 2 decimal places
                    var formattedSubtotal = new Intl.NumberFormat('vi-VN', {
                        style: 'currency',
                        currency: 'VND',
                        minimumFractionDigits: 2,
                        maximumFractionDigits: 2
                    }).format(subtotal);

                    row.cells[4].textContent = formattedSubtotal; // Set formatted subtotal

                    total += subtotal;
                });

                // Format total to VND with 2 decimal places
                document.getElementById('grand-total').textContent = new Intl.NumberFormat('vi-VN', {
                    style: 'currency',
                    currency: 'VND',
                    minimumFractionDigits: 2,
                    maximumFractionDigits: 2
                }).format(total);
            }

            // Function to observe changes in the DOM and reinitialize event listeners
            function observeDOMChanges() {
                var targetNode = document.querySelector('tbody');
                var observer = new MutationObserver(function (mutationsList) {
                    for (var mutation of mutationsList) {
                        if (mutation.type === 'childList') {
                            initializeEventListeners();
                            updateTotal(); // Update total when new rows are added
                            break;
                        }
                    }
                });
                var config = {childList: true};
                observer.observe(targetNode, config);
            }

            // Initialize event listeners when the DOM content is loaded
            document.addEventListener('DOMContentLoaded', function () {
                initializeEventListeners();
                observeDOMChanges();
            });

        </script>




        <jsp:include page="footer.jsp"/>
    </body>
</html>
