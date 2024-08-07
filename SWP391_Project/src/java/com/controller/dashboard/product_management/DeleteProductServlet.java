/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.controller.dashboard.product_management;

import com.controller.WebManager;
import com.model.Manager;
import com.model.Product;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.File;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
@WebServlet(name = "DeleteProductServlet", urlPatterns = {"/deleteproduct"})
public class DeleteProductServlet extends HttpServlet {

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
            out.println("<title>Servlet DeleteProductServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DeleteProductServlet at " + request.getContextPath() + "</h1>");
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
        Manager manager = (Manager) request.getSession().getAttribute("manager");

        if (manager == null) {
            response.sendRedirect("login_system.jsp");
            return;
        }
        PrintWriter out = response.getWriter();
        String pid = request.getParameter("pid");
        try {
            int id = Integer.parseInt(pid);
            List<String> imagePaths = WebManager.getInstance().productDAO.getImagesByProductId(id);
            Product product = WebManager.getInstance().productDAO.getProduct(id);
            WebManager.getInstance().discountDAO.updateDiscountProductIdToNull(id);
            if (imagePaths != null) {
                for (String imagePath : imagePaths) {
                    // Thực hiện xoá file hình ảnh
                    File file = new File(request.getServletContext().getRealPath(imagePath));
                    if (file.delete()) {
                        // File đã được xoá
                    } else {
                        // Xử lý khi không thể xoá file
                    }
                }
            }
            WebManager.getInstance().rateDAO.deleteRateByProductId(id);
            
            
            if (WebManager.getInstance().productDAO.deleteProductImage(product)
                    || WebManager.getInstance().productDAO.getImagesByProductId(product.getProductId()).size() == 0) {
                if (WebManager.getInstance().productSerialNumberDAO.deleteProductSerialByProductId(product.getProductId())
                        || WebManager.getInstance().productSerialNumberDAO.getListSerialByProductId(product.getProductId()).size() == 0) {
                    WebManager.getInstance().orderItemDAO.deleteOrderItemByProductId(id);
                    WebManager.getInstance().cartItemDAO.deleteCartItemByProductId(id);
                    if (WebManager.getInstance().productDAO.deleteProduct(product)) {
                        out.println("<script>");
                        out.println("alert('Delete product sucessfully !');");
                        out.println("window.location.href='manageproduct';");
                        out.println("</script>");
                    } else {
                        out.println("<script>");
                        out.println("alert('Can't delete product');");
                        out.println("window.location.href='manageproduct';");
                        out.println("</script>");
                    }
                } else {
                    out.println("<script>");
                    out.println("alert('Can't delete product');");
                    out.println("window.location.href='manageproduct';");
                    out.println("</script>");
                }
            } else {
                out.println("<script>");
                out.println("alert('Can't delete product');");
                out.println("window.location.href='manageproduct';");
                out.println("</script>");
            }
        } catch (SQLException ex) {
            Logger.getLogger(DeleteProductServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(DeleteProductServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NumberFormatException ex) {
            Logger.getLogger(DeleteProductServlet.class.getName()).log(Level.SEVERE, null, ex);
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
