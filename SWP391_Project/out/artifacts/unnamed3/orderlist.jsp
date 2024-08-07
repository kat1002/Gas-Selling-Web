<%-- 
    Document   : orderlist
    Created on : May 16, 2024, 5:59:12 AM
    Author     : kat1002
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>BLAZO | PROFILE</title>
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
                            <div class="author-card-details">
                                <h5 class="author-card-name text-lg">Daniel Adams</h5><span class="author-card-position">Joined February 06, 2017</span>
                            </div>
                        </div>
                    </div>
                    <div class="wizard">
                        <nav class="list-group list-group-flush">
                            <a class="list-group-item active" href="#">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div><i class="fa fa-shopping-bag mr-1 text-muted"></i>
                                        <div class="d-inline-block font-weight-medium text-uppercase">Orders List</div>
                                    </div><span class="badge badge-secondary">6</span>
                                </div>
                            </a><a class="list-group-item" href="https://www.bootdey.com/snippets/view/bs4-profile-settings-page" target="__blank"><i class="fa fa-user text-muted"></i>Profile Settings</a><a class="list-group-item" href="#"><i class="fa fa-map-marker text-muted"></i>Addresses</a>
                            <a class="list-group-item" href="https://www.bootdey.com/snippets/view/bs4-wishlist-profile-page" tagert="__blank">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div><i class="fa fa-heart mr-1 text-muted"></i>
                                        <div class="d-inline-block font-weight-medium text-uppercase">My Wishlist</div>
                                    </div><span class="badge badge-secondary">3</span>
                                </div>
                            </a>
                            <a class="list-group-item" href="#">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div><i class="fa fa-tag mr-1 text-muted"></i>
                                        <div class="d-inline-block font-weight-medium text-uppercase">My Tickets</div>
                                    </div><span class="badge badge-secondary">4</span>
                                </div>
                            </a>
                        </nav>
                    </div>
                </div>
                <!-- Orders Table-->
                <div class="col-lg-8 pb-5">
                    <div class="d-flex justify-content-end pb-3">
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
                    </div>
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead>
                                <tr>
                                    <th>Order #</th>
                                    <th>Date Purchased</th>
                                    <th>Status</th>
                                    <th>Total</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><a class="navi-link" href="#order-details" data-toggle="modal">78A643CD409</a></td>
                                    <td>August 08, 2017</td>
                                    <td><span class="badge badge-danger m-0">Canceled</span></td>
                                    <td><span>$760.50</span></td>
                                </tr>
                                <tr>
                                    <td><a class="navi-link" href="#order-details" data-toggle="modal">34VB5540K83</a></td>
                                    <td>July 21, 2017</td>
                                    <td><span class="badge badge-info m-0">In Progress</span></td>
                                    <td>$315.20</td>
                                </tr>
                                <tr>
                                    <td><a class="navi-link" href="#order-details" data-toggle="modal">112P45A90V2</a></td>
                                    <td>June 15, 2017</td>
                                    <td><span class="badge badge-warning m-0">Delayed</span></td>
                                    <td>$1,264.00</td>
                                </tr>
                                <tr>
                                    <td><a class="navi-link" href="#order-details" data-toggle="modal">28BA67U0981</a></td>
                                    <td>May 19, 2017</td>
                                    <td><span class="badge badge-success m-0">Delivered</span></td>
                                    <td>$198.35</td>
                                </tr>
                                <tr>
                                    <td><a class="navi-link" href="#order-details" data-toggle="modal">502TR872W2</a></td>
                                    <td>April 04, 2017</td>
                                    <td><span class="badge badge-success m-0">Delivered</span></td>
                                    <td>$2,133.90</td>
                                </tr>
                                <tr>
                                    <td><a class="navi-link" href="#order-details" data-toggle="modal">47H76G09F33</a></td>
                                    <td>March 30, 2017</td>
                                    <td><span class="badge badge-success m-0">Delivered</span></td>
                                    <td>$86.40</td>
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
