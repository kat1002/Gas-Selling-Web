<%-- 
    Document   : Home
    Created on : May 10, 2024, 5:06:37 PM
    Author     : WuanTun
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <title>SENIKS | HOME</title>
        <link rel="stylesheet" href="CSS/main.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
    </head>

    <body>
        <header>
            <div class="row-menu1">
                <ul class="menu">
                    <li class="menu-item">
                        <button class="open-button menu-link" onclick="openCart()">
                            <i class="fa-solid fa-cart-shopping"></i> My Cart
                        </button>
                    </li>

                    <li>
                        <a href="Login.jsp" class="menu-link">
                            <i class="fa-solid fa-user"></i> Login
                        </a>
                    </li>
                    </li>
                </ul>
                <div class="form-popup" id="myCart" style="display: none">
                    <div class="form-container">
                        <h2 style="
                            text-align: left;
                            color: #9f8a46;
                            font-weight: 600;
                            margin: 0 0 2% 0;
                            ">
                            MY CART
                        </h2>
                        <div class="cart-row">
                            <span class="cart-item cart-header cart-column">Product</span>
                            <span class="cart-price cart-header cart-column">Price</span>
                            <span class="cart-quantity cart-header cart-column">Qty</span>
                        </div>
                        <div class="cart-items">
                            <div class="cart-row">
                                <div class="cart-item cart-column">
                                    <img class="cart-item-image" src="media/guitar-img.webp" width="100" height="100" />
                                    <span class="cart-item-title">Ibanez Artwood AW84CE-WK Acoustic
                                        Guitar, Weathered Black</span>
                                </div>
                                    <span class="cart-price cart-column">383.99</span>
                                <div class="cart-quantity cart-column">
                                    <input class="cart-quantity-input" type="number" min="1" value="1" />
                                    <button class="btn-danger" type="button">
                                        Delete
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="cart-total">
                            <strong class="cart-total-title">Total:</strong>
                            <span class="cart-total-price">$383.99</span>
                        </div>
                        <button type="submit" class="btn btn-pay" onclick="pay()">Pay</button>
                        <button type="button" class="btn cancel" onclick="closeCart()">
                            <i class="fa-solid fa-xmark"></i>
                        </button>
                    </div>
                </div>

            </div>
            <div class="row-menu2">
                <a href="Home.jsp"><img class="logo" src="media/Cat.jpg" alt="logo" /></a>
                <ul class="menu">
                    <li class="menu-item">
                        <a class="menu-link" href="Home.jsp">HOME</a>
                    </li>
                    <li class="menu-item">
                        <a class="menu-link" href="contact.html">CONTACT</a>
                    </li>
                    <li class="menu-item">
                        <a class="menu-link" href="faq.html">HELP / FAQ</a>
                    </li>
                    <li class="menu-item">
                        <a class="menu-link" href="categories.html">CATEGORIES</a>
                    </li>
                    <li class="menu-item">
                        <a class="menu-link" href="about.html">WHO ARE WE?</a>
                    </li>
                </ul>
                <form class="search-button">
                    <input type="text" placeholder="Search..." />
                    <button><i class="fa fa-search"></i></button>
                </form>
            </div>
        </header>
        <main>
            <div class="slideshow-container">
                <div class="mySlides fade">
                    <img src="media/slide1.webp" style="width: 100%" />
                </div>
                <div class="mySlides fade">
                    <img src="media/slide2.webp" style="width: 100%" />
                </div>
                <div class="mySlides fade">
                    <img src="media/slide3.webp" style="width: 100%" />
                </div>
                <a class="prev" onclick="plusSlides(-1)">❮</a>
                <a class="next" onclick="plusSlides(1)">❯</a>
            </div>
            <p class="title" id="first">Shop Popular Categories</p>
            <div class="img-list-mobile">
                <ul class="menu">
                    <div class="img-row">
                        <li class="list-item">
                            <a class="menu-link" href="categories.html">
                                <img src="media/drums.png" alt="" /><br />Drum
                            </a>
                        </li>
                        <li class="list-item">
                            <a class="menu-link" href="categories.html">
                                <img src="media/guitar.png" alt="" /><br />Guitar
                            </a>
                        </li>
                        <li class="list-item">
                            <a class="menu-link" href="categories.html">
                                <img src="media/headphone.png" alt="" /><br />Headphone
                            </a>
                        </li>
                        <li class="list-item">
                            <a class="menu-link" href="categories.html">
                                <img src="media/microphone.png" alt="" /><br />Microphone
                            </a>
                        </li>
                    </div>
                    <div class="img-row">
                        <li class="list-item">
                            <a class="menu-link" href="categories.html">
                                <img src="media/keyboard.png" alt="" /><br />Keyboard
                            </a>
                        </li>
                        <li class="list-item">
                            <a class="menu-link" href="categories.html">
                                <img src="media/software.png" alt="" /><br />Software
                            </a>
                        </li>
                        <li class="list-item">
                            <a class="menu-link" href="categories.html">
                                <img src="media/speaker.png" alt="" /><br />Speaker
                            </a>
                        </li>
                        <li class="list-item">
                            <a class="menu-link" href="categories.html">
                                <img src="media/synthesizer.png" alt="" /><br />Synthesizer
                            </a>
                        </li>
                    </div>
                </ul>
            </div>
            <div class="img-list-desktop">
                <ul class="menu">
                    <li class="list-item">
                        <a class="menu-link" href="categories.html">
                            <img src="media/drums.png" alt="" /><br />Drum
                        </a>
                    </li>
                    <li class="list-item">
                        <a class="menu-link" href="categories.html">
                            <img src="media/guitar.png" alt="" /><br />Guitar
                        </a>
                    </li>
                    <li class="list-item">
                        <a class="menu-link" href="categories.html">
                            <img src="media/headphone.png" alt="" /><br />Headphone
                        </a>
                    </li>
                    <li class="list-item">
                        <a class="menu-link" href="categories.html">
                            <img src="media/microphone.png" alt="" /><br />Microphone
                        </a>
                    </li>
                    <li class="list-item">
                        <a class="menu-link" href="categories.html">
                            <img src="media/keyboard.png" alt="" /><br />Keyboard
                        </a>
                    </li>
                    <li class="list-item">
                        <a class="menu-link" href="categories.html">
                            <img src="media/software.png" alt="" /><br />Software
                        </a>
                    </li>
                    <li class="list-item">
                        <a class="menu-link" href="categories.html">
                            <img src="media/speaker.png" alt="" /><br />Speaker
                        </a>
                    </li>
                    <li class="list-item">
                        <a class="menu-link" href="categories.html">
                            <img src="media/synthesizer.png" alt="" /><br />Synthesizer
                        </a>
                    </li>
                </ul>
            </div>
            <p class="title">Hot Deals</p>
            <div class="product">
                <ul>
                    <li class="product-card">
                        <a href="product.html"><img src="media/guitar-img.webp" alt="" /></a>
                        <a class="menu-link" href="product.html">Ibanez Artwood AW84CE-WK Acoustic Guitar, Weathered
                            Black</a>
                        <p class="star">
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            (1)
                        </p>
                        <p class="stock">In stock</p>
                        <p class="price">$383.99</p>
                    </li>
                    <li class="product-card">
                        <a href="product.html"><img src="media/guitar-img.webp" alt="" /></a>
                        <a class="menu-link" href="product.html">Ibanez Artwood AW84CE-WK Acoustic Guitar, Weathered
                            Black</a>
                        <p class="star">
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            (1)
                        </p>
                        <p class="stock">In stock</p>
                        <p class="price">$383.99</p>
                    </li>
                    <li class="product-card">
                        <a href="product.html"><img src="media/guitar-img.webp" alt="" /></a>
                        <a class="menu-link" href="product.html">Ibanez Artwood AW84CE-WK Acoustic Guitar, Weathered
                            Black</a>
                        <p class="star">
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            (1)
                        </p>
                        <p class="stock">In stock</p>
                        <p class="price">$383.99</p>
                    </li>
                    <li class="product-card">
                        <a href="product.html"><img src="media/guitar-img.webp" alt="" /></a>
                        <a class="menu-link" href="product.html">Ibanez Artwood AW84CE-WK Acoustic Guitar, Weathered
                            Black</a>
                        <p class="star">
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            (1)
                        </p>
                        <p class="stock">In stock</p>
                        <p class="price">$383.99</p>
                    </li>
                    <li class="product-card">
                        <a href="product.html"><img src="media/guitar-img.webp" alt="" /></a>
                        <a class="menu-link" href="product.html">Ibanez Artwood AW84CE-WK Acoustic Guitar, Weathered
                            Black</a>
                        <p class="star">
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            (1)
                        </p>
                        <p class="stock">In stock</p>
                        <p class="price">$383.99</p>
                    </li>
                </ul>
            </div>
            <p class="title">Best sellers</p>
            <div class="product">
                <ul>
                    <li class="product-card">
                        <a href="product.html"><img src="media/guitar-img.webp" alt="" /></a>
                        <a class="menu-link" href="product.html">Ibanez Artwood AW84CE-WK Acoustic Guitar, Weathered
                            Black</a>
                        <p class="star">
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            (1)
                        </p>
                        <p class="stock">In stock</p>
                        <p class="price">$383.99</p>
                    </li>
                    <li class="product-card">
                        <a href="product.html"><img src="media/guitar-img.webp" alt="" /></a>
                        <a class="menu-link" href="product.html">Ibanez Artwood AW84CE-WK Acoustic Guitar, Weathered
                            Black</a>
                        <p class="star">
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            (1)
                        </p>
                        <p class="stock">In stock</p>
                        <p class="price">$383.99</p>
                    </li>
                    <li class="product-card">
                        <a href="product.html"><img src="media/guitar-img.webp" alt="" /></a>
                        <a class="menu-link" href="product.html">Ibanez Artwood AW84CE-WK Acoustic Guitar, Weathered
                            Black</a>
                        <p class="star">
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            (1)
                        </p>
                        <p class="stock">In stock</p>
                        <p class="price">$383.99</p>
                    </li>
                    <li class="product-card">
                        <a href="product.html"><img src="media/guitar-img.webp" alt="" /></a>
                        <a class="menu-link" href="product.html">Ibanez Artwood AW84CE-WK Acoustic Guitar, Weathered
                            Black</a>
                        <p class="star">
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            (1)
                        </p>
                        <p class="stock">In stock</p>
                        <p class="price">$383.99</p>
                    </li>
                    <li class="product-card">
                        <a href="product.html"><img src="media/guitar-img.webp" alt="" /></a>
                        <a class="menu-link" href="product.html">Ibanez Artwood AW84CE-WK Acoustic Guitar, Weathered
                            Black</a>
                        <p class="star">
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            (1)
                        </p>
                        <p class="stock">In stock</p>
                        <p class="price">$383.99</p>
                    </li>
                </ul>
            </div>
            <p class="title">NEW ARRIVALS</p>
            <div class="product">
                <ul>
                    <li class="product-card">
                        <a href="product.html"><img src="media/guitar-img.webp" alt="" /></a>
                        <a class="menu-link" href="product.html">Ibanez Artwood AW84CE-WK Acoustic Guitar, Weathered
                            Black</a>
                        <p class="star">
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            (1)
                        </p>
                        <p class="stock">In stock</p>
                        <p class="price">$383.99</p>
                    </li>
                    <li class="product-card">
                        <a href="product.html"><img src="media/guitar-img.webp" alt="" /></a>
                        <a class="menu-link" href="product.html">Ibanez Artwood AW84CE-WK Acoustic Guitar, Weathered
                            Black</a>
                        <p class="star">
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            (1)
                        </p>
                        <p class="stock">In stock</p>
                        <p class="price">$383.99</p>
                    </li>
                    <li class="product-card">
                        <a href="product.html"><img src="media/guitar-img.webp" alt="" /></a>
                        <a class="menu-link" href="product.html">Ibanez Artwood AW84CE-WK Acoustic Guitar, Weathered
                            Black</a>
                        <p class="star">
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            (1)
                        </p>
                        <p class="stock">In stock</p>
                        <p class="price">$383.99</p>
                    </li>
                    <li class="product-card">
                        <a href="product.html"><img src="media/guitar-img.webp" alt="" /></a>
                        <a class="menu-link" href="product.html">Ibanez Artwood AW84CE-WK Acoustic Guitar, Weathered
                            Black</a>
                        <p class="star">
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            (1)
                        </p>
                        <p class="stock">In stock</p>
                        <p class="price">$383.99</p>
                    </li>
                    <li class="product-card">
                        <a href="product.html"><img src="media/guitar-img.webp" alt="" /></a>
                        <a class="menu-link" href="product.html">Ibanez Artwood AW84CE-WK Acoustic Guitar, Weathered
                            Black</a>
                        <p class="star">
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            <i class="fa-solid fa-star" style="color: #9f8a46"></i>
                            (1)
                        </p>
                        <p class="stock">In stock</p>
                        <p class="price">$383.99</p>
                    </li>
                </ul>
            </div>
            <p class="title" id="f-ar">Featured Articles</p>
            <div class="f-ar2">
                <div class="card3">
                    <a href=""><img class="pod"
                                    src="https://blog.sweelee.com/uploads/2023/08/The-Best-Pedalboards-2023@1200x630-480x237.jpg"
                                    alt="" /></a>
                    <p>
                        <a class="menu-link" href="#">The Best Pedalboards 2023</a>
                    </p>
                    <p class="cmt">
                        There's no easier, neater way to o...<a class="menu-link fix2" href="#">Read more</a>
                    </p>
                </div>
                <div class="card3">
                    <a href=""><img class="pod"
                                    src="https://blog.sweelee.com/uploads/2023/08/The-Best-Pedalboards-2023@1200x630-480x237.jpg"
                                    alt="" /></a>
                    <p>
                        <a class="menu-link" href="#">The Best Pedalboards 2023</a>
                    </p>
                    <p class="cmt">
                        There's no easier, neater way to o...<a class="menu-link fix2" href="#">Read more</a>
                    </p>
                </div>
                <div class="card3">
                    <a href=""><img class="pod"
                                    src="https://blog.sweelee.com/uploads/2023/08/The-Best-Pedalboards-2023@1200x630-480x237.jpg"
                                    alt="" /></a>
                    <p>
                        <a class="menu-link" href="#">The Best Pedalboards 2023</a>
                    </p>
                    <p class="cmt">
                        There's no easier, neater way to o...<a class="menu-link fix2" href="#">Read more</a>
                    </p>
                </div>
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
        <footer>
            <div id="end">
                <div class="card">
                    <p class="title3">CUSTOMER SERVICES</p>
                    <ul>
                        <li><a href="contact.html">Contact</a></li>
                        <li><a href="#">Returns</a></li>
                        <li><a href="contact.html">Sitemap</a></li>
                        <li><a href="#">Gift Vouchers</a></li>
                    </ul>
                </div>
                <div class="card">
                    <p class="title3">INFORMATION</p>
                    <ul>
                        <li><a href="about.html">About me</a></li>
                        <li><a href="#">Delivery information</a></li>
                        <li><a href="#">Privacy policy</a></li>
                    </ul>
                </div>
                <div class="card">
                    <p class="title3">SOCIAL NETWORK</p>
                    <ul>
                        <li><a href="#">Facebook</a></li>
                        <li><a href="#">Youtube</a></li>
                        <li><a href="#">Twitter</a></li>
                    </ul>
                </div>
                <div class="card">
                    <p class="title3">PAYMENT METHODS</p>
                    <ul>
                        <li>
                            <img src="media/pay_2.webp" alt="" /><img src="media/pay_3.webp" alt="" />
                        </li>
                        <li>
                            <img src="media/pay_4.webp" alt="" /><img src="media/pay_5.webp" alt="" />
                        </li>
                        <li>
                            <img src="/media/pay_7.webp" alt="" /><img src="/media/pay_8.webp" alt="" />
                        </li>
                    </ul>
                </div>
            </div>
            <p id="cpr">Copyright © 2200005850_NguyenHuyHoang</p>
        </footer>
        <script src="JS/Slide.js"></script>
        <!--	<script src="JS/Login.js"></script>-->
        <script src="JS/Cart.js"></script>
    </body>

</html>
