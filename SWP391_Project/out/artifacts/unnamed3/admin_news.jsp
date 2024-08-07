<!DOCTYPE html>
<html>

    <head>
        <title>BLAZO | NEWS</title>


        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <style>
            .center {
                text-align: center;
            }

            .pagination {
                display: inline-block;
            }

            .pagination a {
                color: black;
                float: left;
                padding: 8px 16px;
                text-decoration: none;
                transition: background-color .3s;
                border: 1px solid #ddd;
                margin: 0 4px;
            }

            .pagination a.active {
                background-color: #4CAF50;
                color: white;
                border: 1px solid #4CAF50;
            }

            .pagination a:hover:not(.active) {
                background-color: #ddd;
            }
        </style>
    </head>

    <body>
        <link rel="stylesheet" href="CSS/news.css" />
        <jsp:include page="admin_header.jsp" />
        
        <main>
            <p class="title" id="first">News-post</p>


            <div class="product-moblie" style=" position: relative;">
                <ul>
                    <li class="product-card-mobile" >
                        <a style="float: left" href="news-post.jsp"><img src="media/img-news-1.jpg" alt="" /></a>
                        <div style="float: left"><h4>Gas Price in 4/2024</h4>
                            <p class="grey none">9/4/2024</p>
                            <p class="none" style="margin-top: 10px; color: black;">Gas price increase ...</p>
                        </div>
                    </li>
                    <li class="product-card-mobile" >
                        <a style="float: left" href="news-post.jsp"><img src="media/img-news-1.jpg" alt="" /></a>
                        <div style="float: left"><h4>Gas Price in 4/2024</h4>
                            <p class="grey none">9/4/2024</p>
                            <p class="none" style="margin-top: 10px; color: black;">Gas price increase ...</p>
                        </div>
                    </li>
                    <li class="product-card-mobile" >
                        <a style="float: left" href="news-post.jsp"><img src="media/img-news-1.jpg" alt="" /></a>
                        <div style="float: left"><h4>Gas Price in 4/2024</h4>
                            <p class="grey none">9/4/2024</p>
                            <p class="none" style="margin-top: 10px; color: black;">Gas price increase ...</p>
                        </div>
                    </li>
                    <li class="product-card-mobile" >
                        <a style="float: left" href="news-post.jsp"><img src="media/img-news-1.jpg" alt="" /></a>
                        <div style="float: left"><h4>Gas Price in 4/2024</h4>
                            <p class="grey none">9/4/2024</p>
                            <p class="none" style="margin-top: 10px; color: black;">Gas price increase ...</p>
                        </div>
                    </li>
                    <li class="product-card-mobile" >
                        <a style="float: left" href="news-post.jsp"><img src="media/img-news-1.jpg" alt="" /></a>
                        <div style="float: left"><h4>Gas Price in 4/2024</h4>
                            <p class="grey none">9/4/2024</p>
                            <p class="none" style="margin-top: 10px; color: black;">Gas price increase ...</p>
                        </div>
                    </li>
                    <li class="product-card-mobile" >
                        <a style="float: left" href="news-post.jsp"><img src="media/img-news-1.jpg" alt="" /></a>
                        <div style="float: left"><h4>Gas Price in 4/2024</h4>
                            <p class="grey none">9/4/2024</p>
                            <p class="none" style="margin-top: 10px; color: black;">Gas price increase ...</p>
                        </div>
                    </li>
                </ul>
            </div>


            <div class="product" style=" position: relative;">
                <ul  style="">
                    <li class="product-card-abc">
                        <a href="news-post.jsp"><img class="abc" src="media/img-news-1.jpg" alt="" /></a>
                        <h4>Gas Price in 4/2024</h4>
                        <p class="grey">9/4/2024</p>
                        <p style="margin-top: 10px; color: black;">Gas price increase ...</p>
                    </li>
                    <li class="product-card-abc">
                        <a href="news-post.jsp"><img class="abc" src="media/img-news-1.jpg" alt="" /></a>
                        <h4>Gas Price in 4/2024</h4>
                        <p class="grey">9/4/2024</p>
                        <p style="margin-top: 10px; color: black;">Gas price increase ...</p>
                    </li>
                    <li class="product-card-abc">
                        <a href="news-post.jsp"><img class="abc" src="media/img-news-1.jpg" alt="" /></a>
                        <h4>Gas Price in 4/2024</h4>
                        <p class="grey">9/4/2024</p>
                        <p style="margin-top: 10px; color: black;">Gas price increase ...</p>
                    </li>
                    <ul  style="">
                    <li class="product-card-abc">
                        <a href="news-post.jsp"><img class="abc" src="media/img-news-1.jpg" alt="" /></a>
                        <h4>Gas Price in 4/2024</h4>
                        <p class="grey">9/4/2024</p>
                        <p style="margin-top: 10px; color: black;">Gas price increase ...</p>
                    </li>
                    <li class="product-card-abc">
                        <a href="news-post.jsp"><img class="abc" src="media/img-news-1.jpg" alt="" /></a>
                        <h4>Gas Price in 4/2024</h4>
                        <p class="grey">9/4/2024</p>
                        <p style="margin-top: 10px; color: black;">Gas price increase ...</p>
                    </li>
                    <li class="product-card-abc">
                        <a href="news-post.jsp"><img class="abc" src="media/img-news-1.jpg" alt="" /></a>
                        <h4>Gas Price in 4/2024</h4>
                        <p class="grey">9/4/2024</p>
                        <p style="margin-top: 10px; color: black;">Gas price increase ...</p>
                    </li>


                </ul>
            </div>

            <div class="center">
                <div class="pagination">
                    <a href="#" class="prev-page">&laquo;</a>
                    <a href="#" class="page-number">1</a>
                    <a href="#" class="page-number active">2</a>
                    <a href="#" class="page-number">3</a>
                    <a href="#" class="page-number">4</a>
                    <a href="#" class="page-number">5</a>
                    <a href="#" class="page-number">6</a>
                    <a href="#" class="next-page">&raquo;</a>
                </div>
            </div>
        </main>
        <script src="JS/Slide.js"></script>
        <script src="JS/Login.js"></script>
        <script src="JS/Cart.js"></script>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const paginationLinks = document.querySelectorAll('.pagination a.page-number');
                const prevPageLink = document.querySelector('.pagination a.prev-page');
                const nextPageLink = document.querySelector('.pagination a.next-page');
                let currentPage = 2;

                paginationLinks.forEach(link => {
                    link.addEventListener('click', function (event) {
                        event.preventDefault();
                        currentPage = parseInt(this.textContent);
                        updatePaginationLinks(currentPage);
                        fetchProducts(currentPage);
                    });
                });

                prevPageLink.addEventListener('click', function (event) {
                    event.preventDefault();
                    if (currentPage > 1) {
                        currentPage--;
                        updatePaginationLinks(currentPage);
                        fetchProducts(currentPage);
                    }
                });

                nextPageLink.addEventListener('click', function (event) {
                    event.preventDefault();
                    if (currentPage < paginationLinks.length) {
                        currentPage++;
                        updatePaginationLinks(currentPage);
                        fetchProducts(currentPage);
                    }
                });

                function updatePaginationLinks(activePage) {
                    paginationLinks.forEach(link => {
                        link.classList.remove('active');
                    });
                    paginationLinks[activePage - 1].classList.add('active');
                }

                function fetchProducts(page) {
                    // Replace the URL with your actual API endpoint
                    fetch(`https://example.com/api/products?page=${page}`)
                            .then(response => response.json())
                            .then(data => {
                                const productContainer = document.querySelector('.product ul');
                                productContainer.innerHTML = '';
                                data.products.forEach(product => {
                                    const productCard = document.createElement('li');
                                    productCard.className = 'product-card';
                                    productCard.innerHTML = `
                        <a href="news-post.jsp"><img src="${product.image}" alt="" /></a>
                        <h4>${product.title}</h4>
                        <p class="grey">${product.date}</p>
                        <p style="margin-top: 10px; color: black;">${product.description}</p>
                    `;
                                    productContainer.appendChild(productCard);
                                });
                            })
                            .catch(error => {
                                console.error('Error fetching products:', error);
                            });
                }

                // Initial fetch
                fetchProducts(currentPage);
            });
        </script>

    </body>

</html>