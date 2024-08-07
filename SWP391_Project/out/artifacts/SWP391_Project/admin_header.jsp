<%-- 
    Document   : header.jsp
    Created on : May 11, 2024, 5:52:28 PM
    Author     : kat1002
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <link href="CSS/header.css" rel="stylesheet" type="text/css"/>
        <link href="CSS/main.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <style>
            body {
                margin: 0;

            }

            .topnav {
                
                background-color:#ffa5ab;
                height: 70px;
                /*                width: 100%*/
            }

            .topnav>div {
                float: left;
                display: block;
                text-align: center;
                padding: 0px 12px;
                color: black;
                text-decoration: none;
                font-size: 18px;
                font-weight: 700;
                box-sizing: border-box;
            }

            /*            .topnav div.dropdown {
                                padding: 25px 0px;          
                        }*/

            .topnav>div>a{
                color: black;
                text-decoration: none;
                font-size: 18px;
                font-weight: 700;
                line-height: 70px;
                padding: 20px 0px;
            }


            .topnav form {
                float: right;
                display: block;
                padding: 14px 16px;
                line-height: 70px;
            }
            .topnav div.menu-link{
                float: right;
            }

            .topnav div:not(:first-child):hover {
                background-color: #ddd;
                color: black;
            }

            .topnav a.active {
                background-color: #04AA6D;
                color: white;
            }

            .topnav .icon {
                display: none;
            }

            @media screen and (max-width: 1170px) {
                .topnav div:not(:first-child) {
                    display: none;
                }

                .topnav div.menu-link {
                    float: right;
                    display: block;
                    font-size: 30px;
                    height: 70px;
                }
                .topnav a.icon i {
                    line-height: 70px;
                }


            }

            @media screen and (max-width: 1170px) {
                .topnav.responsive {
                    position: relative;
                    height:auto;
                }


                .topnav.responsive .icon {
                    position: absolute;
                    right: 0;
                    top: 0;
                }

                .topnav.responsive a:first-child {
                    display: none;
                }
                .topnav.responsive form {
                    display: none;
                }
                .topnav.responsive a {
                    float: none;
                    display: block;
                    text-align: left;
                }
                .logo{
                    width: auto;
                }
                .fixed-full-width-div {
                    position:relative;

                }
            }


            .fixed-full-width-div {
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                width: 100%;
                height: 70px;
                margin: 0 0 10px 0;
                box-sizing: border-box;
                z-index:1000;
            }
            .dropbtn {
                background-color: #4CAF50;
                color: white;
                padding: 16px;
                font-size: 16px;
                border: none;
                cursor: pointer;
            }

            .dropdown {
                position: relative;
                display: inline-block;
            }

            .dropdown-content {
                display: none;
                position: absolute;
                background-color: #f9f9f9;
                min-width: 160px;
                box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
                z-index: 1;
            }

            .dropdown-content a {
                color: black;
                padding: 12px 16px;
                text-decoration: none;
                display: block;
                
            }

            .dropdown-content a:hover {
                background-color: #f1f1f1
            }

            .dropdown:hover .dropdown-content {
                display: block;
            }

            .dropdown:hover .dropbtn {
                background-color: #3e8e41;
            }
        </style>
    </head>

    <header class="fixed-full-width-div">

        <div  class="topnav" id="myTopnav">
            <div class="dropdown">
                <button class="dropbtn">Dropdown</button>
                <div class="dropdown-content">
                    <a href="#">Link 1</a>
                    <a href="#">Link 2</a>
                    <a href="#">Link 3</a>
                </div>
            </div>
        </div>
        <div class="dropdown">
            <button class="dropbtn">Dropdown</button>
            <div class="dropdown-content">
                <a href="#">Link 1</a>
                <a href="#">Link 2</a>
                <a href="#">Link 3</a>
            </div>
        </div>

    </header>

    <script>
        function headerFunction() {
            var x = document.getElementById("myTopnav");
            if (x.className === "topnav") {
                x.className += " responsive";
            } else {
                x.className = "topnav";
            }
        }
    </script>

</html>
