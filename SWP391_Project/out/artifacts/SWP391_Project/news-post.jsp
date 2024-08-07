<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

    <head>
        <title>BLAZO | NEWS</title>

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
            <div><p style="padding-left: 15px" class="grey date">${requestScope.news.createdAt}</p></div>

            <c:if test="${sessionScope.role ne 0}">
                <div style="display: flex;flex-direction:row">
                    <div class="img-list-desk" style="width: 50%">
                        <div class="menu">
                            <a href="edit-news?id=${requestScope.news.newsId}" class="news-card" style="text-decoration: none">                            
                                <div style="margin-left: 10px;text-align:center;line-height: 150px; ">
                                    <i style="margin-right:10px" class="fa-regular fa-pen-to-square"></i>Edit

                                </div >
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
            </c:if> 
            <div class="row" style="min-height: 200px">
                <div>
                    <p  class="cmt">
                        ${requestScope.news.body}
                    </p>
                </div>
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