/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package com.controller.dashboard.userlist;

import com.model.DAO.ManagerDAO;
import com.model.Manager;
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
@WebServlet(name="EditManagerServlet", urlPatterns={"/editManager"})
public class EditManagerServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<title>Servlet EditManagerServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditManagerServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

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
        String post_id_raw = request.getParameter("id");
        int news_id = 0;
        try {
            news_id = Integer.parseInt(post_id_raw);
        } catch (NumberFormatException e) {

        }
        ManagerDAO ManagerDAO = new ManagerDAO();
        Manager Manager= ManagerDAO.getManager(news_id);
        request.setAttribute("manager", Manager);
        request.getRequestDispatcher("editManager.jsp").forward(request, response);
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
        Manager manager = new Manager();
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
        String role = request.getParameter("role");
        manager.setFirst_name(newFirstname);
        manager.setLast_name(newLastname);
        manager.setPhone_number(newPhone);
        manager.setEmail(email);
        manager.setUsername(username);
        manager.setManagerId(id);

        if (role != null && role.equals("1")) {
            manager.setRole(1);
        } 
        if (role != null && role.equals("2")) {
            manager.setRole(2);
        }
        if (role != null && role.equals("3")) {
            manager.setRole(3);
        }
        ManagerDAO managerDAO = new ManagerDAO();
        managerDAO.updateManager(manager);
        response.sendRedirect("manageStaff");
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
