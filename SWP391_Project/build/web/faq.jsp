<!DOCTYPE html>
<html>

    <head>
        <title>BLAZO | FAQ</title>
        <link rel="icon" href="media/icon/icons8-faq-30.png"/>
        <link rel="stylesheet" href="CSS/faq.css" />
        <link rel="stylesheet" href="CSS/main.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
    </head>

    <body>
        <jsp:include page="header.jsp" />
        <div id="fb-root"></div>
        <script async defer crossorigin="anonymous" 
                src="https://connect.facebook.net/vi_VN/sdk.js#xfbml=1&version=v20.0" 
        nonce="HvVHDIdc"></script>
        <main style="min-height: 400px">
            <p class="title">FAQ'S</p>
            <section class="faq-container">
                <div class="faq-one">
                    <h3 class="faq-page">What is Blazo?</h3>
                    <div class="faq-body">
                        <p>
                            We know that shopping online can sometimes come with questions and uncertainties, 
                            so we've compiled this comprehensive guide to help you find quick and easy answers. 
                            Whether you're curious about placing an order,
                            our shipping policies, or how to return a product, we've got you covered.<br/><br/>
                            Our goal is to make your shopping experience as smooth and enjoyable as possible. 
                            If you can't find the information you're looking for here, 
                            please don't hesitate to reach out to our customer service team. We're here to help!
                        </p>
                    </div>
                </div>
                <hr class="hr-line" />
                <div class="faq-two">
                    <h3 class="faq-page">Promotions and Discounts</h3>
                    <div class="faq-body">
                        <p>
                            We have sales and promotions( check in newsletter, social media...)
                            <br/><br/>
                            We have a loyalty program
                        </p>
                    </div>
                </div>
                <hr class="hr-line" />
                <div class="faq-three">
                    <h3 h3 class="faq-page">
                        Returns and Exchanges
                    </h3>
                    <div class="faq-body">
                        <p>
                            Return policy: At Blazo, we want you to be completely satisfied with your purchase. 
                            If for any reason you are not happy with your order.
                            <br/><br/>
                            Returning an item to Blazo is simple and hassle-free. Step: 
                            <br/>
                            &nbsp; Initiate the return<br/>
                            &nbsp; Prepare Your Package<br/>
                            &nbsp; Ship the Package<br/>
                            &nbsp; Confirmation
                        </p>
                    </div>
                </div>
                    <hr class="hr-line" />
                <div class="faq-three">
                    <h3 h3 class="faq-page">
                        Warranty
                    </h3>
                    <div class="faq-body">
                        <p>
                            Send order, product serial number and contact via email: blazoonlinegasshop@gmail.com to get instruction
                        </p>
                    </div>
                </div>
            </section>
            <p class="title">MORE QUESTION</p>
            <div class="fb-comments" 
                 data-href="https://daihoc.fpt.edu.vn/" 
                data-width="100%" data-numposts="5">
            </div>
        </main>
        <jsp:include page="footer.jsp" />
        <script src="JS/Login.js"></script>
        <script src="JS/FAQ.js"></script>
        <script src="JS/Cart.js"></script>
    </body>
    <style>
        /* General Styles */
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        main {
            min-height: 400px;
            padding: 20px;
            background-color: #f9f9f9;
        }
        p{
            font-size: 18px;
        }
        /* Title Styles */
        .title {
            font-size: 2em;
            margin-bottom: 20px;
            text-align: center;
            color: #333;
        }

        /* FAQ Container Styles */
        .faq-container {
            max-width: 800px;
            margin: 0 auto;
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            overflow: hidden;
        }

        /* FAQ Item Styles */
        .faq-one, .faq-two, .faq-three,.faq-four {
            padding: 20px;
        }

        .faq-page {
            font-size: 1.5em;
            margin: 0;
            cursor: pointer;
            position: relative;
        }

        .faq-page::after {
            content: '+';
            font-size: 1.2em;
            position: absolute;
            right: 20px;
            top: 50%;
            transform: translateY(-50%);
            transition: transform 0.3s ease;
        }

        .faq-body {
            display: none;
            margin-top: 10px;
            font-size: 1em;
            color: #555;
        }

        .hr-line {
            margin: 0;
            border: 0;
            border-top: 1px solid #eee;
        }

        /* Expanded FAQ Item Styles */
        .faq-page.active::after {
            transform: translateY(-50%) rotate(45deg);
        }

        .faq-page.active + .faq-body {
            display: block;
        }
    </style>
</html>