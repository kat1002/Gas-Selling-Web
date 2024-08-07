<%-- 
    Document   : productlist
    Created on : Jun 3, 2024, 9:30:14 PM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>List product</title>
        <style>
            /* styles.css */

            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f8f9fa;
            }

            .navbar {
                background-color: #343a40;
                color: white;
                padding: 1em;
                text-align: center;
            }

            .container {
                padding: 2em;
            }

            .btn {
                display: inline-block;
                padding: 0.5em 1em;
                margin: 0.2em;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 1em;
            }

            .btn-primary {
                background-color: #007bff;
                color: white;
            }

            .btn-success {
                background-color: #28a745;
                color: white;
            }

            .table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 1em;
            }

            th, td {
                border: 1px solid #dee2e6;
                padding: 8px;
                text-align: left;
            }

            th {
                background-color: #e9ecef;
            }

            .modal {
                display: none;
                position: fixed;
                z-index: 1;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                overflow: auto;
                background-color: rgba(0,0,0,0.5);
                padding-top: 80px;
            }

            .modal-content {
                background-color: #fff;
                margin: 5% auto;
                padding: 20px;
                border: 1px solid #888;
                border-radius: 4px;
                width: 80%;
                max-width: 600px;
            }

            .closeBtn {
                color: #aaa;
                float: right;
                font-size: 28px;
                margin-bottom: 10%;
                font-weight: bold;
            }

            .closeBtn:hover,
            .closeBtn:focus {
                color: black;
                text-decoration: none;
                cursor: pointer;
            }

            .form {
                display: flex;
                flex-direction: column;
            }

            .form-group {
                margin-bottom: 1em;
            }

            .form-control {
                width: 100%;
                padding: 0.5em;
                font-size: 1em;
                border: 1px solid #ced4da;
                border-radius: 4px;
            }

            .footer {
                background-color: #343a40;
                color: white;
                text-align: center;
                padding: 1em;
                position: fixed;
                bottom: 0;
                width: 100%;
            }

        </style>
        <script>
            document.addEventListener("DOMContentLoaded", () => {
                const productFormModal = document.getElementById('productFormModal');
                const addProductBtn = document.getElementById('addProductBtn');
                const closeBtn = document.querySelector('.closeBtn');
                const productForm = document.getElementById('productForm');
                const productList = document.getElementById('productList');
                let editingProduct = null;

                addProductBtn.onclick = () => {
                    productForm.reset();
                    editingProduct = null;
                    productFormModal.style.display = "block";
                }

                closeBtn.onclick = () => {
                    productFormModal.style.display = "none";
                }

                window.onclick = (event) => {
                    if (event.target == productFormModal) {
                        productFormModal.style.display = "none";
                    }
                }

                productForm.onsubmit = (event) => {
                    event.preventDefault();
                    const productName = document.getElementById('productName').value;
                    const productPrice = document.getElementById('productPrice').value;
                    const productDescription = document.getElementById('productDescription').value;

                    if (editingProduct) {
                        updateProduct(editingProduct, productName, productPrice, productDescription);
                    } else {
                        addProduct(productName, productPrice, productDescription);
                    }

                    productFormModal.style.display = "none";
                }

                function addProduct(name, price, description) {
                    const row = document.createElement('tr');
                    row.innerHTML = `
            <td>${name}</td>
            <td>${price}</td>
            <td>${description}</td>
            <td>
                <button class="btn btn-secondary" onclick="editProduct(this)">Sửa</button>
                <button class="btn btn-danger" onclick="deleteProduct(this)">Xóa</button>
            </td>
        `;
                    productList.appendChild(row);
                }

                window.editProduct = function (button) {
                    const row = button.parentElement.parentElement;
                    const cells = row.getElementsByTagName('td');
                    document.getElementById('productName').value = cells[0].innerText;
                    document.getElementById('productPrice').value = cells[1].innerText;
                    document.getElementById('productDescription').value = cells[2].innerText;
                    editingProduct = row;
                    productFormModal.style.display = "block";
                }

                window.deleteProduct = function (button) {
                    const row = button.parentElement.parentElement;
                    productList.removeChild(row);
                }

                function updateProduct(row, name, price, description) {
                    const cells = row.getElementsByTagName('td');
                    cells[0].innerText = name;
                    cells[1].innerText = price;
                    cells[2].innerText = description;
                }
            });

        </script>
    </head>
    <body>
        <header class="navbar">
            <h1>Quản lý sản phẩm</h1>
        </header>

        <main class="container">
            <button id="addProductBtn" style="float: right;" class="btn btn-primary">Thêm sản phẩm mới</button>
            <div id="productFormModal" class="modal">
                <div class="modal-content">
                    <span class="closeBtn" style="margin-bottom: 20%;">&times;</span>
                    <form action="addproduct" id="productForm" class="form">
                        <div class="form-group">
                            <label for="productName">Product name</label>
                            <input type="text" id="productName" name="productName" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="productPrice">Product Price</label>
                            <input type="number" id="productPrice" name="productPrice" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="productDescription">Description</label>
                            <textarea id="productDescription" name="productDescription" class="form-control" required></textarea>
                        </div>
                        <div class="form-group">
                            <label for="productDCategory">Category</label>
                            <select id="productCategory" name="productCategory" class="form-control" required>
                                <option>1</option>
                                <option>2</option>
                                <option>3</option>
                            </select>
                        </div>
                        <button type="submit" id="submitBtn" class="btn btn-success">Lưu</button>
                    </form>
                </div>
            </div>
            <table class="table">
                <thead>
                    <tr>
                        <th>Title</th>
                        <th>Price</th>
                        <th>Description</th>
                        <th>Image</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody id="productList">
                    <c:forEach items="${requestScope.products}" var="product">
                        <tr>
                            <td>${product.title}</td>
                            <td>${product.price}</td>
                            <td>${product.description}</td>
                            <td>${product.getImages()[0]}</td>
                            <td>
                                <button class="btn btn-secondary" onclick="editProduct(this)">Sửa</button>
                                <button class="btn btn-danger" onclick="deleteProduct(this)">Xóa</button>
                            </td>
                        </tr>
                    </c:forEach>

                </tbody>
            </table>
        </main>

        <footer class="footer">
            <p>&copy; 2024 Quản lý sản phẩm</p>
        </footer>
    </body>
</html>
