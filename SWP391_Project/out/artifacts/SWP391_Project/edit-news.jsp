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
        </style>
    </head>
    <jsp:include page="header.jsp" />
    <body>
        <main style="min-height:1000px">
            <p class="title" id="first">Edit news</p>

            <form id="newsForm" enctype="multipart/form-data" action="edit-news?id=${requestScope.news.newsId}" method="post" style="text-align: left">
                <input
                    style="caret-color: black"
                    type="text"
                    class="btn btn-primary profile-btn"
                    placeholder="Title"
                    value="${requestScope.news.title}"
                    name="title" required
                    />
                 <input
                    style="caret-color: black;"
                    id="fileInput"
                    type="file"
                    accept="image/*"
                    name="theme_image"
                    />
                <input style="display:none" name="sub_theme_image" value="${requestScope.news.theme_image}"/>
                <textarea
                    style="caret-color: black"
                    class="btn btn-primary profile-btn"
                    placeholder="Short description"
                    name="short_des" required
                    >${requestScope.news.short_description}</textarea>
                <label style="text-align:left" for="fileInput" class="custom-file-label">Choose theme image</label>
                <img id="imagePreview" class="image-preview" src="${requestScope.news.theme_image}" alt="Image Preview" />
                <textarea name="content" id="editor">${requestScope.news.body}</textarea>
                <button style="margin-top: 10px" class="btn btn-primary" type="submit">Save</button>
            </form>


        </main>
    </body>
    <jsp:include page="footer.jsp" />
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
    </script>
    
    <script>
        document.getElementById('fileInput').addEventListener('change', function(event) {
            const file = event.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    const imagePreview = document.getElementById('imagePreview');
                    imagePreview.src = e.target.result;
                    imagePreview.style.display = 'block';
                }
                reader.readAsDataURL(file);
            }
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
