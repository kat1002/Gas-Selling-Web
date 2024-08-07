package com.controller.dashboard.warrantyList;

import com.controller.dashboard.product_management.DeleteProductServlet;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;
import com.model.Customer;
import com.model.DAO.CustomerDAO;
import com.model.DAO.ManagerDAO;
import com.model.DAO.OrderDAO;
import com.model.DAO.OrderItemDAO;
import com.model.DAO.ProductDAO;
import com.model.DAO.ProductSerialNumberDAO;
import com.model.DAO.WarrantyDAO;
import com.model.Manager;
import com.model.Order;
import com.model.OrderItem;
import com.model.Product;
import com.model.ProductSerialNumber;
import com.model.Warranty;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Base64;
import java.sql.Date;
import java.util.Locale;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "ExportWarrantyServlet", urlPatterns = {"/exportWarranty"})
public class ExportWarrantyServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, ClassNotFoundException {
        response.setContentType("application/pdf");
         response.setHeader("Content-Disposition", "inline; filename=\"PhieuBaoHanh.pdf\"");

        int id = Integer.parseInt(request.getParameter("id"));
        WarrantyDAO WarrantyDAO = new WarrantyDAO();
        ProductSerialNumberDAO ProductSerialNumberDAO = new ProductSerialNumberDAO();
        OrderItemDAO OrderItemDAO = new OrderItemDAO();
        OrderDAO OrderDAO = new OrderDAO();
        CustomerDAO CustomerDAO = new CustomerDAO();
        ManagerDAO ManagerDAO = new ManagerDAO();
        ProductDAO ProductDAO = new ProductDAO();
        Warranty warranty = WarrantyDAO.getWarranty(id);
        ProductSerialNumber ProductSerialNumber = ProductSerialNumberDAO.getById(warranty.getSerialNumberId());
        OrderItem OrderItem = OrderItemDAO.getOrderItemById(ProductSerialNumber.getOrderItemId());
        Order order = OrderDAO.getOrder(OrderItem.getOrderId());
        Customer customer = CustomerDAO.getCustomer(order.getCustomerId());
        Manager manager = ManagerDAO.getManager(warranty.getManagerId());
        Product product = ProductDAO.getProduct(ProductSerialNumber.getProductId());

        String titleStr = "PHIẾU BẢO HÀNH";

        LocalDate today = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
        String formattedDate = today.format(formatter);
        String dayStr = "Ngày: " + formattedDate;

        String customerName = customer.getName();
        String customerPhone = customer.getPhone_number();
        String managerName = manager.getFirst_name()+" "+manager.getLast_name();
        String managerId = String.valueOf(manager.getManagerId());
        
        Date guaranteeDate = warranty.getGuaranteeDate();
        LocalDate localDate = guaranteeDate.toLocalDate();
        String guaranteeDateStr = localDate.format(formatter);
        
        String productSerialNumber = ProductSerialNumber.getServiceTag();
        String productName = product.getTitle();
        String productStatus = warranty.getStatus();
        String productWarrantyTime = String.valueOf(product.getWarranty_months())+" tháng";
        String productWarrantyType = warranty.getWarrantyType()==1?"Trong thời hạn":"Ngoài thời hạn";
        String productWarrantyImages = warranty.getImages();

