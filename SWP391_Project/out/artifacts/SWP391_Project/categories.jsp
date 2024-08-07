<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>
            BLAZO | CATEGORIES
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
        </style>
        <script>
//            function handleCheckbox(checkbox) {
//                // Uncheck all other checkboxes
//                const checkboxes = document.querySelectorAll('input[type="checkbox"]');
//                checkboxes.forEach((cb) => {
//                    if (cb !== checkbox) {
//                        cb.checked = false;
//                    }
//                });
//            }
        </script>
    </head>

    <body>
        <jsp:include page="header.jsp" />

        <main>
            <p class="title">CATEGORIES</p>
            <div class="row">
                <div class="column1">
                    <div id="categories-refinement-list" class="refinement-list">

                        <form id="filterProduct" method="get">
                            <h3>Categories</h3>
                            <ul class="list">
                                <li>
                                    <label class="container">
                                        All <input oninput="searchProduct()" type="radio" name="cid"
                                                   value="0"
                                                   ${requestScope.cid eq 0 ? 'checked':''}
                                                   />
                                        <span class="checkmark"></span>
                                    </label>
                                </li>
                                <c:forEach items="${requestScope.categories}" var="category">
                                    <li>
                                        <label class="container">
                                            ${category.getTitle()} <input oninput="searchProduct()" type="radio" name="cid"
                                                   value="${category.getCategoryId()}"
                                                   ${category.getCategoryId() eq requestScope.cid ? 'checked':''}
                                                   />
                                            <span class="checkmark"></span>
                                        </label>
                                    </li>
                                </c:forEach>
                            </ul>
                            <br>
                            <h3>Sort by price</h3>
                            <ul class="list">
                                <li>
                                    <label class="container">
                                        <input oninput="searchProduct()" type="radio" name="choicesortprice" value="0" ${requestScope.choicesortprice eq 0 ? 'checked':''}>Constant
                                        <span class="checkmark"></span>
                                    </label>
                                </li>
                                <li>
                                    <label class="container">
                                        <input oninput="searchProduct()" type="radio" name="choicesortprice" value="1" ${requestScope.choicesortprice eq 1 ? 'checked':''}>Decrease
                                        <span class="checkmark"></span>
                                    </label>
                                </li>
                                <li>
                                    <label class="container">
                                        <input oninput="searchProduct()" type="radio" name="choicesortprice" value="2" ${requestScope.choicesortprice eq 2 ? 'checked':''}>Increase
                                        <span class="checkmark"></span>
                                    </label>
                                </li>
                            </ul>   
                            <!-- Hidden inputs to preserve state -->

<!--                            <input type="hidden" name="fromprice" value="${fromprice}">
                            <input type="hidden" name="toprice" value="${toprice}">
                            <input type="hidden" name="itemperpage" value="${itemperpage}">
                            <input type="hidden" name="search" value="${search}">
                            <input type="hidden" name="page" value="${page}">
                            <input type="hidden" name="datefrom" value="${datefrom}"/>
                            <input type="hidden" name="dateto" value="${dateto}"/>-->
                        </form>
                        <form method="get" id="filterRange">
                            <h3>Found product in price range ($)</h3>
                            <input oninput="searchProduct()"s step="0.01" type="number" class="writeform" name="fromprice" placeholder="From Price" value="${fromprice}"/>
                            <input oninput="searchProduct()" step="0.01" type="number" class="writeform" name="toprice" style="margin-top:1%;" placeholder="To Price" value="${toprice}"/>
<!--                            <button ><i class="fa fa-search"></i></button>-->

                            <!-- Hidden inputs to preserve state -->

<!--                            <input type="hidden" name="choicesortprice" value="${choicesortprice}">
                            <input type="hidden" name="cid" value="${cid}">                            
                            <input type="hidden" name="itemperpage" value="${itemperpage}">
                            <input type="hidden" name="search" value="${search}">
                            <input type="hidden" name="page" value="${page}">
                            <input type="hidden" name="datefrom" value="${datefrom}"/>
                            <input type="hidden" name="dateto" value="${dateto}"/>-->
                        </form>
                        <form method="get" id="filterSearch">
                            <!-- Hidden inputs to preserve state -->

