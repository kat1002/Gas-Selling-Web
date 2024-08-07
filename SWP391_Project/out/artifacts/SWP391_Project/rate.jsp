
<%-- 
    Document   : review
    Created on : Jun 14, 2024, 12:35:40 PM
    Author     : Acer Nitro 5
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <link rel="stylesheet" href="CSS/bootstrap.min.css">
        <link rel="stylesheet" href="CSS/review.css">

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
        <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-alpha1/dist/css/bootstrap.min.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <style>
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
                color: #ff0000;
                cursor: default;
            }

            .rated > label::before {
                content: "\2605";
                position: absolute;
                top: 0;
                left: 0;
            }

            .rated > input:checked ~ label {
                color: #ff0000;
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
                color: #ff0000;
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

            /*            .content{
                            margin: auto;
                            width: 80%;
                            float: left;
                            margin-left: 30px;
                            height: auto
                        }*/
            /*            .pagination {
                            display: inline-block;
                        }
                        .pagination a {
                            color: black;
                            font-size: 22px;
                            float: left;
                            padding: 8px 16px;
                            text-decoration: none;
                        }
                        .pagination a.active {
                            background-color: #4CAF50;
                            color: chocolate;
                        }
                        .pagination a:hover:not(.active) {
                            background-color: chocolate;
                        }*/

        </style>
    </head>
    <body>
        <main>

            <div class="content alert alert-primary text-center text-primary" style="margin-top: 3%;">
                <h2>Customer's reviews</h2>
            </div>
            <div class="row d-flex justify-content-center">
                <div class="card col-10 container">
                    <div class="p-3">

                        <h6>Comments</h6>

                    </div>
                    <nav>
                        <ul class="pagination justify-content-center">
                            <li class="page-item ${requestScope.page eq 1 ? 'disabled' : ''}">
                                <a class="page-link" href="<c:out value='rate?page=${page-1}'/>" tabindex="-1">Before</a>
                            </li>

                            <c:forEach begin="${1}" end="${requestScope.num}" var="i">
                                <li class="${i==page ? 'bg-primary' : ''} page-item">
                                    <a class="page-link" href="rate?page=${i}">${i}</a>
                                </li>
                            </c:forEach>

                            <li class="page-item ${page eq requestScope.num ? 'disabled' : ''}">
                                <a class="page-link" href="<c:out value='rate?page=${page+1}'/>">After</a>
                            </li>
                        </ul>
                    </nav>

                    <div class="mt-3 align-items-center p-3">
                        
                        <form action="addrate">
                            <div class="d-flex flex-row form-color">
                                <img src="'https://cdn-icons-png.freepik.com/512/3177/3177440.png'" width="50" class="rounded-circle mr-2">
                                <input type="text" name="id" class="d-none" value="${sessionScope.account.id}">&nbsp;
                                <div class="rate">

                                    <input type="radio" name="rate" value="5" id="5"><label for="5">☆</label>
                                    <input type="radio" name="rate" value="4" id="4"><label for="4">☆</label>
                                    <input type="radio" name="rate" value="3" id="3"><label for="3">☆</label>
                                    <input type="radio" name="rate" value="2" id="2"><label for="2">☆</label>
                                    <input type="radio" name="rate" value="1" id="1"><label for="1">☆</label>
                                </div>
                                <input type="submit" class="btn btn-primary" value="Send" width="50">   <!-- when submit, data got sent to the servlet-->
                            </div>
                        </form>
                                
                        <!-- list of all raters -->
                        <div class="mt-2" id="content">
                            <c:forEach items="${listR}" var="r">
                                <c:set var="user" value="${r.getCustomer(r.customer_id)}"/>
                                
                                <div class="cmt d-flex flex-row p-3">   
                                    <img src="'https://cdn-icons-png.freepik.com/512/3177/3177440.png'" width="40" height="40" class="rounded-circle mr-3">
                                    <div class="w-100">

                                        <div class="d-flex justify-content-between align-items-center">
                                            <div class="d-flex flex-row align-items-center">
                                                <span class="mr-2"><p>${user.username}</p>
                                                    <div class="rated">
                                                        <input type="radio" disabled ${(r.rate eq 1) ? 'checked' : ''} id="1"><label for="1">☆</label>
                                                        <input type="radio" disabled ${(r.rate eq 2) ? 'checked' : ''} id="2"><label for="2">☆</label>
                                                        <input type="radio" disabled ${(r.rate eq 3) ? 'checked' : ''} id="3"><label for="3">☆</label>
                                                        <input type="radio" disabled ${(r.rate eq 4) ? 'checked' : ''} id="4"><label for="4">☆</label>
                                                        <input type="radio" disabled ${(r.rate eq 5) ? 'checked' : ''} id="5"><label for="5">☆</label>
                                                    </div>
                                                </span>
                                            </div>

                                        </div>
                                        <p class="text-justify comment-text mb-0">${r.rate}</p>
                                    </div>
                                    
                                    <c:if test="${(sessionScope.account.isAdmin eq 1) or (sessionScope.account.id eq r.uid)}">
                                        <a class="btn btn-white text-primary" href="editcomment?id=${r.rid}">✏</a>
                                        <a class="btn btn-white text-danger" onclick="doDelete('${r.rid}')" >🗑️</a>
                                    </c:if>

                                </div>
                            </c:forEach>
                        </div>
                        
                    </div>
                </div>
            </div>
        </main>


        <!-- Comment JS -->                
        <script type="text/javascript">
            function doDelete(id) {
                if (confirm('Are you sure about deleting this comment ?')) {
                    window.location = 'deletereview?id=' + id;
                }
            }
        </script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script>
            function loadMore() {
                var amount = document.getElementsByClassName("cmt").length;
                $.ajax({
                    url: "/motor.shoppe/loadmorecomment",
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
