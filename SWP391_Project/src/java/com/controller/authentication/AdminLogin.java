/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.controller.authentication;

import com.model.DAO.CustomerDAO;
import com.model.DAO.ManagerDAO;
import com.utils.UtilHashPass;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author WuanTun
 */
@WebServlet(name = "AdminLogin", urlPatterns = {"/adminlogin"})
public class AdminLogin extends HttpServlet {

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
            out.println("<title>Servlet AdminLogin</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminLogin at " + request.getContextPath() + "</h1>");
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ManagerDAO managerDAO = new ManagerDAO();

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if ("".equals(username) || "".equals(password)) {
            request.setAttribute("loginerr", "Username or password is empty");
            request.getRequestDispatcher("admin_login.jsp").forward(request, response);
            return;
        }

        if (!managerDAO.checkUsername(username)) {
            request.setAttribute("loginerr", "Username is incorrect.");
            request.getRequestDispatcher("admin_login.jsp").forward(request, response);
            return;
        }

        if (!managerDAO.checkPassword(username, password)) {
            request.setAttribute("loginerr", "Password is incorrect.");
            request.getRequestDispatcher("admin_login.jsp").forward(request, response);
            return;
        }
        String hashedPassword = UtilHashPass.EncodePassword(password);
        if (!managerDAO.checkPassword(username, password)) {
            request.setAttribute("loginerr", "Password is incorrect.");
            request.getRequestDispatcher("admin_login.jsp").forward(request, response);
            return;
        }

        HttpSession session = request.getSession();
        session.setAttribute("manager", managerDAO.getManagerByUsername(username));
        session.removeAttribute("user");
        session.setAttribute("role", 0);//admin : 0; cus : 1;
        response.sendRedirect("dashboard");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("userC".equals(cookie.getName())) {
                    request.setAttribute("username", cookie.getValue());
                }
                if ("passC".equals(cookie.getName())) {
                    request.setAttribute("password", cookie.getValue());
                }
            }
        } else {
            request.setAttribute("username", "");
            request.setAttribute("password", "");
        }
        request.getRequestDispatcher("admin_login.jsp").forward(request, response);

    }

}
