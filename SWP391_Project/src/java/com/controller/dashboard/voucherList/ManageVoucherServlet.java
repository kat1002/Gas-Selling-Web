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
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.sql.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author kirit
 */
@WebServlet(name = "ManageVoucherServlet", urlPatterns = {"/manageVoucher"})
public class ManageVoucherServlet extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        Manager manager = (Manager) request.getSession().getAttribute("manager");
        if (manager == null) {
            response.sendRedirect("login_system.jsp");
            return;
        }
        VoucherDAO VoucherDAO = new VoucherDAO();
        Date dateCreateFrom = null;
        Date dateCreateTo = null;
        Date dateModifyFrom = null;
        Date dateModifyTo = null;
        String[] searchTermsCode = new String[0];
        String[] searchTermsTitle = new String[0];

        String type = request.getParameter("type");
        String setPageNumber = request.getParameter("set-page-number");

        String searchCode = request.getParameter("searchCode");
        String searchTitle = request.getParameter("searchTitle");
        String createDateFrom = request.getParameter("createDateFrom");
        String statusStr = request.getParameter("status");
        String createDateTo = request.getParameter("createDateTo");
        String modifyDateFrom = request.getParameter("modifyDateFrom");
        String modifyDateTo = request.getParameter("modifyDateTo");
        String createdByStr = request.getParameter("createdBy");
        String modifitedByStr = request.getParameter("modifitedBy");

        List<Voucher> listVoucher = new ArrayList<>();

        //serach-name
        if (searchCode != null && !searchCode.equals("")) {
            searchTermsCode = searchCode.split("\\s+");
        }
        if (searchTitle != null && !searchTitle.equals("")) {
            searchTermsTitle = searchTitle.split("\\s+");
        }

        //date
        dateCreateFrom = ((createDateFrom == null) || (createDateFrom.equals("")))
                ? null : Date.valueOf(createDateFrom);
        dateCreateTo = ((createDateTo == null) || (createDateTo.equals("")))
                ? null : Date.valueOf(createDateTo);
        dateModifyFrom = ((modifyDateFrom == null) || (modifyDateFrom.equals("")))
                ? null : Date.valueOf(modifyDateFrom);
        dateModifyTo = ((modifyDateTo == null) || (modifyDateTo.equals("")))
                ? null : Date.valueOf(modifyDateTo);

        int createdBy = (createdByStr != null && !createdByStr.isEmpty()) ? Integer.parseInt(createdByStr) : 0;
        int modifitedBy = (modifitedByStr != null && !modifitedByStr.isEmpty()) ? Integer.parseInt(modifitedByStr) : 0;

        Boolean status = true;
        if (statusStr != null && !statusStr.isEmpty()) {
            status = Boolean.valueOf(statusStr);
        }

        List<Voucher> listVoucherRaw = VoucherDAO.getVoucherByFilter(searchTermsCode, searchTermsTitle, createdBy, modifitedBy, dateCreateFrom, dateCreateTo, dateModifyFrom, dateModifyTo,status);

        //select via cate
        if (type == null || type.equals("") || type.equals("all")) {
            type = "all";
            listVoucher = listVoucherRaw;
        }
        if (type.equals("1")) {
            for (Voucher voucher : listVoucherRaw) {
                if (voucher.getDiscountType() == 1) {
                    listVoucher.add(voucher);
                }
            }
        }
        if (type.equals("0")) {
            for (Voucher voucher : listVoucherRaw) {
                if (voucher.getDiscountType() == 0) {
                    listVoucher.add(voucher);
                }
            }
        }

        //set number news
        if (setPageNumber == null || setPageNumber.equals("")) {
            request.setAttribute("setPageNumber", 5);
        } else {
            request.setAttribute("setPageNumber", request.getParameter("set-page-number"));
        }
        
        request.setAttribute("searchCode", searchCode);
        request.setAttribute("searchTitle", searchTitle);
        request.setAttribute("type", type);
        request.setAttribute("createDateFrom", dateCreateFrom);
        request.setAttribute("createDateTo", dateCreateTo);
        request.setAttribute("modifyDateFrom", dateModifyFrom);
        request.setAttribute("modifyDateTo", dateModifyTo);
        request.setAttribute("createdBy", createdBy);
        request.setAttribute("modifitedBy", modifitedBy);
        request.setAttribute("status", status);

        request.setAttribute("listVoucher", listVoucher);

        request.getRequestDispatcher("manageVoucher.jsp").forward(request, response);
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
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ManageVoucherServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ManageVoucherServlet.class.getName()).log(Level.SEVERE, null, ex);
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ManageVoucherServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ManageVoucherServlet.class.getName()).log(Level.SEVERE, null, ex);
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
