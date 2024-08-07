/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.controller.dashboard;

import com.controller.WebManager;
import com.controller.dashboard.discount_management.EditDiscountServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * @author Admin
 */
@WebServlet(name = "DashboardServlet", urlPatterns = {"/dashboard"})
public class DashboardServlet extends HttpServlet {

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
        System.out.println(request.getSession().getAttribute("manager"));
        if (request.getSession().getAttribute("manager") == null) {
            response.sendRedirect("login_system.jsp");
            return;
        }
        try {
            String year = request.getParameter("year");
            ArrayList<String> recentYears = new ArrayList<>();
            int currentYear = java.time.LocalDate.now().getYear();
            int currentMonth = java.time.LocalDate.now().getMonthValue();
            for (int i = 0; i < 10; i++) {
                recentYears.add(Integer.toString(currentYear - i));
            }
            int yearr = (year == null || year.isEmpty()) ? currentYear : Integer.parseInt(year);
            request.setAttribute("yearr", yearr);
            request.setAttribute("currentYear", currentYear);
            request.setAttribute("recentYears", recentYears);
            // Gán total sales cho tháng 1
            request.setAttribute("totalSaledMonth1", WebManager.getInstance().orderDAO.getTotalSaledByMonth(1, yearr));
            // Gán total sales cho tháng 2
            request.setAttribute("totalSaledMonth2", WebManager.getInstance().orderDAO.getTotalSaledByMonth(2, yearr));
            // Gán total sales cho tháng 3
            request.setAttribute("totalSaledMonth3", WebManager.getInstance().orderDAO.getTotalSaledByMonth(3, yearr));
            // Gán total sales cho tháng 4
            request.setAttribute("totalSaledMonth4", WebManager.getInstance().orderDAO.getTotalSaledByMonth(4, yearr));
            // Gán total sales cho tháng 5
            request.setAttribute("totalSaledMonth5", WebManager.getInstance().orderDAO.getTotalSaledByMonth(5, yearr));
            // Gán total sales cho tháng 6
            request.setAttribute("totalSaledMonth6", WebManager.getInstance().orderDAO.getTotalSaledByMonth(6, yearr));
            // Gán total sales cho tháng 7
            request.setAttribute("totalSaledMonth7", WebManager.getInstance().orderDAO.getTotalSaledByMonth(7, yearr));
            // Gán total sales cho tháng 8
            request.setAttribute("totalSaledMonth8", WebManager.getInstance().orderDAO.getTotalSaledByMonth(8, yearr));
            // Gán total sales cho tháng 9
            request.setAttribute("totalSaledMonth9", WebManager.getInstance().orderDAO.getTotalSaledByMonth(9, yearr));
            // Gán total sales cho tháng 10
            request.setAttribute("totalSaledMonth10", WebManager.getInstance().orderDAO.getTotalSaledByMonth(10, yearr));
            // Gán total sales cho tháng 11
            request.setAttribute("totalSaledMonth11", WebManager.getInstance().orderDAO.getTotalSaledByMonth(11, yearr));
            // Gán total sales cho tháng 12
            request.setAttribute("totalSaledMonth12", WebManager.getInstance().orderDAO.getTotalSaledByMonth(12, yearr));
            // Gán total delivery cho tháng 1
            request.setAttribute("totalDeliveryMonth1", WebManager.getInstance().orderDAO.getTotalDeliveringByMonth(1, yearr));
            // Gán total delivery cho tháng 2
            request.setAttribute("totalDeliveryMonth2", WebManager.getInstance().orderDAO.getTotalDeliveringByMonth(2, yearr));
            // Gán total delivery cho tháng 3
            request.setAttribute("totalDeliveryMonth3", WebManager.getInstance().orderDAO.getTotalDeliveringByMonth(3, yearr));
            // Gán total delivery cho tháng 4
            request.setAttribute("totalDeliveryMonth4", WebManager.getInstance().orderDAO.getTotalDeliveringByMonth(4, yearr));
            // Gán total delivery cho tháng 5
            request.setAttribute("totalDeliveryMonth5", WebManager.getInstance().orderDAO.getTotalDeliveringByMonth(5, yearr));
            // Gán total delivery cho tháng 6
            request.setAttribute("totalDeliveryMonth6", WebManager.getInstance().orderDAO.getTotalDeliveringByMonth(6, yearr));
            // Gán total delivery cho tháng 7
            request.setAttribute("totalDeliveryMonth7", WebManager.getInstance().orderDAO.getTotalDeliveringByMonth(7, yearr));
            // Gán total delivery cho tháng 8
            request.setAttribute("totalDeliveryMonth8", WebManager.getInstance().orderDAO.getTotalDeliveringByMonth(8, yearr));
            // Gán total delivery cho tháng 9
            request.setAttribute("totalDeliveryMonth9", WebManager.getInstance().orderDAO.getTotalDeliveringByMonth(9, yearr));
            // Gán total delivery cho tháng 10
            request.setAttribute("totalDeliveryMonth10", WebManager.getInstance().orderDAO.getTotalDeliveringByMonth(10, yearr));
            // Gán total delivery cho tháng 11
            request.setAttribute("totalDeliveryMonth11", WebManager.getInstance().orderDAO.getTotalDeliveringByMonth(11, yearr));
            // Gán total delivery cho tháng 12
            request.setAttribute("totalDeliveryMonth12", WebManager.getInstance().orderDAO.getTotalDeliveringByMonth(12, yearr));
            request.setAttribute("total_saled", WebManager.getInstance().orderDAO.getTotalSaled());
            request.setAttribute("total_revenue", WebManager.getInstance().orderDAO.getTotalRevenue());
            request.setAttribute("total_orders", WebManager.getInstance().orderDAO.getAllOrders().size());
            request.setAttribute("total_customers", WebManager.getInstance().customerDAO.listAllcustomer().size());
            request.setAttribute("total_managers", WebManager.getInstance().managerDAO.getTotalManagersWithRole_1());
            request.setAttribute("total_feedbacks", WebManager.getInstance().rateDAO.getRateList().size());
            request.setAttribute("total_gas_revenue", WebManager.getInstance().orderDAO.getTotalRevenueByCategory(1));
            request.setAttribute("total_stove_revenue", WebManager.getInstance().orderDAO.getTotalRevenueByCategory(2));
            request.setAttribute("total_accessories_revenue", WebManager.getInstance().orderDAO.getTotalRevenueByCategory(21));
            request.setAttribute("list_category_product", WebManager.getInstance().categoryDAO.getAllCategories());
            // Tổng doanh thu của tháng hiện tại
            double currentMonthSales = WebManager.getInstance().orderDAO.getTotalSaledByMonth(currentMonth, currentYear);
// Tổng doanh thu của tháng trước
            double previousMonthSales = WebManager.getInstance().orderDAO.getTotalSaledOfPreviousMonth(currentMonth, currentYear);
            // Tính toán sự thay đổi
            double salesChange = 0;
            if (previousMonthSales != 0) {
                salesChange = ((currentMonthSales - previousMonthSales) / previousMonthSales) * 100;
            }
            request.setAttribute("sales_change", salesChange);
            // Tổng số đơn hàng của tháng hiện tại
            int currentMonthOrders = WebManager.getInstance().orderDAO.getTotalOrdersByMonth(currentMonth, currentYear);

            // Tổng số đơn hàng của tháng trước
            int previousMonthOrders = WebManager.getInstance().orderDAO.getTotalOrdersOfPreviousMonth(currentMonth, currentYear);

            // Tính toán sự thay đổi
            double ordersChange = 0;
            if (previousMonthOrders != 0) {
                ordersChange = ((double) (currentMonthOrders - previousMonthOrders) / previousMonthOrders) * 100;
            }
            // Đặt giá trị vào request attribute
            request.setAttribute("orders_change", ordersChange);
            // Tổng doanh thu của tháng hiện tại
            double currentMonthRevenue = WebManager.getInstance().orderDAO.getTotalRevenueByMonth(currentMonth, currentYear);

            // Tổng doanh thu của tháng trước
            double previousMonthRevenue = WebManager.getInstance().orderDAO.getTotalRevenueOfPreviousMonth(currentMonth, currentYear);

            // Tính toán sự thay đổi
            double revenueChange = 0;
            if (previousMonthRevenue != 0) {
                revenueChange = ((currentMonthRevenue - previousMonthRevenue) / previousMonthRevenue) * 100;
            }

            // Đặt giá trị vào request attribute
            request.setAttribute("revenue_change", revenueChange);
            // Tổng số lượng phản hồi của tháng hiện tại
            int currentMonthFeedbacks = WebManager.getInstance().rateDAO.getTotalFeedbacksByMonth(currentMonth, currentYear);

            // Tổng số lượng phản hồi của tháng trước
            int previousMonthFeedbacks = WebManager.getInstance().rateDAO.getTotalFeedbacksOfPreviousMonth(currentMonth, currentYear);

            // Tính toán sự thay đổi
            double feedbacksChange = 0;
            if (previousMonthFeedbacks != 0) {
                feedbacksChange = ((double) (currentMonthFeedbacks - previousMonthFeedbacks) / previousMonthFeedbacks) * 100;
            }

            // Đặt giá trị vào request attribute
            request.setAttribute("feedbacks_change", feedbacksChange);
            request.setAttribute("biggest_order", WebManager.getInstance().orderDAO.getBiggestOrder());
            request.setAttribute("newest_voucher", WebManager.getInstance().voucherDAO.getNewestVoucher());
            request.setAttribute("newest_customer", WebManager.getInstance().customerDAO.getNewestCustomer());
            request.setAttribute("newest_manager", WebManager.getInstance().managerDAO.getNewestManager());
            request.setAttribute("newest_feedback", WebManager.getInstance().rateDAO.getNewestFeedback());
            request.setAttribute("newest_order", WebManager.getInstance().orderDAO.getNewestOrder());
            request.getRequestDispatcher("dashboard.jsp").forward(request, response);
        } catch (Exception ex) {
            Logger.getLogger(EditDiscountServlet.class.getName()).log(Level.SEVERE, null, ex);
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
        //processRequest(request, response);
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
