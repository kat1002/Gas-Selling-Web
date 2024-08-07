<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
    Document   : cart
    Created on : May 15, 2024, 10:45:53 AM
    Author     : kat1002
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>BLAZO | CART</title>
    <link href="CSS/cart2.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"/>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
</head>
<body>
<jsp:include page="header.jsp"/>

<div class="shopping-cart">
    <!-- Title -->
    <div class="title">
        Shopping Bag
    </div>

    <c:forEach items="cart_items" var="product">
        <div class="item">
            <div class="buttons">
              <span class="delete-btn">
                  <i class="fa fa-times" aria-hidden="true"></i>
              </span>
            </div>

            <div class="image">
                <img src="${product.getImages()[0]}" alt=""/>
            </div>

            <div class="description">
                <span>${product.getTitle()}</span>
                <span>${product.getCategory()}</span>
            </div>

            <div class="quantity">
                <button class="plus-btn" type="button" name="button">
                    <i class="fa fa-plus" aria-hidden="true"></i>
                </button>
                <input type="text" name="name" value="1">
                <button class="minus-btn" type="button" name="button">
                    <i class="fa fa-minus" aria-hidden="true"></i>
                </button>
            </div>

            <div class="total-price">$${product.getPrice()}</div>
        </div>
    </c:forEach>


    <div class="container">
        <div class="total">
            Total: $0.00
        </div>
        <button class="proceed-button">Proceed</button>
    </div>


</div>
<script type="text/javascript">
    $('.minus-btn').on('click', function (e) {
        e.preventDefault();
        var $this = $(this);
        var $input = $this.closest('div').find('input');
        var value = parseInt($input.val());

        if (value > 1) {
            value = value - 1;
        } else {
            value = 0;
        }

        $input.val(value);

    });

    $('.plus-btn').on('click', function (e) {
        e.preventDefault();
        var $this = $(this);
        var $input = $this.closest('div').find('input');
        var value = parseInt($input.val());

        if (value < 100) {
            value = value + 1;
        } else {
            value = 100;
        }

        $input.val(value);
    });

    $('.like-btn').on('click', function () {
        $(this).toggleClass('is-active');
    });
</script>

<!-- Include footer -->
<jsp:include page="footer.jsp"/>
</body>
</html>
