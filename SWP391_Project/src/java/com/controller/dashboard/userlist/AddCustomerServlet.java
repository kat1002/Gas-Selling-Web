///*
// * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
// * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
// */
//package com.controller.dashboard.userlist;
//
//import com.controller.WebManager;
//import com.model.Customer;
//import com.model.DAO.CustomerDAO;
//import com.utils.UtilHashPass;
//import java.io.IOException;
//import java.io.PrintWriter;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import java.sql.SQLException;
//import java.util.logging.Level;
//import java.util.logging.Logger;
//
///**
// *
// * @author kirit
// */
//@WebServlet(name = "AddCustomerServlet", urlPatterns = {"/addCustomer"})
//public class AddCustomerServlet extends HttpServlet {
//
//    /**
//     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
//     * methods.
//     *
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        response.setContentType("text/html;charset=UTF-8");
//
//        
//    }
//
//    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
//    /**
//     * Handles the HTTP <code>GET</code> method.
//     *
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        processRequest(request, response);
//    }
//
//    /**
//     * Handles the HTTP <code>POST</code> method.
//     *
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        try {
//            Customer customer = new Customer();
//            String newFirstname = request.getParameter("firstname");
//            String username = request.getParameter("username");
//            String newLastname = request.getParameter("lastname");
//            String email = request.getParameter("email");
//            String password = request.getParameter("password");
//            String newPhone = request.getParameter("phone");
//            String newAddress1 = request.getParameter("address1");
//            String newAddress2 = request.getParameter("address2");
//            String postalCode = request.getParameter("postalcode");
//            String city = request.getParameter("city");
//            String receiveEmail = request.getParameter("receiveEmail");
//            int postalcode = 0;
//            try {
//                postalcode = Integer.parseInt(postalCode);
//            } catch (NumberFormatException e) {
//                // You may want to set an error message and forward to the form again
//                request.setAttribute("error", "Invalid postal code format");
//                request.getRequestDispatcher("profile.jsp").forward(request, response);
//                return;
//            }
//            String encodedPassword = UtilHashPass.EncodePassword(password);
//
//            customer.setFirst_name(newFirstname);
//            customer.setLast_name(newLastname);
//            customer.setPhone_number(newPhone);
//            customer.setAddress_line1(newAddress1);
//            customer.setAddress_line2(newAddress2);
//            customer.setPostal_code(postalcode);
//            customer.setCity(city);
//            customer.setGmail(email);
//            customer.setUsername(username);
//
//            if (receiveEmail != null && receiveEmail.equals("yes")) {
//                customer.setCustomerType(1);
//            } else {
//                customer.setCustomerType(2);
//            }
//            CustomerDAO customerDAO = new CustomerDAO();
//            WebManager.getInstance().customerDAO.addCustomer(customer, encodedPassword);
//        } catch (SQLException ex) {
//            Logger.getLogger(AddCustomerServlet.class.getName()).log(Level.SEVERE, null, ex);
//        } catch (ClassNotFoundException ex) {
//            Logger.getLogger(AddCustomerServlet.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        response.sendRedirect("manageCustomer");
//    }
//
//    /**
//     * Returns a short description of the servlet.
//     *
//     * @return a String containing servlet description
//     */
//    @Override
//    public String getServletInfo() {
//        return "Short description";
//    }// </editor-fold>
//
//}
