/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.controller.customer_voucher;

import com.controller.WebManager;
import com.model.Customer;
import com.model.InventoryItem;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "SaveVoucherServlet", urlPatterns = {"/savevoucher"})
public class SaveVoucherServlet extends HttpServlet {

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
            out.println("<title>Servlet SaveVoucherServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SaveVoucherServlet at " + request.getContextPath() + "</h1>");
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
            String voucherid = request.getParameter("voucherid");
            int vid = Integer.parseInt(voucherid);
            if (WebManager.getInstance().voucherDAO.getVoucher(vid) != null) {
                InventoryItem item = WebManager.getInstance().inventoryItemDAO.getInventoryItemByInventoryAndVoucher(
                        WebManager.getInstance().inventoryDAO.getInventoryByCustomerId(customer.getCustomerId()).getInventoryId(), vid);
                if (item == null) {
                    InventoryItem newItem = new InventoryItem(WebManager.getInstance().inventoryDAO.getInventoryByCustomerId(customer.getCustomerId()).getInventoryId(), vid, 2);
                    WebManager.getInstance().inventoryItemDAO.addInventoryItem(newItem);
                    WebManager.getInstance().voucherDAO.reduceVoucherQuantity(vid, 2);
                    response.getWriter().println("<script>");
                    response.getWriter().println("alert('Saved voucher sucessfully !');");
                    response.getWriter().println("window.location.href='voucher';");
                    response.getWriter().println("</script>");
                } else {
                    response.getWriter().println("<script>");
                    response.getWriter().println("alert('Can't save voucher !');");
                    response.getWriter().println("window.location.href='voucher';");
                    response.getWriter().println("</script>");
                }
            } else {
                response.getWriter().println("<script>");
                response.getWriter().println("alert('Can't find voucher !');");
                response.getWriter().println("window.location.href='voucher';");
                response.getWriter().println("</script>");
            }
        } catch (Exception ex) {
            Logger.getLogger(SaveVoucherServlet.class.getName()).log(Level.SEVERE, null, ex);
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
