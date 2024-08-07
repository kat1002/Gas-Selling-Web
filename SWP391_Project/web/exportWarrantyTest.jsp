package com.controller.news;

import com.model.Customer;
import com.model.DAO.CustomerDAO;
import com.model.DAO.NewsDAO;
import com.model.News;
import com.utils.EmailHandler;
import jakarta.mail.MessagingException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@MultipartConfig
@WebServlet(name = "AddNewsServlet", urlPatterns = {"/add-news"})
public class AddNewsServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(AddNewsServlet.class.getName());
    private static final String IMAGE_UPLOAD_DIR = "media/news/theme/";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (var out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddNewsServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddNewsServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String title = request.getParameter("title").trim();
        String body = request.getParameter("content").trim();
        String newsCate = request.getParameter("newsCate");
        Part image = request.getPart("theme_image");
        String shortDes = request.getParameter("short_des").trim();
        String sendNotic = request.getParameter("sendNotic");
        try {
            String imagePath = saveImage(request, image);

            NewsDAO newsDAO = new NewsDAO();
            News news = new News();
            news.setTitle(title);
            news.setBody(body);
            news.setNewsCategory(newsCate);
            news.setShort_description(shortDes);
            news.setTheme_image(imagePath);
            news.setCreatedBy(1);
            news.setModifiedBy(1);

            newsDAO.addNews(news);
            List<String> listEmail = new ArrayList<>();
            if (sendNotic != null && sendNotic.equals("true")) {
                CustomerDAO CustomerDAO = new CustomerDAO();       
                for (Customer c : CustomerDAO.listAllcustomer()) {
                    if(c.getCustomerType() == 1)
                    listEmail.add(c.getGmail());
                }
            }
            String subject = "new News post from Blazo Shop";
            String bodyMail = "Title: " + title + "\n\n";
            bodyMail += shortDes + "\n";
            bodyMail += "Click here to go to News: " + "http://localhost:9999/SWP391_Project/news";
            EmailHandler.sendEmailBcc(listEmail, subject, bodyMail);
            response.sendRedirect("manageNews");
        } catch (IOException ex) {
            LOGGER.log(Level.SEVERE, "Error processing news addition", ex);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while processing your request.");
        }
    }

    private String saveImage(HttpServletRequest request, Part image) throws IOException {
        String imageName = Paths.get(image.getSubmittedFileName()).getFileName().toString();
        String imagePath = IMAGE_UPLOAD_DIR + imageName;
        String fullPath = request.getServletContext().getRealPath(imagePath);
        image.write(fullPath);
        return imagePath;
    }

    @Override
    public String getServletInfo() {
        return "AddNewsServlet handles the addition of news articles";
    }
}
