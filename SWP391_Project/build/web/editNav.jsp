<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="com.model.News" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>

<!DOCTYPE html>
<html>
    <head>
        <title>BLAZO | NEWS</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
        <link rel="stylesheet" href="CSS/news.css" />
        <script src="ckeditor5/ckeditor5-build-classic/ckeditor.js"></script>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <style>
            .custom-select {
                width: 20%;
                padding: 10px 15px;
                font-size: 16px;
                line-height: 1.5;
                color: #495057;
                background-color: #fff;
                background-clip: padding-box;
                border: 1px solid #ced4da;
                border-radius: 0.25rem;
                box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.075);
                transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
                margin-top: 10px;
                float:left;
            }

            .custom-select:focus {
                border-color: #80bdff;
                outline: 0;
                box-shadow: 0 0 5px rgba(128, 189, 255, 0.5);
            }
            .containerSpecial {
                display: flex;
                justify-content: space-between;
                align-items: center;
                width: 50%;
            }
            .label {
                margin-right: 10px; /* Adjust the spacing as needed */
            }
            .select {
                flex-grow: 1; /* This allows the select to take the remaining space */
            }
            .btn-return {
                display: inline-block;
                padding: 10px 20px;
                font-size: 16px;
                color: black;
                background-color: #f4f4f4;
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
        <main style="min-height:500px">
            <a href="manageNav" class="btn-return"><i class="fa-solid fa-backward"></i> Back to manage Navbar</a>
            <p class="title" id="first">Edit nav</p>
            <p style="color:green" class="grey">Must fill all attribute before submit</p>
            <form id="newsForm" action="editNav?id=${requestScope.nav.categoryId}" method="post" style="text-align: left">
                <input
                    style="caret-color: black"
                    type="text"
                    class="btn btn-primary profile-btn"
                    placeholder="Title"
                    name="title" required
                    value="${requestScope.nav.title}"
                    />
                <input
                    style="caret-color: black"
                    type="text"
                    class="btn btn-primary profile-btn"
                    placeholder="Url"
                    name="url" required
                    value="${requestScope.nav.description}"
                    />
                <input
                    style="caret-color: black"
                    type="number"
                    class="select custom-select"
                    placeholder="Position"
                    name="role" required
                    value="${requestScope.nav.role}"
                    />
                <button style="margin-top: 150px" class="btn btn-primary" type="submit">Submit</button>
            </form>


        </main>
    </body>

    <script>
        function validateForm() {
            const title = document.querySelector('input[name="title"]');
            const url = document.querySelector('input[name="url"]');

            let isValid = true;

            if (!title.value.trim()) {
                alert("Title cannot be blank");
                isValid = false;
            }
            if (!url.value.trim()) {
                alert("Title cannot be blank");
                isValid = false;
            }
            return isValid;
        }

        document.addEventListener('DOMContentLoaded', function () {
            const form = document.getElementById('newsForm');
            form.addEventListener('submit', function (event) {
                if (!validateForm()) {
                    event.preventDefault();
                }
            });
        });
    </script>

    <style>
        /* CSS for the news page */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
            color: #333;
        }

        main {
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        input[type="checkbox"] {
            transform: scale(1.5); /* Adjust the scale value to make the checkbox bigger */
            margin: 5px; /* Optional: Adjust the margin to better align with the text */
        }

        .title {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .grey {
            font-size: 14px;
            color: grey;
            margin-bottom: 20px;
        }

        form {
            display: flex;
            flex-direction: column;
        }

        input[type="text"], textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }

        input[type="file"] {
            display: none;
        }

        .custom-file-label {
            display: inline-block;
            background-color: #f4f4f4;
            color: black;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            margin-bottom: 15px;
            text-align: center;
        }

        .custom-file-label:hover {
            background-color: #0056b3;
        }

        .image-preview {
            display: block;
            margin-top: 10px;
            max-width: 100%;
            max-height: 300px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        button[type="submit"] {
            background-color: #f4f4f4;
            color: black;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            margin-top: 15px;
            text-align: center;
        }

        button[type="submit"]:hover {
            background-color: #0056b3;
        }

        .ck-editor__editable {
            min-height: 200px;
        }

        @media (max-width: 600px) {
            main {
                margin: 20px;
                padding: 15px;
            }

            .title {
                font-size: 20px;
            }

            input[type="text"], textarea {
                font-size: 14px;
            }

            .custom-file-label {
                padding: 8px 15px;
            }

            button[type="submit"] {
                font-size: 14px;
                padding: 8px 15px;
            }
        }
    </style>
</html>