        try (OutputStream out = response.getOutputStream()) {
            // Load font from web application's resource directory
            InputStream fontStream = getServletContext().getResourceAsStream("/fonts/arial.ttf");
            BaseFont bf = BaseFont.createFont("arial.ttf", BaseFont.IDENTITY_H, BaseFont.EMBEDDED, true, fontStream.readAllBytes(), null);
            Font font = new Font(bf, 12);

            // Create PDF document
            Document document = new Document();
            PdfWriter.getInstance(document, out);
            document.open();

            // Add title
            Paragraph title = new Paragraph(titleStr, new Font(bf, 16, Font.BOLD));
            title.setAlignment(Element.ALIGN_CENTER);
            document.add(title);

            // Add date
            Paragraph date = new Paragraph(dayStr, font);
            date.setAlignment(Element.ALIGN_RIGHT);
            document.add(date);

            document.add(Chunk.NEWLINE);

            // Add customer information
            document.add(new Paragraph("THÔNG TIN KHÁCH HÀNG", new Font(bf, 14, Font.BOLD)));
            document.add(new Paragraph("Tên KH: " + customerName, font));
            document.add(new Paragraph("ĐT: " + customerPhone, font));
            document.add(Chunk.NEWLINE);

            // Add receiver information
            document.add(new Paragraph("THÔNG TIN NGƯỜI TIẾP NHẬN", new Font(bf, 14, Font.BOLD)));
            document.add(new Paragraph("Tên nv: " + managerName, font));
            document.add(new Paragraph("Mã số nv: " + managerId, font));
            document.add(Chunk.NEWLINE);

            // Add return date
            document.add(new Paragraph("NGÀY HẸN TRẢ", new Font(bf, 14, Font.BOLD)));
            document.add(new Paragraph("Dự kiến khoảng " + guaranteeDateStr, font));
            document.add(Chunk.NEWLINE);

            // Add product information table
            PdfPTable table = new PdfPTable(7);
            table.setWidthPercentage(100);
            table.setWidths(new int[]{1, 2, 3, 3, 3, 2, 2});

            // Add column headers
            addTableHeader(table, "TT", font);
            addTableHeader(table, "Mã SP", font);
            addTableHeader(table, "Tên SP", font);
            addTableHeader(table, "Tình trạng SP", font);
            addTableHeader(table, "Ảnh SP", font);
            addTableHeader(table, "Hạn bảo hành", font);
            addTableHeader(table, "Hình thức", font);

            // Add product data row
            addTableCell(table, "1", font);
            addTableCell(table, productSerialNumber, font);
            addTableCell(table, productName, font);
            addTableCell(table, productStatus, font);
            addTableCellWithImage(table, productWarrantyImages, font, request); // Adding image to the table cell
            addTableCell(table, productWarrantyTime, font);
            addTableCell(table, productWarrantyType, font);

            document.add(table);

            document.add(Chunk.NEWLINE);

            // Add signatures
            PdfPTable signTable = new PdfPTable(2);
            signTable.setWidthPercentage(100);
            signTable.setWidths(new int[]{1, 1});

            addSignCell(signTable, "Khách hàng", font);
            addSignCell(signTable, "Nhân viên tiếp nhận", font);

            addSignCell(signTable, "Ký ghi rõ họ tên", font);
            addSignCell(signTable, "Ký ghi rõ họ tên", font);

            document.add(signTable);

            document.close();
        } catch (DocumentException | IOException e) {
            Logger.getLogger(ExportWarrantyServlet.class.getName()).log(Level.SEVERE, null, e);
            throw new ServletException("Exception in generating PDF", e);
        }
        response.sendRedirect("manageWarranty");
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ExportWarrantyServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ExportWarrantyServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ExportWarrantyServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ExportWarrantyServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private void addTableHeader(PdfPTable table, String headerTitle, Font font) {
        PdfPCell header = new PdfPCell();
        header.setBackgroundColor(BaseColor.LIGHT_GRAY);
        header.setHorizontalAlignment(Element.ALIGN_CENTER);
        header.setBorderWidth(2);
        header.setPhrase(new Phrase(headerTitle, font));
        table.addCell(header);
    }

    private void addTableCell(PdfPTable table, String text, Font font) {
        PdfPCell cell = new PdfPCell(new Phrase(text, font));
        cell.setPaddingLeft(4);
        cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
        table.addCell(cell);
    }

    private void addTableCellWithImage(PdfPTable table, String imagePaths, Font font, HttpServletRequest request) throws IOException, DocumentException {
        if (imagePaths != null && !imagePaths.isEmpty()) {
            String[] paths = imagePaths.split(",");
            PdfPCell cell = new PdfPCell();
            for (String path : paths) {
                String fullPath = request.getServletContext().getRealPath(path);
                Image img = Image.getInstance(fullPath);
                img.scaleToFit(100, 100); // Adjust image size as needed
                cell.addElement(img);
            }
            table.addCell(cell);
        } else {
            addTableCell(table, "", font);
        }
    }

    private void addSignCell(PdfPTable table, String content, Font font) {
        PdfPCell cell = new PdfPCell();
        cell.setPhrase(new Phrase(content, font));
        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
        cell.setBorder(Rectangle.NO_BORDER);
        table.addCell(cell);
    }
}
