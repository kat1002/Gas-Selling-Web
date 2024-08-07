<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 05/07/2024
  Time: 13:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Page Not Found</title>
        <style>
            /*        body {
                        font-family: Arial, sans-serif;
                        background-color: #f2f2f2;
                        text-align: center;
                        padding: 50px;
                    }*/
            .containernotfound {
                background-color: #fff;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                padding: 20px;
                max-width: 600px;
                margin: 0 auto;
                font-family: Arial, sans-serif;
                text-align: center;
                padding: 50px;
            }
            .notfoundtitle {
                color: #555;
            }
            .textnotfound {
                color: #777;
                margin-bottom: 20px;
            }
        </style>
        <script>
            function removeFilter() {
                // Xóa tất cả các tham số query trong URL
                window.location.href = window.location.pathname;
            }
        </script>
    </head>
    <body>
        <div class="containernotfound">
            <img src="media/gas.png" width="80" height="80"/>
            <h5 class="notfoundtitle">There are no results for the selected filter</h5>
            <p class="textnotfound">No postings were found for what you filtered. Change the Filter or Unfilter criteria.</p>
            <button onclick="removeFilter()" class="btn btn-success" style="text-align: center;">Remove Filter</button>
        </div>
    </body>
</html>
