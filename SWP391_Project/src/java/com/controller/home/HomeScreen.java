/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.controller.home;

import com.controller.WebManager;
import com.model.Category;
import com.model.DAO.NewsDAO;
import com.model.DAO.footerDAO;
import com.model.DAO.headerDAO;
import com.model.News;
import com.model.Product;
import com.utils.EmailHandler;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import jakarta.servlet.http.HttpSession;
//import java.lang.System.Logger;
//import java.lang.System.Logger.Level;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import java.io.IOException;
import java.util.ArrayList;

public class HomeScreen extends HttpServlet {

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
            throws ServletException, IOException, SQLException, ClassNotFoundException {
        response.setContentType("text/html;charset=UTF-8");
        prepareHeaderAndFooter(request, response);

//        request.setAttribute("product", WebManager.getInstance().productDAO.getProduct(1));
        request.setAttribute("hotdeals", WebManager.getInstance().productDAO.getHotDealProducts(5));
        request.setAttribute("newarrivals", WebManager.getInstance().productDAO.getNewArrivalProducts(5));
        request.setAttribute("bestsellers", WebManager.getInstance().productDAO.getBestSellerProducts(5));
        request.setAttribute("webManager", WebManager.getInstance());

        NewsDAO newsDAO = new NewsDAO();
        List<News> listBanner = newsDAO.getBanner();
        request.setAttribute("listBanner", listBanner);
        

        request.getRequestDispatcher("home.jsp").forward(request, response);
    }


    public void prepareHeaderAndFooter(HttpServletRequest request, HttpServletResponse response) {
        headerDAO headerDao = new headerDAO();
        List<Category> listCategory = headerDao.getAllCategory();

        List<Category> header = new ArrayList<>();
        List<Category> footerItem = new ArrayList<>(); //footer con
        List<Category> footerContent = new ArrayList<>();// footer cha
        List<Category> categoryTitle = new ArrayList<>();

        for (Category c : listCategory) {
            int role = c.getRole();
            if (role > 0) {
                header.add(c);
            } else if (role < 0) {
                if (String.valueOf(role).contains("0")) {
                    footerContent.add(c);
                } else {
                    footerItem.add(c);
                }
            } else {
                categoryTitle.add(c);
            }
        }
//        List<Category> footerItem = dF.getFooterItem();
//        List<Category> footerContent = dF.getFooterContent();        
        HttpSession session = request.getSession();
        //        session.setAttribute("contact", contact);
        session.setAttribute("header", header);
        session.setAttribute("categoryTitle", categoryTitle);
        session.setAttribute("footerItem", footerItem);
        session.setAttribute("footerContent", footerContent);
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
        try {
            processRequest(request, response);
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(HomeScreen.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(HomeScreen.class.getName()).log(Level.SEVERE, null, ex);
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
