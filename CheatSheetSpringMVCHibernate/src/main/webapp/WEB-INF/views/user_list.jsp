<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.*, com.hibernate.entity.UserEntity" %> 
<%
    // Sorting: Sort by Joined Date descending (newest first)
    List<UserEntity> userList = (List<UserEntity>) request.getAttribute("users");
    if (userList != null) {
        userList.sort((u1, u2) -> u2.getCreatedAt().compareTo(u1.getCreatedAt()));
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User List | Admin Analytics</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    
    <style>
        :root {
            --bg-canvas: #f4fbfc;       
            --brand-blue: #2563eb;     
            --text-dark: #1e293b;
            --text-gray: #64748b;
            --border-light: #e2e8f0;
            --shadow-sm: 0 10px 25px -5px rgba(0, 0, 0, 0.02), 0 8px 16px -6px rgba(0, 0, 0, 0.02);
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: var(--bg-canvas);
            color: var(--text-dark);
            margin: 0;
            padding: 0;
            overflow-x: hidden;
        }

        .page-container {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .page-wrapper {
            display: flex;
            padding: 24px;
            gap: 24px;
            align-items: flex-start;
            flex: 1;
        }

        .main-workspace {
            flex-grow: 1;
            min-width: 0;
        }

        /* Enhanced Card Design matching Admin Dashboard */
        .info-card {
            background-color: #ffffff;
            border-radius: 20px;
            padding: 30px;
            border: none;
            height: 100%;
            box-shadow: var(--shadow-sm);
            border-top: 4px solid var(--brand-blue);
        }
        
        .info-card-title {
            font-weight: 800;
            color: var(--text-dark); 
            font-size: 22px;
            margin-bottom: 24px;
            display: flex;
            align-items: center;
        }

        /* Custom Table adjustments */
        .table tbody tr:hover {
            background-color: #f8fafc;
            transition: background-color 0.2s ease;
        }

        .badge-active {
            background-color: #dcfce7;
            color: #166534;
            padding: 6px 14px;
            border-radius: 20px;
            font-weight: 700;
            font-size: 12px;
            display: inline-block;
        }

        /* Pagination Accent Color Synchronization */
        .pagination .page-item.active .page-link {
            background-color: var(--brand-blue);
            border-color: var(--brand-blue);
            color: #ffffff;
        }
        .pagination .page-link {
            color: var(--brand-blue);
            border-radius: 8px;
            margin: 0 3px;
            font-weight: 600;
        }

        .site-footer {
            background: #111827;
            color: white;
            margin-top: 60px;
            padding: 40px 20px;
        }
        .footer-container {
            max-width: 1200px;
            margin: auto;
            text-align: center;
        }
        .footer-container h3 {
            margin-bottom: 10px;
            font-size: 24px;
        }
        .footer-container p {
            color: #d1d5db;
            margin-bottom: 8px;
        }
        .copyright {
            margin-top: 15px;
            font-size: 14px;
            color: #9ca3af;
        }
    </style>
</head>
<body>

    <div class="page-container">
        
        <!-- Header Section Synchronized -->
        <header style="background:white; padding:20px 50px; display:flex; justify-content:space-between; align-items:center; box-shadow:0 2px 20px rgba(0,0,0,.05);">
            <h2 style="color:#2563eb; margin: 0; font-weight: 700;">CheatSheet Hub</h2>
            <nav style="display:flex; align-items:center; gap:25px;">
                <a href="${pageContext.request.contextPath}/admin/profile" style="text-decoration:none; color:#334155; font-weight: 600;">Profile</a>
            </nav>
        </header>

        <div class="page-wrapper">
            
            <!-- Sidebar Component Include Layout Structure matching Dashboard -->
            <jsp:include page="/WEB-INF/views/sidebar.jsp" />

            <div class="main-workspace">
                
                <!-- Pagination Logic Initialization -->
                <c:set var="pageSize" value="10" />
                <c:set var="currentPage" value="${empty param.page ? 0 : param.page}" />
                <c:set var="totalItems" value="${fn:length(users)}" />
                <c:set var="totalPages" value="${(totalItems + pageSize - 1) / pageSize}" />
                <c:set var="startIndex" value="${currentPage * pageSize}" />
                <c:set var="endIndex" value="${startIndex + pageSize - 1}" />

                <!-- Table Wrapper info-card block -->
                <div class="info-card">
                    <h3 class="info-card-title">
                        <i class="fa-solid fa-users me-2 text-primary"></i> User Registrations List
                    </h3>

                    <div class="table-responsive">
                        <table class="table align-middle" style="border-color: #f1f5f9;">
                            <thead style="background-color: #f8fafc; color: #64748b; font-weight: 700; font-size: 14px;">
                                <tr>
                                    <th style="padding: 14px; width: 80px;">No</th>
                                    <th>Name</th>
                                    <th>Email</th>
                                    <th>Joined Date</th>
                                    <th class="text-center" style="width: 120px;">Status</th>
                                </tr>
                            </thead>
                            <tbody style="font-size: 15px;">
                                <c:choose>
                                    <c:when test="${not empty users}">
                                        <c:forEach items="${users}" var="user" varStatus="loop">
                                            <c:if test="${loop.index >= startIndex && loop.index <= endIndex}">
                                                <tr>
                                                    <td style="padding: 16px; font-weight: 700; color: #64748b;">
                                                        #${(currentPage * pageSize) + loop.count}
                                                    </td>
                                                    <td class="fw-semibold text-dark">${user.name}</td>
                                                    <td style="color: #475569;">${user.email}</td>
                                                    <td style="color: #475569;">
                                                        <fmt:parseDate value="${user.createdAt}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDate" type="both"/>
                                                        <fmt:formatDate value="${parsedDate}" pattern="dd MMM yyyy, hh:mm a" />
                                                    </td>
                                                    <td class="text-center">
                                                        <span class="badge-active">Active</span>
                                                    </td>
                                                </tr>
                                            </c:if>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="5" class="text-center py-5 text-muted" style="font-size: 16px;">
                                                <i class="bi bi-folder-x d-block mb-2" style="font-size: 40px; color: #cbd5e1;"></i>
                                                No users found.
                                            </td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>

                    <!-- Pagination Navigation -->
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

        <!-- Footer Section Synchronized -->
        <footer class="site-footer">
            <div class="footer-container">
                <h3>CheatSheet Hub</h3>
                <p>Learn Faster. Share Knowledge. Build Better.</p>
                <p class="copyright">© 2026 CheatSheet Hub. All Rights Reserved.</p>
            </div>
        </footer>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>