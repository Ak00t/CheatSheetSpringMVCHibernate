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
        .premium-card { background: #ffffff; border: 1px solid #f1f5f9; border-radius: 18px; box-shadow: 0 10px 25px rgba(0, 0, 0, 0.02); }
        .table thead th { font-size: 0.85rem; text-transform: uppercase; letter-spacing: 0.5px; color: #64748b; padding: 16px; border-bottom: 2px solid #f1f5f9; }
        .table tbody td { padding: 20px 16px; font-weight: 500; color: #334155; }
        .badge { font-weight: 600; padding: 6px 12px; border-radius: 8px; }
        .btn-action { transition: all 0.2s; padding: 8px 20px; font-weight: 600; }
        .btn-action:hover { transform: translateY(-2px); }
    </style>
</head>
<body>

<header style="background:white; padding:20px 50px; display:flex; justify-content:space-between; align-items:center; box-shadow:0 2px 20px rgba(0,0,0,.05);">
    <h2 style="color:#2563eb; margin: 0;">CheatSheet Hub</h2>
</header>

<div class="workspace-wrapper">
    <jsp:include page="/WEB-INF/views/sidebar.jsp" />
    
    <div class="analytics-content-area">
        <div class="mb-4">
            <h2 class="fw-bold text-dark">Tag Requests</h2>
            <p class="text-secondary">Review and approve pending tag submissions.</p>
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
                                            <form action="${pageContext.request.contextPath}/admin/tag-request-process/action" method="POST">
                                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                                <input type="hidden" name="id" value="${req.id}" />
                                                
                                                <button type="button" class="btn btn-sm btn-success btn-action me-2" 
                                                        onclick="processTagRequest(this.form, 'ACCEPT')">
                                                    <i class="fa-solid fa-check me-1"></i> Accept
                                                </button>
                                                
                                                <button type="button" class="btn btn-sm btn-danger btn-action" 
                                                        onclick="if(confirm('Are you sure you want to reject?')) processTagRequest(this.form, 'REJECT')">
                                                    <i class="fa-solid fa-xmark me-1"></i> Reject
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="4" class="text-center py-5 text-muted">No pending requests found.</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp" />
<!-- Custom Alert Modal -->
<div id="customAlert" style="display:none; position:fixed; top:30px; right:30px; background:#ffffff; border-left: 6px solid #f59e0b; padding:25px; border-radius:12px; box-shadow: 0 20px 25px rgba(0,0,0,0.1); z-index:9999; max-width:450px; border: 1px solid #e5e7eb;">
    <div style="display:flex; align-items:flex-start;">
        <div style="color:#f59e0b; font-size:28px; margin-right:18px;"><i class="fa-solid fa-triangle-exclamation"></i></div>
        <div>
            <div style="color:#92400e; font-weight:800; font-size:18px;">Duplicate Tag Exists</div>
            <p style="color:#4b5563; font-size:14px;">The tag already exists in the approved database.</p>
            <button onclick="document.getElementById('customAlert').style.display='none'" class="btn btn-warning btn-sm">Dismiss</button>
        </div>
    </div>
</div>

<script>
    async function processTagRequest(formElement, actionType) {
        const formData = new FormData(formElement);
        formData.append('action', actionType);
        
        try {
            const response = await fetch(formElement.action, {
                method: 'POST',
                body: new URLSearchParams(formData)
            });

            if (response.ok) {
                location.reload(); 
            } else if (response.status === 409) {
                document.getElementById('customAlert').style.display = 'block';
            } else {
                alert("Error occurred!");
            }
        } catch (error) {
            console.error("Error:", error);
        }
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>