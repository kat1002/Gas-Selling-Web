/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.model.DAO;

import com.model.Warranty;
import java.sql.SQLException;
import java.sql.*;
import java.util.logging.Logger;
import com.utils.DBContext;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;

/**
 *
 * @author kirit
 */
public class WarrantyDAO {

    private Logger LOGGER = Logger.getLogger(ProductDAO.class.getName());

    public WarrantyDAO() throws SQLException, ClassNotFoundException {
    }

//    public void addWarrantyImage(int warrantyId, String url) throws SQLException {
//        String sql = "INSERT INTO warranty_image (warranty_id, url) VALUES (?, ?)";
//        Connection conn = null;
//        PreparedStatement statement = null;
//
//        try {
//            conn = DBContext.getConnection(); // Obtain the connection
//            statement = conn.prepareStatement(sql);
//            statement.setInt(1, warrantyId);
//            statement.setString(2, url);
//            statement.executeUpdate();
//        } catch (SQLException | ClassNotFoundException e) {
//            e.printStackTrace();
//        } finally {
//            if (statement != null) {
//                statement.close();
//            }
//            if (conn != null) {
//                DBContext.closeConnection(conn); // Close the connection
//            }
//        }
//    }
    public boolean insertWarranty(Warranty warranty) throws SQLException {
        String sql = "INSERT INTO warranty (serialNumber_id, manager_id, warranty_type, guarantee_date, status, isDone,warranty_image,created_by,modified_by,created_at,modified_at) VALUES (?, ?, ?, ?, ?, ?, ?,?,?,GETDATE(),GETDATE())";

        Connection conn = null;
        PreparedStatement statement = null;
        boolean rowInserted = false;

        try {
            conn = DBContext.getConnection(); // Obtain the connection
            statement = conn.prepareStatement(sql);

            statement.setInt(1, warranty.getSerialNumberId());
            statement.setInt(2, warranty.getManagerId());
            statement.setInt(3, warranty.getWarrantyType());
            statement.setDate(4, new java.sql.Date(warranty.getGuaranteeDate().getTime()));
            statement.setString(5, warranty.getStatus());
            statement.setBoolean(6, warranty.isIsDone());
            statement.setString(7, warranty.getImages());
            statement.setInt(8, warranty.getCreatedBy());
            statement.setInt(9, warranty.getModifiedBy());
            rowInserted = statement.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        } finally {
            if (statement != null) {
                statement.close();
            }
            if (conn != null) {
                DBContext.closeConnection(conn); // Close the connection
            }
        }

        return rowInserted;
    }

    public List<Warranty> listAllWarranties() throws SQLException {
        List<Warranty> warrantyList = new ArrayList<Warranty>();
        String sql = "SELECT * FROM warranty";
        Connection conn = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            conn = DBContext.getConnection(); // Obtain the connection
            statement = conn.prepareStatement(sql);
            resultSet = statement.executeQuery();

            while (resultSet.next()) {
                warrantyList.add(
                        new Warranty(resultSet.getInt("warranty_id"),
                                resultSet.getInt("serialNumber_id"),
                                resultSet.getInt("manager_id"),
                                resultSet.getInt("warranty_type"),
                                resultSet.getDate("guarantee_date"),
                                resultSet.getString("status"),
                                resultSet.getBoolean("isDone"),
                                resultSet.getString("warranty_image"),
                                resultSet.getDate("created_at"),
                                resultSet.getDate("modified_at"),
                                resultSet.getInt("created_by"),
                                resultSet.getInt("modified_by")));
            }
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } finally {
            if (resultSet != null) {
                resultSet.close();
            }
            if (statement != null) {
                statement.close();
            }
            if (conn != null) {
                DBContext.closeConnection(conn); // Close the connection
            }
        }

