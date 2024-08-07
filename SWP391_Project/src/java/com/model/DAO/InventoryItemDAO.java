/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.model.DAO;

/**
 *
 * @author kat1002
 */
import com.model.InventoryItem;
import com.utils.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class InventoryItemDAO {

    private static final Logger LOGGER = Logger.getLogger(headerDAO.class.getName());

    public InventoryItemDAO() throws SQLException, ClassNotFoundException {
    }

    public void addInventoryItem(InventoryItem item) {
        String sql = "INSERT INTO inventory_item (inventory_id, voucher_id, amount) VALUES (?, ?, ?)";
        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            if (conn != null) {
                try (PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                    stmt.setInt(1, item.getInventoryId());
                    stmt.setInt(2, item.getVoucherId());
                    stmt.setInt(3, item.getAmount());
                    stmt.executeUpdate();

                    try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                        if (generatedKeys.next()) {
                            item.setItemId(generatedKeys.getInt(1));
                        }
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error adding inventory item", e);
        } finally {
            DBContext.closeConnection(conn);
        }
    }

    public InventoryItem getInventoryItem(int itemId) {
        String sql = "SELECT * FROM inventory_item WHERE item_id = ?";
        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            if (conn != null) {
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setInt(1, itemId);
                    try (ResultSet rs = stmt.executeQuery()) {
                        if (rs.next()) {
                            return new InventoryItem(
                                    rs.getInt("item_id"),
                                    rs.getInt("inventory_id"),
                                    rs.getInt("voucher_id"),
                                    rs.getInt("amount")
                            );
                        }
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error getting inventory item", e);
        } finally {
            DBContext.closeConnection(conn);
        }
        return null;
    }

    public List<InventoryItem> getInventoryItemByInventoryId(int inventoryId) {
        String sql = "SELECT * FROM inventory_item WHERE inventory_id = ?";
        Connection conn = null;
        List<InventoryItem> items = new ArrayList<>();
        try {
            conn = DBContext.getConnection();
            if (conn != null) {
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setInt(1, inventoryId);
                    try (ResultSet rs = stmt.executeQuery()) {
                        while (rs.next()) {
                            items.add(new InventoryItem(
                                    rs.getInt("item_id"),
                                    rs.getInt("inventory_id"),
                                    rs.getInt("voucher_id"),
                                    rs.getInt("amount")
                            ));
                        }
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error getting inventory item", e);
        } finally {
            DBContext.closeConnection(conn);
        }
        return items;
    }

    public InventoryItem getInventoryItemByInventoryAndVoucher(int inventoryId, int voucherId) {
        String sql = "SELECT * FROM inventory_item WHERE inventory_id = ? AND voucher_id = ?";
        Connection conn = null;
        InventoryItem item = null;
        try {
            conn = DBContext.getConnection();
            if (conn != null) {
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setInt(1, inventoryId);
                    stmt.setInt(2, voucherId);
                    try (ResultSet rs = stmt.executeQuery()) {
                        if (rs.next()) {
                            item = new InventoryItem(
                                    rs.getInt("item_id"),
                                    rs.getInt("inventory_id"),
                                    rs.getInt("voucher_id"),
                                    rs.getInt("amount")
                            );
                        }
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error getting inventory item", e);
        } finally {
            DBContext.closeConnection(conn);
        }
        return item;
    }

    public List<InventoryItem> getAllInventoryItems() {
        List<InventoryItem> items = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            if (conn != null) {
                String sql = "SELECT * FROM inventory_item";
                try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
                    while (rs.next()) {
                        items.add(new InventoryItem(
                                rs.getInt("item_id"),
                                rs.getInt("inventory_id"),
                                rs.getInt("voucher_id"),
                                rs.getInt("amount")
                        ));
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error getting all inventory items", e);
        } finally {
            DBContext.closeConnection(conn);
        }
        return items;
    }

    public void updateInventoryItem(InventoryItem item) {
        String sql = "UPDATE inventory_item SET inventory_id = ?, voucher_id = ?, amount = ? WHERE item_id = ?";
        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            if (conn != null) {
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setInt(1, item.getInventoryId());
                    stmt.setInt(2, item.getVoucherId());
                    stmt.setInt(3, item.getAmount());
                    stmt.setInt(4, item.getItemId());
                    stmt.executeUpdate();
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error updating inventory item", e);
        } finally {
            DBContext.closeConnection(conn);
        }
    }
    
    public void reduceInventoryItemAmount(int item_id, int amount) {
        String sql = "UPDATE inventory_item SET amount = amount - ? WHERE item_id = ?";
        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            if (conn != null) {
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setInt(1, amount);
                    stmt.setInt(2, item_id);
                    stmt.executeUpdate();
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error updating inventory item", e);
        } finally {
            DBContext.closeConnection(conn);
        }
    }

    public void deleteInventoryItem(int itemId) {
        String sql = "DELETE FROM inventory_item WHERE item_id = ?";
        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            if (conn != null) {
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setInt(1, itemId);
                    stmt.executeUpdate();
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error deleting inventory item", e);
        } finally {
            DBContext.closeConnection(conn);
        }
    }

    public static void main(String[] args) throws SQLException, ClassNotFoundException {
        for (InventoryItem item : new InventoryItemDAO().getInventoryItemByInventoryId(24)){
            System.out.println(item);
        }
    }
}
