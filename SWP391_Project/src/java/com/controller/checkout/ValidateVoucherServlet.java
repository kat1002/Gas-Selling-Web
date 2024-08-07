/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.controller.checkout;

import com.controller.WebManager;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.model.Customer;
import com.model.Inventory;
import com.model.InventoryItem;
import com.model.Voucher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "ValidateVoucherServlet", urlPatterns = {"/validatevoucher"})
public class ValidateVoucherServlet extends HttpServlet {

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
            out.println("<title>Servlet ValidateVoucherServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ValidateVoucherServlet at " + request.getContextPath() + "</h1>");
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
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("user");
        if (customer == null) {
            response.sendRedirect("home"); // Redirect to login if user is not logged in
            return;
        }
        try {
            JsonObject jsonResponse = new JsonObject();
            String voucherCode = request.getParameter("voucherCode");
            double currentTotal = Double.parseDouble(request.getParameter("currentTotal"));
            Voucher voucher = WebManager.getInstance().voucherDAO.getVoucherByCode(voucherCode);
            Inventory inventory = WebManager.getInstance().inventoryDAO.getInventoryByCustomerId(customer.getCustomerId());
            if (inventory != null) {
                InventoryItem item = WebManager.getInstance().inventoryItemDAO.getInventoryItemByInventoryAndVoucher(inventory.getInventoryId(), voucher.getVoucherId());
                if (item != null) {
                    if (voucher != null && voucher.isStatus() && item.getAmount() > 0) {
                        double discountValue = voucher.getDiscountValue();
                        double newTotal = 0;
                        if (voucher.getDiscountType() == 1) {
                            newTotal = currentTotal - (currentTotal * discountValue);
                        } else if (voucher.getDiscountType() == 2) {
                            newTotal = currentTotal - discountValue;
                        }
                        if (currentTotal >= voucher.getCondition()) {
                            int vid = voucher.getVoucherId();
                            jsonResponse.addProperty("success", true);
                            jsonResponse.addProperty("newTotal", newTotal);
                            jsonResponse.addProperty("total", currentTotal);
                            jsonResponse.addProperty("vid", vid);
                            jsonResponse.addProperty("code", voucherCode);
                        } else {
                            jsonResponse.addProperty("success", false);
                        }

                    } else {
                        jsonResponse.addProperty("success", false);
                    }
                } else {
                    jsonResponse.addProperty("success", false);
                }
            } else {
                jsonResponse.addProperty("success", false);
            }
            response.getWriter().write(new Gson().toJson(jsonResponse));
        } catch (SQLException ex) {
            Logger.getLogger(ValidateVoucherServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ValidateVoucherServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NumberFormatException ex) {
            Logger.getLogger(ValidateVoucherServlet.class.getName()).log(Level.SEVERE, null, ex);
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
