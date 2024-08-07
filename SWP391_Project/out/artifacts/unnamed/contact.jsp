<!DOCTYPE html>
<html>

    <head>
        <title>BLAZO | CONTACT</title>
        <link rel="stylesheet" href="CSS/contact.css">
        <link rel="stylesheet" href="CSS/main.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="viewport" content="width=device-width, initial-scale=1">
    </head>

    <body>
        <jsp:include page="header.jsp" />
        <main>
            <p class="title">CONTACT US</p>
            <div class="row">
                <div class="column1">
                    <div class="border-line">
                        <p class="title4">INFORMATION</p>
                        <p class="cmt3">We encourage and assist musicians at every stage of their careers, and by fostering
                            communities among people, we may help to deepen the bonds between people, culture, and music.
                        </p>
                    </div>
                    <div class="border-line">
                        <p class="icon2"><i class="fa-solid fa-location-dot"></i></p>
                        <p class="cmt3">Viet Nam</p>
                        <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3724.5062169040325!2d105.52271427502428!3d21.012421688339977!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135abc60e7d3f19%3A0x2be9d7d0b5abcbf4!2sFPT%20University!5e0!3m2!1sen!2s!4v1716424671392!5m2!1sen!2s" 
                                width="325" height="200" style="border:0;" 
                            allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade">   
                        </iframe>
                    <div class="border-line">
                        <p class="icon2"><i class="fa-solid fa-phone"></i></p>
                        <p class="cmt3">Hotline: 012 3456 789</p>
                    </div>
                </div>
                <div class="column2">
                    <p class="title4" style="padding:0 30px;">SEND YOUR COMMENTS</p>
                    <form class="form">
                        <p type="Name:"><input placeholder="Write your name here.."></input></p>
                        <p type="Email:"><input placeholder="Let us know how to contact you back.."></input></p>
                        <p type="Message:"><input placeholder="What would you like to tell us.."></input></p>
                        <button>Send Message</button>
                    </form>
                </div>
            </div>
        </main>
        <jsp:include page="footer.jsp" />

        <script src="JS/Login.js"></script>
        <script src="JS/Cart.js"></script>
    </body>

</html>