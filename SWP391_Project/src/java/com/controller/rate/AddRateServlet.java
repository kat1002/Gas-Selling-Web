/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.controller.rate;

import com.controller.WebManager;
import com.model.DAO.RateDAO;
import com.model.Product;
import com.model.Rate;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Acer Nitro 5
 */
public class AddRateServlet extends HttpServlet {

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
            out.println("<title>Servlet AddRateServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddRateServlet at " + request.getContextPath() + "</h1>");
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
            //        processRequest(request, response);

            String userIdString = request.getParameter("userId");
            String productIdString = request.getParameter("productId");
            String rateString = request.getParameter("rate");
            String commentString = request.getParameter("comment");
            LocalDateTime created_on = LocalDateTime.now();
            LocalDateTime modified_on = LocalDateTime.now();
            
            if(request.getSession().getAttribute("user") == null) {
                response.sendRedirect("login_system.jsp");
                return;
            }

            int userId = Integer.parseInt(userIdString);
            int productId = Integer.parseInt(productIdString);
            int rate = Integer.parseInt(rateString);
            
            Rate r = new Rate(userId, productId, rate, commentString, created_on, modified_on);
            WebManager.getInstance().rateDAO.addRate(r);

            response.sendRedirect("product?id=" + productId);
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(AddRateServlet.class.getName()).log(Level.SEVERE, null, ex);
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
