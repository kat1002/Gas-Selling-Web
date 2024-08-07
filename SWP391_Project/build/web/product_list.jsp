<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>
            BLAZO | PRODUCT LIST
        </title>
        <link rel="icon" href="media/icon/icons8-gas-64.png"/>
        <link rel="stylesheet" href="CSS/categories.css"/>
        <link rel="stylesheet" href="CSS/main.css"/>
        <script src="JS/Cart.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <style>
            #paginationContainer {
                display: flex;
                align-items: center; /* Align items vertically in the center */
            }

            .page-link {
                margin: 0 5px; /* Optional: Add some spacing between buttons */
            }

            .writeform {
                margin: 0 5px; /* Optional: Add some spacing between input and buttons */
            }

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
            .pagination {
                display: inline-block;
            }

            .pagination button {
                color: black;
                float: left;
                padding: 8px 16px;
                text-decoration: none;
                transition: background-color .3s;
                border: 1px solid #ddd;
                margin: 0 4px;
            }

            .pagination button.active {
                background-color: #4CAF50;
                color: white;
                border: 1px solid #4CAF50;
            }

            .pagination button:hover:not(.active) {
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
            .writeform{
                padding: 10px;
                box-sizing: border-box;
                background: none;
                outline: none;
                resize: none;
                border: 0;
                transition: all 0.3s;
                border-bottom: 3px inset;
            }
            .outofstock {
                font-size: 12px;
                font-weight: 400;
                color: #ef1564;
                margin: 12px 0;
            }
            .arrived-date {
                font-size: 14px;
                color: #555;
                margin-top: 5px;
            }
            .product-card {
                position: relative; /* Đảm bảo phần tử cha có position để con có thể absolute dựa trên nó */
            }
            .product-card .original-price {
                text-decoration: line-through;
                color: #888;
            }

            .product-card .discounted-price {
                color: red;
            }
            .product-card .discount-badge {
                position: absolute;
                top: 10px;
                right: 10px;
                padding: 5px 10px;
                background-color: red;
                color: white;
                font-weight: bold;
                border-radius: 5px;
                transform: rotate(-15deg);
                z-index: 1;
                transition: opacity 0.3s ease; /* Thêm transition cho hiệu ứng mượt */
            }

            .product-card.discount-applied .discount-badge {
                opacity: 1; /* Hiển thị badge khi có discount */
                animation: pulse 1s infinite alternate;
            }

            @keyframes pulse {
                from {
                    transform: scale(1);
                }
                to {
                    transform: scale(1.1);
                }
            }



        </style>
        <script>
            // Kiểm tra và thêm lớp discount-applied nếu có discount
            document.addEventListener("DOMContentLoaded", function () {
                var productCards = document.querySelectorAll(".product-card");
                productCards.forEach(function (card) {
                    if (card.querySelector(".discounted-price")) {
                        card.classList.add("discount-applied");
                    }
                });
            });
//            function showDescription(element) {
//                var description = element.getAttribute('data-description');
//                if (description) {
//                    element.innerHTML = description;
//                }
//            }
//
//            function hideDescription(element) {
//                var title = discounttitle.getDiscount(product.getDiscountId()).getTitle();
//                element.innerHTML = title;
//            }

        </script>


    </head>

    <body>
        <jsp:include page="header.jsp" />

        <main>
            <p class="title">PRODUCT LIST</p>
            <div class="row">
                <div class="column1">
                    <div id="categories-refinement-list" class="refinement-list">

                        <form action="product_list" id="filterCategory" method="get">
                            <h3>Categories</h3>
                            <ul class="list">
                                <li>
                                    <label class="container">
                                        All <input onclick="submitFormAndBuildURL('filterCategory')" type="radio" name="cid"
                                                   value="0"
                                                   ${requestScope.cid eq 0 ? 'checked':''}
                                                   />
                                        <span class="checkmark"></span>
                                    </label>
                                </li>
                                <c:forEach items="${requestScope.categories}" var="category">
                                    <li>
                                        <label class="container">
                                            ${category.getTitle()} <input onclick="submitFormAndBuildURL('filterCategory')" type="radio" name="cid"
                                                   value="${category.getCategoryId()}"
                                                   ${category.getCategoryId() eq requestScope.cid ? 'checked':''}
                                                   />
                                            <span class="checkmark"></span>
                                        </label>
                                    </li>
                                </c:forEach>
                            </ul>
                        </form>
                        <form action="product_list" id="filterStar" method="get">
                            <h3>Filter by star</h3>
                            <select name="star" onchange="submitFormAndBuildURL('filterStar')">
                                <option ${star eq "" ? 'selected':''} value="0">None</option>
                                <option ${star eq "5" ? 'selected':''} value="5">⭐️⭐️⭐️⭐️⭐️ </option>
                                <option ${star eq "4" ? 'selected':''} value="4">⭐️⭐️⭐️⭐️</option>
                                <option ${star eq "3" ? 'selected':''} value="3">⭐️⭐️⭐ </option>
                                <option ${star eq "2" ? 'selected':''} value="2">⭐️⭐ </option>
                                <option ${star eq "1" ? 'selected':''} value="1">⭐ </option>
                                <option ${star eq "Unrated" ? 'selected':''} value="Unrated">Unrated</option> <!-- Corrected value here -->
                            </select>
                        </form>
                        <form action="product_list" id="filterSort" method="get">
                            <br>
                            <h3>Sort by price</h3>
                            <ul class="list">
                                <li>
                                    <label class="container">
                                        <input onclick="submitFormAndBuildURL('filterSort')" type="radio" name="choicesortprice" value="0" ${requestScope.choicesortprice eq 0 ? 'checked':''}>Constant
                                        <span class="checkmark"></span>
                                    </label>
                                </li>
                                <li>
                                    <label class="container">
                                        <input onclick="submitFormAndBuildURL('filterSort')" type="radio" name="choicesortprice" value="1" ${requestScope.choicesortprice eq 1 ? 'checked':''}>Decrease
                                        <span class="checkmark"></span>
                                    </label>
                                </li>
                                <li>
                                    <label class="container">
                                        <input onclick="submitFormAndBuildURL('filterSort')" type="radio" name="choicesortprice" value="2" ${requestScope.choicesortprice eq 2 ? 'checked':''}>Increase
                                        <span class="checkmark"></span>
                                    </label>
                                </li>
                            </ul>
                        </form>
                        <form action="product_list" method="get" id="filterRange">
                            <h3>Found product in price range ($)</h3>
                            <input style="width: 80%;"  step="0.01" type="number" class="writeform" name="fromprice" placeholder="From Price" value="${fromprice}"/>
                            <input style="width: 80%;"  step="0.01" type="number" class="writeform" name="toprice" style="margin-top:1%;" placeholder="To Price" value="${toprice}"/>
                            <button onclick="submitFormAndBuildURL('filterRange')"><i class="fa fa-search"></i></button>
                        </form>
                        <form action="product_list" method="get" id="filterSearch">

                            <h3>Search items</h3>
                            <input style="width: 80%;"  type="text" class="writeform" name="search" placeholder="Search" value="${requestScope.search}"/>
                            <button onclick="submitFormAndBuildURL('filterSearch')"><i class="fa fa-search"></i></button>
                        </form>
                        <form action="product_list" method="get" id="filterTime">
                            <h3>Search for products arrival by date</h3>
                            <input style="width: 80%;"  type="date" class="writeform" name="datefrom" value="${datefrom}"/>
                            <input style="width: 80%;"  type="date" class="writeform" name="dateto" value="${dateto}"/>
                            <button><i class="fa fa-search" onclick="submitFormAndBuildURL('filterTime')"></i></button>
                        </form>
                        <form action="product_list" method="get" id="filterNumPage">
                            <h3>Items/ page</h3>
                            <input style="width: 80%;" type="number" class="writeform" value="${requestScope.itemperpage}" min="1" name="itemperpage"/>
                            <button><i class="fa fa-search" onclick="submitFormAndBuildURL('filterNumPage')"></i></button>
                        </form>

                    </div>
                </div>
                <jsp:useBean id="rating" class="com.model.DAO.RateDAO" scope="request"></jsp:useBean>
                    <div class="column2">
                        <div class="rowproduct listproduct" id="content">
                        <c:choose>
                            <c:when test="${requestScope.products.size() > 0}">
                                <c:forEach items="${requestScope.products}" var="product">
                                    <jsp:useBean id="discounttitle" class="com.model.DAO.DiscountDAO" scope="request"></jsp:useBean>
                                        <div class="product-card">
                                            <a href="product?id=${product.getProductId()}"><img src="${product.getImages()[0]}" alt="${product.getTitle()}" title="${product.getTitle()}" /></a>
                                        <a class="menu-link" href="product?id=${product.getProductId()}">${product.getTitle()}</a>
                                        <p class="arrived-date">Arrived: ${product.getCreatedDate()}</p>
                                        <p class="star">
                                            <c:choose>
                                                <c:when test="${product.getReviewsRate() eq 0}">
                                                <p class="price" style="color: red;">Unrated</p>
                                            </c:when>
                                            <c:otherwise>
                                                <c:forEach begin="1" end = "${product.getReviewsRate()}">
                                                    <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                                                </c:forEach>
                                                <c:forEach begin="1" end = "${5 - product.getReviewsRate()}">
                                                    <i class="fa-solid fa-star" style="color: #727580"></i>
                                                </c:forEach>
                                                <p class="arrived-date">(${rating.getRateListByProductId(product.getProductId()).size()})</p>    
                                            </c:otherwise>
                                        </c:choose>

                                        </p>
                                        <c:if test="${product.getStock() > 0}">
                                            <p class="stock">In stock</p>
                                        </c:if>
                                        <c:if test="${product.getStock() <= 0}">
                                            <p class="outofstock">Out of stock</p>
                                        </c:if>
                                        <c:choose>
                                            <c:when test="${product.getDiscountId() ne 0 && discounttitle.getDiscount(product.getDiscountId()) ne null}">
                                                <div class="discount-badge" data-description="${discounttitle.getDiscount(product.getDiscountId()).getDescription()}">
                                                    ${discounttitle.getDiscount(product.getDiscountId()).getTitle()}
                                                </div>
                                                <p class="price original-price" style="text-decoration: line-through;">${product.getPrice()} &#8363;</p>
                                                <p class="price discounted-price" style="color: red;"><fmt:formatNumber value="${product.getPrice() - product.getPrice() * discounttitle.getDiscount(product.getDiscountId()).getDiscountValue()}"
                                                                  type="number"
                                                                  maxFractionDigits="2"
                                                                  minFractionDigits="2" /> &#8363;</p>
                                                </c:when>
                                                <c:otherwise>
                                                <p class="price">${product.getPrice()} &#8363;</p>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <jsp:include page="notsearch_customer.jsp"/>
                            </c:otherwise>
                        </c:choose>

                    </div>
                    <div class="center">
                        <div class="pagination" id="paginationContainer">
                            <button class="page-number" onclick="changePage(1)" ${page le 1 ? 'disabled':''}>First</button>
                            <button class="page-number" onclick="changePage(${page - 1})" ${page le 1 ? 'disabled':''}>Prev</button>
                            <form action="product_list" method="get" id="filterPage" style="display: inline-block;">
                                <input onchange="submitFormAndBuildURL('filterPage')" class="writeform" type="number" value="${page}" name="page" min="1" max="${num}" required="">
                            </form>
                            <button class="page-number" onclick="changePage(${page + 1})" ${page ge num ? 'disabled':''}>Next</button>
                            <button class="page-number" onclick="changePage(${num})" ${page ge num ? 'disabled':''}>Last</button>

                        </div>
                    </div>
                </div>
            </div>
        </main>
        <jsp:include page="footer.jsp" />

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script>
                                //    function handlePageInput() {
                                //        var page = document.querySelector('#filterPage input[name="page"]').value;
                                //        changePage(page);
                                //    }
                                //
                                //    function changePage(page) {
                                //        var currentPage = parseInt(document.querySelector('#filterPage input[name="page"]').value);
                                //
                                //        if (page === 'next') {
                                //            page = currentPage + 1;
                                //        } else if (page === 'prev') {
                                //            page = currentPage - 1;
                                //        }
                                //
                                //        // Ensure page is within valid range
                                //        var maxPage = parseInt(document.querySelector('#filterPage input[name="page"]').getAttribute('max'));
                                //        page = Math.min(Math.max(page, 1), maxPage);
                                //
                                //        // Update the input field with the new page number
                                //        document.querySelector('#filterPage input[name="page"]').value = page;
                                //
                                //        // Call searchProduct function with the updated page number
                                //        searchProduct(page);
                                //    }
                                //
                                //    function searchProduct(page = 1) {
                                //        // Gather all necessary data for the AJAX request
                                //        var cid = document.querySelector('input[name="cid"]:checked').value;
                                //        var choicesortprice = document.querySelector('input[name="choicesortprice"]:checked').value;
                                //        var fromprice = document.getElementsByName("fromprice")[0].value;
                                //        var toprice = document.getElementsByName("toprice")[0].value;
                                //        var search = document.getElementsByName("search")[0].value;
                                //        var datefrom = document.getElementsByName("datefrom")[0].value;
                                //        var dateto = document.getElementsByName("dateto")[0].value;
                                //        var itemperpage = document.getElementsByName("itemperpage")[0].value;
                                //
                                //        // Make an AJAX request
                                //        $.ajax({
                                //            url: "/SWP391_Project/product_list_handle",
                                //            type: "get",
                                //            data: {
                                //                cid: cid,
                                //                choicesortprice: choicesortprice,
                                //                fromprice: fromprice,
                                //                toprice: toprice,
                                //                search: search,
                                //                datefrom: datefrom,
                                //                dateto: dateto,
                                //                itemperpage: itemperpage,
                                //                page: page
                                //            },
                                //            success: function (data) {
                                //                // Update the content area with the received data
                                //                var row = document.getElementById("content");
                                //                row.innerHTML = data;
                                //            },
                                //            error: function (xhr) {
                                //                // Handle errors here
                                //                console.log("Error:", xhr.statusText);
                                //            }
                                //        });
                                //    }
        </script>

        <script>
            function changePage(newPage) {
                // Get the current URL and its search parameters
                var url = new URL(window.location.href);

                // Update the page parameter
                url.searchParams.set('page', newPage);

                // Redirect to the updated URL
                window.location.href = url.toString();
            }

            function submitFormAndBuildURL(formId) {
                var form = document.getElementById(formId);
                var url = new URL(window.location.href);
                var formData = new FormData(form);

                // Loop through all form inputs
                for (var [key, value] of formData.entries()) {
                    if (value.trim() !== "") {
                        if (value !== '0') {
                            url.searchParams.set(key, value);
                        } else {
                            url.searchParams.delete(key);
                        }
                    } else {
                        url.searchParams.delete(key);
                    }
                }

                // Redirect to the new URL
                window.location.href = url.toString();
            }

            // Add submit event listener to all forms
            document.querySelectorAll('form').forEach(function (form) {
                form.addEventListener('submit', function (event) {
                    event.preventDefault(); // Prevent default form submission
                    submitFormAndBuildURL(form.id); // Call your handler function
                });
            });
        </script>


        <script src="JS/Login.js"></script>
        <script src="JS/Cart.js"></script>
        <script src="JS/Uncheck.js"></script>
    </body>

</html>
