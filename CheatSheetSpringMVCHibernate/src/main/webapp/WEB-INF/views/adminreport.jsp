<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DevNote Admin - Report Control Room</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Plus Jakarta Sans', sans-serif; background-color: #f4fbfc; color: #1e293b; }
        .wrapper { display: flex; min-height: 100vh; }
        .main-content { flex-grow: 1; padding: 24px; }
        .info-card { background-color: #ffffff; border-radius: 20px; padding: 30px; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05); }
    </style>
</head>
<body>

        <header style="background:white; padding:20px 50px; display:flex; justify-content:space-between; align-items:center; box-shadow:0 2px 20px rgba(0,0,0,.05);">
            <h2 style="color:#2563eb; margin: 0;">CheatSheet Hub</h2>
            <nav style="display:flex; gap:25px;">
         
                <a href="${pageContext.request.contextPath}/admin/profile" style="text-decoration:none; color:#334155; font-weight: 600;">Profile</a>
            </nav>
        </header>

    <div class="wrapper">
        <!-- Sidebar Include -->
        <jsp:include page="sidebar.jsp" />
     
        <div class="main-content">
            <div class="info-card">
                <h3 class="fw-bold text-primary mb-4"><i class="fa-solid fa-gavel"></i> Community Violation Reports Room</h3>
                
                <c:choose>
                    <c:when test="${not empty pendingReportsList}">
                        <div class="table-responsive">
                            <table class="table align-middle">
                                <thead class="table-light">
                                    <tr>
                                        <th>Report ID</th>
                                        <th>Reporter User</th>
                                        <th>Target Type</th>
                                        <th>Target ID</th>
                                        <th>Violation Reason</th>
                                        <th>Report Description</th>
                                        <th class="text-end">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="report" items="${pendingReportsList}">
                                        <tr>
                                            <td class="fw-bold"><c:out value="${report.id}"/></td>
                                            <td>ID: <c:out value="${report.reporterUser.id}"/></td>
                                            <td><span class="badge bg-dark text-uppercase"><c:out value="${report.targetType}"/></span></td>
                                            <td class="fw-semibold">ID: <c:out value="${report.targetId}"/></td>
                                            
                                            <td><span class="badge bg-danger"><c:out value="${report.reason}"/></span></td>
                                            <td style="max-width: 250px;"><c:out value="${report.description}"/></td>
                                            <td class="text-end">
                                                <div class="d-inline-flex gap-2">
                                                    <button type="button" class="btn btn-sm btn-outline-warning fw-semibold" 
                                                            data-bs-toggle="modal" data-bs-target="#warningModal${report.id}">
                                                        <i class="fa-solid fa-paper-plane"></i> Warn
                                                    </button>
                                                    
                                                    <form action="${pageContext.request.contextPath}/admin/reports/resolve" method="POST" style="margin:0;">
                                                        <input type="hidden" name="reportId" value="${report.id}" />
                                                        <button type="submit" name="actionType" value="BAN" class="btn btn-sm btn-danger fw-semibold">
                                                            <i class="fa-solid fa-ban"></i> Ban
                                                        </button>
                                                        <button type="submit" name="actionType" value="REJECT" class="btn btn-sm btn-outline-secondary fw-semibold">
                                                            Reject
                                                        </button>
                                                    </form>
                                                </div>

                                                <!-- Warning Message Modal Window -->
                                                <div class="modal fade text-start" id="warningModal${report.id}" tabindex="-1" aria-hidden="true">
                                                    <div class="modal-dialog">
                                                        <form action="${pageContext.request.contextPath}/admin/reports/resolve" method="POST" class="modal-content">
                                                            <input type="hidden" name="reportId" value="${report.id}" />
                                                            <input type="hidden" name="actionType" value="WARNING" />
                                                            <div class="modal-header">
                                                                <h5 class="modal-title fw-bold">Send Warning Notice</h5>
                                                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                            </div>
                                                            <div class="modal-body">
                                                                <label class="form-label fw-semibold text-secondary">Warning Message Content</label>
                                                                <textarea name="warningMessage" class="form-control" rows="4" required>Your account/content (ID: ${report.targetId}) has been reported for ${report.reason}. Please review community terms guidelines.</textarea>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                                <button type="submit" class="btn btn-warning fw-bold">Transmit Warning</button>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center py-5">
                            <p class="fs-5 text-muted">No pending reports found.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <!-- Footer Include -->
   <jsp:include page="footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>