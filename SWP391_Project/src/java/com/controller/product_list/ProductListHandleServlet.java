/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.controller.product_list;

import com.controller.WebManager;
import com.model.Discount;
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
@WebServlet(name = "ProductListHandleServlet", urlPatterns = {"/product_list_handle"})
public class ProductListHandleServlet extends HttpServlet {

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
            out.println("<title>Servlet CategoryHandleServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CategoryHandleServlet at " + request.getContextPath() + "</h1>");
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
        PrintWriter out = response.getWriter();
        try {
            List<Product> products = new ArrayList<>();
            String cid = request.getParameter("cid");
            int idd = (cid == null) ? 0 : Integer.parseInt(cid);

            int totalProducts = WebManager.getInstance().productDAO.listProductsByCategory(idd).size();
            int itemsPerPage = 3;

            int num = ((totalProducts % itemsPerPage == 0) ? (totalProducts / itemsPerPage) : (totalProducts / itemsPerPage) + 1); // Số lượng trang sẽ bằng số lượng sản phẩm
            int page = 1; // Trang mặc định là trang 1

            String xpage = request.getParameter("page");
            String choicesortprice = request.getParameter("choicesortprice");
            String itemperpage = request.getParameter("itemperpage");
            String fromprice = request.getParameter("fromprice");
            String toprice = request.getParameter("toprice");
            String datefrom = request.getParameter("datefrom");
            String dateto = request.getParameter("dateto");
            String search = request.getParameter("search");
            String star = request.getParameter("star");
            page = (xpage == null || xpage.isEmpty() || xpage.equals("0")) ? 1 : Integer.parseInt(xpage);
            int cidd = (cid == null || cid.isEmpty()) ? 0 : Integer.parseInt(cid);
            int sortprice = (choicesortprice == null || choicesortprice.isEmpty()) ? 0 : Integer.parseInt(choicesortprice);
            itemsPerPage = (itemperpage == null || itemperpage.isEmpty()) ? 3 : Integer.parseInt(itemperpage);

            int totalProductsChoice = WebManager.getInstance().productDAO.listProductsMultipleChoice(cidd, sortprice, search, fromprice, toprice, datefrom, dateto, null, null, null, null, star).size();
            int start = (page - 1) * itemsPerPage;
            int end = Math.min(page * itemsPerPage, totalProductsChoice);

            products = WebManager.getInstance().productDAO.getProductByPage(
                    WebManager.getInstance().productDAO.listProductsMultipleChoice(cidd, sortprice, search, fromprice, toprice, datefrom, dateto, null, null, null, null, star), start, end);
            for (Product product : products) {
                out.println("<div class=\"product-card\">");
                out.println("<a href=\"product?id=" + product.getProductId() + "\"><img src=\"" + product.getImages().get(0) + "\" alt=\"\" /></a>");
                out.println("<a class=\"menu-link\" href=\"product?id=" + product.getProductId() + "\">" + product.getTitle() + "</a>");
                out.println("<p class=\"star\">");
                for (int i = 0; i < product.getReviewsRate(); i++) {
                    out.println("<i class=\"fa-solid fa-star\" style=\"color: #9f8a46\"></i>");
                }
                for (int i = 0; i < (5 - product.getReviewsRate()); i++) {
                    out.println("<i class=\"fa-solid fa-star\" style=\"color: #727580\"></i>");
                }
                out.println("</p>");
                if (product.getStock() > 0) {
                    out.println("<p class=\"stock\">In stock</p>");
                } else {
                    out.println("<p class=\"outofstock\">Out of stock</p>");
                }
                // Điều kiện xác định giảm giá và hiển thị giá bán
                Discount discount = WebManager.getInstance().discountDAO.getDiscountByProductId(product.getProductId());
                if (discount != null) {
                    double discountedPrice = product.getPrice() - (product.getPrice() * discount.getDiscountValue());
                    out.println("<p class=\"price\" style=\"text-decoration: line-through;\">$" + product.getPrice() + "</p>");
                    out.println("<p class=\"price\" style=\"color: red;\">$" + String.format("%.2f", discountedPrice) + "</p>");
                } else {
                    out.println("<p class=\"price\">$" + product.getPrice() + "</p>");
                }
                out.println("</div>");
            }
        } catch (Exception ex) {
            Logger.getLogger(ProductListHandleServlet.class.getName()).log(Level.SEVERE, null, ex);
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
