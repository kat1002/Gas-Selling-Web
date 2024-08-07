<%-- 
    Document   : User_Login
    Created on : May 13, 2024, 12:01:32 PM
    Author     : WuanTun
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
        <link rel="icon" href="media/icon/login.png"/>
        <title>Blazo | Login & Registration</title>
    </head>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap');
    </style>
    <body>

        <div class="wrapper">
            <nav class="nav" style="margin-bottom:5px">
                <div class="nav-button">
                    <button class="btn white-btn" id="loginBtn" onclick="login()">Sign In</button>
                    <button class="btn" id="registerBtn" onclick="register()">Sign Up</button>
                </div>
            </nav>

            <div class="form-box">
                <div class="login-container" id="login">
                    <div class="top">

                        <span>Don't have an account? <a href="#" onclick="register()">Sign Up</a></span>
                        <header>SIGN IN</header>
                    </div>
                    <form action="login?action=login" method="post">
                        <div class="input-box">
                            <input style="color:white" type="text" class="input-field" name="username" placeholder="Username"
                                   value="${requestScope.username}">
                            <i class="bx bx-user"></i>
                        </div>
                        <div class="input-box">
                            <input style="color:white" type="password" class="input-field" name="password" placeholder="Password"
                                   value="${requestScope.password}">
                            <i class="bx bx-lock-alt"></i>
                        </div>
                        <div class="input-box">
                            <input type="submit" class="submit" value="Sign In">
                        </div>
                        <div class="input-box">

                            <button type="button" class="login-with-google-btn" id="googleLoginBtn">
                                <img src="media/ggicon.png" alt="alt"/>
                                Sign in with Google
                            </button>

                        </div>
                        <p style="color :red">${loginerr}</p>
                        <div class="two-col">
                            <div class="one">
                                <input type="checkbox" id="rememberMe" name="rememberMe"<c:if test="${requestScope.remember eq 'remember'}">checked</c:if>>
                                <label for="rememberMe"> Remember Me</label>
                            </div>
                            <div class="two">
                                <label><a href="forgetPassword">Forgot password?</a></label>
                            </div>
                        </div>
                    </form>
                </div>

                <div class="register-container" id="register">
                    <div class="top">
                        <span>Have an account? <a href="#" onclick="login()">Sign In</a></span>
                        <header>SIGN UP</header>
                        <p style="color: red; font-weight: bold; text-align: center;">${messExist}</p>
                    </div>
                    <form action="login?action=register" method="post">
                        <div  class="input-box">
                            <input style="color:white" type="text" class="input-field" name="username" placeholder="Username" required>
                            <i class="bx bx-user"></i>
                            <p style="color :red">${messUsername}</p>
                        </div>
                        <div class="input-box">
                            <input style="color:white" type="text" class="input-field" name="gmail" placeholder="Gmail" required>
                            <i class="bx bx-envelope"></i>
                            <p style="color :red">${messGmail}</p>

                        </div>
                        <div class="input-box">
                            <input style="color:white" type="text" class="input-field" name="firstname" placeholder="First Name" required>
                            <i class="bx bx-message"></i>
                        </div>
                        <div class="input-box">
                            <input style="color:white" type="text" class="input-field" name="lastname" placeholder="Last Name" required>
                            <i class="bx bx-message"></i>
                        </div>
                        <div class="input-box">
                            <input style="color:white" type="password" class="input-field" name="password" placeholder="Password" required>
                            <i class="bx bx-lock-alt"></i>
                            <p style="color :red">${messPassword}</p>
                        </div>
                        <div class="input-box">
                            <input style="color:white" type="password" class="input-field" name="confirmPassword" placeholder="Confirm Password"
                                   required>
                            <i class="bx bx-lock-alt"></i>
                            <p style="color :red">${messCfpass}</p>
                        </div>
                        <div class="input-box">
                            <input type="submit" class="submit" value="Register">
                        </div>

                        <div class="input-box">
                            <!--                            <button type="button" class="login-with-facebook-btn" id="facebookLoginBtn">
                                                            <img src="media/fbicon.png" alt="alt"/>
                                                            Sign up with Facebook
                                                        </button>-->
                            <button type="button" class="login-with-google-btn" id="googleLoginBtn2">
                                <img src="media/ggicon.png" alt="alt"/>
                                Sign up with Google
                            </button>

                        </div>


                    </form>
                </div>

            </div>

        </div>

        <script>
            var a = document.getElementById("loginBtn");
            var b = document.getElementById("registerBtn");
            var x = document.getElementById("login");
            var y = document.getElementById("register");

            function login() {
                x.style.left = "4px";
                y.style.right = "-520px";
                a.className += " white-btn";
                b.className = "btn";
                x.style.opacity = 1;
                y.style.opacity = 0;
            }

            function register() {
                x.style.left = "-510px";
                y.style.right = "5px";
                a.className = "btn";
                b.className += " white-btn";
                x.style.opacity = 0;
                y.style.opacity = 1;
            }

            window.onload = function () {
                var registerError = "<%= request.getAttribute("registerError") %>";
                if (registerError === "true") { // Check if registerError is "true"
                    register(); // Display register form if there's a registration error
                } else {
                    login(); // Otherwise, display login form
                }
            };

            document.getElementById("googleLoginBtn").onclick = function () {
                window.location.href = "https://accounts.google.com/o/oauth2/auth?scope=profile email&redirect_uri=http://localhost:9999/SWP391_Project/logingg&response_type=code&client_id=454396997334-76vne6juqskdfl83nhkpoc0uusbinadd.apps.googleusercontent.com&approval_prompt=force";
            };

            document.getElementById("googleLoginBtn2").onclick = function () {
                window.location.href = "https://accounts.google.com/o/oauth2/auth?scope=profile email&redirect_uri=http://localhost:9999/SWP391_Project/logingg&response_type=code&client_id=454396997334-76vne6juqskdfl83nhkpoc0uusbinadd.apps.googleusercontent.com&approval_prompt=force";
            };
        </script>

    </body>
    <style>
        /* POPPINS FONT */


        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background: url("media/background.jpg");
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
/*            overflow: hidden;*/
        }

        input:focus, textarea:focus {
            outline: none;
        }

        .wrapper {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 110vh;
            background: rgba(39, 39, 39, 0.4);
        }

        .nav {
            position: absolute;
            top: 0;
            display: flex;
            justify-content: space-around;
            width: 100%;
            height: 100px;
            line-height: 100px;
            background: linear-gradient(rgba(39, 39, 39, 0.6), transparent);
            z-index: 100;
        }
        
        

        .nav-logo p {
            color: white;
            font-size: 25px;
            font-weight: 600;
        }

        .nav-menu ul {
            display: flex;
        }

        .nav-menu ul li {
            list-style-type: none;
        }

        .nav-menu ul li .link {
            text-decoration: none;
            font-weight: 500;
            color: #fff;
            padding-bottom: 15px;
            margin: 0 25px;
        }

        .link:hover, .active {
            border-bottom: 2px solid #fff;
        }

        .nav-button .btn {
            width: 130px;
            height: 40px;
            font-weight: 500;
            background: rgba(255, 255, 255, 0.4);
            border: none;
            border-radius: 30px;
            cursor: pointer;
            transition: .3s ease;
        }

        .btn:hover {
            background: rgba(255, 255, 255, 0.3);
        }

        #registerBtn {
            margin-left: 15px;
        }

        .btn.white-btn {
            background: rgba(255, 255, 255, 0.7);
        }

        .btn.btn.white-btn:hover {
            background: rgba(255, 255, 255, 0.5);
        }

        .nav-menu-btn {
            display: none;
        }

        .form-box {
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
            width: 512px;
            height: 650px;
            overflow: hidden;
            z-index: 2;
        }

        .login-container {
            position: absolute;
            left: 4px;
            width: 500px;
            display: flex;
            flex-direction: column;
            transition: .5s ease-in-out;
        }

        .register-container {
            position: absolute;
            right: -520px;
            width: 500px;
            display: flex;
            flex-direction: column;
            transition: .5s ease-in-out;
        }

        .top span {
            color: #fff;
            font-size: small;
            padding: 10px 0;
            display: none;
            justify-content: center;
        }

        .top span a {
            font-weight: 500;
            color: #fff;
            margin-left: 5px;
        }

        header {
            color: #fff;
            font-size: 30px;
            text-align: center;
            padding: 30px 0 30px 0;
        }

        .two-forms {
            display: flex;
            gap: 10px;
        }

        .input-field {
            font-size: 15px;
            background: rgba(255, 255, 255, 0.2);
            color: black;
            height: 40px;
            width: 100%;
            padding: 0 10px 0 45px;
            border: none;
            border-radius: 30px;
            outline: none;
            transition: .2s ease;
        }

        .input-field:hover, .input-field:focus {
            background: rgba(255, 255, 255, 0.25);
        }

        ::-webkit-input-placeholder {
            color: black;
        }

        .input-box i {
            position: relative;
            top: -31px;
            left: 17px;
            color: #ffffff;
        }

        .submit {
            font-size: 15px;
            font-weight: 500;
            color: black;
            height: 45px;
            width: 100%;
            border: none;
            border-radius: 30px;
            outline: none;
            background: rgba(255, 255, 255, 0.7);
            cursor: pointer;
            transition: .3s ease-in-out;
        }

        .submit:hover {
            background: #999999;
            box-shadow: 1px 5px 7px 1px rgba(0, 0, 0, 0.2);
        }

        .two-col {
            display: flex;
            justify-content: space-between;
            color: #fff;
            font-size: small;
            margin-top: 10px;
        }

        .two-col .one {
            display: flex;
            gap: 5px;
        }

        .two label a {
            text-decoration: none;
            color: #fff;
        }

        .two label a:hover {
            text-decoration: underline;
        }

        .nav-button {
            display: flex;
            align-items: center;
        }
        .login-with-google-btn {
            display: flex;
            align-items: center;
            font-size: 14px;
            font-weight: 500;
            color: black;
            background: rgba(255, 255, 255, 0.7);
            border: none;
            border-radius: 30px;
            height: 40px;
            width: auto; /* Change width to auto */
            margin-top: 10px;
            margin-left: 2px;
            cursor: pointer;
            transition: background-color .3s, box-shadow .3s;
            position: relative;
        }
        
        .login-with-facebook-btn,
        .login-with-google-btn {
            display: flex;
            align-items: center; /* Căn giữa theo chiều dọc */
            font-size: 14px;
            font-weight: 500;
            color: black;
            background: rgba(255, 255, 255, 0.7);
            border: none;
            border-radius: 30px;
            height: 40px;
            width: 100%;
            margin-top: 10px; /* Khoảng cách từ nút đăng ký */
            margin-left: 2px;
            cursor: pointer;
            transition: background-color .3s, box-shadow .3s;
            position: relative; /* Thêm dòng này */
        }

        .login-with-facebook-btn:hover,
        .login-with-google-btn:hover {
            background-color: #999999;
        }

        .login-with-facebook-btn img,
        .login-with-google-btn img {
            margin-right: 20px;
            margin-left: 25px; /* Khoảng cách giữa hình ảnh và chữ */
            width: 20px;
        }

        .top span a {
            font-weight: bold; /* Để in đậm chữ "Sign In" và "Sign Up" */
            color: #fff;
            margin-left: 5px;
        }

        @media only screen and (max-width: 786px) {
            .nav-button {
                display: none;
            }

            .nav-menu.responsive {
                top: 100px;
                display: flex;
            }

            .nav-menu {
                position: absolute;
                top: 100px;
                display: flex;
                justify-content: center;
                background: rgba(255, 255, 255, 0.2);
                width: 100%;
                height: 90vh;
                backdrop-filter: blur(20px);
                transition: .3s;
                transform: translateY(-100%);
            }
            
            .nav{
                z-index:0;
            }
            
            .top span{
                display:block;
            }

            .nav-menu ul {
                flex-direction: column;
                text-align: center;
            }

            .nav-menu-btn {
                display: block;
            }

            .nav-menu-btn i {
                font-size: 25px;
                color: #fff;
                padding: 10px;
                background: rgba(255, 255, 255, 0.2);
                border-radius: 50%;
                cursor: pointer;
                transition: .3s;
            }

            .nav-menu-btn i:hover {
                background: rgba(255, 255, 255, 0.15);
            }
        }

        @media only screen and (max-width: 540px) {
            .wrapper {
                min-height: 100vh;
            }
            

            .form-box {
                width: 100%;
                height: 500px;
                z-index:1;
            }

            .register-container, .login-container {
                width: 100%;
                padding: 0 20px;
            }

            .register-container .two-forms {
                flex-direction: column;
                gap: 0;
            }

        }
    </style>


</html>
