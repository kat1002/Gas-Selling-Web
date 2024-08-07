<%-- 
    Document   : ProductDetail
    Created on : May 9, 2024, 10:05:10 PM
    Author     : Acer Nitro 5
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>
            BLAZO | PRODUCT DETAILS
        </title>
        <link rel="icon" href="media/icon/icons8-gas-64.png"/>
        <link rel="stylesheet" href="CSS/product.css" />
        <link rel="stylesheet" href="CSS/main.css" />
        <link rel="stylesheet" href="CSS/review.css">
        <link rel="stylesheet" href="CSS/bootstrap.min.css">

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
        <script src="ckeditor5/ckeditor5-build-classic/ckeditor.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
        <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <!-- jQuery -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>

        <!-- Bootstrap JS -->
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <style>

            /* Rate css*/

            .rated {
                display: flex;
                margin-top: -10px;
            }

            .rated > input {
                display: none;
            }

            .rated > label {
                position: relative;
                font-size: 25px;
                color: gold;
                cursor: default;
            }

            .rated > label::before {
                content: "\2605";
                position: absolute;
                top: 0;
                left: 0;
            }

            .rated > input:checked ~ label {
                color: gold;
            }

            .rated > input:checked ~ label ~ label {
                color: #ddd; /* Màu khi chưa được chọn */
            }
            .form-color {
                display: flex;
                flex-direction: column;
            }
            .d-flex {
                display: flex;
                flex-direction: row;
                align-items: center;
            }
            .form-control {
                flex-grow: 1;
            }

            .rate {
                display: flex;
                flex-direction: row-reverse;
                justify-content: center;
            }

            .rate > input{
                display:none;
            }

            .rate > label {
                position: relative;
                width: 1em;
                font-size: 25px;
                color: gold;
                cursor: pointer;
            }
            .rate > label::before{
                content: "\2605";
                position: absolute;
                opacity: 0;
            }
            .rate > label:hover:before,
            .rate > label:hover ~ label:before {
                opacity: 1 !important;
            }

            .rate > input:checked ~ label:before{
                opacity:1;
            }

            .rate:hover > input:checked ~ label:before{
                opacity: 0.4;
            }



            /* Product css*/

            html, body {
                margin: 0;
                padding: 0;
                height: 100%;
                overflow-x: hidden;
            }

            body {
                display: flex;
                flex-direction: column;
            }

            .button-12 {
                display: flex;
                justify-content: center;
            }

            main {
                flex: 1;
                display: flex;
                flex-direction: column;
                padding: 20px;
            }

            footer {
                width: 100%;
            }

            .content .imgcontent {
                width: 100%;
                height: 100%;
            }

            .stock-number {
                font-size: 20px;
                font-weight: 400;
                color: black;
                margin: 12px 0;
            }
            .qty button {
                background-color: #9f8a46;
                color: white;
                border: none;
                padding: 5px 10px;
                cursor: pointer;
                font-size: 16px;
                margin: 0 5px;
                border-radius: 5px;
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

            .page-link {
                z-index: 0 !important;
            }

            /* The Modal (background) */
            .modal {
                /*                display: none;  Hidden by default */
                position: fixed; /* Stay in place */
                z-index: 1; /* Sit on top */
                left: 0;
                top: 0;
                width: 100%; /* Full width */
                height: 100%; /* Full height */
                overflow: auto; /* Enable scroll if needed */
                background-color: rgb(0,0,0); /* Fallback color */
                background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
                padding-top: 60px;
            }

            /* The Close Button */
            .close {
                color: #aaa;
                float: right;
                font-size: 28px;
                font-weight: bold;
            }

            .close:hover,
            .close:focus {
                color: black;
                text-decoration: none;
                cursor: pointer;
            }

            @media screen and (min-width: 300px) {
                img.imgcontent.img-prd {
                    width: 100%;
                    height: 100%;
                }

                input.qty {
                    display: flex;
                }
                /*                .price {
                                    font-size: 0.5rem;
                                }*/
                .button-12 {
                    width: 100%;
                    height: 100%;
                }

            }
            @media (max-width: 935px) {
                .button-12 {
                    padding: 15px 40px;
                }

                .column2 .price-product {
                    font-size: 2rem;
                }
                .qty button {
                    padding: 5px 8px;
                    font-size: 14px;
                    margin: 0 3px;
                }
                .qty input {
                    width: 100%;
                    font-size: 14px;
                }

            }
            @media (max-width: 430px) {
                .column2 .price-product {
                    font-size: 1rem;
                }
                .qty .stock{
                    flex-direction: column;
                }
                .qty button, .qty input {
                    margin: 5px 0;
                }
                .qty input {
                    width: 100%;
                    box-sizing: border-box;
                    padding: 5px;
                    font-size: 16px;
                }
            }
            /* Thêm thanh cuộn dọc cho khối content */
            .content {
                max-height: 300px; /* Đặt chiều cao tối đa cho khối content */
                overflow-y: auto; /* Kích hoạt thanh cuộn dọc khi nội dung vượt quá kích thước */
            }
            .content-image {
                max-height: 600px; /* Đặt chiều cao tối đa cho khối content */
                max-width: 950px;
                overflow-y: auto; /* Kích hoạt thanh cuộn dọc khi nội dung vượt quá kích thước */
                overflow-x: auto;
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
            .slideshow-container {
                position: relative;
                width: 100%;
                overflow: hidden;
            }

            .slide {
                display: flex;
                transition: transform 0.5s ease-in-out;
            }

            .product-card {
                width: 25%; /* Hoặc tùy thuộc vào số lượng sản phẩm trên mỗi trang */
                box-sizing: border-box;
                padding: 10px;
            }

            .product-navigation button {
                position: absolute;
                top: 50%;
                transform: translateY(-50%);
                background-color: rgba(0, 0, 0, 0.5);
                color: white;
                border: none;
                cursor: pointer;
            }
            .rating-box {
                width: 130px;
                height: 130px;
                margin-right: auto;
                margin-left: auto;
                background-color: #FBC02D;
                color: #fff;
            }

            .rating-label {
                font-weight: bold;
            }

            /* Rating bar width */
            .rating-bar {
                width: 300px;
                padding: 8px;
                border-radius: 5px;
            }

            /* The bar container */
            .bar-container {
                width: 100%;
                background-color: #f1f1f1;
                text-align: center;
                color: white;
                border-radius: 20px;
                cursor: pointer;
                margin-bottom: 5px;
            }

            /* Individual bars */
            .bar-5 {
                width: 70%;
                height: 13px;
                background-color: #FBC02D;
                border-radius: 20px;

            }
            .bar-4 {
                width: 30%;
                height: 13px;
                background-color: #FBC02D;
                border-radius: 20px;

            }
            .bar-3 {
                width: 20%;
                height: 13px;
                background-color: #FBC02D;
                border-radius: 20px;

            }
            .bar-2 {
                width: 10%;
                height: 13px;
                background-color: #FBC02D;
                border-radius: 20px;

            }
            .bar-1 {
                width: 0%;
                height: 13px;
                background-color: #FBC02D;
                border-radius: 20px;

            }

            td {
                padding-bottom: 10px;
            }

            .star-active {
                color: #FBC02D;
                margin-top: 10px;
                margin-bottom: 10px;
            }

            .star-active:hover {
                color: #F9A825;
                cursor: pointer;
            }

            .star-inactive {
                color: #CFD8DC;
                margin-top: 10px;
                margin-bottom: 10px;
            }

            .blue-text {
                color: #0091EA;
            }

            .content {
                font-size: 18px;
            }

            .profile-pic {
                width: 90px;
                height: 90px;
                border-radius: 100%;
                margin-right: 30px;
            }

            .pic {
                width: 80px;
                height: 80px;
                margin-right: 10px;
            }

            .vote {
                cursor: pointer;
            }
            .card {
                border-radius: 5px;
                background-color: #fff;
                padding-left: 60px;
                padding-right: 60px;
                margin-top: 30px;
                padding-top: 30px;
                padding-bottom: 30px;
            }
            .h-60{
                height:60%!important
            }
            /* The Modal (background) */
            .modal {
                display: none;
                position: fixed;
                z-index: 1050;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                overflow: auto;
                background-color: rgba(0, 0, 0, 0.5);
            }

            .modal-dialog {
                margin: 1.75rem auto;
            }

            .modal-content {
                border-radius: 0.3rem;
                background-color: #fff;
                box-shadow: 0 0 1.75rem rgba(0, 0, 0, 0.3);
            }

            .modal-header,
            .modal-footer {
                padding: 1rem;
                border-color: #dee2e6;
            }

            .modal-title {
                font-size: 1.25rem;
            }

            .close {
                font-size: 1.5rem;
            }
            .product-card .original-price {
                text-decoration: line-through;
                color: #888;
            }

            .product-card .discounted-price {
                color: red;
            }
        </style>

    </head>
    <body>
        <jsp:useBean id="feedback" class="com.model.DAO.RateDAO" scope="request"></jsp:useBean>
        <jsp:useBean id="customer" class="com.model.DAO.CustomerDAO" scope="request"></jsp:useBean>
        <jsp:useBean id="discounttitle" class="com.model.DAO.DiscountDAO" scope="request"></jsp:useBean>

        <jsp:include page="header.jsp" />
        <main class="mb-5">

            <p class="product-name content-product-h3">
                ${product.getTitle()}
            </p>
            <p class="star2">
                ${count_sold} Sold
                |
                <c:forEach begin="1" end="${product.getReviewsRate()}">
                    <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                </c:forEach>
                <c:forEach begin="1" end="${5 - product.getReviewsRate()}">
                    <i class="fa-solid fa-star" style="color: #727580"></i>
                </c:forEach>(${feedback.getRateListByProductId(product.productId).size()})
            </p>    <!-- Average ratings by customers -->

            <div class="board">
                <div class="content">
                    <c:forEach items="${product.images}" var="img" varStatus="status">
                        <img class="imgGallery" src="${img}" alt="" onclick="displayImage('${img}')" />
                    </c:forEach>
                </div>
                <div class="content-image">
                    <!--                    <div id="first1">-->
                    <img id="mainImage" class="imgcontent img-prd" src="${product.getImages()[0]}" />
                    <!--                    </div>-->
                </div>
            </div>

            <div class="row">                           
                <div class="col-auto">                                    
                    <p class="product-name fix3">Product details</p>
                    <div class="background">

                        <p class="product-name">About This Product</p>
                        <p class="cmt2">
                            ${product.getDescription()}
                        </p>

                        <p class="product-name">Category</p>
                        <p class="cmt2">
                            ${product.getCategory()}
                        </p>

                    </div>

                </div>

                <div class="col-auto">
                    <div class="background">
                        <div style="display: flex">
                            <p class="price-product" style="font-weight: 600">
                            </p>
                            <c:choose>
                                <c:when test="${product.getDiscountId() ne 0 && discounttitle.getDiscount(product.getDiscountId()) ne null}">

                                    <p class="price-product price original-price" style="text-decoration: line-through;">${product.getPrice()} &#8363;</p>
                                    <p class="price-product price discounted-price" style="color: red;"><fmt:formatNumber value="${product.getPrice() - product.getPrice() * discounttitle.getDiscount(product.getDiscountId()).getDiscountValue()}"
                                                      type="number"
                                                      maxFractionDigits="2"
                                                      minFractionDigits="2" /> &#8363;</p>
                                    </c:when>
                                    <c:otherwise>
                                    <p class="price-product price">${product.getPrice()} &#8363;</p>
                                </c:otherwise>
                            </c:choose>

                        </div>
                        <div> 
                            <c:choose>
                                <c:when test="${product.getStock() > 0}">
                                    <p class="qty">
                                        Quantity:
                                        <br>
                                        <button onclick="changeQuantity(-1)">-</button>                              
                                        <input class="qty-value" id="qty-value" type="number" min="1" value="1" max="${product.getStock()}"/>
                                        <button onclick="changeQuantity(1)">+</button>
                                    </p>
                                </c:when>
                            </c:choose>

                            <p class="stock-number">
                                <strong class="${product.getStock() > 0 ? 'text-success':'text-danger'}">
                                    <c:choose>
                                        <c:when test="${product.getStock() > 0}">
                                            Stock: ${product.getStock()} product(s) available    
                                        </c:when>
                                        <c:otherwise>
                                            Out of stock
                                        </c:otherwise>
                                    </c:choose> 
                                </strong>
                            </p>
                        </div>
                        <c:choose>
                            <c:when test="${product.getStock() > 0}">
                                <button class="button-12 btn-cart" role="button" onclick="addToCart(${product.getProductId()})">
                                    <i class="fa-solid fa-cart-shopping">
                                        Add to Cart
                                    </i> 
                                </button>
                            </c:when>
                        </c:choose>

                    </div>

                </div>
            </div>
            <hr>     
            <p class="product-name">Related product</p> 
            <!--                <div class="product-navigation">
                                <button id="previousBtn">Previous</button>
                                <button id="nextBtn">Next</button>
                            </div>-->
            <div class="row">

                <br/>
                <div class="rowproduct listproduct slideshow-container">
                    <c:forEach items="${requestScope.products}" var="product">
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
                                    <p class="arrived-date">(${feedback.getRateListByProductId(product.getProductId()).size()})</p>    
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
                    <a class="prev" onclick="changeSlide(-1)">❮</a>
                    <a class="next" onclick="changeSlide(1)">❯</a>
                </div>
            </div>
            <hr>
            <!-- Customer Ratings Summary -->
            <p class="product-name">Customers 's Feedbacks</p>
            <div class="row d-flex justify-content-center">
                <!-- Rating Summary Card -->
                <div class="card col-12 container-fluid">
                    <div class="row justify-content-left d-flex">
                        <!-- Rating Summary -->
                        <div class="col-md-12 d-flex flex-column">
                            <div class="rating-box text-center">
                                <!-- Replace '4.0' with the average rating calculated dynamically -->
                                <h1 class="pt-4"><fmt:formatNumber value="${product.getReviewsRate()}" type="number" minFractionDigits="1" maxFractionDigits="1"/></h1>
                                <p class="">out of 5</p>
                            </div>
                            <div>
                                <c:forEach var="i" begin="1" end="5">
                                    <span class="fa fa-star ${i <= product.getReviewsRate() ? 'star-active' : 'star-inactive'} mx-1"></span>
                                </c:forEach>(${rateListByProduct.size()} reviews)
                            </div>
                        </div>

                        <!-- Rating Breakdown -->
                        <div class="col-md-8">
                            <div class="rating-bar0 justify-content-center">
                                <table class="text-left mx-auto">
                                    <tr>
                                        <td class="rating-label">Excellent</td>
                                        <td class="rating-bar">
                                            <div class="bar-container">
                                                <!-- Adjust the width of 'bar-5' dynamically based on the percentage -->
                                                <div class="bar-5" style="width: ${(rateListByProduct.size() > 0) ? ((feedback.countRateByStarAndProduct(5, product.getProductId()) / rateListByProduct.size()) * 100) : 0}%;"></div>
                                            </div>
                                        </td>
                                        <td class="text-right">${feedback.countRateByStarAndProduct(5, product.getProductId())}</td>
                                    </tr>
                                    <tr>
                                        <td class="rating-label">Good</td>
                                        <td class="rating-bar">
                                            <div class="bar-container">
                                                <!-- Adjust the width of 'bar-4' dynamically based on the percentage -->
                                                <div class="bar-4" style="width: ${(rateListByProduct.size() > 0) ? ((feedback.countRateByStarAndProduct(4, product.getProductId()) / rateListByProduct.size()) * 100) : 0}%;"></div>
                                            </div>
                                        </td>
                                        <td class="text-right">${feedback.countRateByStarAndProduct(4, product.getProductId())}</td>
                                    </tr>
                                    <tr>
                                        <td class="rating-label">Average</td>
                                        <td class="rating-bar">
                                            <div class="bar-container">
                                                <!-- Adjust the width of 'bar-3' dynamically based on the percentage -->
                                                <div class="bar-3" style="width: ${(rateListByProduct.size() > 0) ? ((feedback.countRateByStarAndProduct(3, product.getProductId()) / rateListByProduct.size()) * 100) : 0}%;"></div>
                                            </div>
                                        </td>
                                        <td class="text-right">${feedback.countRateByStarAndProduct(3, product.getProductId())}</td>
                                    </tr>
                                    <tr>
                                        <td class="rating-label">Poor</td>
                                        <td class="rating-bar">
                                            <div class="bar-container">
                                                <!-- Adjust the width of 'bar-2' dynamically based on the percentage -->
                                                <div class="bar-2" style="width: ${(rateListByProduct.size() > 0) ? ((feedback.countRateByStarAndProduct(2, product.getProductId()) / rateListByProduct.size()) * 100) : 0}%;"></div>
                                            </div>
                                        </td>
                                        <td class="text-right">${feedback.countRateByStarAndProduct(2, product.getProductId())}</td>
                                    </tr>
                                    <tr>
                                        <td class="rating-label">Terrible</td>
                                        <td class="rating-bar">
                                            <div class="bar-container">
                                                <!-- Adjust the width of 'bar-1' dynamically based on the percentage -->
                                                <div class="bar-1" style="width: ${(rateListByProduct.size() > 0) ? ((feedback.countRateByStarAndProduct(1, product.getProductId()) / rateListByProduct.size()) * 100) : 0}%;"></div>
                                            </div>
                                        </td>
                                        <td class="text-right">${feedback.countRateByStarAndProduct(1, product.getProductId())}</td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        <!-- Rate Part -->
                        <div class="mt-3 col-12 align-items-center p-5">
                            <!-- Form Rate -->
                            <c:if test="${sessionScope.user ne null}">
                                <c:if test="${!hasRated}">
                                    <form action="addrate" method="post">
                                        <div class="d-flex flex-row form-color">
                                            <img src="${sessionScope.user.customerImage}" width="40" height="40" class="rounded-circle mr-3">
                                            <textarea id="commentAdd" name="comment" class="form-control" placeholder="Enter comment"></textarea>
                                            <input type="text" name="productId" class="d-none" value="${product.getProductId()}">&nbsp;
                                            <input type="text" name="userId" class="d-none" value="${sessionScope.user.id}">&nbsp;
                                            <input type="submit" class="btn btn-danger" value="Send" width="50">
                                        </div>
                                        <div class="rate">
                                            <input type="radio" name="rate" value="5" id="5"><label for="5">☆</label>
                                            <input type="radio" name="rate" value="4" id="4"><label for="4">☆</label>
                                            <input type="radio" name="rate" value="3" id="3"><label for="3">☆</label>
                                            <input type="radio" name="rate" value="2" id="2"><label for="2">☆</label>
                                            <input type="radio" name="rate" value="1" id="1"><label for="1">☆</label>
                                        </div>
                                    </form>
                                </c:if>
                            </c:if>

                            <!-- List of All Raters -->

                            <c:choose>
                                <c:when test="${rateListByProduct.size() > 0}">
                                    <div class="mt-2 content" id="content">
                                        <c:forEach items="${rateListByProduct}" var="r">
                                            <c:set var="account" value="${r.getCustomerById(r.customer_id)}"/>

                                            <div class="cmt d-flex flex-row p-3">
                                                <img src="${account.customerImage}" width="40" height="40" class="rounded-circle mr-3">
                                                <div class="w-100">
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <div class="d-flex flex-row align-items-center">
                                                            <span class="mr-2"><p>${account.username}</p>
                                                                <div class="rated">
                                                                    <input type="radio" disabled ${(r.rate eq 1) ? 'checked' : ''} id="1"><label for="1">☆</label>
                                                                    <input type="radio" disabled ${(r.rate eq 2) ? 'checked' : ''} id="2"><label for="2">☆</label>
                                                                    <input type="radio" disabled ${(r.rate eq 3) ? 'checked' : ''} id="3"><label for="3">☆</label>
                                                                    <input type="radio" disabled ${(r.rate eq 4) ? 'checked' : ''} id="4"><label for="4">☆</label>
                                                                    <input type="radio" disabled ${(r.rate eq 5) ? 'checked' : ''} id="5"><label for="5">☆</label>
                                                                </div>
                                                            </span>
                                                        </div>
                                                        <small>${r.getFormattedModifiedOn()}</small>
                                                    </div>
                                                    <p class="text-justify comment-text mb-0">${r.comment}</p>
                                                </div>

                                                <c:if test="${(sessionScope.manager.role eq 0) or (sessionScope.user.id eq r.customer_id)}">
                                                    <!-- Nút Edit với thuộc tính dữ liệu -->
                                                    <button class="btn btn-white text-primary" 
                                                            onclick="openEditRateModal('${r.rate_id}')">✏
                                                    </button>

                                                    <button class="btn btn-white text-danger" onclick="doDelete('${r.getRate_id()}', '${product.getProductId()}')">🗑️</button>
                                                    <form action="deleterate" method="post" id="deleteRate${r.getRate_id()}">
                                                        <input type="hidden" name="rateId" value="${r.getRate_id()}"/>
                                                        <input type="hidden" name="productId" value="${product.getProductId()}"/>
                                                    </form>
                                                </c:if>
                                            </div>
                                        </c:forEach>
                                    </div>

                                </c:when>
                                <c:otherwise>
                                    <jsp:include page="no-feedback-available.jsp"/>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <!-- Modal -->
                    <div id="editRateModal" class="modal" role="dialog" aria-labelledby="editRateModalLabel" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="editRateModalLabel">Edit Rating</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <form id="editRateForm" action="editrate" method="post">
                                        <div class="form-group">
                                            <label for="username">Username:</label>
                                            <input type="text" class="form-control" id="username" name="username" readonly>
                                        </div>
                                        <div class="form-group">
                                            <label for="rating">Rating:</label>
                                            <div class="rated">
                                                <input type="radio" name="rate" value="1" id="rating1"><label for="rating1">☆</label>
                                                <input type="radio" name="rate" value="2" id="rating2"><label for="rating2">☆</label>
                                                <input type="radio" name="rate" value="3" id="rating3"><label for="rating3">☆</label>
                                                <input type="radio" name="rate" value="4" id="rating4"><label for="rating4">☆</label>
                                                <input type="radio" name="rate" value="5" id="rating5"><label for="rating5">☆</label>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="comment">Comment:</label>
                                            <textarea class="form-control" id="commentEdit" name="comment"></textarea>
                                        </div>
                                        <input type="hidden" id="rateId" name="rateId">
                                        <input type="hidden" id="productId" name="productId">
                                    </form>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                    <button type="button" class="btn btn-primary" onclick="submitEditRate()">Save changes</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>



            <hr>
        </main>

        <jsp:include page="footer.jsp" />
        <!-- JS -->
        <script>
            function submitEditRate() {
                document.getElementById('editRateForm').submit();
            }
        </script>
        <script>
            function openEditRateModal(rateId) {
                $.ajax({
                    url: 'fetchrate',
                    method: 'GET',
                    data: {rateId: rateId},
                    success: function (response) {
                        document.getElementById('rateId').value = response.rateId;
                        document.getElementById('productId').value = response.productId;
                        document.getElementById('username').value = response.username;
                        document.getElementById('commentEdit').value = response.comment;

                        const ratingElements = document.querySelectorAll('input[name="rate"]');
                        ratingElements.forEach(element => {
                            if (element.value === response.currentRating.toString()) {
                                element.checked = true;
                            }
                        });
                        // Khởi tạo CKEditor sau khi modal được mở
                        ClassicEditor
                                .create(document.querySelector('#commentEdit'), {
                                    extraPlugins: [MyCustomUploadAdapterPlugin],
                                    image: {
                                        toolbar: ['imageTextAlternative', 'imageStyle:full', 'imageStyle:side']
                                    }
                                })
                                .catch(error => {
                                    console.error(error);
                                });

                        var myModal = new bootstrap.Modal(document.getElementById('editRateModal'));
                        myModal.show();
                    },
                    error: function (xhr, status, error) {
                        console.error('Có lỗi xảy ra:', error);
                    }
                });
            }
        </script>
        <script>

            // Khai báo hàm MyCustomUploadAdapterPlugin và MyUploadAdapter một lần duy nhất
            function MyCustomUploadAdapterPlugin(editor) {
                editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
                    return new MyUploadAdapter(loader);
                };
            }

            class MyUploadAdapter {
                constructor(loader) {
                    this.loader = loader;
                    this.reader = new FileReader();
                }

                upload() {
                    return this.loader.file
                            .then(file => new Promise((resolve, reject) => {
                                    this._initListeners(resolve, reject);
                                    this.reader.readAsDataURL(file);
                                }));
                }

                _initListeners(resolve, reject) {
                    this.reader.onload = () => resolve({default: this.reader.result});
                    this.reader.onerror = error => reject(error);
                }

                abort() {
                    this.reader.abort();
                }
            }

            // Khởi tạo CKEditor cho productDescription
            ClassicEditor
                    .create(document.querySelector('#commentAdd'), {
                        extraPlugins: [MyCustomUploadAdapterPlugin],
                        image: {
                            toolbar: ['imageTextAlternative', 'imageStyle:full', 'imageStyle:side']
                        }
                    })
                    .catch(error => {
                        console.error(error);
                    });

//            ClassicEditor
//                    .create(document.querySelector('#commentEdit'), {
//                        extraPlugins: [MyCustomUploadAdapterPlugin],
//                        image: {
//                            toolbar: ['imageTextAlternative', 'imageStyle:full', 'imageStyle:side']
//                        }
//                    })
//                    .catch(error => {
//                        console.error(error);
//                    });


        </script>
        <script>
            let currentSlideIndex = 0; // Chỉ số trang hiện tại
            const slidesToShow = 5; // Số sản phẩm hiển thị trên mỗi trang
            const products = document.querySelectorAll('.product-card'); // Danh sách sản phẩm

            function showSlides(index) {
                const totalSlides = Math.ceil(products.length / slidesToShow);

                // Xóa tất cả các sản phẩm khỏi hiển thị
                products.forEach((product, i) => {
                    product.style.display = 'none';
                });

                // Hiển thị sản phẩm cho trang hiện tại
                for (let i = index * slidesToShow; i < (index + 1) * slidesToShow && i < products.length; i++) {
                    products[i].style.display = 'block';
                }
            }

            function changeSlide(step) {
                const totalSlides = Math.ceil(products.length / slidesToShow);
                currentSlideIndex += step;

                // Đảm bảo chỉ số trang không vượt quá giới hạn
                if (currentSlideIndex >= totalSlides) {
                    currentSlideIndex = 0;
                } else if (currentSlideIndex < 0) {
                    currentSlideIndex = totalSlides - 1;
                }

                showSlides(currentSlideIndex);
            }

// Hiển thị trang đầu tiên khi tải trang
            document.addEventListener('DOMContentLoaded', () => {
                showSlides(currentSlideIndex);
            });
        </script>

        <script>
            function displayImage(imageSrc) {
                document.getElementById("mainImage").src = imageSrc;
            }
        </script>

        <script>
            function changeQuantity(amount) {
                var input = document.querySelector('.qty-value');
                var currentValue = parseInt(input.value);
                var newValue = currentValue + amount;
                var maxStock = parseInt(input.max);
                if (newValue >= 1 && newValue <= maxStock) { // Ensure quantity does not go below 1
                    input.value = newValue;
                }
            }

            function addToCart(productId) {
                var quantity = document.getElementById('qty-value').value;
                console.log(quantity);
                window.location.href = 'cart?action=add&pid=' + productId + '&qty=' + quantity;
            }

        </script>

        <script>
            function doDelete(rateId, productId) {
                if (confirm('Are you sure to delete this feedback ?')) {
                    document.getElementById("deleteRate" + rateId).submit();
                }
            }


            // Get the modal
            var modal = document.getElementById("editRateModal");

// Get the button that opens the modal
            var edit = document.getElementById("editRateId");

// Get the <span> element that closes the modal
            var span = document.getElementsByClassName("close")[0];

// When the user clicks the button, open the modal 
            edit.onclick = function (event) {
                event.preventDefault(); // Prevent default link behavior
                modal.style.display = "block";
            };

// When the user clicks on <span> (x), close the modal
            span.onclick = function () {
                modal.style.display = "none";
            };


        </script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script>

            function loadMore() {
                var amount = document.getElementsByClassName("cmt").length;
                $.ajax({
                    url: "/SWP391_Project/loadmorecomment",
                    type: "get", //send it through get method
                    data: {
                        exists: amount
                    },
                    success: function (data) {
                        var row = document.getElementById("content");
                        row.innerHTML += data;
                    },
                    error: function (xhr) {
                        //Do Something to handle error
                    }
                });
            }
        </script>


    </body>
</html>
