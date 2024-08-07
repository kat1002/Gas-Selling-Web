/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.controller.profile;

import com.controller.WebManager;
import com.model.Customer;
import com.model.DAO.CustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

/**
 * @author Admin
 */
@WebServlet(name = "ProfileServlet", urlPatterns = {"/profile"})
public class ProfileServlet extends HttpServlet {

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
        Customer customer = (Customer) request.getSession().getAttribute("user");

        if (customer == null) {
            response.sendRedirect("login_system.jsp");
            return;
        }
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }

    protected void getUserDetails(HttpServletRequest request, HttpServletResponse response) throws SQLException, ClassNotFoundException {

        Customer customer = (Customer) request.getSession().getAttribute("customer");
        request.setAttribute("customer", WebManager.getInstance().customerDAO.getCustomer(customer.getId()));
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

        String newFirstname = request.getParameter("firstname");
        String newLastname = request.getParameter("lastname");
        String newPhone = request.getParameter("phone");
        String newAddress1 = request.getParameter("address1");
        String newAddress2 = request.getParameter("address2");
        String postalCode = request.getParameter("postalcode");
        String city = request.getParameter("city");
        String receiveEmail = request.getParameter("receiveEmail");

        int postalcode = 0;
        try {
            postalcode = Integer.parseInt(postalCode);
        } catch (NumberFormatException e) {
            // You may want to set an error message and forward to the form again
            request.setAttribute("error", "Invalid postal code format");
            request.getRequestDispatcher("profile.jsp").forward(request, response);
            return;
        }
        System.out.println("New firstname: " + newFirstname);
        System.out.println("New lastname: " + newLastname);
        System.out.println("New phone: " + newPhone);
        System.out.println("New address1: " + newAddress1);
        System.out.println("New address2: " + newAddress2);
        System.out.println("Postal code: " + postalCode);
        System.out.println("City: " + city);

        customer.setFirst_name(newFirstname);
        customer.setLast_name(newLastname);
        customer.setPhone_number(newPhone);
        customer.setAddress_line1(newAddress1);
        customer.setAddress_line2(newAddress2);
        customer.setPostal_code(postalcode);
        customer.setCity(city);
        if (receiveEmail != null && receiveEmail.equals("yes")) {
            customer.setReceiveNotif(1);
        } else {
            customer.setReceiveNotif(0);
        }

        try {
            CustomerDAO customerDAO = WebManager.getInstance().customerDAO;
            boolean isUpdated = customerDAO.updateCustomer(customer);

            if (isUpdated) {
                // Cập nhật lại đối tượng Customer trong session
                session.removeAttribute("user");
                session.setAttribute("user", customer);

                // Profile update successful
                String successUpdate = "UpdateSuccess";
                request.setAttribute("successupdate", successUpdate);
                request.getRequestDispatcher("profile.jsp").forward(request, response);
            } else {
                // Profile update failed
                String failUpdate = "Fail";
                request.setAttribute("errorUpdate", failUpdate);
                request.getRequestDispatcher("profile.jsp").forward(request, response);
            }
        } catch (SQLException | ClassNotFoundException e) {
            // Handle database exception
            e.printStackTrace(); // You should handle exceptions more gracefully in a real application
            response.sendRedirect("profile.jsp"); // Redirect to an error page
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
