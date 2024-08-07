/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.controller.product_list;

import com.controller.WebManager;
import com.model.Category;
import com.model.DAO.CategoryDAO;
import com.model.DAO.ProductDAO;
import com.model.DAO.footerDAO;
import com.model.DAO.headerDAO;
import com.model.Discount;
import com.model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * @author Admin
 */
@WebServlet(name = "ProductListServlet", urlPatterns = {"/product_list"})
public class ProductListServlet extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ProfileServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProfileServlet at " + request.getContextPath() + "</h1>");
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
        PrintWriter out = response.getWriter();
        response.setContentType("text/html;charset=UTF-8");
        
        try {
            prepareHeaderAndFooter(request, response);
            List<Product> products = new ArrayList<>();
            String cid = request.getParameter("cid");

            int totalProducts = WebManager.getInstance().productDAO.listProductsByCategory(0).size();
            String xpage = request.getParameter("page");
            String choicesortprice = request.getParameter("choicesortprice");
            String itemperpage = request.getParameter("itemperpage");
            String fromprice = request.getParameter("fromprice");
            String toprice = request.getParameter("toprice");
            String datefrom = request.getParameter("datefrom");
            String dateto = request.getParameter("dateto");
            String search = request.getParameter("search");
            String star = request.getParameter("star");
            if (star == null){
                star = "";
            }
            int page = (xpage == null || xpage.isEmpty() || xpage.equals("0")) ? 1 : Integer.parseInt(xpage);
            int cidd = (cid == null || cid.isEmpty()) ? 0 : Integer.parseInt(cid);
            int sortprice = (choicesortprice == null || choicesortprice.isEmpty()) ? 0 : Integer.parseInt(choicesortprice);
            int itemsPerPage = (itemperpage == null || itemperpage.isEmpty()) ? 8 : Integer.parseInt(itemperpage);
            int totalProductsChoice = WebManager.getInstance().productDAO.listProductsMultipleChoice(cidd, sortprice, search, fromprice, toprice, datefrom, dateto, null, null, null, null, star).size();
            int start = (page - 1) * itemsPerPage;
            int end = Math.min(page * itemsPerPage, totalProductsChoice);
            products = WebManager.getInstance().productDAO.getProductByPage(
                    WebManager.getInstance().productDAO.listProductsMultipleChoice(cidd, sortprice, search, fromprice, toprice, datefrom, dateto, null, null, null, null, star), start, end);
            int num = ((totalProductsChoice % itemsPerPage == 0) ? (totalProductsChoice / itemsPerPage) : (totalProductsChoice / itemsPerPage) + 1); // Số lượng trang sẽ bằng số lượng sản phẩm
            request.setAttribute("numbertotalproduct", totalProductsChoice);
            request.setAttribute("choicesortprice", sortprice);
            request.setAttribute("fromprice", fromprice);
            request.setAttribute("toprice", toprice);
            request.setAttribute("datefrom", datefrom);
            request.setAttribute("dateto", dateto);
            request.setAttribute("search", search);
            request.setAttribute("itemperpage", itemsPerPage);
            request.setAttribute("cid", cidd);
            request.setAttribute("products", products);
            request.setAttribute("num", num);
            request.setAttribute("star", star);
            request.setAttribute("page", page);
            request.setAttribute("categories", WebManager.getInstance().categoryDAO.getAllCategories());
            request.getRequestDispatcher("product_list.jsp").forward(request, response);
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(ProductListServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(ProductListServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ProductListServlet.class.getName()).log(Level.SEVERE, null, ex);
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
