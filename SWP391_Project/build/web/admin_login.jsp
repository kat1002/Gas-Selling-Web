<%-- 
    Document   : Admin_Login
    Created on : May 13, 2024, 12:01:23 PM
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
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
        <link rel="icon" href="media/icon/login.png"/>
        <title>Blazo | Staff Login</title>
    </head>
    <style>
        /* POPPINS FONT */
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap');

        *{
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
            overflow: hidden;
        }
        input:focus, textarea:focus {
            outline: none;
        }
        .wrapper{
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 110vh;
            background: rgba(39, 39, 39, 0.4);
        }
        .nav{
            position: absolute;
            top: 0;
            display: flex;
            justify-content: space-around;
            width: 100%;
            height: 100px;
            line-height: 100px;
            background: linear-gradient(rgba(39,39,39, 0.6), transparent);
            z-index: 100;
        }
        .nav-logo p{
            color: white;
            font-size: 25px;
            font-weight: 600;
        }
        .nav-menu ul{
            display: flex;
        }
        .nav-menu ul li{
            list-style-type: none;
        }
        .nav-menu ul li .link{
            text-decoration: none;
            font-weight: 500;
            color: #fff;
            padding-bottom: 15px;
            margin: 0 25px;
        }
        .link:hover, .active{
            border-bottom: 2px solid #fff;
        }
        .nav-button .btn{
            width: 130px;
            height: 40px;
            font-weight: 500;
            background: rgba(255, 255, 255, 0.4);
            border: none;
            border-radius: 30px;
            cursor: pointer;
            transition: .3s ease;
        }
        .btn:hover{
            background: rgba(255, 255, 255, 0.3);
        }
        #registerBtn{
            margin-left: 15px;
        }
        .btn.white-btn{
            background: rgba(255, 255, 255, 0.7);
        }
        .btn.btn.white-btn:hover{
            background: rgba(255, 255, 255, 0.5);
        }
        .nav-menu-btn{
            display: none;
        }
        .form-box{
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
            width: 512px;
            height: 650px;
            overflow: hidden;
            z-index: 2;
        }
        .login-container{
            position: absolute;
            left: 4px;
            width: 500px;
            display: flex;
            flex-direction: column;
            transition: .5s ease-in-out;
        }
        .register-container{
            position: absolute;
            right: -520px;
            width: 500px;
            display: flex;
            flex-direction: column;
            transition: .5s ease-in-out;
        }
        .top span{
            color: #fff;
            font-size: small;
            padding: 10px 0;
            display: flex;
            justify-content: center;
        }
        .top span a{
            font-weight: 500;
            color: #fff;
            margin-left: 5px;
        }
        header{
            color: #fff;
            font-size: 30px;
            text-align: center;
            padding: 10px 0 30px 0;
        }
        h1{
            text-align: center;
            padding: 10px 0 30px 0;
        }
        .two-forms{
            display: flex;
            gap: 10px;
        }
        .input-field{
            font-size: 15px;
            background: rgba(255, 255, 255, 0.2);
            color: black;
            height: 50px;
            width: 100%;
            padding: 0 10px 0 45px;
            border: none;
            border-radius: 30px;
            outline: none;
            transition: .2s ease;
        }

        .input-field:hover, .input-field:focus{
            background: rgba(255, 255, 255, 0.25);
        }
        ::-webkit-input-placeholder{
            color: black;
        }
        .input-box i{
            position: relative;
            top: -35px;
            left: 17px;
            color: #ffffff;
        }
        .submit{
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
        .submit:hover{
            background: #999999;
            box-shadow: 1px 5px 7px 1px rgba(0, 0, 0, 0.2);
        }
        .two-col{
            display: flex;
            justify-content: space-between;
            color: #fff;
            font-size: small;
            margin-top: 10px;
        }
        .two-col .one{
            display: flex;
            gap: 5px;
        }
        .two label a{
            text-decoration: none;
            color: #fff;
        }
        .two label a:hover{
            text-decoration: underline;
        }
        @media only screen and (max-width: 786px){
            .nav-button{
                display: none;
            }
            .nav-menu.responsive{
                top: 100px;
                display: flex;
            }
            .nav-menu{
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
            .nav-menu ul{
                flex-direction: column;
                text-align: center;
            }
            .nav-menu-btn{
                display: block;
            }

            .nav-menu-btn i{
                font-size: 25px;
                color: #fff;
                padding: 10px;
                background: rgba(255, 255, 255, 0.2);
                border-radius: 50%;
                cursor: pointer;
                transition: .3s;
            }
            .nav-menu-btn i:hover{
                background: rgba(255, 255, 255, 0.15);
            }
        }
        @media only screen and (max-width: 540px) {
            .wrapper{
                min-height: 100vh;
            }
            .form-box{
                width: 100%;
                height: 500px;
            }
            .register-container, .login-container{
                width: 100%;
                padding: 0 20px;
            }
            .register-container .two-forms{
                flex-direction: column;
                gap: 0;
            }


        }
    </style>
    <body>
        <div class="wrapper">


            <div class="form-box">
                <div class="login-container" id="login">
                    <div class="top">
                        <h1 style="color:white" >STAFF LOGIN</h1>
                        <header>SIGN IN</header>
                    </div>
                    <form action="adminlogin?action=login" method="post">
                        <div class="input-box">
                            <input style="color:white" type="text" class="input-field" name="username"  placeholder="Username" required>
                            <i class="bx bx-user"></i>
                        </div>
                        <div class="input-box">
                            <input style="color:white" type="password" class="input-field" name="password"  placeholder="Password" required>
                            <i class="bx bx-lock-alt"></i>
                        </div>
                        <div class="input-box">
                            <input type="submit" class="submit" value="Sign In">
                        </div>
                        <p style ="color :red">${loginerr}</p>
                        <div class="two-col">

                        </div>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>

