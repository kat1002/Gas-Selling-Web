/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.controller.product_detail;

import com.controller.WebManager;
import com.controller.product_list.ProductListServlet;
import com.model.Customer;
import com.model.DAO.CategoryDAO;
import com.model.DAO.ProductDAO;
import com.model.DAO.RateDAO;
import com.model.DAO.headerDAO;
import com.model.Product;
import com.model.Rate;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import org.apache.catalina.startup.WebAnnotationSet;

/**
 *
 * @author Acer Nitro 5
 */
public class ProductDetailServlet extends HttpServlet {

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
            out.println("<title>Servlet ProductDetailServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductDetailServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    public void prepareHeaderAndFooter(HttpServletRequest request, HttpServletResponse response) throws SQLException, ClassNotFoundException {
        java.util.logging.Logger.getLogger(ProductListServlet.class.getName()).log(java.util.logging.Level.INFO, "header: " + new headerDAO().getHeader());

        HttpSession session = request.getSession();
        session.setAttribute("header", WebManager.getInstance().headerDAO.getHeader());
        session.setAttribute("categoryTitle", WebManager.getInstance().headerDAO.getCategoryTitle());
        session.setAttribute("footerItem", WebManager.getInstance().footerDAO.getFooterItem());
        session.setAttribute("footerContent", WebManager.getInstance().footerDAO.getFooterContent());
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
        String productIdStr = request.getParameter("id");

        if (productIdStr == null || productIdStr.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing product ID");
            return;
        }
        try {
            prepareHeaderAndFooter(request, response);
            WebManager.getInstance().rateDAO.updateReviewsRate();//when someone review, the page will update the ratings of the current product

            int productId = Integer.parseInt(productIdStr);
            Product product = WebManager.getInstance().productDAO.getProduct(productId);
            List<Product> products = WebManager.getInstance().productDAO.listProductsByCategoryRelated(product.getCategoryId(), productId);

            //showing all ratings in pages
            List<Rate> rateList = WebManager.getInstance().rateDAO.getRateListByProductIdDESC(productId);

//            int page, numberpage = 3;
//            int num = (rateList.size() % numberpage == 0 ? (rateList.size() / numberpage) : ((rateList.size() / numberpage) + 1));
//            String xpage = request.getParameter("page");
//            if (xpage == null) {
//                page = 1;
//            } else {
//                page = Integer.parseInt(xpage);
//            }
//            int start = (page - 1) * numberpage;
//            int end = Math.min(page * numberpage, rateList.size());
//            List<Rate> rateListPerPage = WebManager.getInstance().rateDAO.getRatesByPage(rateList, start, end);    

            //check if user commented once
            if (request.getSession().getAttribute("user") != null) {

                Customer customer = (Customer) request.getSession().getAttribute("user");
                int userId = customer.getCustomerId();
                boolean hasRated = WebManager.getInstance().rateDAO.hasUserRatedProduct(userId, productId);
                request.setAttribute("hasRated", hasRated);
            }
            request.setAttribute("rateListByProduct", rateList);
            request.setAttribute("count_sold", WebManager.getInstance().orderItemDAO.countNumberOfProductSold(productId));
//            request.setAttribute("listR", rateList);
//            request.setAttribute("num", num);
//            request.setAttribute("page", page);
            request.setAttribute("product", product);
            request.setAttribute("products", products);
            request.getRequestDispatcher("product.jsp").forward(request, response);
        } catch (NumberFormatException ex) {
            Logger.getLogger(ProductDetailServlet.class.getName()).log(Level.SEVERE, null, ex);
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid product ID");
        } catch (SQLException | ClassNotFoundException e) {
            throw new ServletException("Cannot obtain product from DB", e);
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
