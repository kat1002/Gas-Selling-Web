<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

    <head>
        <title>BLAZO | NEWS</title>
        <link rel="icon" href="media/icon/icons8-news-48.png"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
    </head>

    <body>
        <jsp:include page="header.jsp" />
        <link rel="stylesheet" href="CSS/about.css" />
        <link rel="stylesheet" href="CSS/main.css" />
        <link rel="stylesheet" href="CSS/news.css" />
        <main>

            <div><p class="title" id="abc">${requestScope.news.title}</p></div>
            <div><p style="padding-left: 15px" class="grey date">${requestScope.news.createdAt}/ 
                    <a class="grey" href="news?newsCate=${requestScope.news.newsCategory}">${requestScope.news.newsCategory}</a>
                </p></div>

<%--            <c:if test="${sessionScope.role eq 0}">
                <div style="display: flex;flex-direction:row">
                    <div class="img-list-desk" style="width: 50%">
                        <div class="menu">
                            <a href="edit-news?id=${requestScope.news.newsId}" class="news-card" style="text-decoration: none">                            
                                <div style="margin-left: 10px;text-align:center;line-height: 150px; ">
                                    <i style="margin-right:10px" class="fa-regular fa-pen-to-square"></i>Edit

                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="img-list-desk" style="width: 50%">
                        <div class="menu">
                            <a href="delete-news-post?id=${requestScope.news.newsId}" class="news-card" 
                               style="text-decoration: none" onclick="return confirmDelete();">                            
                                <div style="margin-left: 10px;text-align:center;line-height: 150px; ">
                                    <i style="margin-right:10px" class="fa-solid fa-trash-can"></i>Delete
                                </div >
                            </a>
                        </div>
                    </div>
                </div>
            </c:if>  --%>
            <div class="row" style="min-height: 200px">
                <div>
                    <p  class="cmt">
                        ${requestScope.news.body}
                    </p>
                </div>
            </div>
                    <p style="margin-bottom:70px;margin-top: 70px" class="title" id="abc"></p>

            <c:if test="${requestScope.news.newsCategory ne 'Hot'}">
                <p  class="title" id="first">
                    <a style="color:black" href="news?newsCate=${requestScope.news.newsCategory}">${requestScope.news.newsCategory}</a>
                </p>
                <div class="product" style=" position: relative;">
                    <ul>
                        <c:forEach items="${requestScope.listNewsCate}" var="d">

                            <li class="product-card-abc">
                                <a href="news-post?news-id=${d.newsId}">
                                    <img class="abc" src="${d.theme_image}" alt="" />
                                </a>
                                <h4>${d.title}</h4>
                                <p class="grey">${d.createdAt}</p>
                                <p style="margin-top: 10px; color: black;max-height:147px;overflow:hidden">${d.short_description}</p>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </c:if>

                <p style="color:black" class="title" id="first">
                    <a style="color:black;text-decoration: none" href="news?newsCate=Hot">Hot</a>
                </p>
            <div class="product" style=" position: relative;">
                <ul>
                    <c:forEach items="${requestScope.listNewsHot}" var="d">

                        <li class="product-card-abc">
                            <a href="news-post?news-id=${d.newsId}">
                                <img class="abc" src="${d.theme_image}" alt="" />
                            </a>
                            <h4>${d.title}</h4>
                            <p class="grey">${d.createdAt}</p>
                            <p style="margin-top: 10px; color: black;max-height:147px;overflow:hidden">${d.short_description}</p>
                        </li>
                    </c:forEach>
                </ul>
            </div>

            <p style="color:black" class="title" id="first">
                <a style="color:black;text-decoration: none" href="news">New</a>
            </p>
            <div class="product" style=" position: relative;">
                <ul>
                    <c:forEach items="${requestScope.listNewsNew}" var="d">

                        <li class="product-card-abc">
                            <a href="news-post?news-id=${d.newsId}">
                                <img class="abc" src="${d.theme_image}" alt="" />
                            </a>
                            <h4>${d.title}</h4>
                            <p class="grey">${d.createdAt}</p>
                            <p style="margin-top: 10px; color: black;max-height:147px;overflow:hidden">${d.short_description}</p>
                        </li>
                    </c:forEach>
                </ul>
            </div>


        </main>
        <jsp:include page="footer.jsp" />
        <script src="JS/Login.js"></script>
        <script src="JS/Cart.js"></script>
        <script type="text/javascript">
                                   function confirmDelete() {
                                       return confirm("Are you sure you want to delete this news post?");
                                   }
        </script>
    </body>

</html>