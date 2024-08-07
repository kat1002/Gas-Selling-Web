/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.controller.dashboard.discount_management;

import com.controller.WebManager;
import com.model.Discount;
import com.model.Manager;
import com.model.Product;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "AddDiscountServlet", urlPatterns = {"/adddiscount"})
public class AddDiscountServlet extends HttpServlet {

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
            out.println("<title>Servlet AddDiscountServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddDiscountServlet at " + request.getContextPath() + "</h1>");
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
            List<Product> products = WebManager.getInstance().productDAO.listAllProducts();
            request.setAttribute("products", products);
            request.setAttribute("categories", WebManager.getInstance().categoryDAO.getAllCategories());
            request.getRequestDispatcher("adddiscount.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(AddDiscountServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(AddDiscountServlet.class.getName()).log(Level.SEVERE, null, ex);
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
        Manager manager = (Manager) request.getSession().getAttribute("manager");

        if (manager == null) {
            response.sendRedirect("login_system.jsp");
            return;
        }
        LocalDate now = LocalDate.now();
        java.sql.Date sqlDate = java.sql.Date.valueOf(now);
        Discount discount = new Discount();
        PrintWriter out = response.getWriter();
        try {
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String discountValue = request.getParameter("discountValue");
            String[] pid = request.getParameterValues("pid");
            String expiry = request.getParameter("expiry");
            String status = request.getParameter("status");
            if (WebManager.getInstance().discountDAO.getDiscountByTitle(title) != null) {
                out.println("<script>");
                out.println("alert('The product title is existed in the system !');");
                out.println("window.location.href = 'adddiscount';"); // Trở về trang managebrand khi người dùng ấn OK
                out.println("</script>");
            } else {
                LocalDateTime expiryDateTime = LocalDateTime.parse(expiry, DateTimeFormatter.ISO_LOCAL_DATE_TIME);
                discount.setTitle(title);
                discount.setProductId(0);
                discount.setDescription(description);
                discount.setDiscountValue(Float.parseFloat(discountValue));
                discount.setCreatedBy(manager.getManagerId());
                discount.setModifiedBy(manager.getManagerId());
                discount.setCreatedAt(sqlDate);
                discount.setModifiedAt(sqlDate);
                discount.setExpiry(expiryDateTime);
                if (status.equals("1")) {
                    discount.setStatus(true);
                }
                if (status.equals("2")) {
                    discount.setStatus(false);
                }
                if (discount.getExpiry() != null && discount.getExpiry().isBefore(LocalDateTime.now().plusMinutes(10))) {
                    out.println("<script>");
                    out.println("alert('The expiration time cannot be before or equal to 10 minutes from now!');");
                    out.println("window.location.href='adddiscount';");
                    out.println("</script>");
                    return;
                }
                if (WebManager.getInstance().discountDAO.insertDiscount(discount)) {
                    if (pid != null) {
                        if (pid.length > 0) {
                            for (int i = 0; i < pid.length; i++) {
                                WebManager.getInstance().productDAO.updateDiscountProduct(
                                        WebManager.getInstance().discountDAO.getDiscountByTitle(title).getDiscountId(), Integer.parseInt(pid[i]));
                            }
                        }
                    }

                    out.println("<script>");
                    out.println("alert('Added discount sucessfully !');");
                    out.println("window.location.href='managediscount';");
                    out.println("</script>");
                } else {
                    out.println("<script>");
                    out.println("alert('Can't add discount !');");
                    out.println("window.location.href='managediscount';");
                    out.println("</script>");
                }
            }

        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(AddDiscountServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NumberFormatException ex) {
            Logger.getLogger(AddDiscountServlet.class.getName()).log(Level.SEVERE, null, ex);
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
