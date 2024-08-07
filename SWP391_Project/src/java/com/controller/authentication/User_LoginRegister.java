/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.controller.authentication;

import com.controller.WebManager;
import com.model.DAO.CustomerDAO;
import com.utils.EmailHandler;

import com.utils.UtilHashPass;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.utils.ValidationUtil;

// Make sure to add the BCrypt library to your project dependencies
/**
 *
 * @author WuanTun
 */
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class User_LoginRegister extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Cookie[] cookies = request.getCookies();
        String username = "";
        String password = "";
        String remember = "";

        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("userC".equals(cookie.getName())) {
                    username = cookie.getValue();
                    remember = "remember";
                }
                if ("passC".equals(cookie.getName())) {
                    password = cookie.getValue();
                }
            }
        }

        request.setAttribute("username", username);
        request.setAttribute("password", password);
        request.setAttribute("remember", remember);
        request.getRequestDispatcher("user_login.jsp").forward(request, response);

    }

    protected void login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException, ClassNotFoundException {
        CustomerDAO customerDAO = WebManager.getInstance().customerDAO;

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        boolean rememberMe = request.getParameter("rememberMe") != null && request.getParameter("rememberMe").equals("on");

        if ("".equals(username) || "".equals(password)) {
            request.setAttribute("loginerr", "Username or password is empty");
            request.getRequestDispatcher("user_login.jsp").forward(request, response);
            return;
        }

        if (!customerDAO.checkUsername(username)) {
            request.setAttribute("loginerr", "Username is incorrect.");
            request.getRequestDispatcher("user_login.jsp").forward(request, response);
            return;
        }

        // Hash the password input by the user using the same method
        String hashedPassword = UtilHashPass.EncodePassword(password);
//        System.out.println("Hashed Password for login: " + hashedPassword); // Debugging line
        if (!customerDAO.checkPassword(username, password)) {
            request.setAttribute("loginerr", "Password is incorrect. ");
            request.getRequestDispatcher("user_login.jsp").forward(request, response);
            return;
        }

        HttpSession session = request.getSession();
        session.setAttribute("user", customerDAO.getCustomerByUsername(username));
        session.setAttribute("role", 1); // admin : 0; cus : 1;
        request.getSession().removeAttribute("manager");

        if (rememberMe) {
            Cookie usernameCookie = new Cookie("userC", username);
            Cookie passwordCookie = new Cookie("passC", password);
            Cookie rememberCookie = new Cookie("rememberC", password);
            usernameCookie.setMaxAge(7 * 24 * 60 * 60); // 1 week
            passwordCookie.setMaxAge(7 * 24 * 60 * 60);
            rememberCookie.setMaxAge(7 * 24 * 60 * 60);// 1 week
            response.addCookie(usernameCookie);
            response.addCookie(passwordCookie);
        } else {
            clearCookies(request, response);
        }

        response.sendRedirect("home");
    }

    private void clearCookies(HttpServletRequest request, HttpServletResponse response) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("userC".equals(cookie.getName()) || "passC".equals(cookie.getName()) || "rememberC".equals(cookie.getName())) {
                    cookie.setMaxAge(0);
                    response.addCookie(cookie);
                }
            }
        }
    }

    protected void register(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException, ClassNotFoundException {
        CustomerDAO customerDAO = WebManager.getInstance().customerDAO;
        String username = request.getParameter("username");
        String gmail = request.getParameter("gmail");
        String firstname = request.getParameter("firstname");
        String lastname = request.getParameter("lastname");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        boolean hasError = false;

        if (!ValidationUtil.isValidUsername(username)) {
            String errorUsername = "Invalid username";
            request.setAttribute("messUsername", errorUsername);
            hasError = true;
        } else if (!ValidationUtil.isValidGmail(gmail)) {
            String errorGmail = "Invalid gmail";
            request.setAttribute("messGmail", errorGmail);
            hasError = true;
        } else {
            String passwordError = ValidationUtil.checkPassword(password);
            if (passwordError != null) {
                String errorPassword = passwordError;
                request.setAttribute("messPassword", errorPassword);
                hasError = true;
            } else if (!password.equals(confirmPassword)) {
                String errorCfPassword = "Confirm password does not match";
                request.setAttribute("messCfPass", errorCfPassword);
                hasError = true;
            }
        }

//        if (customerDAO.existsByUsernameOrGmail(username, gmail)) {
//            request.setAttribute("messExist", "Username or Email already exists.");
//            request.setAttribute("signUp", "true");
//            request.setAttribute("registerError", true); // Indicate registration error
//            hasError = true;
//        }
        if (!hasError && customerDAO.existsByUsernameOrGmail(username, gmail)) {
            request.setAttribute("messExist", "Username or Email already exists.");
//            request.setAttribute("signUp", "true");
            request.setAttribute("registerError", true); // Indicate registration error
            hasError = true;
        }

        if (hasError) {
            // Forward back to registration form with error messages
            request.getRequestDispatcher("user_login.jsp").forward(request, response);
        } else {
            // Proceed with registration
//            String encodedPassword = UtilHashPass.EncodePassword(password);
//            customerDAO.createNewCustomer(username, gmail, firstname, lastname, encodedPassword);
            request.getSession().setAttribute("username", username);
            request.getSession().setAttribute("gmail", gmail);
            request.getSession().setAttribute("firstname", firstname);
            request.getSession().setAttribute("lastname", lastname);
            request.getSession().setAttribute("password", password);

            String code = Verification.generateVerifyCode();
            request.getSession().setAttribute("verifycode", code);
            String subject = "Registration Confirmation";
            String body = "Dear " + firstname + ",\nHere is your verify code: " + code + "\n\n Please input to verify";
            EmailHandler.sendEmail(gmail, subject, body);

            response.sendRedirect("verification");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        if ("login".equals(action)) {
            try {
                login(request, response);
            } catch (SQLException | ClassNotFoundException e) {
                throw new RuntimeException(e);
            }
        } else if ("register".equals(action)) {
            try {
                register(request, response);
            } catch (SQLException | ClassNotFoundException e) {
                throw new RuntimeException(e);
            }
        } else {
            response.sendRedirect("user_login.jsp"); // Chuyển hướng đến trang đăng nhập nếu không có action nào được gửi
        }
    }

}
