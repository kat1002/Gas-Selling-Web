/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package com.controller.dashboard.newsList;

import com.model.Category;
import com.model.DAO.headerDAO;
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
@WebServlet(name="EditNavServlet", urlPatterns={"/editNav"})
public class EditNavServlet extends HttpServlet {
   
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
            out.println("<title>Servlet EditNavServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditNavServlet at " + request.getContextPath () + "</h1>");
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
        int id = 0;
        try {
            id = Integer.parseInt(post_id_raw);
        } catch (NumberFormatException e) {

        }
        headerDAO headerDAO = new headerDAO();
        Category nav = headerDAO.getNav(id);
        request.setAttribute("nav", nav);
        request.getRequestDispatcher("editNav.jsp").forward(request, response);
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
        String title = request.getParameter("title").trim();
        String url = request.getParameter("url").trim();
        String role_raw = request.getParameter("role");
        int id = Integer.parseInt(request.getParameter("id"));
        int role = Integer.parseInt(role_raw);
        headerDAO headerDAO = new headerDAO();
        Category nav = new Category();
        Manager manager =(Manager) request.getSession().getAttribute("manager");
        nav.setTitle(title);
        nav.setDescription(url);
        nav.setRole(role);
        nav.setCategoryId(id);
        nav.setModifiedBy(manager.getManagerId());
        headerDAO.updateNav(nav);
        response.sendRedirect("manageNav");
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
