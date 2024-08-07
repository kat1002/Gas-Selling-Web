/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.controller.order_customer;

import com.controller.WebManager;
import com.controller.product_list.ProductListServlet;
import com.model.Customer;
import com.model.DAO.OrderDAO;
import com.model.DAO.headerDAO;
import com.model.Order;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
@WebServlet(name = "OrderListServlet", urlPatterns = {"/orderlist"})
public class OrderListServlet extends HttpServlet {

    public void prepareHeaderAndFooter(HttpServletRequest request, HttpServletResponse response) throws SQLException, ClassNotFoundException {
        Logger.getLogger(ProductListServlet.class.getName()).log(Level.INFO, "header: " + new headerDAO().getHeader());

        HttpSession session = request.getSession();
        session.setAttribute("header", WebManager.getInstance().headerDAO.getHeader());
        session.setAttribute("categoryTitle", WebManager.getInstance().headerDAO.getCategoryTitle());
        session.setAttribute("footerItem", WebManager.getInstance().footerDAO.getFooterItem());
        session.setAttribute("footerContent", WebManager.getInstance().footerDAO.getFooterContent());
    }

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            prepareHeaderAndFooter(request, response);
            PrintWriter out = response.getWriter();
            HttpSession session = request.getSession();
            Customer customer = (Customer) session.getAttribute("user");
            if (customer == null) {
                out.println("<script>");
                out.println("alert('Please login first !');");
                out.println("window.location.href='home';");
                out.println("</script>");
                response.sendRedirect("home"); // Redirect to login if user is not logged in
                out.close();
                return;
            }
            // Get parameters from request
            List<Order> orders = new ArrayList<>();
            String status = request.getParameter("status");
            String paymentMethod = request.getParameter("paymentMethod");
            String startDate = request.getParameter("startDate");
            String endDate = request.getParameter("endDate");
            String minPrice = request.getParameter("minPrice");
            String maxPrice = request.getParameter("maxPrice");
            String sortprice = request.getParameter("sortprice");
            String page = request.getParameter("page");
            String orderperpage = request.getParameter("orderperpage");
            int totalorder = WebManager.getInstance().orderDAO.getAllOrdersByCustomerID(customer.getCustomerId()).size();
            int xpage = (page == null || page.isEmpty() || page.equals("0")) ? 1 : Integer.parseInt(page);
            int orderPerPage = (orderperpage == null || orderperpage.isEmpty()) ? 5 : Integer.parseInt(orderperpage);
            int paymentmethod = (paymentMethod == null || paymentMethod.isEmpty()) ? 0 : Integer.parseInt(paymentMethod);
            int statuss = (status == null || status.isEmpty()) ? 0 : Integer.parseInt(status);
            int choicesortprice = (sortprice == null || sortprice.isEmpty()) ? 0 : Integer.parseInt(sortprice);
            int totalOrderChoice = WebManager.getInstance().orderDAO.getOrderByCustomerFilter(customer.getCustomerId(), paymentmethod, statuss,
                    minPrice, maxPrice, startDate, endDate, choicesortprice).size();
            int start = (xpage - 1) * orderPerPage;
            int end = Math.min(xpage * orderPerPage, totalOrderChoice);
            orders = WebManager.getInstance().orderDAO.getListOrderByPage(WebManager.getInstance().orderDAO.getOrderByCustomerFilter(customer.getCustomerId(), paymentmethod, statuss,
                    minPrice, maxPrice, startDate, endDate, choicesortprice), start, end);
            int num = (totalOrderChoice % orderPerPage == 0) ? (totalOrderChoice / orderPerPage) : ((totalOrderChoice / orderPerPage) + 1);
            // Set attributes to be accessible in JSP
            request.setAttribute("statuss", statuss);
            request.setAttribute("paymentMethod", paymentmethod);
            request.setAttribute("startDate", startDate);
            request.setAttribute("endDate", endDate);
            request.setAttribute("minPrice", minPrice);
            request.setAttribute("maxPrice", maxPrice);
            request.setAttribute("sortprice", choicesortprice);
            request.setAttribute("page", xpage);
            request.setAttribute("orderPerPage", orderPerPage);
            request.setAttribute("num", num);
            request.setAttribute("orderList", orders);
            request.getRequestDispatcher("orderlist.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(OrderListServlet.class.getName()).log(Level.SEVERE, null, ex);
            
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(OrderListServlet.class.getName()).log(Level.SEVERE, null, ex);
            
        } catch (NumberFormatException ex) {
            Logger.getLogger(OrderListServlet.class.getName()).log(Level.SEVERE, null, ex);
            
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
