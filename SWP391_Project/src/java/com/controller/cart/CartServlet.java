/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.controller.cart;

import com.controller.WebManager;
import com.model.Cart;
import com.model.CartItem;
import com.model.Customer;
import com.model.DAO.CartDAO;
import com.model.DAO.CartItemDAO;
import com.model.DAO.CategoryDAO;
import com.model.DAO.ProductDAO;
import com.model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * @author Admin
 */
@WebServlet(name = "CartServlet", urlPatterns = {"/cart"})
public class CartServlet extends HttpServlet {

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        Customer customer = (Customer) request.getSession().getAttribute("user");

//        if (customer == null) {
//            response.sendRedirect("login_system.jsp");
//            return;
//        }


        String action = request.getParameter("action");

        System.out.println("Cart action: " + action);

        if(action == null) {
            try {
                getCart(request, response, customer);
            } catch (SQLException | ClassNotFoundException e) {
                throw new RuntimeException(e);
            }
            return;
        }

        if(action.equals("add")) {
            try {
                addToCart(request, response, customer);
            } catch (SQLException | ClassNotFoundException e) {
                throw new RuntimeException(e);
            }
            return;
        }

        if(action.equals("delete")) {
            try {
                deleteItemFromCart(request, response);
            } catch (SQLException | ClassNotFoundException e) {
                throw new RuntimeException(e);
            }
            return;
        }

        if(action.equals("update")) {
            try {
                updateCart(request, response);
            } catch (SQLException | ClassNotFoundException e) {
                throw new RuntimeException(e);
            }
            return;
        }
    }

    protected void getCart(HttpServletRequest request, HttpServletResponse response, Customer customer) throws ServletException, IOException, SQLException, ClassNotFoundException {
        // Log the start of the method
        Logger LOGGER = Logger.getLogger(this.getClass().getName());
        LOGGER.log(Level.INFO, "Starting getCart for customer ID: {0}", customer.getId());

        // Fetch the cart
        Cart cart = null;
        try {
            cart = WebManager.getInstance().cartDAO.getCart(customer.getId());
            if (cart == null) {
                LOGGER.log(Level.WARNING, "Cart not found for customer ID: {0}", customer.getId());
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Cart not found");
                return;
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting cart for customer ID: " + customer.getId(), e);
            throw e;
        }

        // Fetch the cart items
        try {
            List<CartItem> cartItems = WebManager.getInstance().cartItemDAO.getCartItemsFromCart(cart.getCartId());

            request.setAttribute("cart_items", cartItems);

            double total = 0;
            for (CartItem c : cartItems) {
                if (WebManager.getInstance().productDAO.getProduct(c.getProductId()).getDiscountId() == 0){
                    total += c.getQuantity() * WebManager.getInstance().productDAO.getProduct(c.getProductId()).getPrice();
                }else{
                    total += c.getQuantity() * (WebManager.getInstance().productDAO.getProduct(c.getProductId()).getPrice() - 
                            WebManager.getInstance().productDAO.getProduct(c.getProductId()).getPrice() * 
                            WebManager.getInstance().discountDAO.getDiscount(WebManager.getInstance().productDAO.getProduct(c.getProductId()).getDiscountId()).getDiscountValue());
                }     
            }

            request.setAttribute("total", total);

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting cart items for cart ID: " + cart.getCartId(), e);
            throw e;
        }

        // Forward to cart.jsp
        try {
            request.getRequestDispatcher("cart.jsp").forward(request, response);
        } catch (ServletException | IOException e) {
            LOGGER.log(Level.SEVERE, "Error forwarding to cart.jsp", e);
            throw e;
        }

        // Log the end of the method
        LOGGER.log(Level.INFO, "Completed getCart for customer ID: {0}", customer.getId());
    }


    protected void addToCart(HttpServletRequest request, HttpServletResponse response, Customer customer) throws ServletException, IOException, SQLException, ClassNotFoundException {
        int quantity = Integer.parseInt(request.getParameter("qty"));
        int product_id = Integer.parseInt(request.getParameter("pid"));

        CartItemDAO cartItemDAO = WebManager.getInstance().cartItemDAO;
        Cart cart = WebManager.getInstance().cartDAO.getCart(customer.getId());
        cartItemDAO.addCartItem(new CartItem(cart.getCartId(), product_id, quantity));
        response.sendRedirect("product?id=" + product_id);
    }

    protected void deleteItemFromCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException, ClassNotFoundException {
        int cartItem_id = Integer.parseInt(request.getParameter("ciid"));

        CartItemDAO cartItemDAO = WebManager.getInstance().cartItemDAO;
        cartItemDAO.deleteCartItem(cartItem_id);
        response.sendRedirect("cart");
    }

    protected void updateCart(HttpServletRequest request, HttpServletResponse response) throws SQLException, ClassNotFoundException, IOException {
        System.out.println("Update Cart");

        // Process the updated quantities from the form
        Map<Integer, Integer> updatedQuantities = new HashMap<>();
        for (String parameterName : request.getParameterMap().keySet()) {
            if (parameterName.startsWith("quantity_")) {
                int itemId = Integer.parseInt(parameterName.substring(9));
                int quantity = Integer.parseInt(request.getParameter(parameterName));
                updatedQuantities.put(itemId, quantity);
            }
        }

        // Update the cart items in the session or database based on the updated quantities
        // Assuming you have a method in your DAO or service to handle this update
        CartItemDAO cartItemDAO = WebManager.getInstance().cartItemDAO;
        for (Map.Entry<Integer, Integer> entry : updatedQuantities.entrySet()) {
            int itemId = entry.getKey();
            int quantity = entry.getValue();
            System.out.println(itemId + " " + quantity);
            cartItemDAO.updateCartItemQuantity(itemId, quantity);
        }

        // Redirect back to the cart page
        response.sendRedirect("cart");
    }



    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

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
