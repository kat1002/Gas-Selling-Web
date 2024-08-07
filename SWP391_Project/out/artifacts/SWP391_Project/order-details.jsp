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
            padding-top: 120px;
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

    </style>
</head>
<body>

<jsp:include page="header.jsp"/>

<div class="container">
    <%
        // Retrieve the order object from the request
        Order order = (Order) request.getAttribute("order");
        List<OrderItem> orderItems = (List<OrderItem>) request.getAttribute("orderItems");
        // Uncomment the line below to retrieve the customer object if needed
        // Customer customer = (Customer) request.getAttribute("user");
    %>

    <h1>ORDER DETAILS</h1>
    <div class="order-info">
        <p><span>Order ID:</span> <%= order.getOrderId() %>
        </p>
        <p><span>Check In Date:</span> <%= order.getOrderDate() %>
        </p>
        <p><span>Payment Method:</span> <%= order.getPaymentMethodName() %>
        </p>
        <p><span>Total Price:</span> <%= order.getTotalPrice() %>
        </p>
        <p><span>City:</span> <%= order.getCity() %>
        </p>

        <!-- Hiển thị danh sách quantity -->
        <ul>
            <% for (OrderItem item : orderItems) { %>
            <li>Quantity: <%= item.getQuantity() %>
            </li>
            <% } %>
        </ul>


        <td>
            <button onclick="submitOrder()" class="submit-button">Submit order</button>
        </td>
    </div>
</div>


<jsp:include page="footer.jsp"/>
<script>
    function submitOrder() {
        alert('Your package will deliver soon');
        // Optionally redirect to a confirmation page or update UI
    }
</script>
</body>
</html>

