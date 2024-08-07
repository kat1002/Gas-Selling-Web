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
                /*                overflow: hidden;*/
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
                padding: 15px 16px;
            }
            .topnav div.menu-link{
                float: right;
            }

            .topnav div:not(:first-child):hover {
                background-color: #ddd;
                color: black;
            }

            .topnav div.dropdown-content:hover {
                background-color: #ffa5ab;
                color: black;
            }

            .topnav a.active {
                background-color: #04AA6D;
                color: white;
            }

            .topnav .icon {
                display: none;
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
                z-index: 1000;
            }
            .dropbtn {
                background-color:#ffa5ab;
                color: black;
                height: 70px;
                border: none;
                cursor: pointer;
                font-size: 18px;
                font-weight: 700;

            }

            .dropdown {
                position: relative;
                display: inline-block;
            }

            .dropdown-content {
                left:0;
                display: none;
                position: absolute;
                background-color: #ffa5ab;
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
                background-color: #ddd;
            }

            .dropdown:hover .dropdown-content {
                display: block;
            }

            .dropdown:hover .dropbtn {
                background-color: #ddd;
            }

            .topnav div.right{
                float:right;
            }

            @media screen and (max-width: 1170px) {
                .topnav div:not(:first-child) {
                    display: none;
                }

                .topnav div.menu-link {
                    float: right;
                    display: flex;
                    font-size: 30px;
                    height: 70px;

                }

                .topnav div.menu-link a.icon{
                    display: block;
                    font-size: 28px;
                    padding:0;
                    margin:auto;
                }
                .topnav.responsive {
                    position: relative;
                    height:auto;
                    overflow: hidden;
                }

                .topnav.responsive .menu-link {
                    position: absolute;
                    right: 0;
                    top: 0;
                }

                .topnav.responsive div {
                    float: none;
                    display: block;
                    text-align: left;
                }

                .topnav.responsive div:first-child {
                    display: none;
                }
                .topnav.responsive form {
                    display: none;
                }
                .logo{
                    width: auto;
                }
                .fixed-full-width-div {
                    position:relative;
                }
                .dropdown-content a.cate{
                    display:none;
                }
                .topnav div.right{
                    float:none;
                }
                /*                .topnav.responsive div.menu-link{
                                    display:none;
                                }*/
            }
        </style>
    </head>

    <header class="fixed-full-width-div">
        <div  class="topnav" id="myTopnav">
            <div><a href="home"><img class="logo" src="media/LOGO.png" alt="logo" /></a></div>
            <c:forEach var="d" items="${sessionScope.header}">
                
                    <c:if test="${d.title ne 'PRODUCTS'}">
                        <div><a href="${d.description}">${d.title}</a></div>
                    </c:if>
                    <c:if test="${d.title eq 'PRODUCTS'}">
                        <div class="dropdown">
                            <button onclick="productRedirect()" class="dropbtn">PRODUCTS</button>
                            <div class="dropdown-content">
                                <c:forEach var="e" items="${sessionScope.categoryTitle}">
                                    <a class="cate" href="category">${e.title}</a>
                                </c:forEach>
                            </div>
                        </div>
                    </c:if>
            </c:forEach>


            <div class="right">
<%--                <a>${sessionScope.user} asfasf</a>--%>
                <c:if test="${sessionScope.user == null}">
                    <a href = "login_system.jsp" >
                        <i class="fa-solid fa-user"></i> Login
                    </a>
                </c:if>

                <c:if test="${sessionScope.user != null}">
                    <a href = "profile">
                        <i class="fa-solid fa-user"></i> ${sessionScope.user.getName()}
                    </a>
                </c:if>
            </div>
            <div class="right">
                <a href = "cart">
                    <i class="fa-solid fa-cart-shopping"></i> My Cart
                </a>
            </div>
            <div class="menu-link">
                <a href="javascript:void(0);" class="icon" onclick="headerFunction()">
                    <i class="fa fa-bars"></i>
                </a> 
            </div>
            <form  class="search-button">
                <input type="text" placeholder="Search..." />
                <button><i class="fa fa-search"></i></button>
            </form>
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
        function productRedirect() {
            window.location.href = "category";
        }
    </script>

</html>
