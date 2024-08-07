/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.controller.dashboard.voucherList;

import com.controller.WebManager;
import com.model.DAO.VoucherDAO;
import com.model.Manager;
import com.model.Voucher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.sql.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author kirit
 */
@WebServlet(name = "AddVoucherServlet", urlPatterns = {"/addVoucher"})
public class AddVoucherServlet extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        Manager manager = (Manager) request.getSession().getAttribute("manager");
        if (manager == null) {
            response.sendRedirect("login_system.jsp");
            return;
        }
        request.getRequestDispatcher("addVoucher.jsp").forward(request, response);
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
        Manager manager = (Manager) request.getSession().getAttribute("manager");
        if (manager == null) {
            response.sendRedirect("login_system.jsp");
            return;
        }
        try {
            String voucherCode = request.getParameter("voucherCode");
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            int discountType = Integer.parseInt(request.getParameter("discountType"));
            float discountValue = Float.parseFloat(request.getParameter("discountValue"));
            float condition = Float.parseFloat(request.getParameter("condition"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            Date date = null;
            String expiry = request.getParameter("expiry");
            date = ((expiry == null) || (expiry.equals("")))
                    ? null : Date.valueOf(expiry);
//        LocalDateTime expiry = LocalDateTime.parse(request.getParameter("expiry"));

            Voucher voucher = new Voucher();
            voucher.setVoucherCode(voucherCode);
            voucher.setTitle(title);
            voucher.setDescription(description);
            voucher.setDiscountType(discountType);
            voucher.setDiscountValue(discountValue);
            voucher.setCondition(condition);
            voucher.setQuantity(quantity);
            voucher.setExpiry(date);
            voucher.setStatus(true);  // Set status to true
            voucher.setCreatedBy(manager.getManagerId());  
            voucher.setModifiedBy(manager.getManagerId()); 
            WebManager.getInstance().voucherDAO.addVoucher(voucher);
            response.sendRedirect("manageVoucher");
        } catch (SQLException ex) {
            Logger.getLogger(AddVoucherServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(AddVoucherServlet.class.getName()).log(Level.SEVERE, null, ex);
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
