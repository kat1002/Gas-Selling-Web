/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.controller.dashboard.warrantyList;

import com.model.DAO.OrderDAO;
import com.model.DAO.OrderItemDAO;
import com.model.DAO.ProductDAO;
import com.model.DAO.ProductSerialNumberDAO;
import com.model.DAO.WarrantyDAO;
import com.model.Manager;
import com.model.Product;
import com.model.ProductSerialNumber;
import com.model.Warranty;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.util.ArrayList;
import java.sql.Date;
import java.util.Calendar;
import java.util.Collection;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;

/**
 *
 * @author kirit
 */
@MultipartConfig
@WebServlet(name = "AddWarrantyServlet", urlPatterns = {"/addWarranty"})
public class AddWarrantyServlet extends HttpServlet {

    private static final String IMAGE_UPLOAD_DIR = "media/warranty/";

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
            out.println("<title>Servlet AddWarrantyServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddWarrantyServlet at " + request.getContextPath() + "</h1>");
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
        try {
            String serviceTag = request.getParameter("serviceTag");
            ProductSerialNumberDAO ProductSerialNumberDAO = new ProductSerialNumberDAO();
            ProductSerialNumber ProductSerialNumber = ProductSerialNumberDAO.getSerialNumberByServiceTag(serviceTag);
            String guaranteeDate = request.getParameter("guaranteeDate");
            String status = request.getParameter("status");

            Collection<Part> parts = request.getParts();
            StringBuilder imagePaths = new StringBuilder();
            for (Part part : parts) {
                if (part.getName().equals("images") && part.getSize() > 0) {
                    String imagePath = saveImage(request, part);
                    if (imagePaths.length() > 0) {
                        imagePaths.append(",");
                    }
                    imagePaths.append(imagePath);
                }
            }

            //warranty_month
            ProductDAO ProductDAO = new ProductDAO();
            Product product = ProductDAO.getProduct(ProductSerialNumber.getProductId());
            int warranty_month = product.getWarranty_months();
            //create_at
            OrderItemDAO OrderItemDAO = new OrderItemDAO();
            OrderDAO OrderDAO = new OrderDAO();
            Date create_at = OrderDAO.getOrder(OrderItemDAO.getOrderItemById(ProductSerialNumber.getOrderItemId()).getOrderId()).getCreatedAt();
            //expiry
            Calendar cal = Calendar.getInstance();
            cal.setTime(create_at);
            cal.add(Calendar.MONTH, warranty_month);
            Date expiry = new Date(cal.getTimeInMillis());
            //warrantyType
            int warrantyType = expiry.after(new java.util.Date()) ? 2 : 1;

            Warranty warranty = new Warranty();
            warranty.setSerialNumberId(ProductSerialNumber.getSerialNumberId());
            Manager manager =(Manager) request.getSession().getAttribute("manager");
            warranty.setManagerId(manager.getManagerId());
            warranty.setCreatedBy(manager.getManagerId());
            warranty.setModifiedBy(manager.getManagerId());
            warranty.setWarrantyType(warrantyType);
            warranty.setGuaranteeDate(Date.valueOf(guaranteeDate));
            warranty.setStatus(status);
            warranty.setIsDone(false);
            warranty.setImages(imagePaths.toString());
            WarrantyDAO WarrantyDAO =new WarrantyDAO();
            WarrantyDAO.insertWarranty(warranty);
        } catch (SQLException ex) {
            Logger.getLogger(AddWarrantyServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(AddWarrantyServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        response.sendRedirect("manageWarranty");
    }

    private String saveImage(HttpServletRequest request, Part image) throws IOException {
        String imageName = Paths.get(image.getSubmittedFileName()).getFileName().toString();
        String imagePath = IMAGE_UPLOAD_DIR + imageName;
        String fullPath = request.getServletContext().getRealPath(imagePath);
        image.write(fullPath);
        return imagePath;
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
