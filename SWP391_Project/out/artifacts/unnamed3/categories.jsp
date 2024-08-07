<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>
            BLAZO | CATEGORIES
        </title>
        <link rel="stylesheet" href="CSS/categories.css"/>
        <link rel="stylesheet" href="CSS/main.css"/>
        <script src="JS/Cart.js"></script>
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
            .product-list {
                display: flex;
                flex-wrap: wrap;
                justify-content: space-between; /* Cân bằng khoảng cách giữa các cột */
                margin: 0;
                padding: 0;
            }

            .product-card {
                flex: 0 0 calc(23% - 20px);  /* Định rộng chiều rộng của mỗi cột */
                margin-bottom: 20px;
                padding: 5px;  /* Thay đổi padding tùy theo thiết kế */
                box-sizing: border-box;
            }

            @media screen and (max-width: 768px) {
                .product-card {
                    flex: 0 0 calc(48% - 20px);
                }
            }

            @media screen and (max-width: 576px) {
                .column1 {
                    width: 100%;
                }

                .column2 {
                    width: 100%;
                }

                .row {
                    flex-direction: column;
                }

                .product-list {
                    flex-direction: row;
                }
                .product-card {
                    flex: 0 0 calc(100% - 20px);
                }
            }

            .rowproduct{
                display:-webkit-box;
                display:-ms-flexbox;
                display:flex;
                -ms-flex-wrap:wrap;
                flex-wrap:wrap;
                margin-right:-15px;
                margin-left:-15px
            }

            .product-card button {
                background-color: #ffffff; /* Thay đổi màu nền của button tại đây */
                color: #000000; /* Thay đổi màu chữ trên button tại đây */
                border: 1px none #000000; /* Thay đổi màu viền của button tại đây, nếu cần */
                font-size: 14px; /* Thay đổi kích cỡ chữ trên button */
            }
        </style>
        <script>
            function handleCheckbox(checkbox) {
                // Uncheck all other checkboxes
                const checkboxes = document.querySelectorAll('input[type="checkbox"]');
                checkboxes.forEach((cb) => {
                    if (cb !== checkbox) {
                        cb.checked = false;
                    }
                });
            }
        </script>
    </head>

    <body>
        <jsp:include page="header.jsp" />

        <main>
            <p class="title">CATEGORIES</p>
            <div class="row">
                <div class="column1">
                    <div id="categories-refinement-list" class="refinement-list">
                        <h3>Categories</h3>
                        <form action="category" onclick="this.submit()" method="get">
                            <ul class="list">
                                <c:forEach items="${requestScope.categories}" var="category">
                                    <li>
                                        <label class="container">
                                            ${category.getTitle()} <input type="checkbox" name="cid"
                                                   value="${category.getCategoryId()}" 
                                                   ${category.getCategoryId() eq requestScope.cid ? 'checked':''} 
                                                   onclick="handleCheckbox(this)"/>
                                            <span class="checkmark"></span>
                                        </label>
                                    </li>
                                </c:forEach>
                            </ul>
                        </form>
                    </div>
                </div>
                <div class="column2">
                    <div class="rowproduct listproduct">
                        <c:forEach items="${requestScope.products}" var="product">
                            <div class="product-card">
                                <a href="product?id=${product.getProductId()}"><img src="${product.getImages()[0]}" alt="" /></a>
                                <a class="menu-link" href="product.jsp">${product.getTitle()}</a>
                                <p class="star">
                                    <c:forEach begin="1" end = "${product.getReviewsRate()}">
                                        <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                                    </c:forEach>
                                    <c:forEach begin="1" end = "${5 - product.getReviewsRate()}">
                                        <i class="fa-solid fa-star" style="color: #727580"></i>
                                    </c:forEach>
                                </p>
                                <p class="stock">In stock</p>
                                <p class="price">$${product.getPrice()}</p>
                            </div>
                        </c:forEach>
                    </div>
                    <div class="center">
                        <div class="pagination">
<%--                            <c:if test="${page ne 1}">--%>
<%--                                <a href="<c:out value='category?page=${page-1}'/>" class="prev-page">&laquo;</a>--%>
<%--                            </c:if>--%>

