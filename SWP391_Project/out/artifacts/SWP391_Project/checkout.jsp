<%--
    Document   : checkout
    Created on : May 23, 2024, 7:33:48 AM
    Author     : kat1002
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="/docs/4.0/assets/img/favicons/favicon.ico">

    <title>Checkout example for Bootstrap</title>

    <link rel="canonical" href="https://getbootstrap.com/docs/4.0/examples/checkout/">

    <!-- Bootstrap core CSS -->
    <link href="./CSS/bootstrap.min.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <style>
        .continue-button {
            margin-bottom: 15px;
        }
    </style>
</head>

<body>

<jsp:include page="header.jsp"/>

<main>
    <div class="container">
        <div class="py-5 text-center">
            <h2>Checkout</h2>
        </div>

        <div class="row">
            <div class="col-md-4 order-md-2 mb-4">
                <h4 class="d-flex justify-content-between align-items-center mb-3">
                    <span class="text-muted">Your cart</span>
                    <span class="badge badge-secondary badge-pill" id="cartItemCount">0</span>
                </h4>
                <ul class="list-group mb-3" id="cartItemList">
                    <!-- Cart items will be dynamically populated here -->
                </ul>

                <div class="list-group-item d-flex justify-content-between bg-light" id="voucherDetails" style="display: none;">
                    <div class="text-success">
                        <h6 class="my-0">Voucher code</h6>
                        <small id="voucherCode"></small>
                    </div>
                    <span class="text-success" id="discountValue"></span>
                </div>

                <div class="list-group-item d-flex justify-content-between" id="totalAmount">
                    <span>Total</span>
                    <strong id="totalValue">$0.00</strong>
                </div>

                <form id="promo-code-form" class="card p-2" onsubmit="redeemPromoCode(event);">
                    <div class="input-group">
                        <input type="text" id="promo-code" class="form-control" placeholder="Promo code">
                        <div class="input-group-append">
                            <button type="submit" class="btn btn-secondary">Redeem</button>
                        </div>
                    </div>
                </form>
            </div>


            <div class="col-md-8 order-md-1">
                <h4 class="mb-3">Shipping address</h4>

                <form id="checkout-form" class="needs-validation" novalidate>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="firstName">First name</label>
                            <input type="text" class="form-control" id="firstName" placeholder="" required>
                            <div class="invalid-feedback">
                                Valid first name is required.
                            </div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="lastName">Last name</label>
                            <input type="text" class="form-control" id="lastName" placeholder="" required>
                            <div class="invalid-feedback">
                                Valid last name is required.
                            </div>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="email">Email</label>
                        <input type="email" class="form-control" id="email" readonly>
                        <div class="invalid-feedback">
                            Please enter a valid email address for shipping updates.
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="phone_number">Phone number</label>
                        <input type="text" class="form-control" id="phone_number" required>
                        <div class="invalid-feedback">
                            Please enter a valid phone number for shipping updates.
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="address_line1">Address Line 1</label>
                        <input type="text" class="form-control" id="address_line1" required>
                        <div class="invalid-feedback">
                            Please enter your shipping address.
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="address_line2">Address Line 2 <span class="text-muted">(Optional)</span></label>
                        <input type="text" class="form-control" id="address_line2">
                    </div>
                    <div class="row">
                        <div class="col-md-5 mb-3">
                            <label for="city">City</label>
                            <input type="text" class="form-control" id="city" required>
                            <div class="invalid-feedback">
                                City required.
                            </div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <label for="zip">Postal Code</label>
                            <input type="text" class="form-control" id="zip" required>
                            <div class="invalid-feedback">
                                Postal code required.
                            </div>
                        </div>
                    </div>
                    <hr class="mb-4">
                    <div class="custom-control custom-checkbox">
                        <input type="checkbox" class="custom-control-input" id="save-info">
                        <label class="custom-control-label" for="save-info">Save this information for next time</label>
                    </div>
                    <hr class="mb-4">
                    <h4 class="mb-3">Payment</h4>
                    <div class="d-block my-3">
                        <div class="custom-control custom-radio">
                            <input id="credit" name="paymentMethod" type="radio" class="custom-control-input" checked
                                   required>
                            <label class="custom-control-label" for="credit">Cash On Delivery (COD)</label>
                        </div>
                    </div>
                    <hr class="mb-4">
                    <button class="btn btn-primary btn-lg btn-block continue-button" type="button" onclick="checkout()">
                        Continue to checkout
                    </button>
                </form>
            </div>
        </div>
    </div>
</main>

<jsp:include page="footer.jsp"/>

<!-- Include jQuery and the custom JavaScript file -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="js/checkout.js"></script>
</body>
</html>
