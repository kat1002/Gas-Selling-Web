/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.controller.dashboard.product_management;

import com.controller.WebManager;
import com.model.DAO.CategoryDAO;
import com.model.Manager;
import com.model.Product;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ManageProductServlet", urlPatterns = {"/manageproduct"})
public class ManageProductServlet extends HttpServlet {


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

        if (request.getSession().getAttribute("manager") == null) {
            response.sendRedirect("login_system.jsp");
            return;
        }

        PrintWriter out = response.getWriter();
        try {
            List<Product> products = new ArrayList<>();
            String xpage = request.getParameter("page");
            String choicesortprice = request.getParameter("choicesortprice");
            String itemperpage = request.getParameter("itemperpage");
            String cid = request.getParameter("cid");
            String fromprice = request.getParameter("fromprice");
            String toprice = request.getParameter("toprice");
            String datecreatedfrom = request.getParameter("datecreatedfrom");
            String datecreatedto = request.getParameter("datecreatedto");
            String datemodifiedfrom = request.getParameter("datemodifiedfrom");
            String datemodifiedto = request.getParameter("datemodifiedto");
            String search = request.getParameter("search");
            String createdby = request.getParameter("createdby");
            String modifiedby = request.getParameter("modifiedby");
            String star = request.getParameter("star");
            int cidd = (cid == null || cid.isEmpty()) ? 0 : Integer.parseInt(cid);
            int sortprice = (choicesortprice == null || choicesortprice.isEmpty()) ? 0 : Integer.parseInt(choicesortprice);
            int itemsPerPage = (itemperpage == null || itemperpage.isEmpty()) ? 5 : Integer.parseInt(itemperpage);
            int page = (xpage == null || xpage.isEmpty() || xpage.equals("0")) ? 1 : Integer.parseInt(xpage);
            int totalProductsChoice = WebManager.getInstance().productDAO.listProductsMultipleChoice(cidd, sortprice, search, fromprice, toprice, datecreatedfrom, datecreatedto, datemodifiedfrom, datemodifiedto, createdby, modifiedby, star).size();
            int num = ((totalProductsChoice % itemsPerPage == 0) ? (totalProductsChoice / itemsPerPage) : (totalProductsChoice / itemsPerPage) + 1);
            int start = (page - 1) * itemsPerPage;
            int end = Math.min(page * itemsPerPage, totalProductsChoice);
            //cid=${cid}&choicesortprice=${choicesortprice}&fromprice=${fromprice}&toprice=${toprice}&datefrom=${datefrom}&dateto=${dateto}&itemperpage=${itemperpage}&search=${search}&createdby=${createdby}&modifiedby=${modifiedby}
            products = WebManager.getInstance().productDAO.getProductByPage(
                    WebManager.getInstance().productDAO.listProductsMultipleChoice(cidd, sortprice, search, fromprice, toprice, datecreatedfrom, datecreatedto, datemodifiedfrom, datemodifiedto, createdby, modifiedby, star), start, end);
            request.setAttribute("numbertotalproduct", totalProductsChoice);
            request.setAttribute("choicesortprice", sortprice);
            request.setAttribute("fromprice", fromprice);
            request.setAttribute("toprice", toprice);
            request.setAttribute("datecreatedfrom", datecreatedfrom);
            request.setAttribute("datecreatedto", datecreatedto);
            request.setAttribute("datemodifiedfrom", datemodifiedfrom);
            request.setAttribute("datemodifiedto", datemodifiedto);
            request.setAttribute("search", search);
            request.setAttribute("createdby", createdby);
            request.setAttribute("modifiedby", modifiedby);
            request.setAttribute("itemperpage", itemsPerPage);;
            request.setAttribute("cid", cidd);
            request.setAttribute("star", star);
            request.setAttribute("products", products);
            request.setAttribute("num", num);
            request.setAttribute("page", page);
            request.setAttribute("categories", WebManager.getInstance().categoryDAO.getAllCategories());
            request.getRequestDispatcher("manageproduct.jsp").forward(request, response);
        } catch (Exception ex) {
            Logger.getLogger(ManageProductServlet.class.getName()).log(Level.SEVERE, null, ex);
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
//        processRequest(request, response);
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