<!--                            <input type="hidden" name="cid" value="${cid}">
                            <input type="hidden" name="choicesortprice" value="${choicesortprice}">
                            <input type="hidden" name="fromprice" value="${fromprice}">
                            <input type="hidden" name="toprice" value="${toprice}">
                            <input type="hidden" name="page" value="${page}">
                            <input type="hidden" name="datefrom" value="${datefrom}"/>
                            <input type="hidden" name="dateto" value="${dateto}"/>-->

                            <h3>Search items</h3>
                            <input oninput="searchProduct()" type="text" class="writeform" name="search" placeholder="Search" value="${requestScope.search}"/>
<!--                            <button ><i class="fa fa-search"></i></button>-->
                        </form>
                        <form method="get" id="filterTime">
                            <h3>Search for products created by date</h3>
                            <input oninput="searchProduct()" type="date" class="writeform" name="datefrom" value="${datefrom}"/>
                            <input oninput="searchProduct()" type="date" class="writeform" name="dateto" value="${dateto}"/>
<!--                            <button ><i class="fa fa-search"></i></button>-->

                            <!-- Hidden inputs to preserve state -->

<!--                            <input type="hidden" name="cid" value="${cid}">
                            <input type="hidden" name="choicesortprice" value="${choicesortprice}">
                            <input type="hidden" name="fromprice" value="${fromprice}">
                            <input type="hidden" name="toprice" value="${toprice}">
                            <input type="hidden" name="search" value="${search}">
                            <input type="hidden" name="page" value="${page}">
                            <input type="hidden" name="itemperpage" value="${itemperpage}">-->
                        </form>
                        <form method="get" id="filterNumPage">
                            <h3>Number of products per page</h3>
                            <input oninput="searchProduct()" type="number" class="writeform" value="${requestScope.itemperpage}" min="1" name="itemperpage"/>
<!--                            <button >Submit</button>-->

                            <!-- Hidden inputs to preserve state -->

