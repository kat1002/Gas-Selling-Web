/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.controller.news;

import com.model.DAO.NewsDAO;
import com.model.News;
import com.utils.DBContext;
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
@WebServlet(name = "NewsServlet", urlPatterns = {"/news"})
public class NewsServlet extends HttpServlet {

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

        NewsDAO newsDAO = new NewsDAO();
        String searchName = request.getParameter("searchName");
        String newsCate = request.getParameter("newsCate");
        List<News> listNewsRaw = new ArrayList<News>();
        List<News> listNews = new ArrayList<News>();
       
        if (searchName == null || searchName.equals("")) {
            searchName="";
            listNewsRaw = newsDAO.getAllNews();
        }else{
            String[] searchTerms = searchName.split("\\s+");
            listNewsRaw = newsDAO.getAllNewsByName(searchTerms);
        }
        
        if (newsCate == null || newsCate.equals("") ||newsCate.equals("all") ) {
            newsCate="all";
            listNews=listNewsRaw;
        }else{
            for(News news : listNewsRaw)
            if(news.getNewsCategory().equals(newsCate)) listNews.add(news);
        }
        
        request.setAttribute("searchName", searchName);               
        request.setAttribute("listNews", listNews);
        request.setAttribute("listNCategory", newsDAO.getNewsCategory());
        request.setAttribute("newsCate", newsCate);

        String setPageNumber = request.getParameter("set-page-number");

        if (setPageNumber == null || setPageNumber.equals("")) {
            request.setAttribute("setPageNumber", 6);
        } else {
                request.setAttribute("setPageNumber", request.getParameter("set-page-number"));
        }
        request.getRequestDispatcher("news.jsp").forward(request, response);
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
            Logger.getLogger(NewsServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(NewsServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(NewsServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(NewsServlet.class.getName()).log(Level.SEVERE, null, ex);
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
