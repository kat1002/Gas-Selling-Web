<%-- 
    Document   : ForgotPassword
    Created on : Jun 3, 2024, 10:07:18 PM
    Author     : WuanTun
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <title>Blazo | Forgot Password</title>
</head>
<style>
    @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;500&display=swap');
</style>
<body>
<div class="login-box">
    <div class="login-header">
        <header>Forget Password</header>
    </div>
    <form action="forgetPassword" method="post">
        <div class="input-box">
            <input type="email" class="input-field" name="email" placeholder="Email" autocomplete="off" required>
        </div>
        <div class="input-submit">
            <button class="submit-btn" id="submit"></button>
            <label for="submit">Send code</label>
        </div>
    </form>
</div>
</body>
<style>

    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: 'Poppins', sans-serif;
    }

    body {
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
        background: #dfdfdf;
    }

    .login-box {
        display: flex;
        justify-content: center;
        flex-direction: column;
        width: 440px;
        height: 480px;
        padding: 30px;
    }

    .login-header {
        text-align: center;
        margin: 20px 0 40px 0;
    }

    .login-header header {
        color: #333;
        font-size: 30px;
        font-weight: 600;
    }

    .input-box .input-field {
        width: 100%;
        height: 60px;
        font-size: 17px;
        padding: 0 25px;
        margin-bottom: 15px;
        border-radius: 30px;
        border: none;
        box-shadow: 0px 5px 10px 1px rgba(0, 0, 0, 0.05);
        outline: none;
        transition: .3s;
    }

    ::placeholder {
        font-weight: 500;
        color: #222;
    }

    .input-field:focus {
        width: 105%;
    }

    .forgot {
        display: flex;
        justify-content: space-between;
        margin-bottom: 40px;
    }

    section {
        display: flex;
        align-items: center;
        font-size: 14px;
        color: #555;
    }

    #check {
        margin-right: 10px;
    }

    a {
        text-decoration: none;
    }

    a:hover {
        text-decoration: underline;
    }

    section a {
        color: #555;
    }

    .input-submit {
        position: relative;
    }

    .submit-btn {
        width: 100%;
        height: 60px;
        background: #222;
        border: none;
        border-radius: 30px;
        cursor: pointer;
        transition: .3s;
    }

    .input-submit label {
        position: absolute;
        top: 45%;
        left: 50%;
        color: #fff;
        -webkit-transform: translate(-50%, -50%);
        -ms-transform: translate(-50%, -50%);
        transform: translate(-50%, -50%);
        cursor: pointer;
    }

    .submit-btn:hover {
        background: #000;
        transform: scale(1.05, 1);
    }

    .sign-up-link {
        text-align: center;
        font-size: 15px;
        margin-top: 20px;
    }

    .sign-up-link a {
        color: #000;
        font-weight: 600;
    }
</style>
</html>
