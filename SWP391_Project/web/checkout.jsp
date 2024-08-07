<%-- 
    Document   : checkout
    Created on : Jul 17, 2024, 3:37:01 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <jsp:useBean id="product"  class="com.model.DAO.ProductDAO"  scope="request"></jsp:useBean>
        <jsp:useBean id="discount"  class="com.model.DAO.DiscountDAO"  scope="request"></jsp:useBean>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <meta charset="utf-8">
            <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
            <meta name="description" content="">
            <meta name="author" content="">
            <link rel="icon" href="/docs/4.0/assets/img/favicons/favicon.ico">
            <script src="js/checkout.js"></script>
            <title>Checkout example for Bootstrap</title>
            <link rel="icon" href="media/icon/icons8-checkout-50.png"/>
            <link rel="canonical" href="https://getbootstrap.com/docs/4.0/examples/checkout/">
            <!-- Include jQuery and the custom JavaScript file -->
            <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
            <script src="js/checkout.js"></script>
            <!-- Bootstrap core CSS -->
            <link href="./CSS/bootstrap.min.css" rel="stylesheet">
            <!-- Custom styles for this template -->
            <style>
                .continue-button {
                    margin-bottom: 15px;
                }
            </style>
            <script>
                $(document).ready(function () {
                    $("#voucher-form").submit(function (event) {
                        event.preventDefault();
                        var voucherCode = $("#voucher-code").val();
                        var currentTotal = $("#current-total-price").val();
                        $.ajax({
                            type: "POST",
                            url: "validatevoucher",
                            data: {
                                voucherCode: voucherCode,
                                currentTotal: currentTotal
                            },
                            dataType: "json",
                            success: function (response) {
                                if (response.success) {
                                    // Format the new total to currency format with two decimal places
                                    var formattedTotal = new Intl.NumberFormat('vi-VN', {
                                        style: 'currency',
                                        currency: 'VND',
                                        minimumFractionDigits: 2
                                    }).format(response.newTotal);

                                    var formattedDiscount = new Intl.NumberFormat('vi-VN', {
                                        style: 'currency',
                                        currency: 'VND',
                                        minimumFractionDigits: 2
                                    }).format(response.total - response.newTotal);
                                    $("#voucher-code-code").text(response.code);
                                    $("#final-total").text(formattedTotal);
                                    $("#voucher-discount").text('-$' + (response.total - response.newTotal).toFixed(2));
                                    // Update the hidden input fields
                                    $("#voucher-id").val(response.vid);
                                    $("#total-price-form").val(response.newTotal.toFixed(2));
                                } else {
                                    alert("Invalid voucher code");
                                }
                            },
                            error: function () {
                                alert("Error validating voucher code");
                            }
                        });
                    });
                });
            </script>
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
                            <span class="badge badge-secondary badge-pill">${requestScope.cartItemList.size()}</span>
                        </h4>
                        <ul class="list-group mb-3">


                            <c:forEach items="${requestScope.cartItemList}" var="c" >
                                <li class="list-group-item d-flex justify-content-between lh-condensed">
                                    <div>
                                        <small class="text-muted">
                                            <c:if test="${not empty product.getProduct(c.getProductId())}">
                                                ${product.getProduct(c.getProductId()).getTitle()}
                                            </c:if>
                                        </small>
                                    </div>
                                    <div>
                                        <small class="text-muted">
                                            Quantity: ${c.getQuantity()}
                                        </small>
                                    </div>
                                    <span class="text-muted">
                                        <fmt:formatNumber value="${c.getQuantity() * (product.getProduct(c.getProductId()).getPrice() - (product.getProduct(c.getProductId()).getPrice() * discount.getDiscount(product.getProduct(c.getProductId()).getDiscountId()).getDiscountValue()))}" type="number" minFractionDigits="2" maxFractionDigits="2"/>&#8363;
                                    </span>
                                </li>
                            </c:forEach>

                      <%--      <c:set var="total" value="0" />
                            <c:forEach items="${requestScope.cartItemList}" var="c">
                                <c:set var="productt" value="${product.getProduct(c.getProductId())}" />
                                <c:set var="discountValue" value="0" />
                                <c:if test="${productt ne null}">
                                    <c:set var="discountt" value="${discount.getDiscount(productt.getDiscountId())}" />
                                    <c:if test="${discountt ne null}">
                                        <c:set var="discountValue" value="${discountt.getDiscountValue()}" />
                                    </c:if>
                                    <c:set var="itemPrice" value="${productt.getPrice() - (productt.getPrice() * discountValue)}" />
                                    <c:set var="lineItemTotal" value="${c.getQuantity() * itemPrice}" />
                                    <c:set var="total" value="${total + lineItemTotal}" />
                                </c:if>
                            </c:forEach> --%>
                            <li class="list-group-item d-flex justify-content-between bg-light">
                                <div class="text-success">
                                    <h6 class="my-0">Voucher code</h6>
                                    <small id="voucher-code-code"></small>
                                </div>
                                <span class="text-success">-</span>
                            </li>
                            <li class="list-group-item d-flex justify-content-between">
                                <span>Total</span>
                                <strong id="total">
                                    <fmt:formatNumber value="${total}" type="number" minFractionDigits="2" maxFractionDigits="2"/>&#8363;
                                </strong>
                            </li>
                            <li class="list-group-item d-flex justify-content-between">
                                <span>Final Total</span>
                                <strong id="final-total">
                                    <fmt:formatNumber value="${total}" type="number" minFractionDigits="2" maxFractionDigits="2"/>&#8363;
                                </strong>
                            </li>
                        </ul>

                        <form id="voucher-form" class="card p-2">
                            <div class="input-group">
                                <input type="hidden" name="totalprice" id="current-total-price" value="${total}"/>
                                <input type="text" name="redeem" class="form-control" id="voucher-code" placeholder="Promo code">
                                <div class="input-group-append">
                                    <button type="submit" class="btn btn-secondary">Redeem</button>
                                </div>
                            </div>
                        </form>
                    </div>

                    <!-- user info -->
                    <!-- "user" is variable on session  -->
                    <div class="col-md-8 order-md-1">
                        <h4 class="mb-3">Billing detail</h4>

                        <form action="checkout" method="post">
                            <input type="hidden" name="voucherid" id="voucher-id" value=""/>
                            <input type="hidden" name="totalprice" id="total-price-form" value="${total}"/>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="firstName">First name</label>
                                    <input type="text" name="firstname" class="form-control" id="firstName" placeholder=""
                                           value="${sessionScope.user.getFirst_name()}" readonly>

                                    <div class="invalid-feedback">
                                        Valid first name is required.
                                    </div>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="lastName">Last name</label>
                                    <input type="text" name="lastname" class="form-control" id="lastName" placeholder=""
                                           value="${sessionScope.user.getLast_name()}" readonly>

                                    <div class="invalid-feedback">
                                        Valid last name is required.
                                    </div>
                                </div>
                            </div>


                            <div class="mb-3">
                                <label for="email">Email</label>
                                <input type="email" name="email" class="form-control" id="email"
                                       value="${sessionScope.user.getGmail()}" readonly>

                                <div class="invalid-feedback">
                                    Please enter a valid email address for shipping updates.
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="phone">Phone number</label>
                                <input type="tel" name="phonenumber" class="form-control" id="phone"
                                       value="${sessionScope.user.getPhone_number()}" required>

                                <div class="invalid-feedback">
                                    Please enter a valid phone number for shipping updates.
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="address">Address 1</label>
                                <input type="text" name="address1" class="form-control" id="address"
                                       value="${sessionScope.user.getAddress_line1()}" required>
                                <div class="invalid-feedback">
                                    Please enter your shipping address.
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="address2">Address 2 <span class="text-muted">(Optional)</span></label>
                                <input type="text" name="address2" class="form-control" id="address2"
                                       value="${sessionScope.user.getAddress_line2()}">
                            </div>

                            <div class="row">
                                <div class="col-md-5 mb-3">
                                    <label for="country">City</label>
                                    <input type="text" name="city" class="form-control" id="zip" value="${sessionScope.user.getCity()}" required>
                                    <div class="invalid-feedback">
                                        Please select a valid country.
                                    </div>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <label for="zip">Postal code</label>
                                    <input type="text" name="postal" class="form-control" id="zip" value="${sessionScope.user.getPostal_code()}" required>
                                    <div class="invalid-feedback">
                                        Zip code required.
                                    </div>
                                </div>
                            </div>
                            <hr class="mb-4">
                            <div class="custom-control custom-checkbox">
                                <input type="checkbox" class="custom-control-input" id="save-info" name="saveInfo">
                                <label class="custom-control-label" for="save-info">Save this information for next time</label>
                            </div>
                            <hr class="mb-4">
                            <h4 class="mb-3">Payment</h4>
                            <div class="d-block my-3">
                                <div class="custom-control custom-radio">
                                    <input id="cod" name="paymentMethod" value="1" type="radio" class="custom-control-input" required>
                                    <label class="custom-control-label" for="cod">Cash On Delivery (COD)</label>
                                </div>
                                <div class="custom-control custom-radio">
                                    <input id="payonline" name="paymentMethod" value="2" type="radio" class="custom-control-input" required>
                                    <label class="custom-control-label" for="payonline">Pay Online</label>
                                </div>
                            </div>

                            <hr class="mb-4">
                            <button class="btn btn-primary btn-lg btn-block continue-button" type="submit">
                                Continue to checkout
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </main>

        <jsp:include page="footer.jsp"/>


    </body>
</html>