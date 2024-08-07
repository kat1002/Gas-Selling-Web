/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.model.DAO;

/**
 *
 * @author kat1002
 */
import com.model.Voucher;
import com.utils.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class VoucherDAO {

    private Logger LOGGER = Logger.getLogger(ProductDAO.class.getName());

    public VoucherDAO() throws SQLException, ClassNotFoundException {

    }

    public void addVoucher(Voucher voucher) {
        String sql = "INSERT INTO voucher (voucher_code, title, description, discount_type, discount_value, condition, quantity, created_by, modified_by, created_at, modified_on, expiry, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, GETDATE(), GETDATE(), ?, ?)";
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DBContext.getConnection();
            stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            stmt.setString(1, voucher.getVoucherCode());
            stmt.setString(2, voucher.getTitle());
            stmt.setString(3, voucher.getDescription());
            stmt.setInt(4, voucher.getDiscountType());
            stmt.setFloat(5, voucher.getDiscountValue());
            stmt.setFloat(6, voucher.getCondition());
            stmt.setInt(7, voucher.getQuantity());
            stmt.setInt(8, voucher.getCreatedBy());
            stmt.setInt(9, voucher.getModifiedBy());
            stmt.setDate(10, new java.sql.Date(voucher.getExpiry().getTime()));
            stmt.setBoolean(11, voucher.isStatus());
            stmt.executeUpdate();

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    voucher.setVoucherId(generatedKeys.getInt(1));
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error adding voucher", e);
        } finally {
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                    LOGGER.log(Level.SEVERE, "Error closing PreparedStatement", e);
                }
            }
            if (conn != null) {
                DBContext.closeConnection(conn);
            }
        }
    }

    public Voucher getVoucher(int voucherId) {
        String sql = "SELECT * FROM voucher WHERE voucher_id = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBContext.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, voucherId);

            rs = stmt.executeQuery();

            if (rs.next()) {
                return new Voucher(
                        rs.getInt("voucher_id"),
                        rs.getString("title"),
                        rs.getString("voucher_code"),
                        rs.getString("description"),
                        rs.getInt("discount_type"),
                        rs.getFloat("discount_value"),
                        rs.getFloat("condition"),
                        rs.getInt("quantity"),
                        rs.getInt("created_by"),
                        rs.getInt("modified_by"),
                        rs.getDate("created_at"),
                        rs.getDate("modified_on"),
                        rs.getDate("expiry"),
                        rs.getBoolean("status")
                );
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving voucher", e);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    LOGGER.log(Level.SEVERE, "Error closing ResultSet", e);
                }
            }
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                    LOGGER.log(Level.SEVERE, "Error closing PreparedStatement", e);
                }
            }
            if (conn != null) {
                DBContext.closeConnection(conn);
            }
        }
        return null;
    }

    public List<Voucher> getVoucherByFilter(String[] searchTermsCode, String[] searchTermsTitle, int createdBy, int modifiedBy, Date dateCreateFrom, Date dateCreateTo, Date dateModifyFrom, Date dateModifyTo, Boolean status) {
        List<Voucher> vouchers = new ArrayList<>();
        Connection connection = null;
        StringBuilder sqlBuilder = new StringBuilder("SELECT * FROM voucher WHERE 1=1");

        if (searchTermsCode != null && searchTermsCode.length > 0) {
            sqlBuilder.append(" AND (");
            for (int i = 0; i < searchTermsCode.length; i++) {
                if (i > 0) {
                    sqlBuilder.append(" OR ");
                }
                sqlBuilder.append("voucher_code LIKE ?");
            }
            sqlBuilder.append(")");
        }

        if (searchTermsTitle != null && searchTermsTitle.length > 0) {
            sqlBuilder.append(" AND (");
            for (int i = 0; i < searchTermsTitle.length; i++) {
                if (i > 0) {
                    sqlBuilder.append(" OR ");
                }
                sqlBuilder.append("title LIKE ?");
            }
            sqlBuilder.append(")");
        }

        if (dateCreateFrom != null) {
            sqlBuilder.append(" AND created_at >= ?");
        }

        if (dateCreateTo != null) {
            sqlBuilder.append(" AND created_at <= ?");
        }

        if (dateModifyFrom != null) {
            sqlBuilder.append(" AND modified_on >= ?");
        }

        if (dateModifyTo != null) {
            sqlBuilder.append(" AND modified_on <= ?");
        }

        if (createdBy > 0) {
            sqlBuilder.append(" AND created_by = ?");
        }

        if (modifiedBy > 0) {
            sqlBuilder.append(" AND modified_by = ?");
        }

        if (status != null) {
            sqlBuilder.append(" AND status = ?");
        }
        sqlBuilder.append(" ORDER BY created_at DESC, voucher_id DESC");

        try {
            connection = DBContext.getConnection(); // Get connection
            PreparedStatement stmt = connection.prepareStatement(sqlBuilder.toString());

            int index = 1;
            if (searchTermsCode != null) {
                for (String term : searchTermsCode) {
                    stmt.setString(index++, "%" + term + "%");
                }
            }

            if (searchTermsTitle != null) {
                for (String term : searchTermsTitle) {
                    stmt.setString(index++, "%" + term + "%");
                }
            }

            if (dateCreateFrom != null) {
                stmt.setDate(index++, new java.sql.Date(dateCreateFrom.getTime()));
            }

            if (dateCreateTo != null) {
                stmt.setDate(index++, new java.sql.Date(dateCreateTo.getTime()));
            }

            if (dateModifyFrom != null) {
                stmt.setDate(index++, new java.sql.Date(dateModifyFrom.getTime()));
            }

            if (dateModifyTo != null) {
                stmt.setDate(index++, new java.sql.Date(dateModifyTo.getTime()));
            }

            if (createdBy > 0) {
                stmt.setInt(index++, createdBy);
            }

            if (modifiedBy > 0) {
                stmt.setInt(index++, modifiedBy);
            }

            if (status != null) {
                stmt.setInt(index++, status ? 1 : 0);
            }
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    vouchers.add(new Voucher(
                            rs.getInt("voucher_id"),
                            rs.getString("title"),
                            rs.getString("voucher_code"),
                            rs.getString("description"),
                            rs.getInt("discount_type"),
                            rs.getFloat("discount_value"),
                            rs.getFloat("condition"),
                            rs.getInt("quantity"),
                            rs.getInt("created_by"),
                            rs.getInt("modified_by"),
                            rs.getDate("created_at"),
                            rs.getDate("modified_on"),
                            rs.getDate("expiry"),
                            rs.getBoolean("status")
                    ));
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error getting news with filters", e);
        } finally {
            DBContext.closeConnection(connection); // Close connection in finally block
        }

        return vouchers;
    }

    public List<Voucher> getAllVouchers() {
        List<Voucher> vouchers = new ArrayList<>();
        String sql = "SELECT [voucher_id] FROM [dbo].[voucher]";
        Connection conn = null;
        try {
            conn = DBContext.getConnection(); // Obtain the connection
            try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
                while (rs.next()) {
                    vouchers.add(getVoucher(rs.getInt("voucher_id")));
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving vouchers", e);
        } finally {
            if (conn != null) {
                DBContext.closeConnection(conn); // Close the connection
            }
        }
        return vouchers;
    }

    public List<Voucher> getListVouchersAvailable() {
        List<Voucher> vouchers = new ArrayList<>();
        String sql = "SELECT [voucher_id]\n"
                + "      ,[voucher_code]\n"
                + "      ,[title]\n"
                + "      ,[description]\n"
                + "      ,[discount_type]\n"
                + "      ,[discount_value]\n"
                + "      ,[condition]\n"
                + "      ,[quantity]\n"
                + "      ,[created_by]\n"
                + "      ,[modified_by]\n"
                + "      ,[created_at]\n"
                + "      ,[modified_on]\n"
                + "      ,[expiry]\n"
                + "      ,[status]\n"
                + "  FROM [dbo].[voucher] WHERE [status] = 1";
        Connection conn = null;
        try {
            conn = DBContext.getConnection(); // Obtain the connection
            try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
                while (rs.next()) {
                    vouchers.add(new Voucher(
                            rs.getInt("voucher_id"),
                            rs.getString("title"),
                            rs.getString("voucher_code"),
                            rs.getString("description"),
                            rs.getInt("discount_type"),
                            rs.getFloat("discount_value"),
                            rs.getFloat("condition"),
                            rs.getInt("quantity"),
                            rs.getInt("created_by"),
                            rs.getInt("modified_by"),
                            rs.getDate("created_at"),
                            rs.getDate("modified_on"),
                            rs.getDate("expiry"),
                            rs.getBoolean("status")
                    ));
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving vouchers", e);
        } finally {
            if (conn != null) {
                DBContext.closeConnection(conn); // Close the connection
            }
        }
        return vouchers;
    }

    public void updateVoucher(Voucher voucher) {
        String sql = "UPDATE voucher SET voucher_code = ?, title = ?, description = ?, discount_type = ?, discount_value = ?, condition = ?, quantity = ?, created_by = ?, modified_by = ?, created_at = ?, modified_on = GETDATE(), expiry = ?, status = ? WHERE voucher_id = ?";
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DBContext.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, voucher.getVoucherCode());
            stmt.setString(2, voucher.getTitle());
            stmt.setString(3, voucher.getDescription());
            stmt.setInt(4, voucher.getDiscountType());
            stmt.setFloat(5, voucher.getDiscountValue());
            stmt.setFloat(6, voucher.getCondition());
            stmt.setInt(7, voucher.getQuantity());
            stmt.setInt(8, voucher.getCreatedBy());
            stmt.setInt(9, voucher.getModifiedBy());
            stmt.setDate(10, new java.sql.Date(voucher.getCreatedAt().getTime()));
            stmt.setDate(11, new java.sql.Date(voucher.getExpiry().getTime()));
            stmt.setBoolean(12, voucher.isStatus());
            stmt.setInt(13, voucher.getVoucherId());
            stmt.executeUpdate();
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error updating voucher", e);
        } finally {
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                    LOGGER.log(Level.SEVERE, "Error closing PreparedStatement", e);
                }
            }
            if (conn != null) {
                DBContext.closeConnection(conn);
            }
        }
    }

    public void reduceVoucherQuantity(int voucherid, int amount) {
        String sql = "UPDATE [dbo].[voucher]\n"
                + "   SET [quantity] = [quantity] - ?\n"
                + " WHERE voucher_id = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = DBContext.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, amount);
            stmt.setInt(2, voucherid);
            stmt.executeUpdate();
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error deleting voucher", e);
        } finally {
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                    LOGGER.log(Level.SEVERE, "Error closing PreparedStatement", e);
                }
            }
            if (conn != null) {
                DBContext.closeConnection(conn);
            }
        }
    }

    public void deleteVoucher(int voucherId) {
        String sql = "DELETE FROM voucher WHERE voucher_id = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = DBContext.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, voucherId);
            stmt.executeUpdate();
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error deleting voucher", e);
        } finally {
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                    LOGGER.log(Level.SEVERE, "Error closing PreparedStatement", e);
                }
            }
            if (conn != null) {
                DBContext.closeConnection(conn);
            }
        }
    }

    public Voucher getVoucherByCode(String code) {
        String sql = "SELECT * FROM voucher WHERE voucher_code = ? AND [status] = 1";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBContext.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, code);

            rs = stmt.executeQuery();

            if (rs.next()) {
                return new Voucher(
                        rs.getInt("voucher_id"),
                        rs.getString("voucher_code"),
                        rs.getString("title"),
                        rs.getString("description"),
                        rs.getInt("discount_type"),
                        rs.getFloat("discount_value"),
                        rs.getFloat("condition"),
                        rs.getInt("quantity"),
                        rs.getInt("created_by"),
                        rs.getInt("modified_by"),
                        rs.getDate("created_at"),
                        rs.getDate("modified_on"),
                        rs.getDate("expiry"),
                        rs.getBoolean("status")
                );
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving voucher", e);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    LOGGER.log(Level.SEVERE, "Error closing ResultSet", e);
                }
            }
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                    LOGGER.log(Level.SEVERE, "Error closing PreparedStatement", e);
                }
            }
            if (conn != null) {
                DBContext.closeConnection(conn);
            }
        }
        return null;
    }

    public Voucher getNewestVoucher() {
        String sql = "SELECT TOP 1 [voucher_id]\n"
                + "      ,[voucher_code]\n"
                + "      ,[title]\n"
                + "      ,[description]\n"
                + "      ,[discount_type]\n"
                + "      ,[discount_value]\n"
                + "      ,[condition]\n"
                + "      ,[quantity]\n"
                + "      ,[created_by]\n"
                + "      ,[modified_by]\n"
                + "      ,[created_at]\n"
                + "      ,[modified_on]\n"
                + "      ,[expiry]\n"
                + "      ,[status]\n"
                + "  FROM [dbo].[voucher] ORDER BY voucher_id DESC";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = DBContext.getConnection();
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();

            if (rs.next()) {
                return new Voucher(
                        rs.getInt("voucher_id"),
                        rs.getString("voucher_code"),
                        rs.getString("title"),
                        rs.getString("description"),
                        rs.getInt("discount_type"),
                        rs.getFloat("discount_value"),
                        rs.getFloat("condition"),
                        rs.getInt("quantity"),
                        rs.getInt("created_by"),
                        rs.getInt("modified_by"),
                        rs.getDate("created_at"),
                        rs.getDate("modified_on"),
                        rs.getDate("expiry"),
                        rs.getBoolean("status")
                );
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving voucher", e);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    LOGGER.log(Level.SEVERE, "Error closing ResultSet", e);
                }
            }
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                    LOGGER.log(Level.SEVERE, "Error closing PreparedStatement", e);
                }
            }
            if (conn != null) {
                DBContext.closeConnection(conn);
            }
        }
        return null;
    }
//        public static void main(String[] args) throws SQLException, ClassNotFoundException {
//        VoucherDAO d = new VoucherDAO();
//        for(Voucher v: d.getAllVouchers()){
//            System.out.println(v.getExpiry());
//        }
//    }
}
