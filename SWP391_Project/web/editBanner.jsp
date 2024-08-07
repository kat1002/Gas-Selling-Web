<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="com.model.News" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>
<!DOCTYPE html>
<html>

    <head>
        <title>BLAZO | NEWS</title>
        <link rel="icon" href="media/icon/icons8-news-48.png"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link href="CSS/main.css" rel="stylesheet" type="text/css"/>
        <style>
            .center {
                text-align: center;
            }

            .pagination {
                display: inline-block;
            }

            .pagination a {
                color: black;
                float: left;
                padding: 8px 16px;
                text-decoration: none;
                transition: background-color .3s;
                border: 1px solid #ddd;
                margin: 0 4px;
            }

            .pagination a.active {
                background-color: #4CAF50;
                color: white;
                border: 1px solid #4CAF50;
            }

            .pagination a:hover:not(.active) {
                background-color: #ddd;
            }

            .product-card-abc {
                position: relative;
                /* other styles */
            }

            .controls {
                position: absolute;
                top: 3px;
                left: 3px;
                right: -3px;
                width: 100%;
                display: flex;
                justify-content: space-between;
                padding: 10px;
                box-sizing: border-box;
            }

            input[type="checkbox"] {
                transform: scale(2);
                margin: 5px;
            }

            .controls .top-right {
                display: none;
                width: 50px;
                background-color: white;
                text-align: center;
                padding: 5px;
                border: 1px solid #ddd;
            }

            .controls input[type="checkbox"].top-left:checked + .top-right {
                display: inline-block;
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
            }
        </style>
    </head>

    <body>
        <link rel="stylesheet" href="CSS/news.css" />
        <main style="min-height: 500px">
            <a href="manageNews" class="btn-return"><i class="fa-solid fa-backward"></i> Back to manage news</a>
            <p class="title" id="first">Edit Banner</p>

            <div class="menu" style="margin-bottom:20px">
                <form style="width:75%" method="post" action="editBanner" class="search-button">
                    <div style="float:left;min-width:400px ">
                        <input type="text" placeholder="Search news" name="searchName" value="${requestScope.searchName}" />
                        <button type="submit"><i class="fa fa-search"></i></button>
                    </div>
                </form>
            </div>

            <div class="product" style="position: relative;">
                <ul>
                    <!-- Loop to display items with banner not equal to 0 first -->
                    <c:forEach items="${requestScope.listBanner}" var="d">
                        <c:if test="${d.banner ne 0}">
                            <li class="product-card-abc">
                                <a href="news-post?news-id=${d.newsId}">
                                    <img class="abc" src="${d.theme_image}" alt="" />
                                </a>
                                <div class="controls">
                                    <input type="checkbox" class="top-left" id="${d.newsId}" checked>
                                    <span class="top-right">${d.banner}</span>
                                </div>
                                <h4>${d.title}</h4>
                                <p class="grey">${d.createdAt}</p>
                            </li>
                        </c:if>
                    </c:forEach>
                    <!-- Loop to display items with banner equal to 0 next -->
                    <c:forEach items="${requestScope.listNews}" var="d">
                        <c:if test="${d.banner eq 0}">
                            <li class="product-card-abc">
                                <a href="news-post?news-id=${d.newsId}">
                                    <img class="abc" src="${d.theme_image}" alt="" />
                                </a>
                                <div class="controls">
                                    <input type="checkbox" class="top-left" id="${d.newsId}">
                                    <span class="top-right">${d.banner}</span>
                                </div>
                                <h4>${d.title}</h4>
                                <p class="grey">${d.createdAt}</p>
                                <p style="margin-top: 10px; color: black; max-height:147px; overflow:hidden">${d.short_description}</p>
                            </li>
                        </c:if>
                    </c:forEach>
                </ul>
            </div>
        </main>
        <script src="JS/Slide.js"></script>
        <script src="JS/Login.js"></script>
        <script src="JS/Cart.js"></script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const checkboxes = document.querySelectorAll('.controls input[type="checkbox"].top-left');

                checkboxes.forEach(checkbox => {
                    checkbox.addEventListener('change', function () {
                        const newsId = this.id; // Get the ID from the checkbox
                        const isChecked = this.checked ? 1 : 0;

                        // Asynchronous call to update banner status
                        fetch(`/SWP391_Project/updateBanner?id=` + newsId + `&isChecked=` + isChecked, {
                            method: 'GET', // Adjust method as per your server-side requirements
                            headers: {
                                'Content-Type': 'application/json'
                                        // Add any other headers if needed
                            }
                        }).then(response => {
                            // Handle response as needed
                            console.log('Banner status updated successfully');
                            // Reload the page after the fetch request is successful
                            location.reload();
                        }).catch(error => {
                            console.error('Error updating banner status:', error);
                        });
                    });
                });
            });
            
            document.addEventListener('DOMContentLoaded', function () {
                const checkboxes = document.querySelectorAll('.controls input[type="checkbox"].top-left');

                checkboxes.forEach(checkbox => {
                    checkbox.addEventListener('change', function () {
                        const spanElement = this.nextElementSibling;
                        if (this.checked) {
                            spanElement.style.display = 'inline-block';
                        } else {
                            spanElement.style.display = 'none';
                        }
                    });
                });
            });
        </script>
    </body>

</html>