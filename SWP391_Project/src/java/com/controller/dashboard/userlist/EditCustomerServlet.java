/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.controller.dashboard.userlist;

import com.model.Customer;
import com.model.DAO.CustomerDAO;
import com.utils.UtilHashPass;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author kirit
 */
@WebServlet(name = "EditCustomerServlet", urlPatterns = {"/editCustomer"})
public class EditCustomerServlet extends HttpServlet {

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
            out.println("<title>Servlet EditCustomerServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditCustomerServlet at " + request.getContextPath() + "</h1>");
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
        String post_id_raw = request.getParameter("id");
        int news_id = 0;
        try {
            news_id = Integer.parseInt(post_id_raw);
        } catch (NumberFormatException e) {

        }
        CustomerDAO CustomerDAO = new CustomerDAO();
        Customer Customer = CustomerDAO.getCustomer(news_id);
        request.setAttribute("customer", Customer);
        request.getRequestDispatcher("editCustomer.jsp").forward(request, response);
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
        Customer customer = new Customer();
        String post_id_raw = request.getParameter("id");
        int id = 0;
        try {
            id = Integer.parseInt(post_id_raw);
        } catch (NumberFormatException e) {

        }
        String newFirstname = request.getParameter("firstname");
        String username = request.getParameter("username");
        String newLastname = request.getParameter("lastname");
        String email = request.getParameter("email");
        String newPhone = request.getParameter("phone");
        String newAddress1 = request.getParameter("address1");
        String newAddress2 = request.getParameter("address2");
        String postalCode = request.getParameter("postalcode");
        String city = request.getParameter("city");
        String receiveEmail = request.getParameter("receiveEmail");
        String type_raw = request.getParameter("type");
        int postalcode = 0;
        int type = 0;
        try {
            postalcode = Integer.parseInt(postalCode);
            type = Integer.parseInt(type_raw);
        } catch (NumberFormatException e) {
            // You may want to set an error message and forward to the form again
            request.setAttribute("error", "Invalid postal code format");
            request.getRequestDispatcher("profile.jsp").forward(request, response);
            return;
        }

        customer.setFirst_name(newFirstname);
        customer.setLast_name(newLastname);
        customer.setPhone_number(newPhone);
        customer.setAddress_line1(newAddress1);
        customer.setAddress_line2(newAddress2);
        customer.setPostal_code(postalcode);
        customer.setCity(city);
        customer.setGmail(email);
        customer.setUsername(username);
        customer.setCustomerId(id);
        customer.setCustomerType(type);

        if (receiveEmail != null && receiveEmail.equals("yes")) {
            customer.setReceiveNotif(1);
        } else {
            customer.setReceiveNotif(0);
        }
        CustomerDAO customerDAO = new CustomerDAO();
        customerDAO.updateCustomer2(customer);
        response.sendRedirect("manageCustomer");
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
