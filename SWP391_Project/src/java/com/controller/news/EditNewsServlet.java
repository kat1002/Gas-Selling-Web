/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.controller.news;

import com.model.DAO.NewsDAO;
import com.model.Manager;
import com.model.News;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.nio.file.Paths;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author kirit
 */
@MultipartConfig
@WebServlet(name = "EditNewsServlet", urlPatterns = {"/edit-news"})
public class EditNewsServlet extends HttpServlet {

    private static final String IMAGE_UPLOAD_DIR = "media/news/theme/";
    private static final Logger LOGGER = Logger.getLogger(EditNewsServlet.class.getName());

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EditNewsServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditNewsServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String post_id_raw = request.getParameter("id");
        int news_id = 0;
        try {
            news_id = Integer.parseInt(post_id_raw);
        } catch (NumberFormatException e) {

        }
        NewsDAO newsDAO = new NewsDAO();
        request.setAttribute("listNewsCategory", newsDAO.getNewsCategory());
        News news = newsDAO.getNews(news_id);
        request.setAttribute("news", news);
        request.getRequestDispatcher("edit-news.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String title = request.getParameter("title").trim();
        String body = request.getParameter("content");
        String newsCate = request.getParameter("newsCate");
        Part image = request.getPart("theme_image");
        String theme_image = request.getParameter("theme_image");
        NewsDAO d = new NewsDAO();
        News news = new News();
        if (image != null && image.getSize() > 0) {
            try {
                String imagePath = saveImage(request, image);
                news.setTheme_image(imagePath);
            } catch (IOException ex) {
                LOGGER.log(Level.SEVERE, "Error processing update addition", ex);
            }
            
        } else {
            theme_image = request.getParameter("sub_theme_image");
            news.setTheme_image(theme_image);
        }
        String short_des = request.getParameter("short_des").trim();
        if(newsCate.equals("Another")){
                news.setNewsCategory(request.getParameter("anotherNewsCate").trim());
            }else{
                news.setNewsCategory(newsCate);
            }
        news.setBody(body);
        Manager manager =(Manager) request.getSession().getAttribute("manager");
        news.setModifiedBy(manager.getManagerId());
        news.setShort_description(short_des);
        news.setTitle(title);
        String post_id_raw = request.getParameter("id");
        int news_id = 0;
        try {
            news_id = Integer.parseInt(post_id_raw);
        } catch (NumberFormatException e) {
        }
        news.setNewsId(news_id);
        d.updateNews(news);
        request.getRequestDispatcher("news-post?news-id=" + news_id).forward(request, response);
    }

    private String saveImage(HttpServletRequest request, Part image) throws IOException {
        String imageName = Paths.get(image.getSubmittedFileName()).getFileName().toString();
        String imagePath = IMAGE_UPLOAD_DIR + imageName;
        String fullPath = request.getServletContext().getRealPath(imagePath);
        image.write(fullPath);
        return imagePath;
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
