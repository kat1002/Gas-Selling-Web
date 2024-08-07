/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.controller.dashboard.discount_management;

import com.controller.WebManager;
import com.controller.dashboard.product_management.ManageProductServlet;
import com.model.Discount;
import com.model.Manager;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "ManageDiscountServlet", urlPatterns = {"/managediscount"})
public class ManageDiscountServlet extends HttpServlet {

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
            out.println("<title>Servlet ManageDiscountServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManageDiscountServlet at " + request.getContextPath() + "</h1>");
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
            String title = request.getParameter("title");
            String discountValueFrom = request.getParameter("discountvaluefrom");
            String discountValueTo = request.getParameter("discountvalueto");
            String createdAtFrom = request.getParameter("createdatfrom");
            String createdAtTo = request.getParameter("createdatto");
            String modifiedAtFrom = request.getParameter("modifiedatfrom");
            String modifiedAtTo = request.getParameter("modifiedatto");
            String createdBy = request.getParameter("createdby");
            String modifiedBy = request.getParameter("modifiedby");
            String itemPerPage = request.getParameter("itemperpage");
            String sortchoice = request.getParameter("sortchoice");
            String xpage = request.getParameter("page");

            if (sortchoice == null){
                sortchoice = "Constant";
            }

            String expiryfrom = request.getParameter("expiryfrom");
            String expiryto = request.getParameter("expiryto");

            int totalDiscount = WebManager.getInstance().discountDAO.getAllDiscounts().size();
            int page = (xpage == null || xpage.isEmpty()) || xpage.equals("0") ? 1 : Integer.parseInt(xpage);
            int itemperpage = (itemPerPage == null || itemPerPage.isEmpty() || itemPerPage.equals("0")) ? 5 : Integer.parseInt(itemPerPage);
            int totalDiscountChoice = WebManager.getInstance().discountDAO.getListDiscountMultipleFilter(title, discountValueFrom, discountValueTo, sortchoice, createdAtFrom, createdAtTo, modifiedAtFrom, modifiedAtTo, createdBy, modifiedBy, expiryfrom, expiryto).size();
            int num = ((totalDiscountChoice % itemperpage == 0) ? (totalDiscountChoice / itemperpage) : (totalDiscountChoice / itemperpage) + 1);
            int start = (page - 1) * itemperpage;
            int end = Math.min(page * itemperpage, totalDiscountChoice);
            List<Discount> discounts = WebManager.getInstance().discountDAO.getListDiscountByPage(WebManager.getInstance().discountDAO.getListDiscountMultipleFilter(title, discountValueFrom, discountValueTo, sortchoice, createdAtFrom, createdAtTo, modifiedAtFrom, modifiedAtTo, createdBy, modifiedBy, expiryfrom, expiryto), start, end);
            request.setAttribute("title", title);
            request.setAttribute("discountValueFrom", discountValueFrom);
            request.setAttribute("discountValueTo", discountValueTo);
            request.setAttribute("createdAtFrom", createdAtFrom);
            request.setAttribute("createdAtTo", createdAtTo);
            request.setAttribute("modifiedAtFrom", modifiedAtFrom);
            request.setAttribute("modifiedAtTo", modifiedAtTo);
            request.setAttribute("expiryfrom", expiryfrom);
            request.setAttribute("expiryto", expiryto);
            request.setAttribute("createdBy", createdBy);
            request.setAttribute("modifiedBy", modifiedBy);
            request.setAttribute("itemperpage", itemperpage);
            request.setAttribute("page", page);
            request.setAttribute("sortchoice", sortchoice);
            request.setAttribute("num", num);
            request.setAttribute("products", WebManager.getInstance().productDAO.listAllProducts());
            request.setAttribute("discounts", discounts);
            request.getRequestDispatcher("managediscount.jsp").forward(request, response);
        } catch (SQLException | ClassNotFoundException | NumberFormatException ex) {
            Logger.getLogger(ManageDiscountServlet.class.getName()).log(Level.SEVERE, null, ex);
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
