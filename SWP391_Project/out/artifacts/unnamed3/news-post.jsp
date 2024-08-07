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

            <div class="row">
                <div>
                    <p class="cmt">
                        ${requestScope.news.body}
                    </p>
                </div>
                <div>
                    <img src="${requestScope.news.image}" alt="" />
                </div>
            </div>

        </main>
	<jsp:include page="footer.jsp" />
        <script src="JS/Login.js"></script>
        <script src="JS/Cart.js"></script>
    </body>

</html>