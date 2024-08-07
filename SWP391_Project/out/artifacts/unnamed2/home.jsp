<%-- 
    Document   : home
    Created on : May 11, 2024, 5:52:39 PM
    Author     : kat1002
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE jsp>
<jsp>

    <head>
        <title>BLAZO | HOME</title>
        <link href="CSS/main.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"/>
        <meta charset="utf-8"/>
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
    </head>

    <body>
    <jsp:include page="header.jsp"/>
    <main>
        <div class="banner-content">
            <a href="news-post.jsp">
                <img src="media/testbanner.png" alt="Banner Image" class="banner-image">
            </a>
        </div>

        <p class="title">Hot Deals</p>
        <div class="product">
            <ul style="width: 100%">
                <c:forEach items="${hotdeals}" var="product">
                    <li class="product-card">
                        <a href="product?id=${product.getProductId()}"><img src="${product.getImages()[0]}" alt=""/></a>
                        <a class="menu-link" href="product?id=${product.getProductId()}">${product.getTitle()}</a>
                        <p class="star">
                            <c:forEach begin="1" end="${product.getReviewsRate()}">
                                <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            </c:forEach>
                            <c:forEach begin="1" end="${5 - product.getReviewsRate()}">
                                <i class="fa-solid fa-star" style="color: #727580"></i>
                            </c:forEach>
                        </p>
                        <p class="stock">In stock</p>
                        <p class="price">$${product.getPrice()}</p>
                    </li>
                </c:forEach>
            </ul>
        </div>
        <p class="title">Best sellers</p>
        <div class="product">
            <ul style="width: 100%">
                <c:forEach items="${bestsellers}" var="product">
                    <li class="product-card">
                        <a href="product?id=${product.getProductId()}"><img src="${product.getImages()[0]}" alt=""/></a>
                        <a class="menu-link" href="product?id=${product.getProductId()}">${product.getTitle()}</a>
                        <p class="star">
                            <c:forEach begin="1" end="${product.getReviewsRate()}">
                                <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            </c:forEach>
                            <c:forEach begin="1" end="${5 - product.getReviewsRate()}">
                                <i class="fa-solid fa-star" style="color: #727580"></i>
                            </c:forEach>
                        </p>
                        <p class="stock">In stock</p>
                        <p class="price">$${product.getPrice()}</p>
                    </li>
                </c:forEach>
            </ul>
        </div>
        <p class="title">NEW ARRIVALS</p>
        <div class="product">
            <ul style="width: 100%">
                <c:forEach items="${newarrivals}" var="product">
                    <li class="product-card">
                        <a href="product?id=${product.getProductId()}"><img src="${product.getImages()[0]}" alt=""/></a>
                        <a class="menu-link" href="product?id=${product.getProductId()}">${product.getTitle()}</a>
                        <p class="star">
                            <c:forEach begin="1" end="${product.getReviewsRate()}">
                                <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            </c:forEach>
                            <c:forEach begin="1" end="${5 - product.getReviewsRate()}">
                                <i class="fa-solid fa-star" style="color: #727580"></i>
                            </c:forEach>
                        </p>
                        <p class="stock">In stock</p>
                        <p class="price">$${product.getPrice()}</p>
                    </li>
                </c:forEach>
            </ul>
        </div>
        <p class="title" id="f-ar">Featured Articles</p>
        <div class="f-ar2">
            <c:forEach begin="1" end="3">
                <div class="card3">
                    <a href=""><img class="pod"
                                    src="media/testbanner.png"
                                    alt=""/></a>
                    <p>
                        <a class="menu-link" href="#">The Best Pedalboards 2023</a>
                    </p>
                    <p class="cmt">
                        There's no easier, neater way to o...<a class="menu-link fix2" href="#">Read more</a>
                    </p>
                </div>
            </c:forEach>

        </div>
        <div class="b-end">
            <div class="card2">
                <p class="icon">
                    <i class="fa-solid fa-truck-ramp-box"></i>
                </p>
                <p class="title2">Reliable Deliveries</p>
                <p class="cmt">Safe and fast shipping</p>
            </div>
            <div class="card2">
                <p class="icon"><i class="fa-solid fa-wallet"></i></p>
                <p class="title2">many incentives</p>
                <p class="cmt">There are several active sales</p>
            </div>
            <div class="card2">
                <p class="icon"><i class="fa-solid fa-tags"></i></p>
                <p class="title2" id="fix">Tax Included</p>
                <p class="cmt">All prices are inclusive of tax</p>
            </div>
            <div class="card2">
                <p class="icon"><i class="fa-solid fa-repeat"></i></p>
                <p class="title2">WARRANTY 30 DAYS</p>
                <p class="cmt">Simple satisfied or refunded</p>
            </div>
        </div>
    </main>
    <jsp:include page="footer.jsp"/>
    <script src="js/Slide.js" type="text/javascript"></script>
    </body>

</jsp>