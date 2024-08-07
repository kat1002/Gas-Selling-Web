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
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author kirit
 */
@WebServlet(name = "UpdateBannerServlet", urlPatterns = {"/updateBanner"})
public class UpdateBannerServlet extends HttpServlet {

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
            int id = Integer.parseInt(request.getParameter("id"));
            int banner = Integer.parseInt(request.getParameter("isChecked"));
            NewsDAO newsDAO = new NewsDAO();
            Manager manager =(Manager) request.getSession().getAttribute("manager");
            if (banner == 0) {
                for (News news : newsDAO.getBanner()) {
                    if (news.getBanner() > newsDAO.getNews(id).getBanner()) {
                        newsDAO.updateNewsBanner(news.getNewsId(), news.getBanner() - 1,manager.getManagerId());
                    }
                }
            }
            if (banner == 1) {
                for (News news : newsDAO.getBanner()) {
                    newsDAO.updateNewsBanner(news.getNewsId(), news.getBanner() + 1,manager.getManagerId());
                }
            }
            
            newsDAO.updateNewsBanner(id, banner,manager.getManagerId());

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
        processRequest(request, response);
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
        processRequest(request, response);
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
