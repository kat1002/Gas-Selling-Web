<%-- 
    Document   : Admin_Login
    Created on : May 13, 2024, 12:01:23 PM
    Author     : WuanTun
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Login</title>
        <!-- Boxicons CSS -->
        <link href='https://unpkg.com/boxicons@2.1.2/css/boxicons.min.css' rel='stylesheet'>
        <style>
            /* Google Fonts - Poppins */
            @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap');

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Poppins', sans-serif;
            }

            .container {
                height: 100vh;
                width: 100%;
                display: flex;
                align-items: center;
                justify-content: center;
                background-image: linear-gradient(to bottom, rgba(255, 0, 0, 0.1), rgba(255, 0, 0, 0.1));
                background-size: cover;
                background-repeat: no-repeat;
                column-gap: 30px;
            }

            .form {
                position: absolute;
                max-width: 430px;
                width: 100%;
                padding: 30px;
                border-radius: 6px;
                background: #FFF;
            }

            header {
                font-size: 28px;
                font-weight: 600;
                color: #232836;
                text-align: center;
            }

            form {
                margin-top: 30px;
            }

            .field {
                position: relative;
                height: 50px;
                width: 100%;
                margin-top: 20px;
                border-radius: 6px;
            }

            .field input,
            .field button {
                height: 100%;
                width: 100%;
                border: none;
                font-size: 16px;
                font-weight: 400;
                border-radius: 6px;
            }

            .field input {
                outline: none;
                padding: 0 15px;
                border: 1px solid #CACACA;
            }

            .field input:focus {
                border-bottom-width: 2px;
            }

            .eye-icon {
                position: absolute;
                top: 50%;
                right: 10px;
                transform: translateY(-50%);
                font-size: 18px;
                color: #8b8b8b;
                cursor: pointer;
                padding: 5px;
            }

            .field button {
                color: #fff;
                background-color: #ff6666;
                transition: all 0.3s ease;
                cursor: pointer;
            }

            .field button:hover {
                background-color: #016dcb;
            }

            .form-link {
                text-align: center;
                margin-top: 10px;
            }

            .forgot-pass {
                color: black;
            }

            .form-link span,
            .form-link a {
                font-size: 14px;
                font-weight: 400;
                color: #232836;
            }

            .form a {
                color: #0171d3;
                text-decoration: none;
            }

            .form-content a:hover {
                text-decoration: underline;
            }

            @media screen and (max-width: 400px) {
                .form {
                    padding: 20px 10px;
                }
            }
        </style>
    </head>
    <body>
        <section class="container forms">
            <div class="form login">
                <div class="form-content">
                    <header>Admin Login</header>
                    <form action="#">
                        <div class="field input-field">
                            <input type="email" placeholder="Username" class="input">
                        </div>

                        <div class="field input-field">
                            <input type="password" placeholder="Password" class="password">
                            
                        </div>

                        <div class="form-link">
                            <a href="#" class="forgot-pass">Forgot password?</a>
                        </div>

                        <div class="field button-field">
                            <button>Login</button>
                        </div>
                    </form>
                </div>
            </div>
        </section>
    </body>
</html>

