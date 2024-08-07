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
        <title>BLAZO </title>
        <link href="CSS/main.css" rel="stylesheet" type="text/css"/>
        <link href="CSS/profile.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
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
            .btn-return {
            display: inline-block;
            padding: 10px 20px;
            font-size: 16px;
            color: black;
            background-color: white;
            text-align: center;
            text-decoration: none;
            border-radius: 5px;
            position: absolute;
            top: 10px;
            left: 10px;
        </style>
    </head>
    <body>

        <div class="container mt-7" style="min-height: 500px">
            <a href="manageStaff" class="btn-return"><i class="fa-solid fa-backward"></i> Back to manage Staff</a>
            <!-- Profile Settings-->
            <div class="col-lg-12 pb-5">
                <form class="row mt-lg-5" action="editManager?id=${requestScope.manager.managerId}" method="post">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="account-fn">Username Name</label>
                            <input class="form-control" type="text" id="account-fn" name="username"
                                   value="${requestScope.manager.username}"   required="">
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="account-fn">First Name</label>
                            <input class="form-control" type="text" id="account-fn" name="firstname"
                                value="${requestScope.manager.first_name}"   required="">
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="account-ln">Last Name</label>
                            <input class="form-control" type="text" id="account-ln" name="lastname"
                               value="${requestScope.manager.last_name}"    required="">
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="account-email">Email Address</label>
                            <input class="form-control" type="email" id="account-email" name="email"
                               value="${requestScope.manager.email}"    required=""    >
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <%--@declare id="account-phone"--%>
                            <label for="account-phone">Phone Number</label>
                            <input id="account-phone" class="form-control" type="text" name="phone"
                                value="${requestScope.manager.phone_number}"    placeholder="Phone Number">
                            <span id="phone-error" style="color: red; display: none;">Phone number must be 10 characters long</span>
                        </div>
                    </div>
                    
                    <div class="col-12">
                        <div class="form-group">
                            <label for="account-postalcode">Select role:</label>
                            <select name="role">
                                <option <c:if test="${requestScope.manager.role eq 1}">selected</c:if> value="1">Manager</option>
                                <option <c:if test="${requestScope.manager.role eq 2}">selected</c:if> value="2">Sale Staff</option>
                                <option <c:if test="${requestScope.manager.role eq 3}">selected</c:if> value="3">Customer Service Staff</option>
                            </select>
                        </div>
                    </div>

                    <div class="col-12">
                        <hr class="mt-2 mb-3">
                        <div class="d-flex flex-wrap justify-content-between align-items-center">
                            <button class="btn btn-style-1 btn-primary" type="submit">Edit</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

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
        </script>
    </body>
</html>