        return warrantyList;
    }

    public Warranty getWarranty(int warrantyId) throws SQLException {
        Warranty warranty = null;
        String sql = "SELECT * FROM warranty WHERE warranty_id = ?";

        Connection conn = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            conn = DBContext.getConnection(); // Obtain the connection
            statement = conn.prepareStatement(sql);
            statement.setInt(1, warrantyId);
            resultSet = statement.executeQuery();

            if (resultSet.next()) {
                warranty = new Warranty();
                warranty.setWarrantyId(resultSet.getInt("warranty_id"));
                warranty.setSerialNumberId(resultSet.getInt("serialNumber_id"));
                warranty.setManagerId(resultSet.getInt("manager_id"));
                warranty.setWarrantyType(resultSet.getInt("warranty_type"));
                warranty.setGuaranteeDate(resultSet.getDate("guarantee_date"));
                warranty.setStatus(resultSet.getString("status"));
                warranty.setIsDone(resultSet.getBoolean("isDone"));
                warranty.setImages(resultSet.getString("warranty_image"));
                warranty.setCreatedAt(resultSet.getDate("created_at"));
                warranty.setCreatedBy(resultSet.getInt("created_by"));
                warranty.setModifiedAt(resultSet.getDate("modified_at"));
                warranty.setModifiedBy(resultSet.getInt("modified_by"));
            }
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } finally {
            if (resultSet != null) {
                resultSet.close();
            }
            if (statement != null) {
                statement.close();
            }
            if (conn != null) {
                DBContext.closeConnection(conn); // Close the connection
            }
        }

        return warranty;
    }