<!--                            <input type="hidden" name="cid" value="${cid}">
                            <input type="hidden" name="choicesortprice" value="${choicesortprice}">
                            <input type="hidden" name="fromprice" value="${fromprice}">
                            <input type="hidden" name="toprice" value="${toprice}">
                            <input type="hidden" name="search" value="${search}">
                            <input type="hidden" name="page" value="${page}">
                            <input type="hidden" name="datefrom" value="${datefrom}"/>
                            <input type="hidden" name="dateto" value="${dateto}"/>-->
                        </form>

                    </div>
                </div>
                <div class="column2">
                    <div class="rowproduct listproduct" id="content">
                        
                        <c:forEach items="${requestScope.products}" var="product">
                            <jsp:useBean id="discounttitle" class="com.model.DAO.DiscountDAO" scope="request"></jsp:useBean>
                            <div class="product-card">
                                <a href="product?id=${product.getProductId()}"><img src="${product.getImages()[0]}" alt="" /></a>
                                <a class="menu-link" href="product?id=${product.getProductId()}">${product.getTitle()}</a>
                                <p class="star">
                                    <c:forEach begin="1" end = "${product.getReviewsRate()}">
                                        <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                                    </c:forEach>
                                    <c:forEach begin="1" end = "${5 - product.getReviewsRate()}">
                                        <i class="fa-solid fa-star" style="color: #727580"></i>
                                    </c:forEach>
                                </p>
                                <c:if test="${product.getStock() > 0}">
                                    <p class="stock">In stock</p>
                                </c:if>
                                <c:if test="${product.getStock() <= 0}">
                                    <p class="outofstock">Out of stock</p>
                                </c:if>
                                <c:choose>
                                    <c:when test="${discounttitle.getDiscountByProductId(product.getProductId()).getDiscountValue() > 0}">
                                        <p class="price" style="text-decoration: line-through;">$${product.getPrice()}</p>
                                        <p class="price" style="color: red;">$<fmt:formatNumber value="${product.getPrice() - product.getPrice() * discounttitle.getDiscountByProductId(product.getProductId()).getDiscountValue()}" 
                                                          type="number" 
                                                          maxFractionDigits="2" 
                                                          minFractionDigits="2" /></p>
                                        </c:when>
                                        <c:otherwise>
                                        <p class="price">$${product.getPrice()}</p>
                                    </c:otherwise>
                                </c:choose>                   
                            </div>
                        </c:forEach>
                    </div>
                    <div class="center">
                        <div class="pagination" id="paginationContainer">
                            <%--<c:if test="${page != 1}">
                                <a href="category?cid=${cid}&choicesortprice=${choicesortprice}&fromprice=${fromprice}&toprice=${toprice}&datefrom=${datefrom}&dateto=${dateto}&itemperpage=${itemperpage}&search=${search}&page=1" class="prev-page"><</a>
                            </c:if>
                            <c:if test="${page != 1}">
                                <a href="category?cid=${cid}&choicesortprice=${choicesortprice}&fromprice=${fromprice}&toprice=${toprice}&datefrom=${datefrom}&dateto=${dateto}&itemperpage=${itemperpage}&search=${search}&page=${page - 1}" class="prev-page">&laquo;</a>
                            </c:if>
                            <c:forEach begin="1" end="${num}" var="i">
                                <a href="category?cid=${cid}&choicesortprice=${choicesortprice}&fromprice=${fromprice}&toprice=${toprice}&datefrom=${datefrom}&dateto=${dateto}&itemperpage=${itemperpage}&search=${search}&page=${i}" class="page-number ${i == page ? 'active' : ''}">${i}</a>
                            </c:forEach>
                            <c:if test="${page != num}">
                                <a href="category?cid=${cid}&choicesortprice=${choicesortprice}&fromprice=${fromprice}&toprice=${toprice}&datefrom=${datefrom}&dateto=${dateto}&itemperpage=${itemperpage}&search=${search}&page=${page + 1}" class="next-page">&raquo;</a>
                            </c:if>
                            <c:if test="${page != num}">
                                <a href="category?cid=${cid}&choicesortprice=${choicesortprice}&fromprice=${fromprice}&toprice=${toprice}&datefrom=${datefrom}&dateto=${dateto}&itemperpage=${itemperpage}&search=${search}&page=${num}" class="prev-page">></a>
                            </c:if>
                            <a href="category?cid=${cid}&choicesortprice=${choicesortprice}&fromprice=${fromprice}&toprice=${toprice}&datefrom=${datefrom}&dateto=${dateto}&itemperpage=${requestScope.numbertotalproduct}&search=${search}&" class="prev-page">All</a>--%>
                            <button class="page-number" onclick="changePage(1)">First</button>
                            <button class="page-number" onclick="changePage(${page - 1 > 0 ? page - 1 : 1})">Prev</button>
                            <form method="get" id="filterPage" style="display: inline-block;">
                                <input oninput="handlePageInput()" class="writeform" type="number" value="${page}" name="page" min="1" max="${num}" required=""/>
                            </form>
                            <button class="page-number" onclick="changePage(${page + 1})">Next</button>
                            <button class="page-number" onclick="changePage(${num})">Last</button>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <jsp:include page="footer.jsp" />

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
    function handlePageInput() {
        var page = document.querySelector('#filterPage input[name="page"]').value;
        changePage(page);
    }
    
    function changePage(page) {
        // Update the input field with the new page number
        document.querySelector('#filterPage input[name="page"]').value = page;
        // Call searchProduct function with the updated page number
        searchProduct(page);
    }

    function searchProduct(page = 1) {
        // Gather all necessary data for the AJAX request
        var cid = document.querySelector('input[name="cid"]:checked').value;
        var choicesortprice = document.querySelector('input[name="choicesortprice"]:checked').value;
        var fromprice = document.getElementsByName("fromprice")[0].value;
        var toprice = document.getElementsByName("toprice")[0].value;
        var search = document.getElementsByName("search")[0].value;
        var datefrom = document.getElementsByName("datefrom")[0].value;
        var dateto = document.getElementsByName("dateto")[0].value;
        var itemperpage = document.getElementsByName("itemperpage")[0].value;

        // Make an AJAX request
        $.ajax({
            url: "/SWP391_Project/categoryhandle",
            type: "get",
            data: {
                cid: cid,
                choicesortprice: choicesortprice,
                fromprice: fromprice,
                toprice: toprice,
                search: search,
                datefrom: datefrom,
                dateto: dateto,
                itemperpage: itemperpage,
                page: page
            },
            success: function (data) {
                // Update the content area with the received data
                var row = document.getElementById("content");
                row.innerHTML = data;
            },
            error: function (xhr) {
                // Handle errors here
                console.log("Error:", xhr.statusText);
            }
        });
    }
