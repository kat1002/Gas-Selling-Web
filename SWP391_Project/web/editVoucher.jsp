<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Add Voucher</title>
        <link href="CSS/main.css" rel="stylesheet" type="text/css"/>
        <link href="CSS/profile.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css"
              integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
        <meta charset="utf-8"/>
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <style>
            .mt-6 {
                margin-top: 4.5rem !important;
            }

            .mt-7 {
                margin-top: 6rem !important;
            }

            @media screen and (max-width: 576px) {
                .mt-7 {
                    margin-top: 8rem !important;
                }
            }

            @media screen and (max-width: 720px) {
                .mt-7 {
                    margin-top: 8rem !important;
                }
            }
            .btn-return {
                display: inline-block;
                padding: 10px 20px;
                font-size: 16px;
                color: black;
                background-color: white;
                text-align: center;
                text-decoration: none;
                border-radius: 5px;
                position: absolute;
                top: 10px;
                left: 10px;
            }
        </style>
    </head>
    <body>
        <div class="container mt-7" style="min-height: 500px">
            <a href="manageVoucher" class="btn-return"><i class="fa-solid fa-backward"></i> Back to manage voucher</a>
            <!-- Add Voucher Form -->
            <div class="col-lg-12 pb-5">
                <form class="row mt-lg-5" action="editVoucher?id=${requestScope.voucher.voucherId}" method="post">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="voucher-code">Voucher Code</label>
                            <input class="form-control" type="text" id="voucher-code" name="voucherCode" required=""
                                   value="${requestScope.voucher.voucherCode}">
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="title">Title</label>
                            <input class="form-control" type="text" id="title" name="title" required=""
                                   value="${requestScope.voucher.title}">
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="description">Description</label>
                            <input class="form-control" type="text" id="description" name="description" required=""
                                   value="${requestScope.voucher.description}">
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="discount-type">Discount Type</label>
                            <input class="form-control" type="number" id="discount-type" name="discountType" required=""
                                   value="${requestScope.voucher.discountType}">
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="discount-value">Discount Value</label>
                            <input class="form-control" type="number" step="0.01" id="discount-value" name="discountValue" required=""
                                   value="${requestScope.voucher.discountValue}">
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="condition">Condition</label>
                            <input class="form-control" type="number" step="0.01" id="condition" name="condition" required=""
                                   value="${requestScope.voucher.condition}">
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="quantity">Quantity</label>
                            <input class="form-control" type="number" id="quantity" name="quantity" required=""
                                   value="${requestScope.voucher.quantity}">
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="expiry">Expiry</label>
                            <!--                            <input class="form-control" type="datetime-local" id="expiry" name="expiry" required="">-->
                            <input class="form-control" type="date" id="expiry" name="expiry" required=""
                                   value="${requestScope.voucher.expiry}">
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="expiry">Status</label>
                            <select name="status">
                                <option value="1" <c:if test="${requestScope.voucher.status eq true}">selected</c:if>>True</option>
                                <option value="0" <c:if test="${requestScope.voucher.status eq false}">selected</c:if>>False</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-12">
                        <hr class="mt-2 mb-3">
                        <div class="d-flex flex-wrap justify-content-between align-items-center">
                            <button class="btn btn-style-1 btn-primary" type="submit">Edit Voucher</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>