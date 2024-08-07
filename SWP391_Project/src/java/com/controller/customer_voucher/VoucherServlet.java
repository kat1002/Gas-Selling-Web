/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.controller.customer_voucher;

import com.controller.WebManager;
import com.controller.product_list.ProductListServlet;
import com.model.Customer;
import com.model.DAO.headerDAO;
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
@WebServlet(name="VoucherServlet", urlPatterns={"/voucher"})
public class VoucherServlet extends HttpServlet {

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
            out.println("<title>Servlet VoucherServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet VoucherServlet at " + request.getContextPath() + "</h1>");
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
    public void prepareHeaderAndFooter(HttpServletRequest request, HttpServletResponse response) throws SQLException, ClassNotFoundException {
        Logger.getLogger(ProductListServlet.class.getName()).log(Level.INFO, "header: " + new headerDAO().getHeader());

        HttpSession session = request.getSession();
        session.setAttribute("header", WebManager.getInstance().headerDAO.getHeader());
        session.setAttribute("categoryTitle", WebManager.getInstance().headerDAO.getCategoryTitle());
        session.setAttribute("footerItem", WebManager.getInstance().footerDAO.getFooterItem());
        session.setAttribute("footerContent", WebManager.getInstance().footerDAO.getFooterContent());
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("user");
        if (customer == null) {
            response.sendRedirect("home"); // Redirect to login if user is not logged in
            return;
        }
        try {
            prepareHeaderAndFooter(request, response);
            if (WebManager.getInstance().inventoryDAO.getInventoryByCustomerId(customer.getCustomerId()) == null){
                WebManager.getInstance().inventoryDAO.createInventory(customer.getCustomerId());
                request.setAttribute("inventory", WebManager.getInstance().inventoryDAO.getInventoryByCustomerId(customer.getCustomerId()));
            }else{
                request.setAttribute("inventory", WebManager.getInstance().inventoryDAO.getInventoryByCustomerId(customer.getCustomerId()));
            }
            request.setAttribute("vouchers_available", WebManager.getInstance().voucherDAO.getListVouchersAvailable());
            request.getRequestDispatcher("voucher.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(VoucherServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(VoucherServlet.class.getName()).log(Level.SEVERE, null, ex);
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
