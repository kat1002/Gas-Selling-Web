/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.controller.dashboard.newsList;

import com.model.Category;
import com.model.DAO.NewsDAO;
import com.model.DAO.headerDAO;
import com.model.News;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author kirit
 */
@WebServlet(name = "ManageNavServlet", urlPatterns = {"/manageNav"})
public class ManageNavServlet extends HttpServlet {

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

        headerDAO headerDAO = new headerDAO();
        Date dateCreateFrom = null;
        Date dateCreateTo = null;
        Date dateModifyFrom = null;
        Date dateModifyTo = null;
        String[] searchTerms = new String[0];

        String role = request.getParameter("role");
        String setPageNumber = request.getParameter("set-page-number");
        String searchName = request.getParameter("searchName");
        String createDateFrom = request.getParameter("createDateFrom");
        String createDateTo = request.getParameter("createDateTo");
        String modifyDateFrom = request.getParameter("modifyDateFrom");
        String modifyDateTo = request.getParameter("modifyDateTo");
        String createdByStr = request.getParameter("createdBy");
        String modifitedByStr = request.getParameter("modifitedBy");

        List<Category> listNav = new ArrayList<Category>();

        //serach-name
        if (searchName != null && !searchName.equals("")) {
            searchTerms = searchName.split("\\s+");
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

        List<Category> listNavRaw = headerDAO.getAllNavFilter(searchTerms, dateCreateFrom, dateCreateTo, dateModifyFrom, dateModifyTo, createdBy, modifitedBy);

        //select via cate
        if (role == null || role.equals("") || role.equals("all")) {
            role = "all";
            listNav = listNavRaw;
        }
        if (role.equals("Header")) {
            for (Category c : listNavRaw) {
                if (c.getRole() > 0) {
                    listNav.add(c);
                }
            }
        }
        if (role.equals("Footer")) {
            for (Category c : listNavRaw) {
                if (c.getRole() < 0) {
                    listNav.add(c);
                }
            }
        }

        //set number news
        if (setPageNumber
                == null || setPageNumber.equals(
                        "")) {
            request.setAttribute("setPageNumber", 5);
        } else {
            request.setAttribute("setPageNumber", request.getParameter("set-page-number"));
        }

        request.setAttribute(
                "searchName", searchName);
        request.setAttribute(
                "role", role);
        request.setAttribute(
                "createDateFrom", dateCreateFrom);
        request.setAttribute(
                "createDateTo", dateCreateTo);
        request.setAttribute(
                "modifyDateFrom", dateModifyFrom);
        request.setAttribute(
                "modifyDateTo", dateModifyTo);
        request.setAttribute(
                "createdBy", createdBy);
        request.setAttribute(
                "modifitedBy", modifitedBy);
        request.setAttribute(
                "navList", listNav);

        request.getRequestDispatcher(
                "manageNav.jsp").forward(request, response);
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
