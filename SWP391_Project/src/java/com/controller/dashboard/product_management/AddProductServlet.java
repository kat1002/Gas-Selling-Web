/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.controller.dashboard.product_management;

import com.controller.WebManager;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.model.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Part;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
//import org.apache.tomcat.util.http.fileupload.disk.DiskFileItem;

/**
 *
 * @author Admin
 */
@MultipartConfig
@WebServlet(name = "AddProductServlet", urlPatterns = {"/addproduct"})
public class AddProductServlet extends HttpServlet {

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
            out.println("<title>Servlet AddProductServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddProductServlet at " + request.getContextPath() + "</h1>");
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
            request.setAttribute("discounts", WebManager.getInstance().discountDAO.getAllDiscounts());
            request.setAttribute("categories", WebManager.getInstance().categoryDAO.getAllCategories());
            request.getRequestDispatcher("addproduct.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(AddProductServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(AddProductServlet.class.getName()).log(Level.SEVERE, null, ex);
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
        PrintWriter out = response.getWriter();
        java.util.Date now = new java.util.Date();
        Product product = new Product();
        int productid = 0;

        try {
            String title = request.getParameter("title");
            String stock = request.getParameter("stock");
            String price = request.getParameter("price");
            String description = request.getParameter("description");
            String cid = request.getParameter("cid");
            String period = request.getParameter("period");
            Part image = request.getPart("image");
            String directory = "/media/product/";
            if (WebManager.getInstance().productDAO.checkProductNameExists(title)) {
                out.println("<script>");
                out.println("alert('The product title is existed in the system !');");
                out.println("window.location.href = 'addproduct';"); // Trở về trang managebrand khi người dùng ấn OK
                out.println("</script>");
            } else {
                int stockValue = Integer.parseInt(stock);
                float priceValue = Float.parseFloat(price);
                int categoryIdValue = Integer.parseInt(cid);
                product.setCreatedDate(now);
                product.setModifiedOn(now);
                product.setCategoryId(categoryIdValue);
                product.setReviewsRate(0);
                product.setDiscountId(0);
                product.setTitle(title);
                product.setDescription(description);
                product.setStock(stockValue);
                product.setPrice(priceValue);
                product.setCreatedBy(manager.getManagerId());
                product.setModifiedBy(manager.getManagerId());
                product.setWarranty_months(Integer.parseInt(period));
                List<String> imageUrls = new ArrayList<>();
                if (product.getPrice() < 0) {
                    out.println("<script>");
                    out.println("alert('Price is not negative');");
                    out.println("window.location.href='manageproduct';");
                    out.println("</script>");
                    return;
                }
                if (product.getStock() < 0) {
                    out.println("<script>");
                    out.println("alert('Stock is not negative');");
                    out.println("window.location.href='manageproduct';");
                    out.println("</script>");
                    return;
                }
                if (WebManager.getInstance().productDAO.insertProduct(product)) {
                    if (image.getSize() > 0) {
                        for (Part part : request.getParts()) {
                            if (part.getContentType() != null) {
                                String imageName = part.getSubmittedFileName();

                                String path = directory + imageName;
                                String fullPath = request.getServletContext().getRealPath(path);
                                part.write(fullPath);

                                if (imageName != null) {
                                    imageUrls.add("media/product/" + imageName);
                                }
                            }
                        }
                        product.setImages(imageUrls);
                        productid = WebManager.getInstance().productDAO.getProductByTitle(title).getProductId();
                        for (String s : product.getImages()) {
                            WebManager.getInstance().productDAO.addProductImages(productid, s);
                        }
                    }
                    for (int i = 0; i < product.getStock(); i++) {
                        ProductSerialNumber psn = new ProductSerialNumber(productid);
//                        psn.setStatus(true);
                        WebManager.getInstance().productSerialNumberDAO.insert(psn);
                    }
                    if (WebManager.getInstance().productDAO.getProductByTitle(title) != null) {
                        out.println("<script>");
                        out.println("alert('Added product sucessfully !');");
                        out.println("window.location.href='manageproduct';");
                        out.println("</script>");
                    }

                } else {
                    out.println("<script>");
                    out.println("alert('Can't add product);");
                    out.println("window.location.href='manageproduct';");
                    out.println("</script>");
                }

            }

        } catch (Exception ex) {
            Logger.getLogger(AddProductServlet.class.getName()).log(Level.SEVERE, null, ex);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, ex.getMessage());
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
