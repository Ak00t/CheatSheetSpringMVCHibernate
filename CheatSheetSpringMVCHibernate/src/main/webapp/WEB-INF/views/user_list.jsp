<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.*, com.hibernate.entity.UserEntity" %> <%
    // Sorting: Joined Date အလိုက် အသစ်ဆုံးကို အပေါ်မှာထားပြီး စီပေးခြင်း
    List<UserEntity> userList = (List<UserEntity>) request.getAttribute("users");
    if (userList != null) {
        userList.sort((u1, u2) -> u2.getCreatedAt().compareTo(u1.getCreatedAt()));
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User List | Admin Analytics</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body { background-color: #f8fafc; font-family: 'Inter', sans-serif; margin: 0; }
        .main-wrapper { display: flex; min-height: 100vh; }
        .content-area { flex: 1; display: flex; flex-direction: column; min-height: 100vh; }
        .main-content { flex: 1; padding: 25px; }
        .card { border-radius: 20px; box-shadow: 0 4px 20px rgba(0,0,0,0.06); border: none; padding: 20px; }
        .table thead { background-color: #f9fafb; color: #4b5563; font-size: 0.85rem; text-transform: uppercase; }
        .table tbody tr:hover { background-color: #f3f4f6; transition: 0.2s; }
        .badge-active { background-color: #dcfce7; color: #166534; padding: 6px 12px; border-radius: 20px; font-weight: 600; font-size: 0.75rem; }
        .row-number { font-weight: bold; color: #6b7280; }
    </style>
</head>
<body>

    <jsp:include page="header.jsp" />

    <div class="main-wrapper">
        <jsp:include page="sidebar.jsp" />

        <div class="content-area">
            <div class="main-content">
                <div class="container-fluid">
                    <h4 class="fw-bold text-dark mb-4">User Registrations List</h4>

                    <c:set var="pageSize" value="10" />
                    <c:set var="currentPage" value="${empty param.page ? 0 : param.page}" />
                    <c:set var="totalItems" value="${fn:length(users)}" />
                    <c:set var="totalPages" value="${(totalItems + pageSize - 1) / pageSize}" />
                    <c:set var="startIndex" value="${currentPage * pageSize}" />
                    <c:set var="endIndex" value="${startIndex + pageSize - 1}" />

                    <div class="card">
                        <div class="table-responsive">
                            <table class="table align-middle">
                                <thead>
                                    <tr>
                                        <th style="width: 50px;">No</th>
                                        <th>Name</th>
                                        <th>Email</th>
                                        <th>Joined Date</th>
                                        <th class="text-center">Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${not empty users}">
                                            <c:forEach items="${users}" var="user" varStatus="loop">
                                                <c:if test="${loop.index >= startIndex && loop.index <= endIndex}">
                                                    <tr>
                                                        <td class="row-number">${(currentPage * pageSize) + loop.count}</td>
                                                        <td class="fw-semibold text-dark">${user.name}</td>
                                                        <td class="text-muted">${user.email}</td>
                                                        <td>
                                                            <fmt:parseDate value="${user.createdAt}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDate" type="both"/>
                                                            <fmt:formatDate value="${parsedDate}" pattern="dd MMM yyyy, hh:mm a" />
                                                        </td>
                                                        <td class="text-center"><span class="badge-active">Active</span></td>
                                                    </tr>
                                                </c:if>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr><td colspan="5" class="text-center py-5">No users found.</td></tr>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>

                        <c:if test="${totalPages > 1}">
                            <nav class="mt-4">
                                <ul class="pagination justify-content-center">
                                    <li class="page-item ${currentPage == 0 ? 'disabled' : ''}">
                                        <a class="page-link" href="?page=${currentPage - 1}">Previous</a>
                                    </li>
                                    <c:forEach begin="0" end="${totalPages - 1}" var="i">
                                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                                            <a class="page-link" href="?page=${i}">${i + 1}</a>
                                        </li>
                                    </c:forEach>
                                    <li class="page-item ${currentPage == totalPages - 1 ? 'disabled' : ''}">
                                        <a class="page-link" href="?page=${currentPage + 1}">Next</a>
                                    </li>
                                </ul>
                            </nav>
                        </c:if>
                    </div>
                </div>
            </div>
            <jsp:include page="footer.jsp" />
        </div>
    </div>
</body>
</html>