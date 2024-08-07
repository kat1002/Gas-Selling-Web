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

            .custom-select {
                width: 20%;
                padding: 10px 15px;
                font-size: 16px;
                line-height: 1.5;
                color: #495057;
                background-color: #fff;
                background-clip: padding-box;
                border: 1px solid #ced4da;
                border-radius: 0.25rem;
                box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.075);
                transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
                margin-top: 10px;
                float:left;
            }

            .custom-select:focus {
                border-color: #80bdff;
                outline: 0;
                box-shadow: 0 0 5px rgba(128, 189, 255, 0.5);
            }
            .containerSpecial {
                display: flex;
                justify-content: space-between;
                align-items: center;
                width: 50%;
            }
            .label {
                margin-right: 10px; /* Adjust the spacing as needed */
            }
            .select {
                flex-grow: 1; /* This allows the select to take the remaining space */
            }
        </style>
    </head>

    <body>
        <jsp:include page="header.jsp" />
        <link rel="stylesheet" href="CSS/news.css" />
        <main style="min-height: 500px">
                <p class="title" id="first">LATEST NEWS AND ACTIVITIES</p>
<%--            <c:if test="${sessionScope.role eq 0}">
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
            </c:if> --%>
            <div class="menu" style="margin-bottom:20px">
                <form style="width:75%" method="post" action="news" class="search-button" >
                    <div style="height: 100%">
                        <div style="float:left;height: 100%">
                            <div style="height: 100%">
                                <input style="height: 60%" onchange="this.form.submit()" 
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
                    </div>
                    <div class="containerSpecial">
                        <label class="label" for="news">Choose a news category:</label>
                        <select onchange="this.form.submit()" class="select custom-select" id="news" name="newsCate">
                            <option value="all" <c:if test="${requestScope.newsCate eq 'all'}">selected</c:if>>All</option>
                            <c:forEach var="c" items="${requestScope.listNCategory}">
                                <option value="${c}" <c:if test="${requestScope.newsCate eq c}">selected</c:if>>${c}</option>
                            </c:forEach>
                        </select>
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
                                    document.addEventListener("DOMContentLoaded", function () {
                                        const prevPageLink = document.querySelector('.pagination a.prev-page');
                                        const nextPageLink = document.querySelector('.pagination a.next-page');
                                        const productContainer = document.querySelector('.product ul');
                                        const paginationContainer = document.querySelector('.pagination');
                                        var inputElement = document.getElementById("setPageNumber");
                                        const itemsPerPage = parseInt(inputElement.value, 10);
                                        let currentPage = 1;
                                        const totalItems = listNews.length;
                                        let totalPages = Math.ceil(totalItems / itemsPerPage);

                                        function updatePaginationLinks() {
                                            // Clear existing page numbers
                                            paginationContainer.querySelectorAll('.page-number, .page-input').forEach(link => link.remove());

                                            if (totalPages <= 5) {
                                                // Add all page numbers if total pages <= 5
                                                for (let i = 1; i <= totalPages; i++) {
                                                    addPageNumberLink(i);
                                                }
                                            } else {
                                                // Add first 2 pages
                                                for (let i = 1; i <= 2; i++) {
                                                    addPageNumberLink(i);
                                                }

                                                // Add current page with input box
                                                addPageInput(currentPage);

                                                // Add last 2 pages
                                                for (let i = totalPages - 1; i <= totalPages; i++) {
                                                    if (i > 2) {
                                                        addPageNumberLink(i);
                                                    }
                                                }
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

                                            // Attach event listener to input box
                                            const pageInput = document.querySelector('a.page-input input');
                                            if (pageInput) {
                                                pageInput.addEventListener('change', function () {
                                                    const pageNumber = parseInt(this.value);
                                                    if (pageNumber >= 1 && pageNumber <= totalPages) {
                                                        currentPage = pageNumber;
                                                        updatePaginationLinks();
                                                        displayProducts(currentPage);
                                                    }
                                                });
                                            }
                                        }

                                        function addPageNumberLink(page) {
                                            const pageNumberLink = document.createElement('a');
                                            pageNumberLink.href = "#";
                                            pageNumberLink.className = "page-number";
                                            pageNumberLink.textContent = page;
                                            if (page === currentPage) {
                                                pageNumberLink.classList.add('active');
                                            }
                                            paginationContainer.insertBefore(pageNumberLink, nextPageLink);
                                        }

                                        function addPageInput(page) {
                                            const pageInputContainer = document.createElement('a');
                                            pageInputContainer.className = "page-input";
                                            const pageInput = document.createElement('input');
                                            pageInput.type = "number";
                                            if (2 < page && page < totalPages - 1)
                                                pageInput.value = page;
                                            pageInput.min = 1;
                                            pageInput.max = totalPages;
                                            pageInputContainer.appendChild(pageInput);
                                            paginationContainer.insertBefore(pageInputContainer, nextPageLink);
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