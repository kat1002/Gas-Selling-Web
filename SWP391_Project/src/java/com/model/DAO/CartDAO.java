package com.model.DAO;

import com.controller.WebManager;
import com.model.Cart;
import com.model.CartItem;
import com.utils.DBContext;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CartDAO {

    private static final Logger LOGGER = Logger.getLogger(CartDAO.class.getName());

    public CartDAO() throws SQLException, ClassNotFoundException {
        // Ensure DBContext initializes the connection

    }

    public Cart getCart(int customerId) {
        String sql = "SELECT TOP 1 * FROM cart WHERE user_id = ?";
        Connection connection = null; // Declare connection outside try block for proper scoping
        try {
            connection = DBContext.getConnection(); // Get connection
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, customerId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    LOGGER.log(Level.INFO, "Cart found: {0}, {1}", new Object[]{rs.getInt("cart_id"), rs.getInt("user_id")});
                    return new Cart(rs.getInt("cart_id"), rs.getInt("user_id"));
                } else {
                    LOGGER.log(Level.INFO, "No cart found, creating a new one for customer_id: {0}", customerId);
                    return createNewCart(customerId);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error getting cart", e);
        } finally {
            DBContext.closeConnection(connection); // Close connection in finally block
        }
        return null;
    }

    private Cart createNewCart(int customerId) {
        String insertSql = "INSERT INTO cart (user_id) VALUES (?)";
        Connection connection = null; // Declare connection outside try block for proper scoping
        try {
            // Open connection
            connection = DBContext.getConnection();

            // Prepare and execute SQL statement
            try (PreparedStatement stmt = connection.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS)) {
                stmt.setInt(1, customerId);
                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
                    LOGGER.log(Level.INFO, "Create cart successfully");
                    try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                        if (generatedKeys.next()) {
                            int newCartId = generatedKeys.getInt(1);
                            return new Cart(newCartId, customerId, 0);
                        }
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error creating new cart", e);
        } finally {
            // Close connection in finally block
            DBContext.closeConnection(connection);
        }
        return null;
    }


    public List<Cart> getAllCarts() {
        List<Cart> carts = new ArrayList<>();
        String sql = "SELECT * FROM cart";
        Connection connection = null; // Declare connection outside try block for proper scoping
        try {
            // Open connection
            connection = DBContext.getConnection();

            // Prepare and execute SQL statement
            try (Statement stmt = connection.createStatement();
                 ResultSet rs = stmt.executeQuery(sql)) {
                while (rs.next()) {
                    carts.add(new Cart(rs.getInt("cart_id"), rs.getInt("user_id"), rs.getFloat("total")));
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error getting all carts", e);
        } finally {
            // Close connection in finally block
            DBContext.closeConnection(connection);
        }
        return carts;
    }


    public void updateCart(Cart cart) {
        String sql = "UPDATE cart SET user_id = ?, total = ? WHERE cart_id = ?";
        Connection connection = null; // Declare connection outside try block for proper scoping
        try {
            // Open connection
            connection = DBContext.getConnection();

            // Prepare and execute SQL statement
            try (PreparedStatement stmt = connection.prepareStatement(sql)) {
                stmt.setInt(1, cart.getUserId());
                stmt.setFloat(2, cart.getTotal());
                stmt.setInt(3, cart.getCartId());
                stmt.executeUpdate();
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error updating cart", e);
        } finally {
            // Close connection in finally block
            DBContext.closeConnection(connection);
        }
    }


    public void deleteCart(int cartId) {
        String sql = "DELETE FROM cart WHERE cart_id = ?";
        Connection connection = null; // Declare connection outside try block for proper scoping
        try {
            // Open connection
            connection = DBContext.getConnection();

            // Prepare and execute SQL statement
            try (PreparedStatement stmt = connection.prepareStatement(sql)) {
                stmt.setInt(1, cartId);
                stmt.executeUpdate();
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error deleting cart", e);
        } finally {
            // Close connection in finally block
            DBContext.closeConnection(connection);
        }
    }
    
    public void deleteCartByCustomer(int userid) {
        String sql = "DELETE FROM cart WHERE user_id = ?";
        Connection connection = null; // Declare connection outside try block for proper scoping
        try {
            // Open connection
            connection = DBContext.getConnection();

            // Prepare and execute SQL statement
            try (PreparedStatement stmt = connection.prepareStatement(sql)) {
                stmt.setInt(1, userid);
                stmt.executeUpdate();
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error deleting cart", e);
        } finally {
            // Close connection in finally block
            DBContext.closeConnection(connection);
        }
    }
    
    public static void main(String[] args) throws SQLException, ClassNotFoundException {
        System.out.println(WebManager.getInstance().cartDAO.getCart(2));
        for (CartItem ci : WebManager.getInstance().cartItemDAO.getCartItemsFromCart(WebManager.getInstance().cartDAO.getCart(2).getCartId())){
            System.out.println(ci);
        }
        
    }

}
