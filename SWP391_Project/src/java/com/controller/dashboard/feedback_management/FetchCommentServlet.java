/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.controller.dashboard.feedback_management;

import com.controller.WebManager;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.model.Rate;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.apache.tomcat.dbcp.dbcp2.SQLExceptionList;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "FetchCommentServlet", urlPatterns = {"/fetchcomment"})
public class FetchCommentServlet extends HttpServlet {

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
            out.println("<title>Servlet FetchCommentServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet FetchCommentServlet at " + request.getContextPath() + "</h1>");
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
        try {
            String rate_id = request.getParameter("rate_id");
            int rid = Integer.parseInt(rate_id);
            Rate rate = WebManager.getInstance().rateDAO.getRateByRateId(rid);
            JsonObject jsonResponse = new JsonObject();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            // Assuming getCustomerById and getProductById methods return customer and product objects respectively
            jsonResponse.addProperty("username", rate.getCustomerById(rate.getCustomer_id()).getUsername());
            jsonResponse.addProperty("profilePicture", rate.getCustomerById(rate.getCustomer_id()).getCustomerImage());
            jsonResponse.addProperty("productName", rate.getProductById(rate.getProduct_id()).getTitle());
            jsonResponse.addProperty("stars", rate.getRate());
            jsonResponse.addProperty("comment", rate.getComment());
            response.getWriter().print(jsonResponse.toString());
        } catch (SQLException ex) {
            Logger.getLogger(FetchCommentServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(FetchCommentServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NumberFormatException ex) {
            Logger.getLogger(FetchCommentServlet.class.getName()).log(Level.SEVERE, null, ex);
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
