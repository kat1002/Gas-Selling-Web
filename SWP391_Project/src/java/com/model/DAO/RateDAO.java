/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.model.DAO;

import com.controller.WebManager;
import com.model.Rate;
import com.utils.DBContext;
import static com.utils.DBContext.connection;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Acer Nitro 5
 */
public class RateDAO extends DBContext {

    private static final Logger LOGGER = Logger.getLogger(RateDAO.class.getName());

    public List<Rate> getRateList() throws SQLException, ClassNotFoundException {
        Connection conn = null;
        String sql = "SELECT [rate_id], [customer_id], [product_id], [rate], [comment], [created_on], [modified_on] FROM dbo.rate";
        try {

            conn = DBContext.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            List<Rate> rateList = new ArrayList<>();
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                rateList.add(new Rate(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getInt(4), rs.getString(5), rs.getTimestamp(6).toLocalDateTime(), rs.getTimestamp(7).toLocalDateTime()));
            }
            return rateList;
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error getting rate list", ex);
        }
        return null;
    }

    public int getTotalFeedbacksByMonth(int month, int year) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT COUNT(*) AS total FROM dbo.rate WHERE DATEPART(month, created_on) = ? AND DATEPART(year, created_on) = ?";
            conn = DBContext.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, month);
            stmt.setInt(2, year);
            rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stmt != null) {
                stmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return 0;
    }

    public int getTotalFeedbacksOfPreviousMonth(int month, int year) throws SQLException {
        if (month == 1) {
            month = 12;
            year--;
        } else {
            month--;
        }
        return getTotalFeedbacksByMonth(month, year);
    }

    public Rate getNewestFeedback() {
        Rate newestFeedback = null;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // SQL query to get the feedback with the latest created_on
            String sql = "SELECT TOP 1 [rate_id], [customer_id], [product_id], [rate], [comment], [created_on], [modified_on] "
                    + "FROM [dbo].[rate] "
                    + "ORDER BY [created_on] DESC";

            // Get connection from DBContext
            conn = DBContext.getConnection();
            stmt = conn.prepareStatement(sql);

            // Execute the query
            rs = stmt.executeQuery();

            // Process the result
            if (rs.next()) {
                newestFeedback = new Rate(
                        rs.getInt("rate_id"),
                        rs.getInt("customer_id"),
                        rs.getInt("product_id"),
                        rs.getInt("rate"),
                        rs.getString("comment"),
                        rs.getTimestamp("created_on").toLocalDateTime(),
                        rs.getTimestamp("modified_on").toLocalDateTime()
                );
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace(); // Log or handle the exception as needed
        } finally {
            // Close resources
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace(); // Log or handle the exception as needed
            }
        }

        return newestFeedback;
    }

    public List<Rate> getRateListByProductId(int product_id) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        String sql = "SELECT [rate_id], [customer_id], [product_id], [rate], [comment], [created_on], [modified_on] FROM [dbo].[rate] WHERE product_id = ?";
        try {

            conn = DBContext.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            List<Rate> rateList = new ArrayList<>();
            ps.setInt(1, product_id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                rateList.add(new Rate(rs.getInt("rate_id"),
                        rs.getInt("customer_id"),
                        rs.getInt("product_id"),
                        rs.getInt("rate"),
                        rs.getString("comment"),
                        rs.getTimestamp("created_on").toLocalDateTime(),
                        rs.getTimestamp("modified_on").toLocalDateTime()));
            }
            return rateList;
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error getting rate list", ex);
        }
        return null;
    }

    public List<Rate> getRateListByProductIdDESC(int product_id) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        String sql = "SELECT [rate_id], [customer_id], [product_id], [rate], [comment], [created_on], [modified_on] FROM [dbo].[rate] WHERE product_id = ? ORDER BY [modified_on] DESC";
        try {

            conn = DBContext.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            List<Rate> rateList = new ArrayList<>();
            ps.setInt(1, product_id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                rateList.add(new Rate(rs.getInt("rate_id"),
                        rs.getInt("customer_id"),
                        rs.getInt("product_id"),
                        rs.getInt("rate"),
                        rs.getString("comment"),
                        rs.getTimestamp("created_on").toLocalDateTime(),
                        rs.getTimestamp("modified_on").toLocalDateTime()));
            }
            return rateList;
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error getting rate list", ex);
        }
        return null;
    }

    public Rate getRateByUserId(int customer_id) {
        String sql = "SELECT [customer_id], [product_id], [rate], [comment], [created_on], [modified_on] FROM dbo.rate WHERE customer_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, customer_id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new Rate(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getString(4), rs.getTimestamp(5).toLocalDateTime(), rs.getTimestamp(6).toLocalDateTime());
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error getting rate by user id", ex);
        }
        return null;
    }
