/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.controller.dashboard.product_management;

import com.controller.WebManager;
import com.controller.dashboard.discount_management.EditDiscountServlet;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.model.ProductSerialNumber;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "ArrivalProductServlet", urlPatterns = {"/addquantityproduct"})
public class AddQuantityProductServlet extends HttpServlet {

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
            out.println("<title>Servlet ArrivalProductServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ArrivalProductServlet at " + request.getContextPath() + "</h1>");
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
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        JsonObject json = new JsonObject();
        try {
            int productId = Integer.parseInt(request.getParameter("pid"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            boolean added = WebManager.getInstance().productDAO.addProductQuantity(quantity, productId);
            for (int i = 0; i < WebManager.getInstance().productDAO.getProduct(productId).getStock() - WebManager.getInstance().productSerialNumberDAO.getListSerialByProductId(productId).size(); i++) {
                ProductSerialNumber psn = new ProductSerialNumber(productId);
//                psn.setStatus(true);
                WebManager.getInstance().productSerialNumberDAO.insert(psn);
            }
            if (added) {
                // Retrieve the updated quantity from the database
                int newQuantity = WebManager.getInstance().productDAO.getProduct(productId).getStock();
                json.add("success", new Gson().toJsonTree(true));
                json.add("newQuantity", new Gson().toJsonTree(newQuantity));
            } else {
                json.add("success", new Gson().toJsonTree(false));
            }
        } catch (Exception ex) {
            Logger.getLogger(AddQuantityProductServlet.class.getName()).log(Level.SEVERE, null, ex);
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            json.addProperty("success", false);
        } finally {
            out.print(json.toString());
            out.close();
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
