<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User List | Admin Analytics</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { background-color: #f8fafc; padding: 40px; }
        .card { border-radius: 18px; box-shadow: 0 10px 25px rgba(0,0,0,0.05); border: none; }
    </style>
</head>
<body>

<div class="container">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="fw-bold text-dark">User Registrations List</h3>
            <p class="text-secondary small">Viewing users based on the selected period filters.</p>
        </div>
        <a href="${pageContext.request.contextPath}/admin/analytics" class="btn btn-outline-primary rounded-3">
            <i class="fa-solid fa-arrow-left me-2"></i>Back to Dashboard
        </a>
    </div>

    <div class="card p-4">
        <div class="table-responsive">
            <table class="table table-hover align-middle">
                <thead class="table-light">
                    <tr>
                        <th>ID</th>
                        <th>Username</th>
                        <th>Email</th>
                        <th>Joined Date</th>
                        <th class="text-center">Status</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty users}">
                            <c:forEach items="${users}" var="user">
                                <tr>
                                    <td class="fw-bold text-muted">#${user.id}</td>
                                    <td class="fw-semibold text-dark">${user.username}</td>
                                    <td>${user.email}</td>
                                    <td>${user.createdAt}</td>
                                    <td class="text-center">
                                        <span class="badge bg-success-subtle text-success">Active</span>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="5" class="text-center py-5 text-muted">
                                    <i class="fa-solid fa-user-slash fa-2x mb-3"></i><br>
                                    No users found for this selected period.
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>