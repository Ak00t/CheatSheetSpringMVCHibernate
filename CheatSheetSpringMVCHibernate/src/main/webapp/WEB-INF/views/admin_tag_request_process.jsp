<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Pending Requests - CheatSheet Hub</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #f8fafc; }
        .workspace-wrapper { display: flex; gap: 35px; padding: 35px 45px 35px 15px; width: 100%; margin: 0; align-items: flex-start; }
        .analytics-content-area { flex-grow: 1; min-width: 0; }
        
        /* Premium Card Style */
        .premium-card { background: #ffffff; border: 1px solid #f1f5f9; border-radius: 18px; box-shadow: 0 10px 25px rgba(0, 0, 0, 0.02); }
        
        /* Table Styling */
        .table thead th { font-size: 0.85rem; text-transform: uppercase; letter-spacing: 0.5px; color: #64748b; padding: 16px; border-bottom: 2px solid #f1f5f9; }
        .table tbody td { padding: 20px 16px; font-weight: 500; color: #334155; }
        .badge { font-weight: 600; padding: 6px 12px; border-radius: 8px; }
        .btn-action { transition: all 0.2s; }
        .btn-action:hover { transform: translateY(-2px); }
    </style>
</head>
<body>

<!-- Header -->
<jsp:include page="header.jsp" />

<div class="workspace-wrapper">
    <!-- Sidebar -->
    <jsp:include page="/WEB-INF/views/sidebar.jsp" />
    
    <!-- Main Content -->
    <div class="analytics-content-area">
        <div class="mb-4">
            <h2 class="fw-bold text-dark m-0" style="letter-spacing: -0.5px;">Tag Requests</h2>
            <p class="text-secondary small m-0 mt-1">Review and approve pending tag submissions from the community.</p>
        </div>

        <div class="card premium-card border-0 p-4">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th>Tag Name</th>
                            <th>Category</th>
                            <th>Requested By</th>
                            <th class="text-end">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty pendingList}">
                                <c:forEach items="${pendingList}" var="req">
                                    <tr>
                                        <td><span class="badge bg-primary-subtle text-primary border border-primary-subtle">${req.name}</span></td>
                                        <td>${req.category.name}</td>
                                        <td><span class="text-dark fw-bold">${req.requestedBy.name}</span></td>
                                        <td class="text-end">
                                            <form action="${pageContext.request.contextPath}/admin/tag-request-process/action" method="POST" class="d-inline">
                                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                                <input type="hidden" name="id" value="${req.id}" />
                                                
                                                <button type="submit" name="action" value="ACCEPT" class="btn btn-sm btn-success px-3 py-2 rounded-3 btn-action me-2">
                                                    <i class="fa-solid fa-check me-1"></i> Accept
                                                </button>
                                                
                                                <button type="submit" name="action" value="REJECT" class="btn btn-sm btn-danger px-3 py-2 rounded-3 btn-action" 
                                                        onclick="return confirm('Are you sure you want to reject this request?');">
                                                    <i class="fa-solid fa-xmark me-1"></i> Reject
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="4" class="text-center py-5 text-muted">
                                        <i class="fa-solid fa-inbox fa-2x mb-3 d-block opacity-50"></i>
                                        No pending requests found.
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<jsp:include page="footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>