/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.controller.dashboard.order_management;

import com.controller.WebManager;
import com.model.Manager;
import com.model.OrderItem;
import com.model.Product;
import com.model.ProductSerialNumber;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "DeleteOrderServlet", urlPatterns = {"/deleteorder"})
public class DeleteOrderServlet extends HttpServlet {

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
            out.println("<title>Servlet DeleteOrderServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DeleteOrderServlet at " + request.getContextPath() + "</h1>");
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
        response.setContentType("text/html;charset=UTF-8");
        Manager manager = (Manager) request.getSession().getAttribute("manager");
        if (manager == null) {
            response.sendRedirect("login_system.jsp");
            return;
        }
        PrintWriter out = response.getWriter();
        try {
            String oid = request.getParameter("oid");
            for (OrderItem oi : WebManager.getInstance().orderItemDAO.getOrderItemsByOrderId(Integer.parseInt(oid))) {
                for (ProductSerialNumber psn : WebManager.getInstance().productSerialNumberDAO.getListSerialByOrderItemId(oi.getOrderItemId())) {
                    psn.setOrderItemId(0);
                    WebManager.getInstance().productSerialNumberDAO.update(psn);
                }
                WebManager.getInstance().productDAO.updateIncreaseQuantity(oi.getQuantity(), oi.getProductId());
            }
            WebManager.getInstance().orderItemDAO.deleteOrderItemByOrderId(Integer.parseInt(oid));
            WebManager.getInstance().orderDAO.delete(Integer.parseInt(oid));
            if (WebManager.getInstance().orderDAO.getOrder(Integer.parseInt(oid)) == null) {
                out.println("<script>");
                out.println("alert('Deleted order sucessfully !');");
                out.println("window.location.href='manageorder';");
                out.println("</script>");
            } else {
                out.println("<script>");
                out.println("alert('Can't delete order');");
                out.println("window.location.href='manageorder';");
                out.println("</script>");
            }
        } catch (Exception ex) {
            Logger.getLogger(DeleteOrderServlet.class.getName()).log(Level.SEVERE, null, ex);
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
