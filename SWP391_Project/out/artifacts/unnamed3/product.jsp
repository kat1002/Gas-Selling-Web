<%-- 
    Document   : ProductDetail
    Created on : May 9, 2024, 10:05:10 PM
    Author     : Acer Nitro 5
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>
            BLAZO | PRODUCT DETAILS
        </title>
        <link rel="stylesheet" href="CSS/product.css" />
        <link rel="stylesheet" href="CSS/main.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />

        <style>

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

            @media screen and (min-width: 300px) {
                img.imgcontent.img-prd {
                    width: 100%;
                    height: 100%;
                }

                input.qty {
                    display: flex;
                }
                .price {
                    font-size: 0.5rem;
                }
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

        </style>

    </head>
    <body>
        <jsp:include page="header.jsp" />
        <main>
            <form action="product">
            </form>
            <p class="product-name content-product-h3">
                ${product.getTitle()}
            </p>
            <p class="star2">
                <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                <i class="fa-solid fa-star" style="color: #9f8a46"></i> (1)
            </p>
            <div class="board">
                <div class="container">
                    <img class="imgGallery" src="${product.getImages()[0]}" alt="" onclick="myFunction()" />
<!--                    <img class="imgGallery" src="${product.getImages()}" alt="" onclick="myFunction2()" />
                    <img class="imgGallery" src="${product.getImages()}" alt="" onclick="myFunction3()" />-->
                </div>
                <div class="content">
                    <div id="first1">
                        <img class="imgcontent img-prd" src="${product.getImages()[0]}" />
                    </div>
                    <!--                    <div id="second">
                                            <img class="imgcontent" src="${product.getImages()}" />
                                        </div>
                                        <div id="third">
                                            <img class="imgcontent" src="${product.getImages()}" />
                                        </div>-->
                </div>
            </div>
            <div class="row">                           
                <div class="column1">                                    
                    <p class="product-name fix3">Product details</p>
                    <div class="background">

                        <p class="product-name">About This Product</p>
                        <p class="cmt2">
                            ${product.getDescription()}

                        </p>
                    </div>

                </div>

                <div class="column2">
                    <div class="background">
                        <div style="display: flex">
                            <p class="price-product" style="font-weight: 600">
                                $
                            </p>
                            <p class="price-product price">${product.getPrice()}</p>
                        </div>
                        <div> 
                            <p class="qty">
                                Quantity:
                                <br>
                                <button onclick="changeQuantity(-1)">-</button>                              
                                <input class="qty-value" type="number" min="1" value="1" />
                                <button onclick="changeQuantity(1)">+</button>
                            </p>
                            <p class="stock-number">
                                <strong>
                                    Stock: ${product.getStock()}
                                </strong>
                            </p>
                        </div>

                        <button class="button-12 btn-cart" role="button">
                            <i class="fa-solid fa-cart-shopping">
                                Add to Cart
                            </i> 
                        </button>
                    </div>

                </div>


            </div>
        </main>
        <jsp:include page="footer.jsp" />
        <script>
            function changeQuantity(amount) {
                var input = document.querySelector('.qty-value');
                var currentValue = parseInt(input.value);
                var newValue = currentValue + amount;
                if (newValue >= 1) { // Ensure quantity does not go below 1
                    input.value = newValue;
                }
            }
        </script>
        <script src="JS/Login.js"></script>
        <script src="JS/ProductGallery.js"></script>
        <script src="JS/Cart.js"></script>
    </body>
</html>
