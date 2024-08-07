<%-- 
    Document   : profile
    Created on : May 16, 2024, 5:40:52 AM
    Author     : kat1002
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>BLAZO | PROFILE</title>
        <link href="CSS/main.css" rel="stylesheet" type="text/css"/>
        <link href="CSS/profile.css" rel="stylesheet" type="text/css"/>
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

        <div class="container mt-7">
            <div class="row mt-lg-5">
                <div class="col-lg-4 pb-5 mt-lg-5">
                    <div class="author-card pb-3 mt-lg-5">
                        <div class="author-card-profile">
                            <div class="author-card-avatar">
                                <img src="https://bootdey.com/img/Content/avatar/avatar1.png" alt="Daniel Adams">
                            </div>
                            <div class="author-card-details">
                                <h5 class="author-card-name text-lg">Daniel Adams</h5><span class="author-card-position">Joined February 06, 2017</span>
                            </div>
                        </div>
                    </div>
                    <div class="wizard mt-2">
                        <nav class="list-group list-group-flush">
                            <a class="list-group-item" href="orderlist.jsp">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div><i class="fe-icon-shopping-bag mr-1 text-muted"></i>
                                        <div class="d-inline-block font-weight-medium text-uppercase">Orders List</div>
                                    </div><span class="badge badge-secondary">6</span>
                                </div>
                            </a><a class="list-group-item active" href="#"><i class="fe-icon-user text-muted"></i>Profile Settings</a>
                            <a class="list-group-item" href="#"><i class="fe-icon-map-pin text-muted"></i>Addresses</a>
                            <a class="list-group-item" href="https://www.bootdey.com/snippets/view/bs4-wishlist-profile-page" target="__blank">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div><i class="fe-icon-heart mr-1 text-muted"></i>
                                        <div class="d-inline-block font-weight-medium text-uppercase">My Vouchers</div>
                                    </div><span class="badge badge-secondary">3</span>
                                </div>
                            </a>
                        </nav>
                    </div>
                </div>

                <!-- Profile Settings-->
                <div class="col-lg-8 pb-5 ">
                    <form class="row mt-lg-5">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="account-fn">First Name</label>
                                <input class="form-control" type="text" id="account-fn" value="Daniel" required="">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="account-ln">Last Name</label>
                                <input class="form-control" type="text" id="account-ln" value="Adams" required="">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="account-email">E-mail Address</label>
                                <input class="form-control" type="email" id="account-email" value="daniel.adams@example.com" disabled="">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="account-phone">Phone Number</label>
                                <input class="form-control" type="text" id="account-phone" value="+7 (805) 348 95 72" required="">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="account-pass">New Password</label>
                                <input class="form-control" type="password" id="account-pass">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="account-confirm-pass">Confirm Password</label>
                                <input class="form-control" type="password" id="account-confirm-pass">
                            </div>
                        </div>
                        <div class="col-12">
                            <hr class="mt-2 mb-3">
                            <div class="d-flex flex-wrap justify-content-between align-items-center">
                                <div class="custom-control custom-checkbox d-block">
                                    <input class="custom-control-input" type="checkbox" id="subscribe_me" checked="">
                                    <label class="custom-control-label" for="subscribe_me">Subscribe me to Newsletter</label>
                                </div>
                                <button class="btn btn-style-1 btn-primary" type="button" data-toast="" data-toast-position="topRight" data-toast-type="success" data-toast-icon="fe-icon-check-circle" data-toast-title="Success!" data-toast-message="Your profile updated successfuly.">Update Profile</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>


        <jsp:include page="footer.jsp" />

    </body>
</html>
