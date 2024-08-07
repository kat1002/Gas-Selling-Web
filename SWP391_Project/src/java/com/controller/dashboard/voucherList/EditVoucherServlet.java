/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.controller.dashboard.voucherList;

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
import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author kirit
 */
@WebServlet(name = "EditVoucherServlet", urlPatterns = {"/editVoucher"})
public class EditVoucherServlet extends HttpServlet {

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
            out.println("<title>Servlet EditVoucherServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditVoucherServlet at " + request.getContextPath() + "</h1>");
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
        response.setContentType("text/html;charset=UTF-8");
        Manager manager = (Manager) request.getSession().getAttribute("manager");
        if (manager == null) {
            response.sendRedirect("login_system.jsp");
            return;
        }
        try {
            String post_id_raw = request.getParameter("id");
            int news_id = 0;
            try {
                news_id = Integer.parseInt(post_id_raw);
            } catch (NumberFormatException e) {

            }
            VoucherDAO VoucherDAO = new VoucherDAO();
            Voucher Voucher = VoucherDAO.getVoucher(news_id);
            request.setAttribute("voucher", Voucher);
            request.getRequestDispatcher("editVoucher.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(EditVoucherServlet.class.getName()).log(Level.SEVERE, null, ex);

        } catch (ClassNotFoundException ex) {
            Logger.getLogger(EditVoucherServlet.class.getName()).log(Level.SEVERE, null, ex);
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
        response.setContentType("text/html;charset=UTF-8");
        Manager manager = (Manager) request.getSession().getAttribute("manager");
        if (manager == null) {
            response.sendRedirect("login_system.jsp");
            return;
        }
        try {
            LocalDate now = LocalDate.now();
            Date sqlDate = Date.valueOf(now);
            String post_id_raw = request.getParameter("id");
            int id = 0;
            try {
                id = Integer.parseInt(post_id_raw);
            } catch (NumberFormatException e) {

            }
            VoucherDAO voucherDAO = new VoucherDAO();
            Voucher voucher = voucherDAO.getVoucher(id);
            String voucherCode = request.getParameter("voucherCode");
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String status = request.getParameter("status");
            int discountType = Integer.parseInt(request.getParameter("discountType"));
            float discountValue = Float.parseFloat(request.getParameter("discountValue"));
            float condition = Float.parseFloat(request.getParameter("condition"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            Date date = null;
            String expiry = request.getParameter("expiry");
            date = ((expiry == null) || (expiry.equals("")))
                    ? null : Date.valueOf(expiry);
            voucher.setVoucherCode(voucherCode);
            voucher.setTitle(title);
            voucher.setDescription(description);
            voucher.setDiscountType(discountType);
            voucher.setDiscountValue(discountValue);
            voucher.setCondition(condition);
            voucher.setQuantity(quantity);
            voucher.setExpiry(date);
            voucher.setVoucherId(id);
            voucher.setCreatedAt(voucher.getCreatedAt());
            voucher.setModifiedOn(sqlDate);
            if (status.equals("1")) {
                voucher.setStatus(true);
            }
            if (status.equals("0")) {
                voucher.setStatus(false);
            }
            voucher.setCreatedBy(voucher.getCreatedBy());  
            voucher.setModifiedBy(manager.getManagerId());

            voucherDAO.updateVoucher(voucher);
            response.sendRedirect("manageVoucher");
        } catch (SQLException ex) {
            Logger.getLogger(EditVoucherServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(EditVoucherServlet.class.getName()).log(Level.SEVERE, null, ex);
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
