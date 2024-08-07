<%-- 
    Document   : dashboardLeftPart
    Created on : Jul 12, 2024, 7:50:15 PM
    Author     : kirit
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <nav class="sidebar sidebar-offcanvas" id="sidebar">
                    <ul class="nav">
                        <li class="nav-item">
                            <a class="nav-link" href="dashboard">
                                <i class="mdi mdi-grid-large menu-icon"></i>
                                <span class="menu-title">Dashboard</span>
                            </a>
                        </li>
                        <li class="nav-item nav-category">User Management</li>
                        <li class="nav-item">
                            <a class="nav-link" data-bs-toggle="collapse" href="#userlist" aria-expanded="false" aria-controls="userlist">
                                <i class="menu-icon mdi mdi-account-box"></i>
                                <span class="menu-title">User List</span>
                                <i class="menu-arrow"></i> 
                            </a>
                            <div class="collapse" id="userlist">
                                <ul class="nav flex-column sub-menu">
                                    <li class="nav-item"> <a class="nav-link" href="manageCustomer">Customers List</a></li>
                                    <c:if test="${sessionScope.manager.role eq 1}">
                                        <li class="nav-item"> <a class="nav-link" href="manageStaff">Staff List</a></li>
                                    </c:if>
                                    
                                </ul>
                            </div>
                        </li>
                        <li class="nav-item nav-category">Products Management</li>
                        <li class="nav-item">
                            <a class="nav-link" data-bs-toggle="collapse" href="#productlist" aria-expanded="false" aria-controls="productlist">
                                <i class="menu-icon mdi mdi-briefcase-check"></i>
                                <span class="menu-title">Products Management</span>
                                <i class="menu-arrow"></i> 
                            </a>
                            <div class="collapse" id="productlist">
                                <ul class="nav flex-column sub-menu">
                                    <li class="nav-item"> <a class="nav-link" href="manageproduct">Products List</a></li>
                                    <li class="nav-item"> <a class="nav-link" href="manageVoucher">Vouchers List</a></li>
                                    <li class="nav-item"> <a class="nav-link" href="managediscount">Discount List</a></li>
                                    <li class="nav-item"> <a class="nav-link" href="manageWarranty">Warranty List</a></li>
                                </ul>
                            </div>
                        </li>
                        <li class="nav-item nav-category">Orders Management</li>
                        <li class="nav-item">
                            <a class="nav-link" data-bs-toggle="collapse" href="#order" aria-expanded="false" aria-controls="order">
                                <i class="menu-icon mdi mdi-package-variant-closed"></i>
                                <span class="menu-title">Orders Management</span>
                                <i class="menu-arrow"></i> 
                            </a>
                            <div class="collapse" id="order">
                                <ul class="nav flex-column sub-menu">
                                    <li class="nav-item"> <a class="nav-link" href="manageorder">Orders List</a></li>
                                </ul>
                            </div>
                        </li>
                        <li class="nav-item nav-category">News Management</li>
                        <li class="nav-item">
                            <a class="nav-link" data-bs-toggle="collapse" href="#newslist" aria-expanded="false" aria-controls="newslist">
                                <i class="menu-icon mdi mdi-newspaper"></i>
                                <span class="menu-title">News Management</span>
                                <i class="menu-arrow"></i> 
                            </a>
                            <div class="collapse" id="newslist">
                                <ul class="nav flex-column sub-menu">
                                    <li class="nav-item"> <a class="nav-link" href="manageNews">News List</a></li>
                                    <li class="nav-item"> <a class="nav-link" href="manageNav">Navbar Manage</a></li>
                                </ul>
                            </div>
                        </li>
                        <li class="nav-item nav-category">Feedback Management</li>
                        <li class="nav-item">
                            <a class="nav-link" data-bs-toggle="collapse" href="#feedbacklist" aria-expanded="false" aria-controls="feedbacklist">
                                <i class="menu-icon mdi mdi-comment"></i>
                                <span class="menu-title">Feedback Management</span>
                                <i class="menu-arrow"></i> 
                            </a>
                            <div class="collapse" id="feedbacklist">
                                <ul class="nav flex-column sub-menu">
                                    <li class="nav-item"> <a class="nav-link" href="managefeedback">Feedback List</a></li>
                                </ul>
                            </div>
                        </li>

                    </ul>
                </nav>
</html>
