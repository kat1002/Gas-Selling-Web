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
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author kirit
 */
@WebServlet(name="ManageManagerServlet", urlPatterns={"/manageStaff"})
public class ManageManagerServlet extends HttpServlet {
   
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
        ManagerDAO ManagerDAO = new ManagerDAO();

        String[] searchTermsLname = new String[0];
        String[] searchTermsUname = new String[0];
        String[] searchTermsFname = new String[0];
        String[] searchTermsPhone = new String[0];
        String[] searchTermsGmail = new String[0];
        

        String type = request.getParameter("type");
        String setPageNumber = request.getParameter("set-page-number");

        String searchUname = request.getParameter("searchUname");
        String searchFname = request.getParameter("searchFname");
        String searchLname = request.getParameter("searchLname");
        String searchGmail = request.getParameter("searchGmail");
        String searchPhone = request.getParameter("searchPhone");

        List<Manager> listManager = new ArrayList<Manager>();

        //serach-name
        if (searchUname != null && !searchUname.equals("")) {
            searchTermsUname = searchUname.split("\\s+");
        }

        // search-first-name
        if (searchFname != null && !searchFname.equals("")) {
            searchTermsFname = searchFname.split("\\s+");
        }

// search-last-name
        if (searchLname != null && !searchLname.equals("")) {
            searchTermsLname = searchLname.split("\\s+");
        }

// search-gmail
        if (searchGmail != null && !searchGmail.equals("")) {
            searchTermsGmail = searchGmail.split("\\s+");
        }

// search-phone
        if (searchPhone != null && !searchPhone.equals("")) {
            searchTermsPhone = searchPhone.split("\\s+");
        }

        List<Manager> listManagerRaw = ManagerDAO.getManagerByFilter(searchTermsUname, searchTermsGmail, searchTermsFname, searchTermsLname, searchTermsPhone);
        if (type == null || type.equals("") || type.equals("all")) {
            type = "all";
            listManager = listManagerRaw;
        }
        if (type.equals("Manager")) {
            type = "Manager";
            for (Manager c : listManagerRaw) {
                if (c.getRoleName().equals("Manager")) {
                    listManager.add(c);
                }
            }
        }
        if (type.equals("Sale Staff")) {
            type = "Sale Staff";
            for (Manager c : listManagerRaw) {
                if (c.getRoleName().equals("Sale Staff")) {
                    listManager.add(c);
                }
            }
        }
        
        if (type.equals("Customer Service Staff")) {
            type = "Customer Service Staff";
            for (Manager c : listManagerRaw) {
                if (c.getRoleName().equals("Customer Service Staff")) {
                    listManager.add(c);
                }
            }
        }

        //set number news
        if (setPageNumber == null || setPageNumber.equals("")) {
            request.setAttribute("setPageNumber", 5);
        } else {
            request.setAttribute("setPageNumber", request.getParameter("set-page-number"));
        }

        request.setAttribute("searchUname",searchUname);
        request.setAttribute("searchFname",searchFname);
        request.setAttribute("searchLname",searchLname);
        request.setAttribute("searchGmail",searchGmail);
        request.setAttribute("searchPhone",searchPhone);
        request.setAttribute("type", type);

        request.setAttribute("listManager", listManager);

        request.getRequestDispatcher("manageStaff.jsp").forward(request, response);
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
        processRequest(request, response);
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
        processRequest(request, response);
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
