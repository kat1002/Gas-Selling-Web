/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.controller.dashboard.warrantyList;

import com.model.DAO.WarrantyDAO;
import com.model.Warranty;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author kirit
 */
@WebServlet(name = "ManageWarrantyServlet", urlPatterns = {"/manageWarranty"})
public class ManageWarrantyServlet extends HttpServlet {

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

        WarrantyDAO WarrantyDAO = new WarrantyDAO();

        Date dateCreateFrom = null;
        Date dateCreateTo = null;
        Date dateModifyFrom = null;
        Date dateModifyTo = null;
        Date guaranteeDate = null;
        String[] searchTermsCode = new String[0];
        String[] searchTermsStatus = new String[0];
        String managerIdStr = request.getParameter("managerId");
        int managerId = (managerIdStr != null && !managerIdStr.isEmpty()) ? Integer.parseInt(managerIdStr) : 0;
        String serialNumberIdStr = request.getParameter("serialNumberId");
        int serialNumberId = (serialNumberIdStr != null && !serialNumberIdStr.isEmpty()) ? Integer.parseInt(serialNumberIdStr) : 0;

        String setPageNumber = request.getParameter("set-page-number");
        String warrantyTypeStr = request.getParameter("warrantyType");
        int warrantyType = (warrantyTypeStr != null && !warrantyTypeStr.isEmpty()) ? Integer.parseInt(warrantyTypeStr) : 0;
        String guaranteeDateStr = request.getParameter("guaranteeDate");

        String searchStatus = request.getParameter("searchStatus");
        String createDateFrom = request.getParameter("createDateFrom");
        String createDateTo = request.getParameter("createDateTo");
        String modifyDateFrom = request.getParameter("modifyDateFrom");
        String modifyDateTo = request.getParameter("modifyDateTo");
        String createdByStr = request.getParameter("createdBy");
        String modifitedByStr = request.getParameter("modifitedBy");
        Boolean isDone = Boolean.valueOf(request.getParameter("isDone"));

        List<Warranty> listWarranty = new ArrayList<>();

        if (searchStatus != null && !searchStatus.equals("")) {
            searchTermsStatus = searchStatus.split("\\s+");
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
        guaranteeDate = ((guaranteeDateStr == null) || (guaranteeDateStr.equals("")))
                ? null : Date.valueOf(guaranteeDateStr);

        int createdBy = (createdByStr != null && !createdByStr.isEmpty()) ? Integer.parseInt(createdByStr) : 0;
        int modifitedBy = (modifitedByStr != null && !modifitedByStr.isEmpty()) ? Integer.parseInt(modifitedByStr) : 0;
        listWarranty = WarrantyDAO.getWarrantyByFilter(serialNumberId, searchTermsStatus, managerId, warrantyType, guaranteeDate, isDone, createdBy, modifitedBy, dateCreateFrom, dateCreateTo, dateModifyFrom, dateModifyTo);

        //set number news
        if (setPageNumber == null || setPageNumber.equals("")) {
            request.setAttribute("setPageNumber", 5);
        } else {
            request.setAttribute("setPageNumber", request.getParameter("set-page-number"));
        }
     
        request.setAttribute("type", warrantyType);
        request.setAttribute("searchStatus", searchStatus);
        request.setAttribute("serialNumberId", serialNumberId);
        request.setAttribute("managerId", managerId);
        request.setAttribute("createDateFrom", dateCreateFrom);
        request.setAttribute("createDateTo", dateCreateTo);
        request.setAttribute("modifyDateFrom", dateModifyFrom);
        request.setAttribute("modifyDateTo", dateModifyTo);
        request.setAttribute("createdBy", createdBy);
        request.setAttribute("modifitedBy", modifitedBy);
        request.setAttribute("isDone", isDone);
        request.setAttribute("guaranteeDate", guaranteeDate);

            request.setAttribute("listWarranty", listWarranty);
        request.getRequestDispatcher("manageWarranty.jsp").forward(request, response);

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ManageWarrantyServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ManageWarrantyServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(ManageWarrantyServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ManageWarrantyServlet.class.getName()).log(Level.SEVERE, null, ex);
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
