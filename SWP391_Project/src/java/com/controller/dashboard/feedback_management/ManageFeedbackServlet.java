/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.controller.dashboard.feedback_management;

import com.controller.WebManager;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "ManageFeedbackServlet", urlPatterns = {"/managefeedback"})
public class ManageFeedbackServlet extends HttpServlet {

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
            out.println("<title>Servlet ManageFeedbackServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManageFeedbackServlet at " + request.getContextPath() + "</h1>");
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
        response.setContentType("text/html;charset=UTF-8");
        if (request.getSession().getAttribute("manager") == null) {
            response.sendRedirect("login_system.jsp");
            return;
        }
        try {
            // Retrieve parameters from the request
            String rating = request.getParameter("rating");
            String comment = request.getParameter("comment");
            String customername = request.getParameter("customername");
            String productname = request.getParameter("productname");
            String createdfrom = request.getParameter("createdfrom");
            String createdto = request.getParameter("createdto");
            String modifiedfrom = request.getParameter("modifiedfrom");
            String modifiedto = request.getParameter("modifiedto");
            String sortmodifiedtime = request.getParameter("sortmodifiedtime");
            String commentsPerPage = request.getParameter("commentsPerPage");
            String page = request.getParameter("page");
            // Set default values if parameters are null
            if (rating == null) {
                rating = "";
            }else{
                
            }
            if (comment == null) {
                comment = "";
            }else{
                
            }
            if (customername == null) {
                customername = "";
            }else{
                
            }
            if (productname == null) {
                productname = "";
            }else{
                
            }
            if (createdfrom == null) {
                createdfrom = "";
            }else{
                
            }
            if (createdto == null) {
                createdto = "";
            }else{
                
            }
            if (modifiedfrom == null) {
                modifiedfrom = "";
            }else{
                
            }
            if (modifiedto == null) {
                modifiedto = "";
            }else{
                
            }
            if (sortmodifiedtime == null) {
                sortmodifiedtime = "0";
            }else{
                
            }
            int commentperpage = 0;
            if (commentsPerPage == null) {
                commentsPerPage = "10"; // Default value
                commentperpage = 10;
            }else{
                commentperpage = Integer.parseInt(commentsPerPage);
            }
            int xpage = 1;
            if (page == null) {
                page = "1"; // Default value
                xpage = 1;
            }else{
                xpage = Integer.parseInt(page);
            }
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
            LocalDateTime createdFrom = parseDateTime(createdfrom, formatter);
            LocalDateTime createdTo = parseDateTime(createdto, formatter);
            LocalDateTime modifiedFrom = parseDateTime(modifiedfrom, formatter);
            LocalDateTime modifiedTo = parseDateTime(modifiedto, formatter);
            int totalComment = WebManager.getInstance().rateDAO.getRateList().size();
            int totalCommentChoice = WebManager.getInstance().rateDAO.getRateByFilter(rating, comment, customername, productname, createdFrom, createdTo, modifiedFrom, modifiedTo, sortmodifiedtime).size();
            int num = ((totalCommentChoice % commentperpage == 0) ? (totalCommentChoice / commentperpage) : (totalCommentChoice / commentperpage) + 1);
            int start = (xpage - 1) * commentperpage;
            int end = Math.min(xpage * commentperpage, totalCommentChoice);
            // Set attributes to be used in JSP
            request.setAttribute("rating", rating);
            request.setAttribute("comment", comment);
            request.setAttribute("customername", customername);
            request.setAttribute("productname", productname);
            request.setAttribute("createdfrom", createdfrom);
            request.setAttribute("createdto", createdto);
            request.setAttribute("modifiedfrom", modifiedfrom);
            request.setAttribute("modifiedto", modifiedto);
            request.setAttribute("sortmodifiedtime", sortmodifiedtime);
            request.setAttribute("commentsPerPage", commentsPerPage);
            request.setAttribute("page", page);
            request.setAttribute("num", num);
            request.setAttribute("rates", WebManager.getInstance().rateDAO.getRatesByPage(WebManager.getInstance().rateDAO.getRateByFilter(rating, comment, customername, productname, createdFrom, createdTo, modifiedFrom, modifiedTo, sortmodifiedtime), start, end));
            request.getRequestDispatcher("managefeedback.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ManageFeedbackServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ManageFeedbackServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NumberFormatException ex){
            Logger.getLogger(ManageFeedbackServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    private LocalDateTime parseDateTime(String dateTimeStr, DateTimeFormatter formatter) {
        if (dateTimeStr != null && !dateTimeStr.isEmpty()) {
            return LocalDateTime.parse(dateTimeStr, formatter);
        }
        return null;
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
        processRequest(request, response);
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
