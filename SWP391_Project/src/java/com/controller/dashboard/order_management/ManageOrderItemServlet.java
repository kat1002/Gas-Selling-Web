/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.controller.dashboard.order_management;

import com.controller.WebManager;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.model.Manager;
import com.model.OrderItem;
import com.model.Product;
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
@WebServlet(name = "ManageOrderDetailServlet", urlPatterns = {"/manageorderitem"})
public class ManageOrderItemServlet extends HttpServlet {

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
            out.println("<title>Servlet ManageOrderDetailServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManageOrderDetailServlet at " + request.getContextPath() + "</h1>");
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
        String oid = request.getParameter("oid");
        String cusid = request.getParameter("cusid");
        try {
            int id = Integer.parseInt(oid);
            int cid = Integer.parseInt(cusid);
            JsonArray jsonArray = new JsonArray();
            List<OrderItem> orderitems = WebManager.getInstance().orderItemDAO.getOrderItemsByOrderId(id);
            for (OrderItem item : orderitems) {
            Product product = WebManager.getInstance().productDAO.getProduct(item.getProductId());
            if (product != null) {
                // Tạo một JSON object để bao gồm thông tin của từng order item và title của product
                JsonObject itemJson = new JsonObject();
                itemJson.addProperty("orderItemId", item.getOrderItemId());
                itemJson.addProperty("orderId", item.getOrderId());
                itemJson.addProperty("productId", item.getProductId());
                itemJson.addProperty("quantity", item.getQuantity());
                itemJson.addProperty("price", item.getPrice());
                itemJson.addProperty("productTitle", product.getTitle()); // Thêm title của product vào JSON

                // Thêm itemJson vào một mảng hoặc danh sách để gửi về client
                jsonArray.add(itemJson);
            }
        }

            JsonObject jsonResponse = new JsonObject();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            jsonResponse.add("order", new Gson().toJsonTree(WebManager.getInstance().orderDAO.getOrder(id)));
            jsonResponse.add("customer", new Gson().toJsonTree(WebManager.getInstance().customerDAO.getCustomer(cid)));
            jsonResponse.add("orderitems", jsonArray);
            response.getWriter().write(jsonResponse.toString());
        } catch (SQLException | ClassNotFoundException | NumberFormatException e) {
            Logger.getLogger(ManageOrderItemServlet.class.getName()).log(Level.SEVERE, null, e);
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
