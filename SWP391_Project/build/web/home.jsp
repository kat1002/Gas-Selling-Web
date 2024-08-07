<%-- 
    Document   : home
    Created on : May 11, 2024, 5:52:39 PM
    Author     : kat1002
--%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE jsp>
<html>

    <head>
        <meta charset="utf-8"/>
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <title>BLAZO | HOME</title>
        <link rel="icon" href="media/icon/imageshomepage.png">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"/>
        <link rel="stylesheet" href="CSS/main.css"/>
        <style>
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
        </script>
    </head>

    <body>
        <jsp:include page="header.jsp"/>
        <jsp:useBean id="rating" class="com.model.DAO.RateDAO" scope="request"></jsp:useBean>
            <main>
                <div class="slideshow-container" style="width: 90%">

                <c:forEach var="d" items="${requestScope.listBanner}">
                    <div class="mySlides fade">
                        <a href="news-post?news-id=${d.newsId}">
                            <img src="${d.theme_image}" style="width:100%;height: 50%">
                        </a>
                    </div>
                </c:forEach>

                <a class="prev" onclick="manualSlideChange(-1)">❮</a>
                <a class="next" onclick="manualSlideChange(1)">❯</a>
<%--                <c:if test="${sessionScope.role eq 0 }">
                    <a href="editBanner" class="edit-link">
                        <i class="fa-regular fa-pen-to-square"></i>
                        <h3>Edit</h3>
                    </a>
                </c:if> --%>
            </div>
            <br>

            <div style="text-align:center">
                <c:forEach var="d" items="${requestScope.listBanner}">
                    <span class="dot" ></span> 
                </c:forEach>
            </div>


            <jsp:useBean id="discounttitle" class="com.model.DAO.DiscountDAO" scope="request"></jsp:useBean>
                <p class="title">Hot Deals</p>
                <div class="product">
                    <ul style="width: 100%">
                    <c:forEach items="${hotdeals}" var="product">

                        <li class="product-card">
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
                                    <p class="price discounted-price" style="color: red;">$<fmt:formatNumber value="${product.getPrice() - product.getPrice() * discounttitle.getDiscount(product.getDiscountId()).getDiscountValue()}"
                                                      type="number"
                                                      maxFractionDigits="2"
                                                      minFractionDigits="2" />&#8363;</p>
                                    </c:when>
                                    <c:otherwise>
                                    <p class="price">${product.getPrice()} &#8363;</p>
                                </c:otherwise>
                            </c:choose>
                        </li>
                    </c:forEach>
                </ul>
            </div>
            <p class="title">Best sellers</p>
            <div class="product">
                <ul style="width: 100%">
                    <c:forEach items="${bestsellers}" var="product">
                        <li class="product-card">
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
                                    <p class="price discounted-price" style="color: red;">$<fmt:formatNumber value="${product.getPrice() - product.getPrice() * discounttitle.getDiscount(product.getDiscountId()).getDiscountValue()}"
                                                      type="number"
                                                      maxFractionDigits="2"
                                                      minFractionDigits="2" />&#8363;</p>
                                    </c:when>
                                    <c:otherwise>
                                    <p class="price">${product.getPrice()} &#8363;</p>
                                </c:otherwise>
                            </c:choose>
                        </li>
                    </c:forEach>
                </ul>
            </div>
            <p class="title">NEW ARRIVALS</p>
            <div class="product">
                <ul style="width: 100%">
                    <c:forEach items="${newarrivals}" var="product">
                        <li class="product-card">
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
                                    <p class="price discounted-price" style="color: red;">$<fmt:formatNumber value="${product.getPrice() - product.getPrice() * discounttitle.getDiscount(product.getDiscountId()).getDiscountValue()}"
                                                      type="number"
                                                      maxFractionDigits="2"
                                                      minFractionDigits="2" /> &#8363;</p>
                                    </c:when>
                                    <c:otherwise>
                                    <p class="price">${product.getPrice()} &#8363;</p>
                                </c:otherwise>
                            </c:choose>
                        </li>
                    </c:forEach>
                </ul>
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
    </body>
    <script>
        let slideIndex = 1;
        let slideInterval;

        function plusSlides(n) {
            showSlides(slideIndex += n);
        }

        function showSlides(n) {
            let i;
            let slides = document.getElementsByClassName("mySlides");
            let dots = document.getElementsByClassName("dot");
            if (n > slides.length) {
                slideIndex = 1
            }
            if (n < 1) {
                slideIndex = slides.length
            }
            for (i = 0; i < slides.length; i++) {
                slides[i].style.display = "none";
            }
            for (i = 0; i < dots.length; i++) {
                dots[i].className = dots[i].className.replace(" active", "");
            }
            slides[slideIndex - 1].style.display = "block";
            dots[slideIndex - 1].className += " active";
        }

        function startSlideInterval() {
            slideInterval = setInterval(function () {
                plusSlides(1);
            }, 5000);
        }

        function resetSlideInterval() {
            clearInterval(slideInterval);
            startSlideInterval();
        }

        function manualSlideChange(n) {
            plusSlides(n);
            resetSlideInterval();
        }

        // Initial call to start the slide show
        showSlides(slideIndex);
        startSlideInterval();
    </script>
</html>