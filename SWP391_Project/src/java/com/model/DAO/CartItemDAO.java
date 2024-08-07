package com.model.DAO;

import com.model.CartItem;
import com.utils.DBContext;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CartItemDAO {
    private static final Logger LOGGER = Logger.getLogger(CartItemDAO.class.getName());


    public CartItemDAO() throws SQLException, ClassNotFoundException {
    }

    public void addCartItem(CartItem cartItem) {
        String selectSql = "SELECT quantity FROM cart_item WHERE cart_id = ? AND product_id = ?";
        String updateSql = "UPDATE cart_item SET quantity = ? WHERE cart_id = ? AND product_id = ?";
        String insertSql = "INSERT INTO cart_item (cart_id, product_id, quantity) VALUES (?, ?, ?)";
        Connection connection = null;

        try {
            connection = DBContext.getConnection();
            try (PreparedStatement selectStmt = connection.prepareStatement(selectSql)) {
                selectStmt.setInt(1, cartItem.getCartId());
                selectStmt.setInt(2, cartItem.getProductId());
                try (ResultSet rs = selectStmt.executeQuery()) {
                    if (rs.next()) {
                        try (PreparedStatement updateStmt = connection.prepareStatement(updateSql)) {
                            updateStmt.setInt(1, rs.getInt("quantity") + cartItem.getQuantity());
                            updateStmt.setInt(2, cartItem.getCartId());
                            updateStmt.setInt(3, cartItem.getProductId());
                            updateStmt.executeUpdate();
                        }
                    } else {
                        try (PreparedStatement insertStmt = connection.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS)) {
                            insertStmt.setInt(1, cartItem.getCartId());
                            insertStmt.setInt(2, cartItem.getProductId());
                            insertStmt.setInt(3, cartItem.getQuantity());
                            insertStmt.executeUpdate();
                            try (ResultSet generatedKeys = insertStmt.getGeneratedKeys()) {
                                if (generatedKeys.next()) {
                                    cartItem.setItemId(generatedKeys.getInt(1));
                                }
                            }
                        }
                    }
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error adding cart item", e);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } finally {
            DBContext.closeConnection(connection);
        }
    }

    private CartItem getCartItem(int itemId) {
        String sql = "SELECT * FROM cart_item WHERE item_id = ?";
        Connection connection = null;

        try {
            connection = DBContext.getConnection();
            try (PreparedStatement stmt = connection.prepareStatement(sql)) {
                stmt.setInt(1, itemId);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        return new CartItem(itemId, rs.getInt("cart_id"), rs.getInt("product_id"), rs.getInt("quantity"));
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error getting cart item for item ID: " + itemId, e);
        } finally {
            DBContext.closeConnection(connection);
        }

        return null; // Return null if no cart item found or error occurred
    }

    public boolean deleteCartItems(int cartId) {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DBContext.getConnection(); // Replace with your database connection method

            String sql = "DELETE FROM cart_item WHERE cart_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, cartId);

            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0; // Return true if at least one row was deleted
        } catch (SQLException | ClassNotFoundException e) {
            // Log the exception
            LOGGER.log(Level.SEVERE, "Error occurred while deleting cart items for cart ID: " + cartId, e);
            return false;
        } finally {
            // Close resources in finally block
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                    LOGGER.log(Level.WARNING, "Failed to close PreparedStatement", e);
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    LOGGER.log(Level.WARNING, "Failed to close Connection", e);
                }
            }
        }
    }


    public List<CartItem> getAllCartItems() {
        List<CartItem> cartItems = new ArrayList<>();
        String sql = "SELECT * FROM cart_item";
        Connection connection = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            connection = DBContext.getConnection(); // Open connection
            stmt = connection.createStatement();
            rs = stmt.executeQuery(sql);

            while (rs.next()) {
                cartItems.add(new CartItem(rs.getInt("item_id"), rs.getInt("cart_id"), rs.getInt("product_id"), rs.getInt("quantity")));
            }
        } catch (SQLException | ClassNotFoundException e) {
            Logger.getLogger(CartItemDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            // Close ResultSet
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    Logger.getLogger(CartItemDAO.class.getName()).log(Level.SEVERE, null, e);
                }
            }
            // Close Statement
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                    Logger.getLogger(CartItemDAO.class.getName()).log(Level.SEVERE, null, e);
                }
            }
            // Close Connection
            DBContext.closeConnection(connection);
        }
        return cartItems;
    }



    public void updateCartItem(CartItem cartItem) {
        String sql = "UPDATE cart_item SET cart_id = ?, product_id = ?, quantity = ? WHERE item_id = ?";
        Connection connection = null;
        PreparedStatement stmt = null;

        try {
            connection = DBContext.getConnection(); // Open connection
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, cartItem.getCartId());
            stmt.setInt(2, cartItem.getProductId());
            stmt.setInt(3, cartItem.getQuantity());
            stmt.setInt(4, cartItem.getItemId());
            stmt.executeUpdate();
        } catch (SQLException | ClassNotFoundException e) {
            Logger.getLogger(CartItemDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            // Close PreparedStatement
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                    Logger.getLogger(CartItemDAO.class.getName()).log(Level.SEVERE, null, e);
                }
            }
            // Close Connection
            DBContext.closeConnection(connection);
        }
    }

    public void updateCartItemQuantity(int itemId, int quantity) {
        String sql = "UPDATE cart_item SET quantity = ? WHERE item_id = ?";
        Connection connection = null;
        PreparedStatement stmt = null;

        try {
            connection = DBContext.getConnection(); // Open connection
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, quantity);
            stmt.setInt(2, itemId);
            stmt.executeUpdate();
        } catch (SQLException | ClassNotFoundException e) {
            Logger.getLogger(CartItemDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            // Close PreparedStatement
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                    Logger.getLogger(CartItemDAO.class.getName()).log(Level.SEVERE, null, e);
                }
            }
            // Close Connection
            DBContext.closeConnection(connection);
        }
    }


    public void deleteCartItem(int itemId) {
        String sql = "DELETE FROM cart_item WHERE item_id = ?";
        Connection connection = null;
        PreparedStatement stmt = null;

        try {
            connection = DBContext.getConnection(); // Open connection
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, itemId);
            stmt.executeUpdate();
        } catch (SQLException | ClassNotFoundException e) {
            Logger.getLogger(CartItemDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            // Close PreparedStatement
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                    Logger.getLogger(CartItemDAO.class.getName()).log(Level.SEVERE, null, e);
                }
            }
            // Close Connection
            DBContext.closeConnection(connection);
        }
    }
    
    public void deleteCartItemByProductId(int productid) {
        String sql = "DELETE FROM cart_item WHERE product_id = ?";
        Connection connection = null;
        PreparedStatement stmt = null;

        try {
            connection = DBContext.getConnection(); // Open connection
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, productid);
            stmt.executeUpdate();
        } catch (SQLException | ClassNotFoundException e) {
            Logger.getLogger(CartItemDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            // Close PreparedStatement
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                    Logger.getLogger(CartItemDAO.class.getName()).log(Level.SEVERE, null, e);
                }
            }
            // Close Connection
            DBContext.closeConnection(connection);
        }
    }


    public List<CartItem> getCartItemsFromCart(int cartId) {
        String sql = "SELECT * FROM cart_item WHERE cart_id = ?";
        List<CartItem> cartItems = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBContext.getConnection(); // Open connection
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, cartId);

            rs = stmt.executeQuery();
            while (rs.next()) {
                CartItem cartItem = new CartItem(rs.getInt("item_id"), rs.getInt("cart_id"), rs.getInt("product_id"), rs.getInt("quantity"));
                cartItems.add(cartItem);
                System.out.println("Retrieved CartItem: " + cartItem); // Log the retrieved CartItem
            }
        } catch (SQLException | ClassNotFoundException e) {
            Logger.getLogger(CartItemDAO.class.getName()).log(Level.SEVERE, "Error getting cart items for cart ID: " + cartId, e);
        } finally {
            // Close ResultSet
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    Logger.getLogger(CartItemDAO.class.getName()).log(Level.SEVERE, "Error closing ResultSet", e);
                }
            }
            // Close PreparedStatement
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                    Logger.getLogger(CartItemDAO.class.getName()).log(Level.SEVERE, "Error closing PreparedStatement", e);
                }
            }
            // Close Connection
            if (conn != null) {
                DBContext.closeConnection(conn);
            }
        }

        return cartItems;
    }


}
