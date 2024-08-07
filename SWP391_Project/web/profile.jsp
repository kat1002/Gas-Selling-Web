<%-- 
    Document   : profile
    Created on : May 16, 2024, 5:40:52 AM
    Author     : kat1002
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>BLAZO | PROFILE</title>
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
    </head>
    <body>
        <jsp:include page="header.jsp"/>

        <div class="container mt-7" style="min-height: 500px">
            <div class="row mt-lg-5">
                <div class="col-lg-4 pb-5 mt-lg-5">
                    <div class="author-card pb-3 mt-lg-5">
                        <div class="author-card-profile">
                            <form action="updateImage" method="post" enctype="multipart/form-data" id="newsForm">
                                <div class="author-card-avatar" >
                                    <img  src="${sessionScope.user.getCustomerImage()}" alt="Avatar">
                                </div>
                                <div class="author-card-details">
                                    <h5 class="author-card-name text-lg">${sessionScope.user.getName()}</h5>
                                </div>
                                <input
                                    style="display: none;"
                                    id="fileInput"
                                    type="file"
                                    accept="image/*"
                                    name="image"
                                    required
                                    onchange="this.form.submit()"
                                    />
                                <button style="margin-top: 5px" class="btn btn-style-1 btn-primary" type="button" onclick="document.getElementById('fileInput').click()">
                                    Change Avatar
                                </button>
                            </form>
                        </div>
                    </div>
                    <div class="wizard mt-2">
                        <nav class="list-group list-group-flush">
                            <a class="list-group-item" href="orderlist">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div><i class="fe-icon-shopping-bag mr-1 text-muted"></i>
                                        <div class="d-inline-block font-weight-medium text-uppercase">Orders List</div>
                                    </div>
                                </div>
                            </a><a class="list-group-item active" href="profile"><i class="fe-icon-user text-muted"></i>Profile
                                Settings</a>
                            <a class="list-group-item" href="voucher">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div><i class="fe-icon-heart mr-1 text-muted"></i>
                                        <div class="d-inline-block font-weight-medium text-uppercase">My Vouchers</div>
                                    </div>
                                </div>
                            </a>
                        </nav>
                    </div>
                </div>

                <!-- Profile Settings-->
                <div class="col-lg-8 pb-5">
                    <form class="row mt-lg-5" action="profile" method="post">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="account-fn">First Name</label>
                                <input class="form-control" type="text" id="account-fn" name="firstname"
                                       value="${sessionScope.user.first_name}" required="">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="account-ln">Last Name</label>
                                <input class="form-control" type="text" id="account-ln" name="lastname"
                                       value="${sessionScope.user.last_name}" required="">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="account-email">Email Address</label>
                                <input class="form-control" type="email" id="account-email" value="${sessionScope.user.gmail}"
                                       disabled="">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <%--@declare id="account-phone"--%>
                                <label for="account-phone">Phone Number</label>
                                <input id="account-phone" class="form-control" type="text" name="phone"
                                       placeholder="Phone Number" value="${sessionScope.user.phone_number}">
                                <span id="phone-error" style="color: red; display: none;">Phone number must be 10 characters long</span>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <%--@declare id="account-address1"--%><label for="account-address1">Address 1</label>
                                <input class="form-control" type="text" name="address1" placeholder="Address 1"
                                       value="${sessionScope.user.address_line1}">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <%--@declare id="-account-address2"--%><label for="-account-address2">Address 2</label>
                                <input class="form-control" type="text" name="address2" placeholder="Address 2"
                                       value="${sessionScope.user.address_line2}">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <%--@declare id="account-postalcode"--%>
                                <label for="account-postalcode">Postal Code</label>
                                <input id="account-postalcode" class="form-control" type="text" name="postalcode"
                                       placeholder="Postal Code" value="${sessionScope.user.postal_code}">
                                <span id="postalcode-error" style="color: red; display: none;">Postal code must be 6 characters long</span>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <%--@declare id="account-city"--%><label for="account-city">City</label>
                                <input class="form-control" type="text" name="city" placeholder="City"
                                       value="${sessionScope.user.city}">
                            </div>
                        </div>

                        <!--                customer_type = 1 gui email -->
                        <div class="col-12">
                            <div class="form-group">
                                <label for="account-postalcode">Receive news via email</label>
                                <input type="checkbox" name="receiveEmail" 
                                       value="yes" <c:if test="${sessionScope.user.receiveNotif eq 1}">checked</c:if>>
                                </div>
                            </div>

                            <div class="col-12">
                                <hr class="mt-2 mb-3">
                                <div class="d-flex flex-wrap justify-content-between align-items-center">
                                    <button class="btn btn-style-1 btn-primary" type="submit">Update Profile</button>
                                    <button class="btn btn-style-1 btn-primary" type="button" id="changePasswordButton"
                                            onclick="window.location.href = 'changePassword'">Change password</button>
                                    <button class="btn btn-style-1 btn-primary" type="button"
                                            onclick="window.location.href = '${pageContext.request.contextPath}/logout'">LogOut
                                </button>
                            </div>
                        </div>
                    </form>
                    <c:if test="${requestScope.successupdate != null}">
                        <div class="text-success" name="successupdate"> 
                            <h2>

                                ${successupdate} 
                            </h2>
                        </div>                       
                    </c:if>            
                </div>

            </div>
        </div>


        <jsp:include page="footer.jsp"/>
        <script>
            document.getElementById('account-postalcode').addEventListener('input', function () {
                const postalCodeInput = this;
                const errorMessage = document.getElementById('postalcode-error');

                if (postalCodeInput.value.length !== 6) {
                    errorMessage.style.display = 'block';
                } else {
                    errorMessage.style.display = 'none';
                }
            });


            document.getElementById('account-phone').addEventListener('input', function () {
                const phoneInput = this;
                const errorMessage = document.getElementById('phone-error');

                if (phoneInput.value.length !== 10) {
                    errorMessage.style.display = 'block';
                } else {
                    errorMessage.style.display = 'none';
                }
            });

            document.getElementById('newsForm').addEventListener('submit', function (event) {
                var fileInput = document.getElementById('fileInput');
                var file = fileInput.files[0];
                var fileType = file.type.split('/')[0];

                if (fileType !== 'image') {
                    alert('Please choose an image file.');
                    event.preventDefault(); // Prevent form submission
                }
            });
        </script>
    </body>
</html>
