<%-- 
    Document   : orderlist
    Created on : May 16, 2024, 5:59:12 AM
    Author     : kat1002
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.model.Order" %>
<!DOCTYPE html>
<html>
    <head>
        <title>BLAZO | ORDER</title>
        <link href="CSS/main.css" rel="stylesheet" type="text/css"/>
        <link href="CSS/orderlist.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">

        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <style>
            .mt-6 {
                margin-top: 4.5rem !important;
            }
            .mt-7 {
                margin-top: 6rem !important;
            }
            @media screen and (max-width: 576px){
                .mt-7{
                    margin-top: 8rem !important;
                }
            }
            @media screen and (max-width: 720px){
                .mt-7{
                    margin-top: 8rem !important;
                }
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp" />


        <div class="container mb-4 main-container mt-7">
            <div class="row">
                <div class="col-lg-4 pb-5">
                    <div class="author-card pb-3">
                        <div class="author-card-profile">
                            <div class="author-card-avatar">
                                <img src="https://bootdey.com/img/Content/avatar/avatar1.png" alt="Daniel Adams">
                            </div>
                            <div class="author-card-details">
                                <h5 class="author-card-name text-lg">${sessionScope.user.getName()}</h5><span class="author-card-position">SuperMember</span>
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
                            <a class="list-group-item" href="profile.jsp">Profile Settings</a>
                            <a class="list-group-item" href="voucher.jsp" >
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
                <div class="col-lg-8 pb-5">
                    <!--                    <div class="d-flex justify-content-end pb-3">
                                            <div class="form-inline">
                                                <label class="text-muted mr-3" for="order-sort">Sort Orders</label>
                                                <select class="form-control" id="order-sort">
                                                    <option>All</option>
                                                    <option>Delivered</option>
                                                    <option>In Progress</option>
                                                    <option>Delayed</option>
                                                    <option>Canceled</option>
                                                </select>
                                            </div>
                                        </div>-->
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead>
                                <tr>
                                    <th>${sessionScope.user.id}</th>
                                    <th>Order ID </th>
                                    <th>Date Purchased</th>
                                    <th>Payment Method</th>
                                    <th>Total</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <%
        List<Order> orderList = (List<Order>) request.getAttribute("orderList");
        if (orderList == null) {
            System.out.println("Order list is null"); // Log for debugging
        } else {
            System.out.println("Order List: " + orderList); // Log danh sách orders vào console server
            if (orders.isEmpty()) {
                System.out.println("Order list is empty"); // Log for debugging
            }
        }
        
        if (orderList != null && !orders.isEmpty()) {
            for (Order order : orderList) {%>

                                    <td><%= order.getOrderId()%></td>
                                    <td><%= order.getCustomerId() %></td>
                                    <td><%= order.getTotalPrice() %></td>
                                    <%
                                        }
                                            }else{
                                    %>
                            <h1>No order</h1>
                            <%
                                }
                            %>


                            </tr>


                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="footer.jsp" />

    </body>
</html>
