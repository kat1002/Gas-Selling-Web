<%-- 
    Document   : notsearch_customer
    Created on : Jul 5, 2024, 8:21:36 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Page Not Found</title>
        <style>
            /*        body {
                        font-family: Arial, sans-serif;
                        background-color: #f4f4f4;
                        color: #333;
                        display: flex;
                        justify-content: center;
                        align-items: center;
                        height: 100vh;
                        margin: 0;
                    }*/

            .not-found-container {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                color: #333;
/*                display: flex;*/
                justify-content: center;
                align-items: center;
                text-align: center;
/*                height: 100vh;*/
                margin: 0;
                background: white;
                padding: 40px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            .not-found-container h1 {
                font-size: 6em;
                color: #9f8a46;
                margin: 0;
            }

            .not-found-container h2 {
                font-size: 2em;
                color: #727580;
                margin: 0;
            }

            .not-found-container p {
                font-size: 1.2em;
                margin: 20px 0;
            }

            .not-found-container button {
                display: inline-block;
                margin-top: 20px;
                padding: 10px 20px;
                background-color: #9f8a46;
                color: white;
                text-decoration: none;
                border-radius: 5px;
                transition: background-color 0.3s ease;
            }

            .not-found-container button:hover {
                background-color: #85743a;
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
        <div class="not-found-container">
            <img src="media/search_no_found_filter.png" width="400" height="200"/>
            <h5>There are no results for the selected filter</h5>
            <p>No postings were found for what you filtered. Change the Filter or Unfilter criteria.</p>
            <button onclick="removeFilter()">Remove Filter</button>
        </div>
    </body>
</html>
