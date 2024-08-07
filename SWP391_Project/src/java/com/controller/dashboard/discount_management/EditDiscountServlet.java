/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.controller.dashboard.discount_management;

import com.controller.WebManager;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.model.Discount;
import com.model.Manager;
import java.io.IOException;
import java.io.PrintWriter;

import com.model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "EditDiscountServlet", urlPatterns = {"/editdiscount"})
public class EditDiscountServlet extends HttpServlet {

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
            out.println("<title>Servlet EditDiscountServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditDiscountServlet at " + request.getContextPath() + "</h1>");
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
        Manager manager = (Manager) request.getSession().getAttribute("manager");
        if (manager == null) {
            response.sendRedirect("login_system.jsp");
            return;
        }
        try {
            String title = request.getParameter("title");
            Discount discount = WebManager.getInstance().discountDAO.getDiscountByTitle(title);
            List<Product> products = WebManager.getInstance().productDAO.listAllProducts();
            request.setAttribute("products", products);
            request.setAttribute("discount", discount);
            request.setAttribute("categories", WebManager.getInstance().categoryDAO.getAllCategories());
            request.getRequestDispatcher("editdiscount.jsp").forward(request, response);
//            JsonObject jsonResponse = new JsonObject();
//            jsonResponse.add("discount", new Gson().toJsonTree(discount));
//            jsonResponse.add("products", new Gson().toJsonTree(WebManager.getInstance().productDAO.listAllProducts()));
//            response.setContentType("application/json");
//            response.setCharacterEncoding("UTF-8");
//            response.getWriter().write(jsonResponse.toString());
        } catch (SQLException | ClassNotFoundException | NumberFormatException ex) {
            Logger.getLogger(EditDiscountServlet.class.getName()).log(Level.SEVERE, null, ex);
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
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        Manager manager = (Manager) request.getSession().getAttribute("manager");
        if (manager == null) {
            response.sendRedirect("login_system.jsp");
            return;
        }
        String id = request.getParameter("id");
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String discountValue = request.getParameter("discountValue");
        String[] pid = request.getParameterValues("pid");
        String expiry = request.getParameter("expiry");
        String status = request.getParameter("status");
        LocalDate now = LocalDate.now();
        java.sql.Date sqlDate = java.sql.Date.valueOf(now);
        try {
            LocalDateTime expiryDateTime = LocalDateTime.parse(expiry, DateTimeFormatter.ISO_LOCAL_DATE_TIME);
            Discount discount = new Discount();
            discount.setDiscountId(Integer.parseInt(id));
            discount.setProductId(0);
            discount.setTitle(title);
            discount.setDescription(description);
            discount.setDiscountValue(Float.parseFloat(discountValue));
            discount.setModifiedAt(sqlDate);
            discount.setCreatedAt(WebManager.getInstance().discountDAO.getDiscount(Integer.parseInt(id)).getCreatedAt());
            discount.setModifiedBy(manager.getManagerId());
            discount.setCreatedBy(WebManager.getInstance().discountDAO.getDiscount(Integer.parseInt(id)).getCreatedBy());
            discount.setExpiry(expiryDateTime);
            if (status.equals("1")) {
                discount.setStatus(true);
            }
            if (status.equals("2")) {
                discount.setStatus(false);
            }
            if (discount.getExpiry() != null && discount.getExpiry().isBefore(LocalDateTime.now().plusMinutes(10))){
                out.println("<script>");
                out.println("alert('The expiration time cannot be before or equal to 10 minutes from now!');");
                out.println("window.location.href='editdiscount?title=" + title + "';");
                out.println("</script>");
                return;
            }
            if (WebManager.getInstance().discountDAO.changeDiscount(discount)) {
                if (discount.isStatus()) {
                    if (pid == null || pid.length == 0) {
                        for (Product p : WebManager.getInstance().productDAO.listProductsByDiscount(discount.getDiscountId())) {
                            WebManager.getInstance().productDAO.updateDiscountProductNull(p.getProductId());
                        }
                    } else if (pid.length > 0) {
                        // Bước 1: Hủy discountId cho tất cả các sản phẩm có discountId hiện tại
                        List<Product> productsWithDiscount = WebManager.getInstance().productDAO.listProductsByDiscount(discount.getDiscountId());

                        for (Product p : productsWithDiscount) {
                            WebManager.getInstance().productDAO.updateDiscountProductNull(p.getProductId());
                        }

// Bước 2: Áp dụng discountId mới cho các sản phẩm được chọn
                        for (String productId : pid) {
                            Product product = WebManager.getInstance().productDAO.getProduct(Integer.parseInt(productId));
                            if (product != null) {
                                WebManager.getInstance().productDAO.updateDiscountProduct(discount.getDiscountId(), product.getProductId());
                            }
                        }

                    }
                } else {
                    for (Product p : WebManager.getInstance().productDAO.listProductsByDiscount(discount.getDiscountId())) {
                        WebManager.getInstance().productDAO.updateDiscountProductNull(p.getProductId());
                    }
                }

                out.println("<script>");
                out.println("alert('Updated discount sucessfully !');");
                out.println("window.location.href='managediscount';");
                out.println("</script>");
            } else {
                out.println("<script>");
                out.println("alert('Can't update discount !');");
                out.println("window.location.href='editdiscount?title=" + title + "';");
                out.println("</script>");
            }
        } catch (Exception e) {
            Logger.getLogger(EditDiscountServlet.class.getName()).log(Level.SEVERE, null, e);
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