<%--                            <c:forEach begin="${1}" end="${requestScope.num}" var="i">--%>
<%--                                <a href="category?page=${i}" class="page-number ${i eq page ? 'active':''}">${i}</a>--%>
<%--                            </c:forEach>--%>
<%--                            --%>
<%--                            <c:if test="${page ne num}">--%>
<%--                                <a href="<c:out value='category?page=${page+1}'/>" class="next-page">&raquo;</a>--%>
<%--                            </c:if>--%>

                            <c:if test="${page ne 1}">
                                <a href="<c:out value='category?cid=${cid}&page=${page-1}'/>" class="prev-page">&laquo;</a>
                            </c:if>

                            <c:forEach begin="${1}" end="${requestScope.num}" var="i">
                                <a href="category?cid=${cid}&page=${i}" class="page-number ${i eq page ? 'active':''}">${i}</a>
                            </c:forEach>

                            <c:if test="${page ne num}">
                                <a href="<c:out value='category?cid=${param.cid}&page=${page+1}'/>" class="next-page">&raquo;</a>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <jsp:include page="footer.jsp" />

        <script src="JS/Login.js"></script>
        <script src="JS/Cart.js"></script>
        <script src="JS/Uncheck.js"></script>
        <!--        <script>
                                    document.addEventListener("DOMContentLoaded", function () {
                                        const paginationLinks = document.querySelectorAll('.pagination a.page-number');
                                        const prevPageLink = document.querySelector('.pagination a.prev-page');
                                        const nextPageLink = document.querySelector('.pagination a.next-page');
                                        let currentPage = 1;
        
                                        paginationLinks.forEach(link => {
                                            link.addEventListener('click', function (event) {
                                                event.preventDefault();
                                                currentPage = parseInt(this.textContent);
                                                updatePaginationLinks(currentPage);
                                                fetchProducts(currentPage);
                                            });
                                        });
        
                                        prevPageLink.addEventListener('click', function (event) {
                                            event.preventDefault();
                                            if (currentPage > 1) {
                                                currentPage--;
                                                updatePaginationLinks(currentPage);
                                                fetchProducts(currentPage);
                                            }
                                        });
        
                                        nextPageLink.addEventListener('click', function (event) {
                                            event.preventDefault();
                                            if (currentPage < paginationLinks.length) {
                                                currentPage++;
                                                updatePaginationLinks(currentPage);
                                                fetchProducts(currentPage);
                                            }
                                        });
        
                                        function updatePaginationLinks(activePage) {
                                            paginationLinks.forEach(link => {
                                                link.classList.remove('active');
                                            });
                                            paginationLinks[activePage - 1].classList.add('active');
                                        }
        
                                        function fetchProducts(page) {
                                            // Replace the URL with your actual API endpoint
                                            fetch(`/categorypagination?page=${page}`)
                                                    .then(response => response.json())
                                                    .then(data => {
                                                        const productContainer = document.querySelector('.listproduct');
                                                        productContainer.innerHTML = '';
                                                        data.products.forEach(product => {
                                                            const productCard = document.createElement('div');
                                                            productCard.className = 'product-card';
                                                            productCard.innerHTML = `
                                <div class="product-card">
                                        <a href="product.jsp"><img src="${product.getImages()[0]}" alt="" /></a>
                                        <a class="menu-link" href="product.jsp">${product.getTitle()}</a>
                                        <p class="star">
        <c:forEach begin="1" end = "${product.getReviewsRate()}">
                                    <i class="fa-solid fa-star" style="color: #9f8a46"></i>
        </c:forEach>
        <c:forEach begin="1" end = "${5 - product.getReviewsRate()}">
                                    <i class="fa-solid fa-star" style="color: #727580"></i>
        </c:forEach>
                            </p>
                            <p class="stock">In stock</p>
                            <p class="price">$${product.getPrice()}</p>
                        </div>
                `;
                                                productContainer.appendChild(productCard);
                                            });
                                        })
                                        .catch(error => {
                                            console.error('Error fetching products:', error);
                                        });
                            }

                            // Initial fetch
                            fetchProducts(currentPage);
                        });
    </script>-->
    </body>

</html>
