<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Top Ratings - Platform Analytics</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #f8fafc; }
        .workspace-wrapper { display: flex; gap: 35px; padding: 35px 45px 35px 15px; width: 100%; }
        .content-area { flex-grow: 1; }
        
        /* UI Enhancement */
        .premium-card { background: #ffffff; border: 1px solid #e2e8f0; border-radius: 20px; box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05); }
        .table thead th { border-bottom: 2px solid #f1f5f9; color: #64748b; font-size: 0.85rem; text-transform: uppercase; letter-spacing: 0.05em; padding: 16px; }
        .table tbody td { padding: 20px 16px; color: #334155; }
        
        /* Rank Styling */
        .rank-number { width: 32px; height: 32px; display: flex; align-items: center; justify-content: center; border-radius: 8px; background: #f1f5f9; font-weight: 700; color: #475569; }
        
        /* Other Styles */
        .badge-rating { background: #fffbeb; color: #d97706; font-weight: 600; padding: 6px 12px; border-radius: 10px; border: 1px solid #fde68a; }
    </style>
</head>
<body>

<jsp:include page="header.jsp" />

<div class="workspace-wrapper">
    <jsp:include page="/WEB-INF/views/sidebar.jsp" />
    
    <div class="content-area">
        <div class="mb-4">
            <h2 class="fw-bold text-dark mb-1">Top Rated Content</h2>
            <p class="text-muted mb-0">Showing top 3 highest rated items.</p>
        </div>

        <div class="card premium-card border-0 p-3">
            <table class="table table-hover align-middle mb-0">
                <thead>
                    <tr>
                        <th class="text-center">Rank</th>
                        <th>Title</th>
                        <th>Author</th>
                        <th>Rating</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${topRatingList}" var="item" begin="0" end="2" varStatus="loop">
                        <tr>
                            <td class="text-center">
                                <div class="rank-number mx-auto">${loop.count}</div>
                            </td>
                            <td class="fw-semibold">${item.title}</td>
                            <td>${item.user.name}</td>
                            <td>
                                <span class="badge-rating"><i class="fas fa-star text-warning me-1"></i>${item.ratingAvg}</span>
                            </td>
                        </tr>
                    </c:forEach>
                    
                    <c:if test="${empty topRatingList}">
                        <tr>
                            <td colspan="4" class="text-center py-5 text-muted">No data available at the moment.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>