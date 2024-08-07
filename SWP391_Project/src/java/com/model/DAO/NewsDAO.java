/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.model.DAO;

/**
 *
 * @author kat1002
 */
import com.model.News;
import com.utils.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class NewsDAO {

    private static final Logger LOGGER = Logger.getLogger(NewsDAO.class.getName());

    public void addNews(News news) {
        String sql = "INSERT INTO news (theme_image,short_description,title, body,created_at, modified_on, created_by, modified_by, banner_state, news_category) VALUES (?, ?, ?, ?, GETDATE(), GETDATE(), ?, ?,0,?)";
        Connection connection = null;
        try {
            connection = DBContext.getConnection();
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, news.getTheme_image());
            stmt.setString(2, news.getShort_description());
            stmt.setString(3, news.getTitle());
            stmt.setString(4, news.getBody());
            stmt.setInt(5, news.getCreatedBy());
            stmt.setInt(6, news.getModifiedBy());
            stmt.setString(7, news.getNewsCategory());
            stmt.executeUpdate();
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error add news", e);
        } finally {
            DBContext.closeConnection(connection); // Close connection in finally block
        }
    }

    public News getNews(int newsId) {
        String sql = "SELECT * FROM news WHERE news_id = ?";
        Connection connection = null;
        try {
            connection = DBContext.getConnection();
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, newsId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new News(
                            rs.getInt("news_id"),
                            rs.getString("theme_image"),
                            rs.getString("short_description"),
                            rs.getString("title"),
                            rs.getString("body"),
                            rs.getDate("created_at"),
                            rs.getDate("modified_on"),
                            rs.getInt("created_by"),
                            rs.getInt("modified_by"),
                            rs.getInt("banner_state"),
                            rs.getString("news_category")
                    );
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error getting news", e);
        } finally {
            DBContext.closeConnection(connection); // Close connection in finally block
        }
        return null;
    }

    public List<News> getBanner() {
        List<News> newsList = new ArrayList<>();
        Connection connection = null;
        String sql = "SELECT * FROM news WHERE banner_state <> 0 ORDER BY banner_state ASC";
        try {
            connection = DBContext.getConnection(); // Get connection
            PreparedStatement stmt = connection.prepareStatement(sql);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    newsList.add(new News(
                            rs.getInt("news_id"),
                            rs.getString("theme_image"),
                            rs.getString("short_description"),
                            rs.getString("title"),
                            rs.getString("body"),
                            rs.getDate("created_at"),
                            rs.getDate("modified_on"),
                            rs.getInt("created_by"),
                            rs.getInt("modified_by"),
                            rs.getInt("banner_state"),
                            rs.getString("news_category")
                    ));
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error getting banner", e);
        } finally {
            DBContext.closeConnection(connection); // Close connection in finally block
        }
        return newsList;
    }

    public List<News> getAllNews() {
        List<News> newsList = new ArrayList<>();
        Connection connection = null;
        String sql = "SELECT * FROM news ORDER BY created_at DESC, news_id DESC";
        try {
            connection = DBContext.getConnection(); // Get connection
            PreparedStatement stmt = connection.prepareStatement(sql);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    newsList.add(new News(
                            rs.getInt("news_id"),
                            rs.getString("theme_image"),
                            rs.getString("short_description"),
                            rs.getString("title"),
                            rs.getString("body"),
                            rs.getDate("created_at"),
                            rs.getDate("modified_on"),
                            rs.getInt("created_by"),
                            rs.getInt("modified_by"),
                            rs.getInt("banner_state"),
                            rs.getString("news_category")
                    ));
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error getting all news", e);
        } finally {
            DBContext.closeConnection(connection); // Close connection in finally block
        }
        return newsList;
    }

    public List<News> getAllNewsByCategory(String cate) {
        List<News> newsList = new ArrayList<>();
        Connection connection = null;
        String sql = "SELECT * FROM news where news_category=? ORDER BY created_at DESC, news_id DESC";
        try {
            connection = DBContext.getConnection(); // Get connection
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, cate);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    newsList.add(new News(
                            rs.getInt("news_id"),
                            rs.getString("theme_image"),
                            rs.getString("short_description"),
                            rs.getString("title"),
                            rs.getString("body"),
                            rs.getDate("created_at"),
                            rs.getDate("modified_on"),
                            rs.getInt("created_by"),
                            rs.getInt("modified_by"),
                            rs.getInt("banner_state"),
                            rs.getString("news_category")
                    ));
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error getting all news by category", e);
        } finally {
            DBContext.closeConnection(connection); // Close connection in finally block
        }
        return newsList;
    }

    public List<String> getNewsCategory() {
        List<String> newsCategories = new ArrayList<>();
        Connection connection = null;
        String sql = "select distinct news_category from news";
        try {
            connection = DBContext.getConnection(); // Get connection
            PreparedStatement stmt = connection.prepareStatement(sql);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    newsCategories.add(rs.getString("news_category"));
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error getting all news category", e);
        } finally {
            DBContext.closeConnection(connection); // Close connection in finally block
        }
        return newsCategories;
    }

    public List<News> getAllNewsByName(String[] searchTerms) {
        Connection connection = null;
        List<News> newsList = new ArrayList<>();

        // Create a base SQL query
        StringBuilder sqlBuilder = new StringBuilder("SELECT * FROM news WHERE ");
        boolean firstTerm = true;

        // Append each term to the WHERE clause with OR condition
        for (String term : searchTerms) {
            if (!firstTerm) {
                sqlBuilder.append(" OR ");
            }
            // Use LIKE with wildcard for partial matches
            sqlBuilder.append("title LIKE ?");
            firstTerm = false;
        }

        // Order by clause
        sqlBuilder.append(" ORDER BY created_at DESC, news_id DESC");

        // Execute the SQL query
        try {
            connection = DBContext.getConnection(); // Get connection
            PreparedStatement stmt = connection.prepareStatement(sqlBuilder.toString());
            // Set each term as a parameter in the prepared statement
            for (int i = 0; i < searchTerms.length; i++) {
                stmt.setString(i + 1, "%" + searchTerms[i] + "%");
            }

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    newsList.add(new News(
                            rs.getInt("news_id"),
                            rs.getString("theme_image"),
                            rs.getString("short_description"),
                            rs.getString("title"),
                            rs.getString("body"),
                            rs.getDate("created_at"),
                            rs.getDate("modified_on"),
                            rs.getInt("created_by"),
                            rs.getInt("modified_by"),
                            rs.getInt("banner_state"),
                            rs.getString("news_category")
                    ));
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error getting news by name", e);
        } finally {
            DBContext.closeConnection(connection); // Close connection in finally block
        }
        return newsList;
    }
    
    public List<News> getAllNewsFilter(String[] searchTermsName, String[] searchTermsDes, Date createDateFrom, Date createDateTo, Date modifyDateFrom, Date modifyDateTo, int createdBy, int modifiedBy, boolean haveBanner) {
    Connection connection = null;
    List<News> newsList = new ArrayList<>();

    // Create a base SQL query
    StringBuilder sqlBuilder = new StringBuilder("SELECT * FROM news WHERE 1=1");

    // Append conditions based on the search terms and filters
    if (searchTermsName != null && searchTermsName.length > 0) {
        sqlBuilder.append(" AND (");
        for (int i = 0; i < searchTermsName.length; i++) {
            if (i > 0) {
                sqlBuilder.append(" OR ");
            }
            sqlBuilder.append("title LIKE ?");
        }
        sqlBuilder.append(")");
    }

    if (searchTermsDes != null && searchTermsDes.length > 0) {
        sqlBuilder.append(" AND (");
        for (int i = 0; i < searchTermsDes.length; i++) {
            if (i > 0) {
                sqlBuilder.append(" OR ");
            }
            sqlBuilder.append("short_description LIKE ?");
        }
        sqlBuilder.append(")");
    }

    if (createDateFrom != null) {
        sqlBuilder.append(" AND created_at >= ?");
    }

    if (createDateTo != null) {
        sqlBuilder.append(" AND created_at <= ?");
    }

    if (modifyDateFrom != null) {
        sqlBuilder.append(" AND modified_on >= ?");
    }

    if (modifyDateTo != null) {
        sqlBuilder.append(" AND modified_on <= ?");
    }

    if (createdBy > 0) {
        sqlBuilder.append(" AND created_by = ?");
    }

    if (modifiedBy > 0) {
        sqlBuilder.append(" AND modified_by = ?");
    }

    if (haveBanner) {
        sqlBuilder.append(" AND banner_state > 0");
    }

    // Order by clause
    sqlBuilder.append(" ORDER BY created_at DESC, news_id DESC");

    // Execute the SQL query
    try {
        connection = DBContext.getConnection(); // Get connection
        PreparedStatement stmt = connection.prepareStatement(sqlBuilder.toString());

        int index = 1;
        if (searchTermsName != null) {
            for (String term : searchTermsName) {
                stmt.setString(index++, "%" + term + "%");
            }
        }

        if (searchTermsDes != null) {
            for (String term : searchTermsDes) {
                stmt.setString(index++, "%" + term + "%");
            }
        }

        if (createDateFrom != null) {
            stmt.setDate(index++, new java.sql.Date(createDateFrom.getTime()));
        }

        if (createDateTo != null) {
            stmt.setDate(index++, new java.sql.Date(createDateTo.getTime()));
        }

        if (modifyDateFrom != null) {
            stmt.setDate(index++, new java.sql.Date(modifyDateFrom.getTime()));
        }

        if (modifyDateTo != null) {
            stmt.setDate(index++, new java.sql.Date(modifyDateTo.getTime()));
        }

        if (createdBy > 0) {
            stmt.setInt(index++, createdBy);
        }

        if (modifiedBy > 0) {
            stmt.setInt(index++, modifiedBy);
        }

        try (ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                newsList.add(new News(
                        rs.getInt("news_id"),
                        rs.getString("theme_image"),
                        rs.getString("short_description"),
                        rs.getString("title"),
                        rs.getString("body"),
                        rs.getDate("created_at"),
                        rs.getDate("modified_on"),
                        rs.getInt("created_by"),
                        rs.getInt("modified_by"),
                        rs.getInt("banner_state"),
                        rs.getString("news_category")
                ));
            }
        }
    } catch (SQLException | ClassNotFoundException e) {
        LOGGER.log(Level.SEVERE, "Error getting news with filters", e);
    } finally {
        DBContext.closeConnection(connection); // Close connection in finally block
    }
    return newsList;
}

    public void updateNews(News news) {
        String sql = "UPDATE news SET title = ?, body = ?, modified_on = GETDATE(), modified_by = ?, theme_image = ?, short_description = ?,news_category=? WHERE news_id = ?";
        Connection connection = null;
        try {
            connection = DBContext.getConnection(); // Get connection
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, news.getTitle());
            stmt.setString(2, news.getBody());
            stmt.setInt(3, news.getModifiedBy());
            stmt.setString(4, news.getTheme_image());
            stmt.setString(5, news.getShort_description());
            stmt.setString(6, news.getNewsCategory());
            stmt.setInt(7, news.getNewsId());
            stmt.executeUpdate();
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error update news", e);
        } finally {
            DBContext.closeConnection(connection); // Close connection in finally block
        }
    }

    public void updateNewsBanner(int id, int banner, int idStaff) {
        String sql = "UPDATE news SET banner_state = ?,modified_by = ? WHERE news_id = ?";
        Connection connection = null;
        try {
            connection = DBContext.getConnection(); // Get connection
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, banner);
            stmt.setInt(2, idStaff);
            stmt.setInt(3, id);
            stmt.executeUpdate();
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error update news banner", e);
        } finally {
            DBContext.closeConnection(connection); // Close connection in finally block
        }
    }

    public void deleteNews(int newsId) {
        String sql = "DELETE FROM news WHERE news_id = ?";
        Connection connection = null;
        try {
            connection = DBContext.getConnection(); // Get connection
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, newsId);
            stmt.executeUpdate();
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error delete news", e);
        } finally {
            DBContext.closeConnection(connection); // Close connection in finally block
        }
    }
//
//    public static void main(String[] args) throws SQLException, ClassNotFoundException {
//        NewsDAO d = new NewsDAO();
//        for (News t : d.getAllNewsByCategory("Hot")) {
//            System.out.println(t.getTitle());
//        }
//
//    }
}
