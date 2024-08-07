/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.controller.dashboard.product_management;

import com.controller.product_list.ProductListServlet;
import com.controller.WebManager;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.model.DAO.CategoryDAO;
import com.model.DAO.DiscountDAO;
import com.model.DAO.footerDAO;
import com.model.DAO.headerDAO;
import com.model.Discount;
import com.model.Manager;
import com.model.Product;
import com.model.ProductSerialNumber;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
@MultipartConfig
@WebServlet(name = "EditProductServlet", urlPatterns = {"/editproduct"})
public class EditProductServlet extends HttpServlet {

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
            out.println("<title>Servlet EditProductServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditProductServlet at " + request.getContextPath() + "</h1>");
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
        String title = request.getParameter("title");
        PrintWriter out = response.getWriter();
        try {
            Product product = WebManager.getInstance().productDAO.getProductByTitle(title);
            List<String> submittedfile = new ArrayList<>();
            for (String s : product.getImages()) {
                String modifiedString = s.substring(s.indexOf("media/product/") + "media/product/".length());
                submittedfile.add(modifiedString);
            }
//            JsonObject jsonResponse = new JsonObject();
//            jsonResponse.add("submittedfile", new Gson().toJsonTree(submittedfile));
//            jsonResponse.add("productt", new Gson().toJsonTree(product));
//            jsonResponse.add("categories", new Gson().toJsonTree(WebManager.getInstance().categoryDAO.getAllCategories()));
//            jsonResponse.add("discounts", new Gson().toJsonTree(WebManager.getInstance().discountDAO.getAllDiscounts()));
//            out.write(jsonResponse.toString());
//            out.flush();
            request.setAttribute("submittedfile", submittedfile);
            request.setAttribute("product", product);
            request.setAttribute("categories", WebManager.getInstance().categoryDAO.getAllCategories());
            request.setAttribute("discounts", WebManager.getInstance().discountDAO.getAllDiscounts());
            request.getRequestDispatcher("editproduct.jsp").forward(request, response);

        } catch (Exception ex) {
            Logger.getLogger(EditProductServlet.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            out.close();
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
        try {
            String id = request.getParameter("id");
            String title = request.getParameter("title");
            String stock = request.getParameter("stock");
            String price = request.getParameter("price");
            String description = request.getParameter("description");
            String cid = request.getParameter("cid");
            String did = request.getParameter("did");
            String period = request.getParameter("period");
            Part image = request.getPart("image");
            String directory = "/media/product/";
            int stocks = Integer.parseInt(stock);
            float pricee = Float.parseFloat(price);
            if (pricee < 0){
                out.println("<script>");
                out.println("alert('Price is not negative');");
                out.println("window.location.href='editproduct?title="+id+"';");
                out.println("</script>");
                return;
            }
            if (stocks < 0){
                out.println("<script>");
                out.println("alert('Stock is not negative');");
                out.println("window.location.href='editproduct?title="+id+"';");
                out.println("</script>");
                return;
            }
            if (WebManager.getInstance().productDAO.checkProductNameExistsById(title, Integer.parseInt(id))){
                out.println("<script>");
                out.println("alert('The product title is existed in the system !');");
                out.println("window.location.href = 'editproduct?title="+WebManager.getInstance().productDAO.getProduct(Integer.parseInt(id)).getTitle()+"';"); // Trở về trang managebrand khi người dùng ấn OK
                out.println("</script>");
                return;
            }
            int discountid = (did != null) ? Integer.parseInt(did) : 0;
            if (stocks > WebManager.getInstance().productDAO.getProduct(Integer.parseInt(id)).getStock()) {
                for (int i = 0; i < stocks - WebManager.getInstance().productSerialNumberDAO.getListSerialByProductId(Integer.parseInt(id)).size(); i++) {
                    ProductSerialNumber psn = new ProductSerialNumber(Integer.parseInt(id));
                    WebManager.getInstance().productSerialNumberDAO.insert(psn);
                }
            }
            List<String> imageUrls = new ArrayList<>();
            // Handle current images
            String[] currentImages = request.getParameterValues("currentImages");
            String[] deleteImages = request.getParameterValues("deleteImages");

            if (currentImages != null) {
                for (String img : currentImages) {
                    boolean toDelete = false;
                    if (deleteImages != null) {
                        for (String delImg : deleteImages) {
                            if (img.equals(delImg) && WebManager.getInstance().productDAO.deleteProductImageByPath("media/product/" + img)) {
                                toDelete = true;
                                break;
                            }
                        }
                    }
                    if (!toDelete) {
//                        imageUrls.add("media/product/"+img);
                    } else {
                        // Delete image from server
                        File fileToDelete = new File(request.getServletContext().getRealPath(directory + img));
                        if (fileToDelete.exists()) {
                            fileToDelete.delete();
                        }
                    }
                }
            }

            product.setProductId(Integer.parseInt(id));
            product.setCategoryId(Integer.parseInt(cid));
            product.setTitle(title);
            product.setReviewsRate(WebManager.getInstance().productDAO.getProduct(Integer.parseInt(id)).getReviewsRate());
            product.setStock(stocks);
            product.setDiscountId(discountid);
            product.setPrice(pricee);
            product.setDescription(description);
            product.setCreatedDate(WebManager.getInstance().productDAO.getProduct(Integer.parseInt(id)).getCreatedDate());
            product.setModifiedOn(now);
            product.setCreatedBy(WebManager.getInstance().productDAO.getProduct(Integer.parseInt(id)).getCreatedBy());
            product.setModifiedBy(manager.getManagerId());
            product.setImages(WebManager.getInstance().productDAO.getImagesByProductId(Integer.parseInt(id)));
            product.setWarranty_months(Integer.parseInt(period));
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

            } else {

            }
            for (String s : imageUrls) {
                WebManager.getInstance().productDAO.addProductImages(Integer.parseInt(id), s);
            }
//            if (product.getDiscountId() != 0) {
//                Discount discount = WebManager.getInstance().discountDAO.getDiscount(discountid);
//                discount.setProductId(Integer.parseInt(id));
//                WebManager.getInstance().discountDAO.updateDiscount(discount);
//            } else {
//                Discount discount = WebManager.getInstance().discountDAO.getDiscountByProductId(Integer.parseInt(id));
//
//                if (discount != null) {
//                    discount.setProductId(0);
//                    WebManager.getInstance().discountDAO.updateDiscountProductIdToNull(Integer.parseInt(id));
//                    WebManager.getInstance().productDAO.updateDiscountProductNull(Integer.parseInt(id));
//                } else {
//
//                }
//            }
            if (WebManager.getInstance().productDAO.updateProduct(product)) {
                out.println("<script>");
                out.println("alert('Update product sucessfully');");
                out.println("window.location.href='manageproduct';");
                out.println("</script>");
            } else {
                out.println("<script>");
                out.println("alert('Can't update product');");
                out.println("window.location.href='editproduct?title=" + WebManager.getInstance().productDAO.getProduct(Integer.parseInt(id)).getTitle() + "';");
                out.println("</script>");
            }

        } catch (Exception ex) {
            Logger.getLogger(EditProductServlet.class.getName()).log(Level.SEVERE, null, ex);
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

