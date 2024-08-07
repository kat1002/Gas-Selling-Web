/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.controller.authentication;

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
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author kirit
 */
@WebServlet(name = "ChangePasswordServlet", urlPatterns = {"/changePassword"})
public class ChangePasswordServlet extends HttpServlet {

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
            out.println("<title>Servlet ChangePasswordServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ChangePasswordServlet at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("changePassword.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Fetch parameters from the request
        String oldPassword = request.getParameter("oldPassword");
        String newpass = request.getParameter("newPass");
        String retextNewPass = request.getParameter("reNewPass");

        // PrintWriter to write response
        // PrintWriter to write response
        PrintWriter out = response.getWriter();

        // Check if username or password fields are empty
        if (oldPassword == null || oldPassword.trim().isEmpty()) {
            out.println("<html><body><h3>Old password cannot be empty</h3></body></html>");
            request.getRequestDispatcher("changePassword.jsp").include(request, response);
            return;
        }

        if (newpass == null || newpass.trim().isEmpty()) {
            out.println("<html><body><h3>Password cannot be empty</h3></body></html>");
            request.getRequestDispatcher("changePassword.jsp").include(request, response);
            return;
        }

        if (retextNewPass == null || retextNewPass.trim().isEmpty() || !newpass.equals(retextNewPass)) {
            out.println("<html><body><h3>Passwords do not match</h3></body></html>");
            request.getRequestDispatcher("changePassword.jsp").include(request, response);
            return;
        }

        // Instantiate the DAO to interact with the database
        CustomerDAO customerDAO = new CustomerDAO();
        HttpSession session =request.getSession();
        Customer customer = (Customer) session.getAttribute("user");
        String encodedOldPassword = UtilHashPass.EncodePassword(oldPassword);
        String password = customer.getPassword();
        try {
            // Check if username exists
            if (!customerDAO.checkPassword(customer.getUsername(), oldPassword)) {
                out.println("<html><body><h3>Old password is incorrect.</h3></body></html>");
                request.getRequestDispatcher("changePassword.jsp").include(request, response);
                return;
            }

            // Update the password in the database
            boolean isPasswordUpdated = customerDAO.updatePassword(newpass, customer.getUsername());

            if (isPasswordUpdated) {
                out.println("<script>");
                out.println("alert('change password sucessfully !');");
                out.println("window.location.href='login';");
                out.println("</script>");
                return;
            } else {
                out.println("<html><body><h3>Failed to change the password. Please try again.</h3></body></html>");
                request.getRequestDispatcher("login").forward(request, response);
            }
        } catch (Exception e) {
            // Handle any exceptions (e.g., database errors)
            e.printStackTrace();
            out.println("<html><body><h3>An error occurred. Please try again later.</h3></body></html>");
            request.getRequestDispatcher("changePassword.jsp").include(request, response);
        } finally {
            out.close();
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
