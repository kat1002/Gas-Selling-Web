package com.controller.checkout;

import com.controller.WebManager;
import com.google.gson.*;
import com.model.*;
import com.model.DAO.OrderDAO;
import com.model.DAO.OrderItemDAO;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/checkout/handle")
public class CheckoutHandler extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String action = request.getParameter("action");
        if ("getUserDetails".equals(action)) {
            try {
                getUserDetailsJson(request, response);
            } catch (SQLException | ClassNotFoundException e) {
                throw new RuntimeException(e);
            }
            return;
        }

        if ("getCartDetails".equals(action)) {
            try {
                getCartDetailsJson(request, response);
            } catch (SQLException | ClassNotFoundException e) {
                throw new RuntimeException(e);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String action = request.getParameter("action");

        System.out.println("action: " + action);

        if ("checkout".equals(action)) {
            try {
                checkOut(request, response);
            } catch (SQLException | ClassNotFoundException e) {
                throw new RuntimeException(e);
            }
        }
    }

    // Method to construct user details JSON object
    private void getUserDetailsJson(HttpServletRequest request, HttpServletResponse response) throws SQLException, ClassNotFoundException, IOException {
        JsonObject jsonResponse = new JsonObject();

        Customer customer = (Customer) request.getSession().getAttribute("user");
        System.out.println(customer);

        jsonResponse.add("userDetails", new Gson().toJsonTree(customer));

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonResponse.toString());
    }

    private void getCartDetailsJson(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException, ClassNotFoundException {
        JsonObject cartDetails = new JsonObject();

        Customer customer = (Customer) request.getSession().getAttribute("user");
        Cart cart = WebManager.getInstance().cartDAO.getCart(customer.getId());
        List<CartItem> cartItemList = WebManager.getInstance().cartItemDAO.getCartItemsFromCart(cart.getCartId());

        int total = 0;


        cartDetails.addProperty("count", cartItemList.size());

        JsonArray productList = new JsonArray();

        for (CartItem item : cartItemList) {
            JsonObject product = new JsonObject();

            double totalPrice = item.getQuantity() * WebManager.getInstance().productDAO.getProduct(item.getProductId()).getPrice();

            product.addProperty("productId", item.getProductId());
            product.addProperty("quantity", item.getQuantity());
            product.addProperty("title", WebManager.getInstance().productDAO.getProduct(item.getProductId()).getTitle());
            product.addProperty("totalPrice", totalPrice);
            productList.add(product);

            total += totalPrice;
        }

        cartDetails.add("productList", productList);

//        cartDetails.addProperty("voucherCode", voucherCode);
//        cartDetails.addProperty("discountValue", discountValue);
        cartDetails.addProperty("total", total);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(cartDetails.toString());
    }
    
    protected void checkOut(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException, ClassNotFoundException {
        JsonObject jsonResponse = new JsonObject();
        JsonParser parser = new JsonParser();

        Customer customer = (Customer) request.getSession().getAttribute("user");
        OrderDAO orderDAO = WebManager.getInstance().orderDAO;
        OrderItemDAO orderItemDAO = WebManager.getInstance().orderItemDAO;
        LocalDate now = LocalDate.now();
        Date sqlDate = Date.valueOf(now);
        try {
            JsonObject userDetails = parser.parse(request.getParameter("userDetails")).getAsJsonObject();
            JsonObject cartData = parser.parse(request.getParameter("cartData")).getAsJsonObject();

            orderDAO.insert(new Order(
                    customer.getId(),
                    0,
                    cartData.get("total").getAsDouble(), sqlDate,
                    1,
                    userDetails.get("addressLine1").toString(),
                    userDetails.get("addressLine2").toString(),
                    userDetails.get("postalCode").toString(),
                    userDetails.get("city").toString(),
                    userDetails.get("phoneNumber").toString(), sqlDate,
                    1
            ));

            List<OrderItem> orderItemList = new ArrayList<>();
            JsonArray productList = cartData.getAsJsonArray("productList");

            for (int i = 0; i < productList.size(); i++) {
                JsonObject product = productList.get(i).getAsJsonObject();
                orderItemList.add(new OrderItem(
                        orderDAO.getLastOrderId(customer.getId()),
                        product.get("productId").getAsInt(),
                        product.get("quantity").getAsInt(),
                        product.get("totalPrice").getAsDouble()
                ));
            }

            System.out.println(orderItemList + "  ABCD  "); // Kiểm tra danh sách OrderItem

            for (OrderItem orderItem : orderItemList) {
                boolean success = orderItemDAO.insert(orderItem);
                if (!success) {
                    System.err.println("Failed to insert order item: " + orderItem);
                }
            }

            WebManager.getInstance().cartItemDAO.deleteCartItems(WebManager.getInstance().cartDAO.getCart(customer.getId()).getCartId());

            jsonResponse.addProperty("success", true);
            jsonResponse.addProperty("message", "Checkout successful");

        } catch (JsonSyntaxException e) {
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Error parsing JSON data: " + e.getMessage());
            e.printStackTrace(); // Log the exception for debugging
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // Set HTTP status code
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonResponse.toString());
    }


}
