package com.controller.authentication;

import com.utils.Constant;
import com.controller.WebManager;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.model.GoogleAcc;
import com.model.Customer;
import com.model.DAO.CustomerDAO;
import com.utils.EmailHandler;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.fluent.Form;
import org.apache.http.client.fluent.Request;

public class LoginGoogle extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, ClassNotFoundException {
        String code = request.getParameter("code");
        String accessToken = getToken(code);
        GoogleAcc user = getUserInfo(accessToken);

        //Logger.getLogger(LoginGoogle.class.getName()).log(Level.INFO, "User: " + user.getEmail());

        CustomerDAO customerDAO = WebManager.getInstance().customerDAO;
        Customer customer = customerDAO.findCustomerByGmail(user.getEmail());

        if (customer == null) {
            // Nếu người dùng chưa tồn tại trong database, tạo mới
            customerDAO.createNewCusGoogle(user);
            customer = customerDAO.findCustomerByGmail(user.getEmail());
        }
//        String subject = "Welcome to Our Website!";
//        String body = "Dear " + customer.getFirst_name() + "\n\n Sign up successfully";
//        EmailHandler.sendEmail(user.getEmail(), subject, body);

        // Lấy thông tin người dùng từ database
        // Lưu thông tin người dùng vào session và chuyển hướng đến trang chính
        request.getSession().setAttribute("user", customer);
        //Logger.getLogger(LoginGoogle.class.getName()).log(Level.SEVERE, customer.toString());
        request.getSession().setAttribute("role", 1);
        request.getSession().removeAttribute("manager");
        response.sendRedirect("home");
    }

    public static String getToken(String code) throws ClientProtocolException, IOException {
        String response = Request.Post(Constant.GOOGLE_LINK_GET_TOKEN)
                .bodyForm(Form.form().add("client_id", Constant.GOOGLE_CLIENT_ID)
                        .add("client_secret", Constant.GOOGLE_CLIENT_SECRET)
                        .add("redirect_uri", Constant.GOOGLE_REDIRECT_URI).add("code", code)
                        .add("grant_type", Constant.GOOGLE_GRANT_TYPE).build())
                .execute().returnContent().asString();

        JsonObject jobj = new Gson().fromJson(response, JsonObject.class);
        String accessToken = jobj.get("access_token").toString().replaceAll("\"", "");
        return accessToken;
    }

    public static GoogleAcc getUserInfo(final String accessToken) throws ClientProtocolException, IOException {
        String link = Constant.GOOGLE_LINK_GET_USER_INFO + accessToken;
        String response = Request.Get(link).execute().returnContent().asString();
        //System.out.println("User info response: " + response);
        GoogleAcc googlePojo = new Gson().fromJson(response, GoogleAcc.class);

        return googlePojo;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
