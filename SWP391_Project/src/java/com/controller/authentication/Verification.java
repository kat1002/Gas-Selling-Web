/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.controller.authentication;

import com.controller.WebManager;
import com.model.DAO.CustomerDAO;
import com.utils.UtilHashPass;
import jakarta.servlet.RequestDispatcher;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.security.SecureRandom;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * @author WuanTun
 */
public class Verification extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("verifycode.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String code = request.getParameter("code");
        PrintWriter out = response.getWriter();

        // Get the generated verify code
        String generatedCode = (String) request.getSession().getAttribute("verifycode");

        if (code != null && generatedCode != null && code.equals(generatedCode)) {
            // If the entered code matches the generated code, redirect to the login page
            String username = (String) request.getSession().getAttribute("username");
            String gmail = (String) request.getSession().getAttribute("gmail");
            String firstname = (String) request.getSession().getAttribute("firstname");
            String lastname = (String) request.getSession().getAttribute("lastname");
            String password = (String) request.getSession().getAttribute("password");

            String encodedPassword = UtilHashPass.EncodePassword(password);

            // Insert customer into database
            try {
                CustomerDAO customerDAO = WebManager.getInstance().customerDAO;
                customerDAO.createNewCustomer(username, gmail, firstname, lastname, password);

                // Clear session attributes after successful registration
                request.getSession().removeAttribute("username");
                request.getSession().removeAttribute("gmail");
                request.getSession().removeAttribute("firstname");
                request.getSession().removeAttribute("lastname");
                request.getSession().removeAttribute("password");

                // Set success message and redirect to login page
                out.println("<script>");
                out.println("alert('create account sucessfully !');");
                out.println("window.location.href='user_login.jsp';");
                out.println("</script>");
            } catch (SQLException | ClassNotFoundException e) {
                // Handle database exception
                e.printStackTrace(); // You should handle exceptions more gracefully in a real application
                response.sendRedirect("verifycode.jsp"); // Redirect to an error page
            }

//            request.setAttribute("registerSuccess", "Account created successfully. Please login.");
//            response.sendRedirect("user_login.jsp");
        } else {
            String incorrectCode = "Incorrect Code";
            request.setAttribute("wrongcode", incorrectCode);
            request.getRequestDispatcher("verifycode.jsp").forward(request, response);// You can add a query parameter to indicate the error if needed

        }
    }

    protected static String generateVerifyCode() {
        SecureRandom random = new SecureRandom();
        StringBuilder codeBuilder = new StringBuilder();
        int length = 6;
        for (int i = 0; i < length; i++) {
        int digit = random.nextInt(10); // Generate a random digit between 0 and 9
        codeBuilder.append(digit);
    }
        return codeBuilder.toString();
    }

}
