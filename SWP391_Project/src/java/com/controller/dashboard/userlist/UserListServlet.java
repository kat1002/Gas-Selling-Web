/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package com.controller.dashboard.userlist;

import com.controller.WebManager;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.model.Customer;
import com.model.DAO.CustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Admin
 */
@WebServlet(name="UserListServlet", urlPatterns={"/userlist"})
public class UserListServlet extends HttpServlet {

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String view = request.getParameter("view");
        CustomerDAO customerDAO = new CustomerDAO();

        if(action != null) {

        }

        if(action.equals("customerDetails")) {
            GetCustomerDetails(request, response);
            return;
        }

        int page = Integer.parseInt(request.getParameter("page"));
        int rowsPerPage = Integer.parseInt(request.getParameter("rowsPerPage"));
        String searchType = request.getParameter("searchType");
        String searchQuery = request.getParameter("searchQuery");
        String sortBy = request.getParameter("sortBy");

        List<Customer> customers = customerDAO.getCustomers(page, rowsPerPage, searchType, searchQuery, sortBy);
        int totalCustomers = customerDAO.getTotalCustomerCount(searchType, searchQuery);

        JsonObject jsonResponse = new JsonObject();
        jsonResponse.add("customers", new Gson().toJsonTree(customers));
        jsonResponse.addProperty("totalCustomers", totalCustomers);

        response.setContentType("application/json");
        response.getWriter().write(jsonResponse.toString());
    }

    protected void GetCustomerDetails(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        // Retrieve userId parameter from request
        String userId = request.getParameter("userId");

        // Assuming you have a service or DAO to fetch user details based on userId
        Customer user = null;
        try {
            user = WebManager.getInstance().customerDAO.getCustomer(Integer.parseInt(userId));
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        // Prepare JSON response
        JsonObject jsonResponse = new JsonObject();
        jsonResponse.addProperty("customer_id", user.getId());
        jsonResponse.addProperty("username", user.getUsername());
        jsonResponse.addProperty("firstName", user.getFirst_name());
        jsonResponse.addProperty("lastName", user.getLast_name());
        jsonResponse.addProperty("email", user.getGmail());
        jsonResponse.addProperty("phone", user.getPhone_number());
        jsonResponse.addProperty("address1", user.getAddress_line1());
        jsonResponse.addProperty("address2", user.getAddress_line2());
        jsonResponse.addProperty("postalCode", user.getPostal_code());
        jsonResponse.addProperty("city", user.getCity());

        // Set content type and write JSON response
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonResponse.toString());
        request.getRequestDispatcher("userlist.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
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
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
