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


        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
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
        </style>
    </head>

    <body>
        <jsp:include page="header.jsp" />
        <link rel="stylesheet" href="CSS/news.css" />
        <main>
            <c:if test="${sessionScope.role eq 0 }">
                <p class="title" id="first">LATEST NEWS AND ACTIVITIES</p>
            </c:if>
            <c:if test="${sessionScope.role ne 0}">
                <p class="title" id="first">List News</p>
                <div class="img-list-desk">
                    <div class="menu">
                        <a href="add-news-post.jsp" class="news-card" style="text-decoration: none">                            
                            <div style="margin-left: 10px;text-align:center;line-height: 150px; ">
                                <i style="margin-right:10px" class="fa-solid fa-plus"></i>Add News
                            </div >
                        </a>
                    </div>
                </div>
            </c:if>
            <div class="menu" style="margin-bottom:20px">
                <form style="width:75%" method="post" action="news" class="search-button" >
                    <div style="float:left;height: 100%">
                        <div style="height: 100%"><input style="height: 100%" onchange="list()" 
                                                         id="setPageNumber" type="number" name="set-page-number" 
                                                         value="${requestScope.setPageNumber}">
                            News per page
                        </div>
                    </div>
                    <div style="float:right;margin-left: 10rem;min-width:400px ">
                        <input type="text" placeholder="Search news" name="searchName"
                               value="${requestScope.searchName}"/>
                        <button type="submit"><i class="fa fa-search"></i></button>
                    </div>
                </form>
            </div>


            <div class="product" style=" position: relative;">
                <ul>

                </ul>
            </div>


            <div class="center">
                <div class="pagination">
                    <a href="#" class="prev-page">&laquo;</a>
                    <!-- Pagination links will be dynamically added here -->
                    <a href="#" class="next-page">&raquo;</a>
                </div>
            </div>
            <div class="product" style="position: relative;">
                <ul>
                    <!-- Products will be dynamically added here -->
                </ul>
            </div>
        </main>
        <jsp:include page="footer.jsp" />
        <script src="JS/Slide.js"></script>
        <script src="JS/Login.js"></script>
        <script src="JS/Cart.js"></script>
        <%             
            List<News> listNews = (List<News>) request.getAttribute("listNews");

            Gson gson = new GsonBuilder().create();
            String jsonListNews = gson.toJson(listNews);    
        %>
        <script>
                            var listNews = <%= jsonListNews %>;
//            console.log(listNews);
                            document.addEventListener("DOMContentLoaded", function () {
                                const prevPageLink = document.querySelector('.pagination a.prev-page');
                                const nextPageLink = document.querySelector('.pagination a.next-page');
                                const productContainer = document.querySelector('.product ul');
                                const paginationContainer = document.querySelector('.pagination');
                                var inputElement = document.getElementById("setPageNumber");
                                const itemsPerPage = parseInt(inputElement.value, 10);
//                const itemsPerPage = 8;
                                let currentPage = 1;
                                const totalItems = listNews.length;
                                let totalPages = Math.ceil(totalItems / itemsPerPage);

                                function updatePaginationLinks() {
                                    // Clear existing page numbers
                                    paginationContainer.querySelectorAll('.page-number').forEach(link => link.remove());

                                    // Add new page numbers
                                    for (let i = 1; i <= totalPages; i++) {
                                        const pageNumberLink = document.createElement('a');
                                        pageNumberLink.href = "#";
                                        pageNumberLink.className = "page-number";
                                        pageNumberLink.textContent = i;
                                        if (i === currentPage) {
                                            pageNumberLink.classList.add('active');
                                        }
                                        paginationContainer.insertBefore(pageNumberLink, nextPageLink);
                                    }

                                    // Attach event listeners to new page numbers
                                    paginationContainer.querySelectorAll('.page-number').forEach(link => {
                                        link.addEventListener('click', function (event) {
                                            event.preventDefault();
                                            currentPage = parseInt(this.textContent);
                                            updatePaginationLinks();
                                            displayProducts(currentPage);
                                        });
                                    });
                                }

                                prevPageLink.addEventListener('click', function (event) {
                                    event.preventDefault();
                                    if (currentPage > 1) {
                                        currentPage--;
                                        updatePaginationLinks();
                                        displayProducts(currentPage);
                                    }
                                });

                                nextPageLink.addEventListener('click', function (event) {
                                    event.preventDefault();
                                    if (currentPage < totalPages) {
                                        currentPage++;
                                        updatePaginationLinks();
                                        displayProducts(currentPage);
                                    }
                                });

                                function displayProducts(page) {
                                    productContainer.innerHTML = '';
                                    const start = (page - 1) * itemsPerPage;
                                    const end = Math.min(start + itemsPerPage, totalItems);
                                    for (let i = start; i < end; i++) {
                                        const product = listNews[i];
                                        const productCard = document.createElement('li');
                                        productCard.className = 'product-card-abc';
                                        productCard.innerHTML = `
                <a href="news-post?news-id=` + product.newsId + `"><img class="abc" src="` + product.theme_image + `" alt="" /></a>
                <h4>` + product.title + `</h4>
                <p class="grey">` + product.createdAt + `</p>
                <p style="margin-top: 10px; color: black;max-height:147px;overflow:hidden">` + product.short_description + `</p>
            `;
                                        productContainer.appendChild(productCard);
                                    }
                                }

                                // Initial setup
                                updatePaginationLinks();
                                displayProducts(currentPage);
                            });

                            function list() {
                                updatePaginationLinks();
                                displayProducts(currentPage);
                            }

        </script>

    </body>

</html>