//

    public Rate getRateByRateId(int rate_id) {
        String sql = "SELECT [rate_id]\n"
                + "      ,[customer_id]\n"
                + "      ,[product_id]\n"
                + "      ,[rate]\n"
                + "      ,[comment]\n"
                + "      ,[created_on]\n"
                + "      ,[modified_on]\n"
                + "  FROM [blazo_db].[dbo].[rate] WHERE rate_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, rate_id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new Rate(
                        rs.getInt("rate_id"), // Lấy giá trị của cột 'rate_id'
                        rs.getInt("customer_id"), // Lấy giá trị của cột 'customer_id'
                        rs.getInt("product_id"), // Lấy giá trị của cột 'product_id'
                        rs.getInt("rate"), // Lấy giá trị của cột 'rate'
                        rs.getString("comment"), // Lấy giá trị của cột 'comment'
                        rs.getTimestamp("created_on").toLocalDateTime(), // Lấy giá trị của cột 'created_on' và chuyển đổi thành LocalDateTime
                        rs.getTimestamp("modified_on").toLocalDateTime() // Lấy giá trị của cột 'modified_on' và chuyển đổi thành LocalDateTime
                );
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error getting rate by rate id", ex);
        }
        return null;
    }

    public int countRateByStarAndProduct(int star, int product_id) throws ClassNotFoundException, SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String sql = "SELECT COUNT(*) AS Count FROM [dbo].[rate] WHERE [product_id] = ? AND [rate] = ? GROUP BY [rate]";
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, product_id);
            ps.setInt(2, star);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("Count");
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error getting rate by rate id", ex);
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
        return 0;
    }

    public void updateReviewsRate() throws SQLException, ClassNotFoundException {
        Connection conn = null;
        String sql = "UPDATE dbo.product\n"
                + "SET reviews_rate = (\n"
                + "    SELECT AVG(rate) AS AverageRating\n"
                + "    FROM dbo.rate\n"
                + "    WHERE dbo.rate.product_id = dbo.product.product_id\n"
                + ")";
        try {
            conn = DBContext.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.executeUpdate();
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting average rate ", e);
        }

    }

    public void updateRateByProductId(int productId, int rate, String comment) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        String sql = "UPDATE dbo.rate SET rate = ?, comment = ?, created_on = GETDATE(),modified_on = GETDATE()\n"
                + "where product_id = ?";
        try {
            conn = DBContext.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, rate);
            ps.setString(2, comment);
            ps.setInt(3, productId);
            ps.executeUpdate();
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting average rate ", e);
        }

    }

    public void updateRateByRateId(int productId, int rateid, int rate, String comment) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement ps = null;
        String sql = "  UPDATE dbo.rate \n"
                + "SET rate = ?, comment = ?, modified_on = GETDATE()\n"
                + "WHERE rate_id = ?";
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, rate);
            ps.setString(2, comment);
            ps.setInt(3, rateid);
            ps.executeUpdate();
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting average rate ", e);
        } finally {
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                DBContext.closeConnection(conn);
            }
        }
    }

    public List<Rate> getRatesByPage(List<Rate> list, int start, int end) {
        List<Rate> rateList = new ArrayList<>();
        for (int i = start; i < end; i++) {
            rateList.add(list.get(i));
        }
        return rateList;
    }

    public List<Rate> getRateByFilter(String rating, String comment, String customername, String productname,
            LocalDateTime createdFrom, LocalDateTime createdTo,
            LocalDateTime modifiedFrom, LocalDateTime modifiedTo,
            String sortModifiedTime) throws SQLException {
        List<Rate> rateList = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT [rate_id], [customer_id], [product_id], [rate], [comment], [created_on], [modified_on] FROM [dbo].[rate] WHERE 1=1");
        List<Object> parameters = new ArrayList<>();

        // Append filters to SQL query
        if (rating != null && !rating.isEmpty()) {
            sql.append(" AND [rate] = ?");
            parameters.add(Integer.parseInt(rating));
        }
        // Handle comment search
        if (comment != null && !comment.isEmpty()) {
            comment = comment.trim().replaceAll("\\s+", " ");
            String[] ss = comment.split(" ");
            sql.append(" AND (");
            for (int i = 0; i < ss.length; i++) {
                if (i > 0) {
                    sql.append(" OR ");
                }
                sql.append(" [comment] LIKE ?");
                parameters.add("%" + ss[i] + "%");
            }
            sql.append(" ) ");
        }
        // Handle customer name search
        if (customername != null && !customername.isEmpty()) {
            customername = customername.trim().replaceAll("\\s+", " ");
            String[] ss = customername.split(" ");
            sql.append(" AND [customer_id] IN (SELECT [customer_id] FROM [dbo].[customer] WHERE ");
            for (int i = 0; i < ss.length; i++) {
                if (i > 0) {
                    sql.append(" OR ");
                }
                sql.append("[username] LIKE ?");
                parameters.add("%" + ss[i] + "%");
            }
            sql.append(")");
        }
        // Handle product name search
        if (productname != null && !productname.isEmpty()) {
            productname = productname.trim().replaceAll("\\s+", " ");
            String[] ss = productname.split(" ");
            sql.append(" AND [product_id] IN (SELECT [product_id] FROM [dbo].[product] WHERE ");
            for (int i = 0; i < ss.length; i++) {
                if (i > 0) {
                    sql.append(" OR ");
                }
                sql.append("[title] LIKE ?");
                parameters.add("%" + ss[i] + "%");
            }
            sql.append(")");
        }
        // Handle date filters
        if (createdFrom != null) {
            sql.append(" AND [created_on] >= ?");
            parameters.add(Timestamp.valueOf(createdFrom));
        }
        if (createdTo != null) {
            sql.append(" AND [created_on] <= ?");
            parameters.add(Timestamp.valueOf(createdTo)); // End of day
        }
        if (modifiedFrom != null) {
            sql.append(" AND [modified_on] >= ?");
            parameters.add(Timestamp.valueOf(modifiedFrom));
        }
        if (modifiedTo != null) {
            sql.append(" AND [modified_on] <= ?");
            parameters.add(Timestamp.valueOf(modifiedTo)); // End of day
        }

        // Append sorting to SQL query
        if (sortModifiedTime != null && !sortModifiedTime.isEmpty()) {
            switch (sortModifiedTime) {
                case "1":
                    sql.append(" ORDER BY [modified_on] ASC");
                    break;
                case "2":
                    sql.append(" ORDER BY [modified_on] DESC");
                    break;
                default:
                    break;
            }
        }

        // Create PreparedStatement and set parameters
        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < parameters.size(); i++) {
                ps.setObject(i + 1, parameters.get(i));
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                rateList.add(new Rate(
                        rs.getInt("rate_id"),
                        rs.getInt("customer_id"),
                        rs.getInt("product_id"),
                        rs.getInt("rate"),
                        rs.getString("comment"),
                        rs.getTimestamp("created_on").toLocalDateTime(),
                        rs.getTimestamp("modified_on").toLocalDateTime()
                ));
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error getting rate by filters", ex);
        }
        return rateList;
    }

    public void addRate(Rate r) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        String sql = "INSERT INTO [dbo].[rate] ([customer_id], [product_id], [rate], [comment], [created_on], [modified_on]) VALUES (?, ?, ?, ?, GETDATE(), GETDATE())";
        try {
            conn = DBContext.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, r.getCustomer_id());
            ps.setInt(2, r.getProduct_id());
            ps.setInt(3, r.getRate());
            ps.setString(4, r.getComment());
            ps.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            LOGGER.log(Level.SEVERE, "Error adding rate ", e);
        }
    }

    public void deleteRateByRateId(int rateId) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        String sql = "DELETE FROM [dbo].[rate] WHERE rate_id = ?";
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, rateId);
            ps.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting rate ", e);
        } finally {
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                DBContext.closeConnection(conn);
            }
        }
    }

    public void deleteRateByProductId(int productId) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        String sql = "DELETE FROM [dbo].[rate] WHERE product_id = ?";
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, productId);
            ps.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting rate ", e);
        } finally {
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                DBContext.closeConnection(conn);
            }
        }
    }

    public boolean hasUserRatedProduct(int userId, int productId) {
        Connection conn = null;
        String sql = "select * from rate where customer_id = ? and product_id = ?";

        try {
            conn = DBContext.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(RateDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public static void main(String[] args) throws SQLException, ClassNotFoundException {
        RateDAO rateDAO = new RateDAO();
        System.out.println(rateDAO.countRateByStarAndProduct(1, 1009));
    }
}
