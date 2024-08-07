/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package com.controller.checkout;

import com.controller.WebManager;
import com.model.CartItem;
import com.model.Customer;
import com.model.DAO.OrderDAO;
import com.model.DAO.OrderItemDAO;
import com.model.DAO.ProductDAO;
import com.model.DAO.ProductSerialNumberDAO;
import com.model.Inventory;
import com.model.InventoryItem;
import com.model.Order;
import com.model.OrderItem;
import com.model.ProductSerialNumber;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author kirit
 */
@WebServlet(name="CreateNewOrderServlet", urlPatterns={"/createNewOrder"})
public class CreateNewOrderServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
//        PrintWriter out = response.getWriter();
//        try {
//            response.setContentType("text/html;charset=UTF-8");
//            Order order= (Order)request.getSession().getAttribute("order");
//            List<CartItem> cartitems= (List<CartItem>)request.getSession().getAttribute("cartitems");
//            Customer customer = (Customer) request.getSession().getAttribute("user");
//            OrderDAO orderDAO = WebManager.getInstance().orderDAO;
//            ProductDAO productDAO = WebManager.getInstance().productDAO;
//            OrderItemDAO orderItemDAO = WebManager.getInstance().orderItemDAO;
//            ProductSerialNumberDAO productserialnumberDAO = WebManager.getInstance().productSerialNumberDAO;
//            if (orderDAO.insert(order)) {
//                List<OrderItem> orderItemList = new ArrayList<>();
//                for (CartItem ci : cartitems) {
//                    orderItemList.add(new OrderItem(orderDAO.getNewestOrderByCustomer(customer.getCustomerId()).getOrderId(),
//                            ci.getProductId(),
//                            ci.getQuantity(),
//                            productDAO.getProduct(ci.getProductId()).getPrice()));
//                }
//                for (OrderItem oi : orderItemList) {
//                    orderItemDAO.add(oi);
//                }
//                for (OrderItem ord : orderItemDAO.getOrderItemsByOrderId(orderDAO.getLastOrderReturnId())) {
//                    int availableStock = WebManager.getInstance().productDAO.getProduct(ord.getProductId()).getStock();
//
//                    if (ord.getQuantity() > availableStock) {
//                        // If the quantity exceeds the available stock
//                        productDAO.updateDecreaseQuantity(availableStock, ord.getProductId());
//                        List<ProductSerialNumber> serialNumbers = productserialnumberDAO.getListTopSerialByProductId(ord.getProductId(), availableStock);
//
//                        for (ProductSerialNumber psn : serialNumbers) {
//                            psn.setProductId(ord.getProductId());
//                            psn.setOrderItemId(ord.getOrderItemId());
//                            productserialnumberDAO.update(psn);
//                        }
//                    } else {
//                        // If the quantity is within the available stock
//                        productDAO.updateDecreaseQuantity(ord.getQuantity(), ord.getProductId());
//                        List<ProductSerialNumber> serialNumbers = productserialnumberDAO.getListTopSerialByProductId(ord.getProductId(), ord.getQuantity());
//
//                        for (ProductSerialNumber psn : serialNumbers) {
//                            psn.setProductId(ord.getProductId());
//                            psn.setOrderItemId(ord.getOrderItemId());
//                            productserialnumberDAO.update(psn);
//                        }
//                    }
//
//                    // Update the stock value after the operation
//                    availableStock = WebManager.getInstance().productDAO.getProduct(ord.getProductId()).getStock();
//
//                    // If the product is out of stock, break out of the loop or handle as needed
//                    if (availableStock <= 0) {
//                        break; // Stop further processing if the product is out of stock
//                    }
//                }
//                if (order.getVoucherId() == 0){
//                    
//                }else{
//                    Inventory inventory = WebManager.getInstance().inventoryDAO.getInventoryByCustomerId(customer.getCustomerId());
//                    InventoryItem item = WebManager.getInstance().inventoryItemDAO.getInventoryItemByInventoryAndVoucher(inventory.getInventoryId(), order.getVoucherId());
//                    WebManager.getInstance().inventoryItemDAO.reduceInventoryItemAmount(item.getItemId(), 1);
//                }
//                WebManager.getInstance().cartItemDAO.deleteCartItems(WebManager.getInstance().cartDAO.getCart(customer.getId()).getCartId());
//                WebManager.getInstance().cartDAO.deleteCartByCustomer(customer.getCustomerId());
//                out.println("<script>");
//                out.println("alert('Checkout sucessfully !');");
//                out.println("window.location.href='home';");
//                out.println("</script>");
//            } else {
//                out.println("<script>");
//                out.println("alert('Cannot checkout !');");
//                out.println("window.location.href='checkout';");
//                out.println("</script>");
//            }
//        } catch (SQLException ex) {
//            Logger.getLogger(CreateNewOrderServlet.class.getName()).log(Level.SEVERE, null, ex);
//        } catch (ClassNotFoundException ex) {
//            Logger.getLogger(CreateNewOrderServlet.class.getName()).log(Level.SEVERE, null, ex);
//        }
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
