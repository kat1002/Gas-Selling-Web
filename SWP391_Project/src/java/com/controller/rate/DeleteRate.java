/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.controller.rate;

import com.controller.WebManager;
import com.controller.dashboard.product_management.AddProductServlet;
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

/**
 *
 * @author Acer Nitro 5
 */
@WebServlet(name = "DeleteRate", urlPatterns = {"/deleterate"})
public class DeleteRate extends HttpServlet {

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
            out.println("<title>Servlet DeleteRate</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DeleteRate at " + request.getContextPath() + "</h1>");
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
        String rateIdString = request.getParameter("rateId");
        String productIdString = request.getParameter("productId");
        try {
            int rateId = Integer.parseInt(rateIdString);
            int productId = Integer.parseInt(productIdString);
            WebManager.getInstance().rateDAO.deleteRateByRateId(rateId);
            if (WebManager.getInstance().rateDAO.getRateByRateId(rateId) == null){
                response.getWriter().println("<script>");
                response.getWriter().println("alert('Deleted feedback sucessfully !');");
                response.getWriter().println("window.location.href='product?id="+productId+"';");
                response.getWriter().println("</script>");
            }else{
                response.getWriter().println("<script>");
                response.getWriter().println("alert('Can't Delete feedback !');");
                response.getWriter().println("window.location.href='product?id="+productId+"';");
                response.getWriter().println("</script>");
            }
            
        } catch (NumberFormatException | NullPointerException |SQLException | ClassNotFoundException e) {
            // Xử lý các exception
            Logger.getLogger(DeleteRate.class.getName()).log(Level.SEVERE, null, e);
            // Xử lý khi có lỗi xảy ra, ví dụ chuyển hướng lại trang lỗi
            response.sendRedirect("500.jsp");
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
