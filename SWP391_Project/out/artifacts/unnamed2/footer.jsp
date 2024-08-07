<%-- 
    Document   : footer
    Created on : May 11, 2024, 5:52:39 PM
    Author     : kat1002
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html class="fixed-full-width-div-bot">
        <head>
            <link href="CSS/main.css" rel="stylesheet" type="text/css"/>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
	<meta name="viewport" content="width=device-width, initial-scale=1" />
<!--        <style>
            .fixed-full-width-div-bot {
                position: relative;
                bottom: 0;
                left: 0;
                width: 100%;
                box-sizing: border-box;
                z-index:1000;
            }
        </style>-->
        </head> 
        <footer >
            <div id="end" >
                <c:forEach var="d" items="${sessionScope.footerItem}">
                    <div class="fcard">
				<p class="title3">${d.title}</p>
                                <c:set var="dRole" value="${d.role}"></c:set>
				<ul>
                                    <c:forEach var="e" items="${sessionScope.footerContent}">
                                        <c:set var="eRole" value="${e.role}"></c:set>
                                        <c:if test="${fn:contains(eRole,dRole+'0')}">
                                            <li><a href="e.description">${e.title}</a></li>
                                        </c:if>
                                    </c:forEach>
				</ul>
			</div>
                </c:forEach>
			
		</div>
	</footer>
</html>
