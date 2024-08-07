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
        <link rel="icon" href="media/icon/icons8-news-48.png"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
        <link rel="stylesheet" href="CSS/news.css" />
        <script src="ckeditor5/ckeditor5-build-classic/ckeditor.js"></script>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <style>
            #fileInput {
                display: none;
            }
            .custom-file-label {
                display: inline-block;
                background-color: buttonface;
                color: black;
                padding: 0.6rem 2rem;
                border-radius: 1rem;
                cursor: pointer;
            }
            .image-preview {
                margin-top: 20px;
                max-width: 100%;
                max-height: 300px;
            }
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
            .hidden-input {
                display: none;
                margin-top: 10px;
            }

        </style>
    </head>

    <body>
        <main style="min-height:500px">
            <a href="manageNews" class="btn-return"><i class="fa-solid fa-backward"></i> Back to manage News</a>
            <p class="title" id="first">Add news</p>
            <p style="color:green" class="grey">Must fill all attribute before submit</p>
            <form enctype="multipart/form-data" id="newsForm" action="add-news" method="post" style="text-align: left">
                <input
                    style="caret-color: black"
                    type="text"
                    class="btn btn-primary profile-btn"
                    placeholder="Title"
                    name="title" required
                    />
                <input
                    style="caret-color: black;"
                    id="fileInput"
                    type="file"
                    accept="image/*"
                    name="theme_image" required
                    />
                <textarea
                    style="caret-color: black"
                    class="btn btn-primary profile-btn"
                    placeholder="Short description"
                    name="short_des" required
                    ></textarea>
                <label style="text-align:left;margin-bottom: 5px" for="fileInput" class="custom-file-label">Choose theme image</label>
                <img id="imagePreview" class="image-preview" src="" alt="Image Preview" style="display: none;margin-bottom: 5px"/>
                <textarea  name="content" id="editor"></textarea>
                <label style="margin-top:10px" class="label" for="newsCate">Choose a news category:</label>
                <select class="select custom-select" id="newsCate" name="newsCate" onchange="toggleAnotherInput()">
                    <c:forEach var="c" items="${requestScope.listNewsCategory}">
                        <option value="${c}" <c:if test="${requestScope.news.newsCategory eq c}">selected</c:if>>${c}</option>
                    </c:forEach>
                    <option value="Another">Another:</option>
                </select>
                <input style="width: 30%;" type="text" id="anotherNewsCate" class="hidden-input" name="anotherNewsCate" placeholder="Enter news category"/>
                <div style="font-size:18px;margin-top:5px"><input value="true" type="checkbox" name="sendNotic"/> 
                    Send notification for user via email
                </div>
                <button style="margin-top: 10px" class="btn btn-primary" type="submit">Submit</button>
            </form>


        </main>
    </body>
    <script>
        ClassicEditor
                .create(document.querySelector('#editor'), {
                    extraPlugins: [MyCustomUploadAdapterPlugin],
                    image: {
                        toolbar: ['imageTextAlternative', 'imageStyle:full', 'imageStyle:side']
                    }
                })
                .catch(error => {
                    console.error(error);
                });

        function MyCustomUploadAdapterPlugin(editor) {
            editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
                return new MyUploadAdapter(loader);
            };
        }

        class MyUploadAdapter {
            constructor(loader) {
                this.loader = loader;
                this.reader = new FileReader();
            }

            upload() {
                return this.loader.file
                        .then(file => new Promise((resolve, reject) => {
                                this._initListeners(resolve, reject);
                                this.reader.readAsDataURL(file);
                            }));
            }

            _initListeners(resolve, reject) {
                this.reader.onload = () => resolve({default: this.reader.result});
                this.reader.onerror = error => reject(error);
            }

            abort() {
                this.reader.abort();
            }
        }

        document.getElementById('fileInput').addEventListener('change', function (event) {
            const file = event.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function (e) {
                    const imagePreview = document.getElementById('imagePreview');
                    imagePreview.src = e.target.result;
                    imagePreview.style.display = 'block';
                }
                reader.readAsDataURL(file);
            }
        });

        document.getElementById('newsForm').addEventListener('submit', function (event) {
            var fileInput = document.getElementById('fileInput');
            var file = fileInput.files[0];
            var fileType = file.type.split('/')[0];

            if (fileType !== 'image') {
                alert('Please choose an image file.');
                event.preventDefault(); // Prevent form submission
            }
        });
        function toggleAnotherInput() {
            const selectBox = document.getElementById('newsCate');
            const anotherInput = document.getElementById('anotherNewsCate');
            if (selectBox.value == 'Another') {
                anotherInput.style.display = 'block';
                anotherInput.required = true;
            } else {
                anotherInput.style.display = 'none';
                anotherInput.required = false;
            }
        }
        ;
    </script>

    <script>
        document.getElementById('fileInput').addEventListener('change', function (event) {
            const file = event.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function (e) {
                    const imagePreview = document.getElementById('imagePreview');
                    imagePreview.src = e.target.result;
                    imagePreview.style.display = 'block';
                }
                reader.readAsDataURL(file);
            }
        });
    </script>

    <script>
        function validateForm() {
            const title = document.querySelector('input[name="title"]');
            const shortDescription = document.querySelector('textarea[name="short_des"]');
            const content = document.querySelector('textarea[name="content"]');
            let isValid = true;

            if (!title.value.trim()) {
                alert("Title cannot be blank");
                isValid = false;
            }
            if (!shortDescription.value.trim()) {
                alert("Short description cannot be blank");
                isValid = false;
            }
            if (!content.value.trim()) {
                alert("Content cannot be blank");
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
</html>
