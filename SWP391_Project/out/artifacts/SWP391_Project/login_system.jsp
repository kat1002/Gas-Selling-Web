<%-- 
    Document   : Login
    Created on : May 10, 2024, 5:28:41 PM
    Author     : WuanTun
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Responsive Login and Signup Form</title>

        <!-- CSS -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <!-- Boxicons CSS -->
        <link href='https://unpkg.com/boxicons@2.1.2/css/boxicons.min.css' rel='stylesheet'>

        <style>
            body {
                background: url("media/loginbackground.jpg");
                background-size: cover;
                position: relative;
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
            }
            .overlay {
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: rgba(0, 0, 0, 0.5); /* Adjust the transparency as needed */
                z-index: 1;
            }
            .container {
                position: relative;
                z-index: 2;
            }
            .title h1 {
                text-align: center;
                color: #fff;
                margin-bottom: 40px;
                font-size: 60px; /* Increase font size */
            }
            .login-card {
                padding: 30px;
                border-radius: 10px;
                transition: transform 0.3s;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                width: 100%;
                max-width: 400px;
                color: #fff;
                background-color: rgba(255, 255, 255, 0.9);
                text-decoration: none; /* Ensure no underline for links */
            }
            .login-card:hover {
                transform: scale(1.05);
            }
            .login-card img {
                width: 150px;
                margin-bottom: 20px;
            }
            .login-card .caption {
                font-size: 18px;
                color: #f8f9fa;
            }
            .login-card strong {
                font-size: 24px;
                color: #f8f9fa;
            }
            .login-card a {
                text-decoration: none; /* Remove underline for links */
                color: inherit; /* Ensure color is inherited */
            }
            .equal-height {
                display: flex;
                align-items: stretch;
            }
            .user-card {
                background-color: #ff9999 !important; /* Blue background for user card */
            }
            .admin-card {
                background-color: #ff9999 !important; /* Green background for admin card */
            }
        </style>
    </head>
    <body>
        <div class="overlay"></div>
        <div class="container">
            <div class="title">
                <h1>LOGIN PAGE</h1>
            </div>
            <div class="row justify-content-center align-items-center">
                <div class="equal-height">
                    <div class="col-md-6 col-sm-12 d-flex justify-content-center mb-4 mb-md-0">
                        <a href="user_login.jsp" class="login-card text-center user-card">
                            <img src="media/user.png" alt="Customer Login">
                            <div class="caption">
                                <strong>Customer Login</strong> <br> Login for user and customer
                            </div>
                        </a>
                    </div>
                    <div class="col-md-6 col-sm-12 d-flex justify-content-center mb-4 mb-md-0">
                        <a href="admin_login.jsp" class="login-card text-center admin-card">
                            <img src="media/admin.png" alt="Manager Login">
                            <div class="caption">
                                <strong>Manager Login</strong> <br> Login for Manager
                            </div>
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>





