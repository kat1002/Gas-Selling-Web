<%-- 
    Document   : dashboardHeadPart
    Created on : Jul 12, 2024, 7:53:53 PM
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
    <nav class="navbar default-layout col-lg-12 col-12 p-0 fixed-top d-flex align-items-top flex-row">
        <div class="text-center navbar-brand-wrapper d-flex align-items-center justify-content-start">
            <div class="me-3">
                <button class="navbar-toggler navbar-toggler align-self-center" type="button" data-bs-toggle="minimize">
                    <span class="icon-menu"></span>
                </button>
            </div>
            <div>
                <a class="navbar-brand brand-logo" href="home">
                    <img style="height: 80px;width: 80px" src="media/LOGO.png" alt="logo" />
                </a>
                <a class="navbar-brand brand-logo-mini" href="home">
                    <img src="media/LOGO.png" alt="logo" />
                </a>
            </div>
        </div>
        <div class="navbar-menu-wrapper d-flex align-items-top">
            <ul class="navbar-nav">
                <li class="nav-item font-weight-semibold d-none d-lg-block ms-0">
                    <h1 class="welcome-text">Hello, <span class="text-black fw-bold">${sessionScope.manager.username}</span></h1>
                    <h3 class="welcome-sub-text">Have a good day! </h3>
                </li>
            </ul>
            <ul class="navbar-nav ms-auto">
                <li class="nav-item d-none d-lg-block">
                    <div id="datepicker-popup" class="input-group date datepicker navbar-date-picker">
                        <span class="input-group-addon input-group-prepend border-right">
                            <span class="icon-calendar input-group-text calendar-icon"></span>
                        </span>
                        <input type="text" class="form-control">
                    </div>
                </li>
                <li class="nav-item dropdown d-none d-lg-block user-dropdown">
                    <a class="nav-link" id="UserDropdown" href="#" data-bs-toggle="dropdown" aria-expanded="false">
                        <img class="img-xs rounded-circle" src="media/2304226.png" alt="Profile image"> </a>
                    <div class="dropdown-menu dropdown-menu-right navbar-dropdown" aria-labelledby="UserDropdown">
                        <div class="dropdown-header text-center">
                            <img class="img-xs rounded-circle" src="media/2304226.png" alt="Profile image">
                            <p class="mb-1 mt-3 font-weight-semibold">${sessionScope.manager.username}</p>
                            <p class="fw-light text-muted mb-0">Role: 
                                <c:if test="${sessionScope.manager.role eq 1}">Manager</c:if>
                                <c:if test="${sessionScope.manager.role eq 2}">Sale Staff</c:if>
                                <c:if test="${sessionScope.manager.role eq 3}">Customer Service Staff</c:if>    
                            </p>
                            <p class="fw-light text-muted mb-0">${sessionScope.manager.email}</p>
                        </div>
                        <a class="dropdown-item" href="logout"><i class="dropdown-item-icon mdi mdi-power text-primary me-2"></i>Sign Out</a>
                    </div>
                </li>
            </ul>
            <button class="navbar-toggler navbar-toggler-right d-lg-none align-self-center" type="button" data-bs-toggle="offcanvas">
                <span class="mdi mdi-menu"></span>
            </button>
        </div>
    </nav>
</html>