</script>

        <script>
//            function changePage(newPage) {
//                // Get the current URL and its search parameters
//                var url = new URL(window.location.href);
//                // Update the page parameter
//                url.searchParams.set('page', newPage);
//                // Redirect to the updated URL
//                window.location.href = url.toString();
//            }
//
//            function submitFormAndBuildURL(formId) {
//                var form = document.getElementById(formId);
//                var url = new URL(window.location.href);
//                var formData = new FormData(form);
//                // Loop through all form inputs
//                for (var [key, value] of formData.entries()) {
//                    if (value.trim() !== "") {
//                        if (value !== '0') {
//                            url.searchParams.set(key, value);
//                        } else {
//                            url.searchParams.delete(key);
//                        }
//                    } else {
//                        url.searchParams.delete(key);
//                    }
//                }
//
//                // Redirect to the new URL
//                window.location.href = url.toString();
//            }
//
//// Add submit event listener to all forms
//            document.querySelectorAll('form').forEach(function (form) {
//                form.addEventListener('submit', function (event) {
//                    event.preventDefault(); // Prevent default form submission
//                    submitFormAndBuildURL(form.id); // Call your handler function
//                });
//            });
            
            
//            // Duyệt qua tất cả các form để gọi hàm submitFormAndBuildURL cho mỗi form
//            document.querySelectorAll('form').forEach(function (form) {
//                form.addEventListener('submit', function (event) {
//                    event.preventDefault(); // Ngăn chặn form gửi đi mặc định
//                    submitFormAndBuildURL(form.id); // Gọi hàm xử lý của bạn cho mỗi form
//                });
//            });
//
//
//            function submitFormAndBuildURL(formId) {
//                var form = document.getElementById(formId);
//                var url = new URL(window.location.href);
//                var formData = new FormData(form);
//
//                // Lặp qua tất cả các input của form
//                for (var [key, value] of formData.entries()) {
//                    if (value.trim() !== "") {
////            url.searchParams.set(key, value);
//                        if (value !== '0') {
//                            url.searchParams.set(key, value);
//                        } else {
//                            url.searchParams.delete(key);
//                        }
//                    } else {
//                        if (url.searchParams.has(key)) {
//                            url.searchParams.delete(key);
//                        }
//                    }
//                }
//
//                // Chuyển hướng đến URL mới tùy thuộc vào trạng thái của các tham số
//                if (url.search) {
//                    window.location.href = url.toString();
//                } else {
//                    // Nếu không có tham số query, chuyển hướng đến URL không có tham số
//                    window.location.href = url.pathname;
//                }
//            }
        </script>


        <script src="JS/Login.js"></script>
        <script src="JS/Cart.js"></script>
        <script src="JS/Uncheck.js"></script>
    </body>

</html>
