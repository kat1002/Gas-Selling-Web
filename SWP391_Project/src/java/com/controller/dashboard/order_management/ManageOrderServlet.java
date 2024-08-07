/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.controller.dashboard.order_management;

import com.controller.WebManager;
import com.model.Manager;
import com.model.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "ManageOrderServlet", urlPatterns = {"/manageorder"})
public class ManageOrderServlet extends HttpServlet {
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">

    /**
     * Handles the HTTP <code>GET</code> method.
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
            out.println("<title>Servlet EditProductServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditProductServlet at " + request.getContextPath() + "</h1>");
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
            String customer = request.getParameter("customersearch");
            String totalPriceFrom = request.getParameter("totalpricefrom");
            String totalPriceTo = request.getParameter("totalpriceto");
            String orderDateFrom = request.getParameter("orderdatefrom");
            String orderDateTo = request.getParameter("orderdateto");
            String phoneNumber = request.getParameter("phonenumber");
            String city = request.getParameter("city");
            String payment = request.getParameter("payment");
            String choiceSortPrice = request.getParameter("choicesortprice");
            String page = request.getParameter("page");
            String orderPerPage = request.getParameter("orderperpage");
            String choicestatus = request.getParameter("choicestatus");
            int statuss = 0;
            if (choicestatus == null || choicestatus.equals("0")) {
                statuss = 0;
            } else {
                statuss = Integer.parseInt(choicestatus);
            }
            int totalorders = WebManager.getInstance().orderDAO.getAllOrders().size();
            int xpage = (page == null || page.isEmpty()) || page.equals("0") ? 1 : Integer.parseInt(page);
            int orderperpage = (orderPerPage == null || orderPerPage.isEmpty() || orderPerPage.equals("0")) ? 5 : Integer.parseInt(orderPerPage);
            int totalorderchoice = WebManager.getInstance().orderDAO.getListOrderByFilter(customer, totalPriceFrom, totalPriceTo, orderDateFrom, orderDateTo, phoneNumber, payment, choiceSortPrice, city, statuss).size();
            int num = ((totalorderchoice % orderperpage == 0) ? (totalorderchoice / orderperpage) : (totalorderchoice / orderperpage) + 1);
            int start = (xpage - 1) * orderperpage;
            int end = Math.min(xpage * orderperpage, totalorderchoice);
            List<Order> orders = WebManager.getInstance().orderDAO.getListOrderByPage(WebManager.getInstance().orderDAO.getListOrderByFilter(customer, totalPriceFrom, totalPriceTo, orderDateFrom, orderDateTo, phoneNumber, payment, choiceSortPrice, city, statuss), start, end);
            request.setAttribute("customersearch", customer);
            request.setAttribute("totalpricefrom", totalPriceFrom);
            request.setAttribute("totalpriceto", totalPriceTo);
            request.setAttribute("orderdatefrom", orderDateFrom);
            request.setAttribute("orderdateto", orderDateTo);
            request.setAttribute("phonenumber", phoneNumber);
            request.setAttribute("city", city);
            request.setAttribute("payment", payment);
            request.setAttribute("choicesortprice", choiceSortPrice);
            request.setAttribute("page", xpage);
            request.setAttribute("num", num);
            request.setAttribute("orderperpage", orderperpage);
            request.setAttribute("orders", orders);
            request.setAttribute("choicestatus", choicestatus);
            request.getRequestDispatcher("manageorder.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ManageOrderServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ManageOrderServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NumberFormatException ex) {
            Logger.getLogger(ManageOrderServlet.class.getName()).log(Level.SEVERE, null, ex);
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
}
