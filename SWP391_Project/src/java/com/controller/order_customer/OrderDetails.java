package com.controller.order_customer;

import com.controller.WebManager;
import com.controller.product_list.ProductListServlet;
import com.model.Customer;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;

import com.model.DAO.OrderDAO;
import com.model.DAO.OrderItemDAO;
import com.model.DAO.headerDAO;
import com.model.Order;
import com.model.OrderItem;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "OrderDetails", value = "/OrderDetails")
public class OrderDetails extends HttpServlet {


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet NewServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet NewServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }
    public void prepareHeaderAndFooter(HttpServletRequest request, HttpServletResponse response) throws SQLException, ClassNotFoundException {
        Logger.getLogger(ProductListServlet.class.getName()).log(Level.INFO, "header: " + new headerDAO().getHeader());

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
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
        String orderId = request.getParameter("orderId");
        try {
            prepareHeaderAndFooter(request, response);
            Order order = WebManager.getInstance().orderDAO.getOrder(Integer.parseInt(orderId));
            request.setAttribute("order", order);

            // Lấy danh sách OrderItem cho đơn hàng tương ứng
            List<OrderItem> orderItems = WebManager.getInstance().orderItemDAO.getOrderItemsByOrderId(Integer.parseInt(orderId));
            request.setAttribute("orderItems", orderItems);
            request.getRequestDispatcher("order-details.jsp").forward(request, response);


        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(OrderDetails.class.getName()).log(Level.SEVERE, null, ex);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, ex.getMessage());
        }
        

    }

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