//    private List<String> getWarrantyImages(int warrantyId) throws SQLException {
//        List<String> images = new ArrayList<>();
//        String sql = "SELECT url FROM warranty_image WHERE warranty_id = ?";
//
//        Connection conn = null;
//        PreparedStatement statement = null;
//        ResultSet resultSet = null;
//
//        try {
//            conn = DBContext.getConnection(); // Obtain the connection
//            statement = conn.prepareStatement(sql);
//            statement.setInt(1, warrantyId);
//            resultSet = statement.executeQuery();
//
//            while (resultSet.next()) {
//                images.add(resultSet.getString("url"));
//            }
//        } catch (ClassNotFoundException e) {
//            throw new RuntimeException(e);
//        } finally {
//            if (resultSet != null) {
//                resultSet.close();
//            }
//            if (statement != null) {
//                statement.close();
//            }
//            if (conn != null) {
//                DBContext.closeConnection(conn); // Close the connection
//            }
//        }
//
//        return images;
//    }
//    public boolean deleteWarrantyImages(int warrantyId) throws SQLException {
//        String sql = "DELETE FROM warranty_image WHERE warranty_id = ?";
//        boolean rowDeleted = false;
//        Connection conn = null;
//        PreparedStatement statement = null;
//
//        try {
//            conn = DBContext.getConnection();
//            statement = conn.prepareStatement(sql);
//            statement.setInt(1, warrantyId);
//            rowDeleted = statement.executeUpdate() > 0;
//        } catch (ClassNotFoundException e) {
//            throw new RuntimeException(e);
//        } finally {
//            if (statement != null) {
//                statement.close();
//            }
//            if (conn != null) {
//                DBContext.closeConnection(conn); // Close the connection
//            }
//        }
//
//        return rowDeleted;
//    }
    public void deleteWarranty(int warrantyId) {
        String sql = "DELETE FROM warranty WHERE warranty_id = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = DBContext.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, warrantyId);
            stmt.executeUpdate();
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error deleting warranty", e);
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

    public void updateWarranty(Warranty warranty) {
        Connection conn = null;
        PreparedStatement statement = null;

        try {
            conn = DBContext.getConnection();
            String sql = "UPDATE warranty SET serialNumber_id = ?, manager_id = ?, warranty_type = ?, guarantee_date = ?, status = ?, isDone = ?,warranty_image=?,modified_by=?,modified_at = GETDATE() WHERE warranty_id = ?";
            statement = conn.prepareStatement(sql);
            statement.setInt(1, warranty.getSerialNumberId());
            statement.setInt(2, warranty.getManagerId());
            statement.setInt(3, warranty.getWarrantyType());
            statement.setDate(4, new java.sql.Date(warranty.getGuaranteeDate().getTime()));
            statement.setString(5, warranty.getStatus());
            statement.setBoolean(6, warranty.isIsDone());
            statement.setString(7, warranty.getImages());
            statement.setInt(8, warranty.getModifiedBy());
            statement.setInt(9, warranty.getWarrantyId());
            statement.executeUpdate();
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error update news", e);
        } finally {
            DBContext.closeConnection(conn); // Close connection in finally block
        }
    }

    public List<Warranty> getWarrantyByFilter(int serialNumberId, String[] searchTermsStatus,
            int managerId, int warrantyType, Date guaranteeDate, Boolean isDone,
            int createdBy, int modifiedBy, Date createDateFrom, Date createDateTo,
            Date modifyDateFrom, Date modifyDateTo) throws SQLException, ClassNotFoundException {

        Connection connection = null;
        List<Warranty> warrantyList = new ArrayList<>();
        StringBuilder sqlBuilder = new StringBuilder("SELECT * FROM warranty WHERE 1=1");

        if (searchTermsStatus != null && searchTermsStatus.length > 0) {
            sqlBuilder.append(" AND (");
            for (int i = 0; i < searchTermsStatus.length; i++) {
                if (i > 0) {
                    sqlBuilder.append(" OR ");
                }
                sqlBuilder.append("status LIKE ?");
            }
            sqlBuilder.append(")");
        }

        if (managerId > 0) {
            sqlBuilder.append(" AND manager_id = ?");
        }

        if (serialNumberId > 0) {
            sqlBuilder.append(" AND serialNumber_id = ?");
        }

        if (warrantyType > 0) {
            sqlBuilder.append(" AND warranty_type = ?");
        }

        if (guaranteeDate != null) {
            sqlBuilder.append(" AND guarantee_date = ?");
        }

        if (isDone != null) {
            sqlBuilder.append(" AND isDone = ?");
        }

        if (createdBy > 0) {
            sqlBuilder.append(" AND created_by = ?");
        }

        if (modifiedBy > 0) {
            sqlBuilder.append(" AND modified_by = ?");
        }

        if (createDateFrom != null) {
            sqlBuilder.append(" AND created_at >= ?");
        }

        if (createDateTo != null) {
            sqlBuilder.append(" AND created_at <= ?");
        }

        if (modifyDateFrom != null) {
            sqlBuilder.append(" AND modified_at >= ?");
        }

        if (modifyDateTo != null) {
            sqlBuilder.append(" AND modified_at <= ?");
        }

        // Order by clause
        sqlBuilder.append(" ORDER BY warranty_id DESC");

        try {
            connection = DBContext.getConnection(); // Get connection
            PreparedStatement stmt = connection.prepareStatement(sqlBuilder.toString());

            int index = 1;

            if (searchTermsStatus != null) {
                for (String term : searchTermsStatus) {
                    stmt.setString(index++, "%" + term + "%");
                }
            }

            if (managerId > 0) {
                stmt.setInt(index++, managerId);
            }

            if (serialNumberId > 0) {
                stmt.setInt(index++, serialNumberId);
            }

            if (warrantyType > 0) {
                stmt.setInt(index++, warrantyType);
            }

            if (guaranteeDate != null) {
                stmt.setDate(index++, guaranteeDate);
            }

            if (isDone != null) {
                stmt.setBoolean(index++, isDone);
            }

            if (createdBy > 0) {
                stmt.setInt(index++, createdBy);
            }

            if (modifiedBy > 0) {
                stmt.setInt(index++, modifiedBy);
            }

            if (createDateFrom != null) {
                stmt.setDate(index++, createDateFrom);
            }

            if (createDateTo != null) {
                stmt.setDate(index++, createDateTo);
            }

            if (modifyDateFrom != null) {
                stmt.setDate(index++, modifyDateFrom);
            }

            if (modifyDateTo != null) {
                stmt.setDate(index++, modifyDateTo);
            }

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    warrantyList.add(new Warranty(rs.getInt("warranty_id"),
                            rs.getInt("serialNumber_id"),
                            rs.getInt("manager_id"),
                            rs.getInt("warranty_type"),
                            rs.getDate("guarantee_date"),
                            rs.getString("status"),
                            rs.getBoolean("isDone"),
                            rs.getString("warranty_image"),
                            rs.getDate("created_at"),
                            rs.getDate("modified_at"),
                            rs.getInt("created_by"),
                            rs.getInt("modified_by")));
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error getting warranty with filters", e);
        } finally {
            DBContext.closeConnection(connection); // Close connection in finally block
        }
        return warrantyList;
    }

//    public static void main(String[] args) throws SQLException, ClassNotFoundException {
//        WarrantyDAO d = new WarrantyDAO();
//        Warranty w = d.getWarranty(1);
//        w.setStatus("Siuuuu");
//        d.updateWarranty(w);
//    }
}
