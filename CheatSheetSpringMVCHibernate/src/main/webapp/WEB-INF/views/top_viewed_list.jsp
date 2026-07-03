<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Top Viewed Cheatsheets</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8fafc; padding: 40px; }
        .card { border-radius: 16px; box-shadow: 0 4px 12px rgba(0,0,0,0.05); border: none; }
    </style>
</head>
<body>

<div class="container">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3 class="fw-bold text-dark">Top 10 Most Viewed Cheatsheets</h3>
        <a href="${pageContext.request.contextPath}/admin/analytics" class="btn btn-outline-primary">Back to Dashboard</a>
    </div>

    <div class="card p-4">
        <table class="table table-hover align-middle">
            <thead class="table-light">
                <tr>
                    <th>Cheatsheet Title</th>
                    <th class="text-center">View Count</th>
                    <th class="text-end">Created Date</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${cheatsheets}" var="cs">
                    <tr>
                        <td class="fw-bold">${cs.title}</td>
                        <td class="text-center"><span class="badge bg-primary">${cs.viewCount} Views</span></td>
                        <td class="text-end">${cs.createdAt}</td>
                    </tr>
                </c:forEach>
                <c:if test="${empty cheatsheets}">
                    <tr>
                        <td colspan="3" class="text-center py-4">No data available for the selected period.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>