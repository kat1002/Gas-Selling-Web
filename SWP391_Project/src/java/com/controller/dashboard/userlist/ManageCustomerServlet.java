/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.controller.dashboard.userlist;

import com.model.Customer;
import com.model.DAO.CustomerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *
 * @author kirit
 */
@WebServlet(name = "ManageCustomerServlet", urlPatterns = {"/manageCustomer"})
public class ManageCustomerServlet extends HttpServlet {

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
        CustomerDAO CustomerDAO = new CustomerDAO();

        String[] searchTermsLname = new String[0];
        String[] searchTermsUname = new String[0];
        String[] searchTermsFname = new String[0];
        String[] searchTermsAddr1 = new String[0];
        String[] searchTermsAddr2 = new String[0];
        String[] searchTermsCity = new String[0];
        String[] searchTermsPhone = new String[0];
        String[] searchTermsGmail = new String[0];
        

        String type = request.getParameter("type");
        String setPageNumber = request.getParameter("set-page-number");

        String searchUname = request.getParameter("searchUname");
        String searchFname = request.getParameter("searchFname");
        String searchLname = request.getParameter("searchLname");
        String searchGmail = request.getParameter("searchGmail");
        String searchPhone = request.getParameter("searchPhone");
        String searchAddr1 = request.getParameter("searchAddr1");
        String searchAddr2 = request.getParameter("searchAddr2");
        String searchCity = request.getParameter("searchCity");

        List<Customer> listCustomer = new ArrayList<Customer>();

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

// search-addr1
        if (searchAddr1 != null && !searchAddr1.equals("")) {
            searchTermsAddr1 = searchAddr1.split("\\s+");
        }

// search-addr2
        if (searchAddr2 != null && !searchAddr2.equals("")) {
            searchTermsAddr2 = searchAddr2.split("\\s+");
        }

// search-city
        if (searchCity != null && !searchCity.equals("")) {
            searchTermsCity = searchCity.split("\\s+");
        }

        List<Customer> listCustomerRaw = CustomerDAO.getCustomerByFilter(searchTermsUname, searchTermsGmail, searchTermsFname, searchTermsLname, searchTermsAddr1, searchTermsAddr2, searchTermsPhone, searchTermsCity);
        if (type == null || type.equals("") || type.equals("all")) {
            type = "all";
            listCustomer = listCustomerRaw;
        } else {
            int typeReal = Integer.parseInt(request.getParameter("type"));
            for (Customer c : listCustomerRaw) {
                if (c.getCustomerType() == typeReal) {
                    listCustomer.add(c);
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
        request.setAttribute("searchCity",searchCity);
        request.setAttribute("searchGmail",searchGmail);
        request.setAttribute("searchPhone",searchPhone);
        request.setAttribute("searchAddr1",searchAddr1);
        request.setAttribute("searchAddr2",searchAddr2);

        request.setAttribute("listCustomerType", CustomerDAO.getCustomerType());
        request.setAttribute("type", type);

        request.setAttribute("listCustomer", listCustomer);

        request.getRequestDispatcher("userlist.jsp").forward(request, response);
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
        processRequest(request, response);
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
