/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.controller.news;

import com.model.DAO.NewsDAO;
import com.model.News;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author kirit
 */
@WebServlet(name = "NewsPostServlet", urlPatterns = {"/news-post"})
public class NewsPostServlet extends HttpServlet {

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
            throws ServletException, IOException, SQLException, ClassNotFoundException {
        response.setContentType("text/html;charset=UTF-8");
        String post_id_raw = request.getParameter("news-id");
        int news_id = 0;
        try {
            news_id = Integer.parseInt(post_id_raw);
        } catch (NumberFormatException e) {

        }
        NewsDAO dN = new NewsDAO();
        News news = dN.getNews(news_id);
        request.setAttribute("news", news);

        List<News> listNews = dN.getAllNews();
        List<News> listNewsHot = new ArrayList<>();
        List<News> listNewsNew = new ArrayList<>();
        List<News> listNewsCate = new ArrayList<>();
        for (News newss : listNews) {
            if (newss.getNewsId() != news_id) {
                if (listNewsNew.size() < 4) {
                    listNewsNew.add(newss);
                }
                if (newss.getNewsCategory().equals("Hot") && listNewsHot.size() < 4) {
                    listNewsHot.add(newss);
                }
                if (newss.getNewsCategory().equals(news.getNewsCategory()) && listNewsCate.size() < 4) {
                    listNewsCate.add(newss);
                }
            }
        }
        request.setAttribute("listNewsHot", listNewsHot);
        request.setAttribute("listNewsNew", listNewsNew);
        request.setAttribute("listNewsCate", listNewsCate);

        request.getRequestDispatcher("news-post.jsp").forward(request, response);
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(NewsPostServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(NewsPostServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(NewsPostServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(NewsPostServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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
