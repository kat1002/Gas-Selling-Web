/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.model.DAO;

/**
 *
 * @author kat1002
 */
import com.controller.WebManager;
import com.model.Discount;
import com.model.Manager;
import com.utils.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DiscountDAO {

    private static final Logger LOGGER = Logger.getLogger(DiscountDAO.class.getName());

    public DiscountDAO() throws SQLException, ClassNotFoundException {
    }

    public void addDiscount(Discount discount) {
        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            if (conn != null) {
                String sql = "INSERT INTO discount (product_id, title, description, discount_value, created_by, modified_by, created_at, modified_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                try (PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                    stmt.setInt(1, discount.getProductId());
                    stmt.setString(2, discount.getTitle());
                    stmt.setString(3, discount.getDescription());
                    stmt.setFloat(4, discount.getDiscountValue());
                    stmt.setInt(5, discount.getCreatedBy());
                    stmt.setInt(6, discount.getModifiedBy());
                    stmt.setDate(7, new java.sql.Date(discount.getCreatedAt().getTime()));
                    stmt.setDate(8, new java.sql.Date(discount.getModifiedAt().getTime()));
                    stmt.executeUpdate();

                    try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                        if (generatedKeys.next()) {
                            discount.setDiscountId(generatedKeys.getInt(1));
                        }
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error adding discount", e);
        } finally {
            DBContext.closeConnection(conn);
        }
    }

    public boolean insertDiscount(Discount discount) {
        Connection conn = null;
        boolean rowInserted = false;
        try {
            conn = DBContext.getConnection();
            if (conn != null) {
                String sql = "INSERT INTO [dbo].[discount]\n"
                        + "           ([product_id]\n"
                        + "           ,[title]\n"
                        + "           ,[description]\n"
                        + "           ,[discount_value]\n"
                        + "           ,[created_by]\n"
                        + "           ,[modified_by]\n"
                        + "           ,[created_at]\n"
                        + "           ,[modified_at]\n"
                        + "           ,[expiry]\n"
                        + "           ,[status])\n"
                        + "     VALUES\n"
                        + "           (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                try (PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                    if (discount.getProductId() == 0) {
                        stmt.setNull(1, discount.getProductId());
                    } else {
                        stmt.setInt(1, discount.getProductId());
                    }
                    stmt.setString(2, discount.getTitle());
                    stmt.setString(3, discount.getDescription());
                    stmt.setFloat(4, discount.getDiscountValue());
                    stmt.setInt(5, discount.getCreatedBy());
                    stmt.setInt(6, discount.getModifiedBy());
                    stmt.setDate(7, new java.sql.Date(discount.getCreatedAt().getTime()));
                    stmt.setDate(8, new java.sql.Date(discount.getModifiedAt().getTime()));
                    stmt.setTimestamp(9, java.sql.Timestamp.valueOf(discount.getExpiry()));
                    stmt.setBoolean(10, discount.isStatus());
                    rowInserted = stmt.executeUpdate() > 0;

                    try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                        if (generatedKeys.next()) {
                            discount.setDiscountId(generatedKeys.getInt(1));
                        }
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error adding discount", e);
        } finally {
            DBContext.closeConnection(conn);
        }
        return rowInserted;
    }

    public Discount getDiscount(int discountId) {
        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            if (conn != null) {
                String sql = "SELECT [discount_id]\n"
                        + "      ,[product_id]\n"
                        + "      ,[title]\n"
                        + "      ,[description]\n"
                        + "      ,[discount_value]\n"
                        + "      ,[created_by]\n"
                        + "      ,[modified_by]\n"
                        + "      ,[created_at]\n"
                        + "      ,[modified_at]\n"
                        + "      ,[expiry]\n"
                        + "      ,[status]\n"
                        + "  FROM [dbo].[discount] WHERE discount_id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setInt(1, discountId);
                    try (ResultSet rs = stmt.executeQuery()) {
                        if (rs.next()) {
                            return new Discount(
                                    rs.getInt("discount_id"),
                                    rs.getInt("product_id"),
                                    rs.getString("title"),
                                    rs.getString("description"),
                                    rs.getFloat("discount_value"),
                                    rs.getInt("created_by"),
                                    rs.getInt("modified_by"),
                                    rs.getDate("created_at"),
                                    rs.getDate("modified_at"),
                                    rs.getTimestamp("expiry").toLocalDateTime(),
                                    rs.getBoolean("status")
                            );
                        }
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error getting discount", e);
        } finally {
            DBContext.closeConnection(conn);
        }
        return null;
    }

    public Discount getDiscountByProductId(int pid) {
        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            if (conn != null) {
                String sql = "SELECT [discount_id]\n"
                        + "      ,[product_id]\n"
                        + "      ,[title]\n"
                        + "      ,[description]\n"
                        + "      ,[discount_value]\n"
                        + "      ,[created_by]\n"
                        + "      ,[modified_by]\n"
                        + "      ,[created_at]\n"
                        + "      ,[modified_at]\n"
                        + "      ,[expiry]\n"
                        + "      ,[status]\n"
                        + "  FROM [dbo].[discount] WHERE [product_id] = ?";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setInt(1, pid);
                    try (ResultSet rs = stmt.executeQuery()) {
                        if (rs.next()) {
                            return new Discount(
                                    rs.getInt("discount_id"),
                                    rs.getInt("product_id"),
                                    rs.getString("title"),
                                    rs.getString("description"),
                                    rs.getFloat("discount_value"),
                                    rs.getInt("created_by"),
                                    rs.getInt("modified_by"),
                                    rs.getDate("created_at"),
                                    rs.getDate("modified_at"),
                                    rs.getTimestamp("expiry").toLocalDateTime(),
                                    rs.getBoolean("status")
                            );
                        }
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error getting discount", e);
        } finally {
            DBContext.closeConnection(conn);
        }
        return null;
    }

    public Discount getDiscountByTitle(String title) {
        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            if (conn != null) {
                String sql = "SELECT [discount_id]\n"
                        + "      ,[product_id]\n"
                        + "      ,[title]\n"
                        + "      ,[description]\n"
                        + "      ,[discount_value]\n"
                        + "      ,[created_by]\n"
                        + "      ,[modified_by]\n"
                        + "      ,[created_at]\n"
                        + "      ,[modified_at]\n"
                        + "      ,[expiry]\n"
                        + "      ,[status]\n"
                        + "  FROM [dbo].[discount] WHERE [title] = ?";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setString(1, title);
                    try (ResultSet rs = stmt.executeQuery()) {
                        if (rs.next()) {
                            return new Discount(
                                    rs.getInt("discount_id"),
                                    rs.getInt("product_id"),
                                    rs.getString("title"),
                                    rs.getString("description"),
                                    rs.getFloat("discount_value"),
                                    rs.getInt("created_by"),
                                    rs.getInt("modified_by"),
                                    rs.getDate("created_at"),
                                    rs.getDate("modified_at"),
                                    rs.getTimestamp("expiry").toLocalDateTime(),
                                    rs.getBoolean("status")
                            );
                        }
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error getting discount", e);
        } finally {
            DBContext.closeConnection(conn);
        }
        return null;
    }

    public List<Discount> getListDiscountByPage(List<Discount> list, int start, int end) {
        List<Discount> discounts = new ArrayList<>();
        for (int i = start; i < end; i++) {
            discounts.add(list.get(i));
        }
        return discounts;
    }

    public List<Discount> getListDiscountMultipleFilter(String title,
            String discountvaluefrom,
            String discountvalueto,
            String sortchoice,
            String createdAtFrom,
            String createdAtTo,
            String modifiedAtFrom,
            String modifiedAtTo,
            String createdBy,
            String modifiedBy,
            String expiryfrom,
            String expiryto) throws SQLException {
        List<Discount> discounts = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT [discount_id]\n"
                    + "      ,[product_id]\n"
                    + "      ,[title]\n"
                    + "      ,[description]\n"
                    + "      ,[discount_value]\n"
                    + "      ,[created_by]\n"
                    + "      ,[modified_by]\n"
                    + "      ,[created_at]\n"
                    + "      ,[modified_at]\n"
                    + "      ,[expiry]\n"
                    + "      ,[status]\n"
                    + "  FROM [dbo].[discount] WHERE 1 = 1";
            List<Object> values = new ArrayList<>();
            if (title != null && !title.isEmpty()) {
                title = title.trim().replaceAll("\\s+", " ");
                String[] titlee = title.split(" ");
                sql += " AND ( ";
                for (int i = 0; i < titlee.length; i++) {
                    if (i > 0) {
                        sql += " OR ";
                    }
                    sql += " [title] LIKE ? ";
                    values.add("%" + titlee[i] + "%");
                }
                sql += " ) ";
            }
            if (discountvaluefrom != null && !discountvaluefrom.isEmpty()) {
                sql += " AND [discount_value] >= ? ";
                values.add(discountvaluefrom);
            } else if (discountvalueto != null && !discountvalueto.isEmpty()) {
                sql += " AND [discount_value] <= ? ";
                values.add(discountvalueto);
            } else if (discountvaluefrom != null && !discountvaluefrom.isEmpty()
                    && discountvalueto != null && !discountvalueto.isEmpty()) {
                sql += " AND [discount_value] BETWEEN ? AND ? ";
                values.add(discountvaluefrom);
                values.add(discountvalueto);
            }
            if (createdAtFrom != null && !createdAtFrom.isEmpty()) {
                sql += " AND [created_at] >= ? ";
                values.add(createdAtFrom);
            } else if (createdAtTo != null && !createdAtTo.isEmpty()) {
                sql += " AND [created_at] <= ? ";
                values.add(createdAtTo);
            } else if (createdAtFrom != null && !createdAtFrom.isEmpty()
                    && createdAtTo != null && !createdAtTo.isEmpty()) {
                sql += " AND [created_at] BETWEEN ? AND ? ";
                values.add(createdAtFrom);
                values.add(createdAtTo);
            }
            if (modifiedAtFrom != null && !modifiedAtFrom.isEmpty()) {
                sql += " AND [modified_at] >= ? ";
                values.add(modifiedAtFrom);
            } else if (modifiedAtTo != null && !modifiedAtTo.isEmpty()) {
                sql += " AND [modified_at] <= ? ";
                values.add(modifiedAtTo);
            } else if (modifiedAtFrom != null && !modifiedAtFrom.isEmpty()
                    && modifiedAtTo != null && !modifiedAtTo.isEmpty()) {
                sql += " AND [modified_at] BETWEEN ? AND ? ";
                values.add(modifiedAtFrom);
                values.add(modifiedAtTo);
            }
            if (expiryfrom != null && !expiryfrom.isEmpty()){
                sql += " AND [expiry] >= ? ";
                values.add(expiryfrom);
            }else if (expiryto != null && !expiryto.isEmpty()){
                sql += " AND [expiry] <= ? ";
                values.add(expiryto);
            }else if (expiryfrom != null && !expiryfrom.isEmpty()
                    && expiryto != null && !expiryto.isEmpty()){
                sql += " AND [expiry] BETWEEN ? AND ?";
                values.add(expiryfrom);
                values.add(expiryto);
            }
            if (createdBy != null && !createdBy.isEmpty()) {
                createdBy = createdBy.trim().replaceAll("\\s+", " ");
                List<Manager> managerscreated = WebManager.getInstance().managerDAO.getManagerByPartName(createdBy);
                if (managerscreated != null && !managerscreated.isEmpty()) {
                    sql += " AND  ( ";
                    for (int i = 0; i < managerscreated.size(); i++) {
                        if (i > 0) {
                            sql += " OR ";
                        }
                        sql += " [created_by] = ? ";
                        values.add(managerscreated.get(i).getManagerId());
                    }
                    sql += ")";
                } else {
                    sql += " AND 1 = 0 ";
                }
            }
            if (modifiedBy != null && !modifiedBy.isEmpty()) {
                modifiedBy = modifiedBy.trim().replaceAll("\\s+", " ");
                List<Manager> managersmodified = WebManager.getInstance().managerDAO.getManagerByPartName(modifiedBy);
                if (managersmodified != null && !managersmodified.isEmpty()) {
                    sql += " AND ( ";
                    for (int i = 0; i < managersmodified.size(); i++) {
                        if (i > 0) {
                            sql += " OR";
                        }
                        sql += " [modified_by] = ? ";
                    }
                    sql += ")";
                } else {
                    sql += " AND 1 = 0 ";
                }
            }
            if (sortchoice != null && !sortchoice.isEmpty()) {
                switch (sortchoice) {
                    case "Increase":
                        sql += " ORDER BY [discount_value] ASC ";
                        break;
                    case "Decrease":
                        sql += " ORDER BY [discount_value] DESC ";
                        break;
                }
            }
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            for (int i = 0; i < values.size(); i++) {
                ps.setObject(i + 1, values.get(i));
            }
            rs = ps.executeQuery();
            while (rs.next()) {
                discounts.add(new Discount(
                                    rs.getInt("discount_id"),
                                    rs.getInt("product_id"),
                                    rs.getString("title"),
                                    rs.getString("description"),
                                    rs.getFloat("discount_value"),
                                    rs.getInt("created_by"),
                                    rs.getInt("modified_by"),
                                    rs.getDate("created_at"),
                                    rs.getDate("modified_at"),
                                    rs.getTimestamp("expiry").toLocalDateTime(),
                                    rs.getBoolean("status")
                            ));
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error getting list discount", e);
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                DBContext.closeConnection(conn);
            }
        }
        return discounts;
    }

    public List<Discount> getAllDiscounts() {
        List<Discount> discounts = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            if (conn != null) {
                String sql = "SELECT * FROM discount";
                try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
                    while (rs.next()) {
                        discounts.add(new Discount(
                                    rs.getInt("discount_id"),
                                    rs.getInt("product_id"),
                                    rs.getString("title"),
                                    rs.getString("description"),
                                    rs.getFloat("discount_value"),
                                    rs.getInt("created_by"),
                                    rs.getInt("modified_by"),
                                    rs.getDate("created_at"),
                                    rs.getDate("modified_at"),
                                    rs.getTimestamp("expiry").toLocalDateTime(),
                                    rs.getBoolean("status")
                            ));
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error getting all discounts", e);
        } finally {
            DBContext.closeConnection(conn);
        }
        return discounts;
    }

    public void updateDiscount(Discount discount) {
        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            if (conn != null) {
                String sql = "UPDATE discount SET product_id = ?,"
                        + " title = ?,"
                        + " description = ?,"
                        + " discount_value = ?,"
                        + " created_by = ?,"
                        + " modified_by = ?,"
                        + " created_at = ?,"
                        + " modified_at = ?,"
                        + " expiry = ?"
                        + " WHERE discount_id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setInt(1, discount.getProductId());
                    stmt.setString(2, discount.getTitle());
                    stmt.setString(3, discount.getDescription());
                    stmt.setFloat(4, discount.getDiscountValue());
                    stmt.setInt(5, discount.getCreatedBy());
                    stmt.setInt(6, discount.getModifiedBy());
                    stmt.setDate(7, new java.sql.Date(discount.getCreatedAt().getTime()));
                    stmt.setDate(8, new java.sql.Date(discount.getModifiedAt().getTime()));
                    stmt.setTimestamp(9, java.sql.Timestamp.valueOf(discount.getExpiry()));
                    stmt.setInt(10, discount.getDiscountId());
                    stmt.executeUpdate();
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error updating discount", e);
        } finally {
            DBContext.closeConnection(conn);
        }
    }

    public boolean changeDiscount(Discount discount) {
        Connection conn = null;
        boolean updated = false;
        try {
            conn = DBContext.getConnection();
            if (conn != null) {
                String sql = "UPDATE discount SET product_id = ?,"
                        + " title = ?,"
                        + " description = ?,"
                        + " discount_value = ?,"
                        + " created_by = ?,"
                        + " modified_by = ?,"
                        + " created_at = ?,"
                        + " modified_at = ?,"
                        + " expiry = ?,"
                        + " status = ? "
                        + " WHERE discount_id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    if (discount.getProductId() == 0){
                        stmt.setNull(1, discount.getProductId());
                    }else{
                        stmt.setInt(1, discount.getProductId());
                    }
                    stmt.setString(2, discount.getTitle());
                    stmt.setString(3, discount.getDescription());
                    stmt.setFloat(4, discount.getDiscountValue());
                    stmt.setInt(5, discount.getCreatedBy());
                    stmt.setInt(6, discount.getModifiedBy());
                    stmt.setDate(7, new java.sql.Date(discount.getCreatedAt().getTime()));
                    stmt.setDate(8, new java.sql.Date(discount.getModifiedAt().getTime()));
                    stmt.setTimestamp(9, java.sql.Timestamp.valueOf(discount.getExpiry()));
                    stmt.setBoolean(10, discount.isStatus());
                    stmt.setInt(11, discount.getDiscountId());
                    updated = stmt.executeUpdate() > 0;
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error updating discount", e);
        } finally {
            DBContext.closeConnection(conn);
        }
        return updated;
    }

    public void updateDiscountProductIdToNull(int productId) throws SQLException {
        String sql = "UPDATE discount SET product_id = NULL WHERE product_id = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = DBContext.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, productId);
            stmt.executeUpdate();
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } finally {
            if (stmt != null) {
                stmt.close();
            }
            if (conn != null) {
                DBContext.closeConnection(conn);
            }
        }
    }
    
    public void updateStatusDiscount(Discount discount) throws SQLException {
        String sql = "UPDATE discount SET [status] = ? WHERE discount_id = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = DBContext.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setBoolean(1, discount.isStatus());
            stmt.setInt(2, discount.getDiscountId());
            stmt.executeUpdate();
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } finally {
            if (stmt != null) {
                stmt.close();
            }
            if (conn != null) {
                DBContext.closeConnection(conn);
            }
        }
    }

    public void deleteDiscount(int discountId) {
        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            if (conn != null) {
                String sql = "DELETE FROM discount WHERE discount_id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setInt(1, discountId);
                    stmt.executeUpdate();
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error deleting discount", e);
        } finally {
            DBContext.closeConnection(conn);
        }
    }

}
