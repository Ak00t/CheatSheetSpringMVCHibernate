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
        :root {
            --bg-canvas: #f4fbfc;
            --brand-blue: #2563eb;
            --text-dark: #1e293b;
            --text-gray: #64748b;
            --shadow-sm: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
        }
        body { font-family: 'Plus Jakarta Sans', sans-serif; background-color: var(--bg-canvas); color: var(--text-dark); margin: 0; padding: 0; }
        .page-container { display: flex; flex-direction: column; min-height: 100vh; }
        .page-wrapper { display: flex; padding: 24px; gap: 24px; align-items: flex-start; flex: 1; }
        .main-workspace { flex-grow: 1; min-width: 0; }
        .info-card { background-color: #ffffff; border-radius: 20px; padding: 30px; border: none; box-shadow: var(--shadow-sm); }
        .info-card-title { font-weight: 800; color: var(--brand-blue); font-size: 20px; margin-bottom: 20px; }
        .site-footer { background: #111827; color: white; margin-top: 60px; padding: 40px 20px; text-align: center; }
    </style>
</head>
<body>

<div class="page-container">
    <header style="background:white; padding:20px 50px; display:flex; justify-content:space-between; align-items:center; box-shadow:0 2px 20px rgba(0,0,0,.05);">
        <h2 style="color:#2563eb; margin: 0;">CheatSheet Hub</h2>
        <nav style="display:flex; align-items:center; gap:25px;">
            <a href="${pageContext.request.contextPath}/admin/profile" style="text-decoration:none; color:#334155; font-weight: 600;">Profile</a>
        </nav>
    </header>

    <div class="page-wrapper">
        <jsp:include page="sidebar.jsp" />
     
        <div class="main-workspace">
            <div class="info-card">
                <h3 class="info-card-title"><i class="fa-solid fa-gavel"></i> Community Violation Reports Room</h3>
                
                <c:choose>
                    <c:when test="${not empty pendingReportsList}">
                        <div class="table-responsive">
                            <table class="table align-middle" style="border-color: #f1f5f9;">
                                <thead style="background-color: #f8fafc; color: #64748b; font-weight: 700; font-size: 14px;">
                                    <tr>
                                        <th style="padding: 14px;">ID</th>
                                        <th>Reporter</th>
                                        <th>Target</th>
                                        <th>Reason</th>
                                        <th>Details</th>
                                        <th class="text-end" style="padding-right: 14px;">Actions</th>
                                    </tr>
                                </thead>
                                <tbody style="font-size: 15px;">
                                    <c:forEach var="report" items="${pendingReportsList}">
                                        <tr>
                                            <td style="padding: 16px; font-weight: 700; color: #64748b;">#<c:out value="${report.id}"/></td>
                                            <td>ID: <c:out value="${report.reporterUser.id}"/></td>
                                            <td>
                                                <span class="badge bg-dark text-uppercase" style="font-size: 11px; padding: 6px 10px;">${report.targetType}</span>
                                                <div class="fw-semibold">ID: ${report.targetId}</div>
                                            </td>
                                            <td><span class="badge bg-danger" style="font-size: 11px; padding: 6px 10px;">${report.reason}</span></td>
                                            <td style="max-width: 250px; color: #475569;"><c:out value="${report.description}"/></td>
                                            <td class="text-end" style="padding-right: 14px;">
                                                <div class="d-inline-flex gap-2">
                                                    <button type="button" class="btn btn-sm btn-outline-warning" style="border-radius: 8px; font-weight: 600;" data-bs-toggle="modal" data-bs-target="#warningModal${report.id}">
                                                        <i class="fa-solid fa-triangle-exclamation"></i> Warn
                                                    </button>
                                                    <form action="${pageContext.request.contextPath}/admin/reports/resolve" method="POST" style="margin:0; display: inline-flex; gap: 8px;">
                                                        <input type="hidden" name="reportId" value="${report.id}" />
                                                        <button type="submit" name="actionType" value="BAN" class="btn btn-sm btn-danger" style="border-radius: 8px; font-weight: 600;">Ban</button>
                                                        <button type="submit" name="actionType" value="REJECT" class="btn btn-sm btn-outline-secondary" style="border-radius: 8px; font-weight: 600;">Reject</button>
                                                    </form>
                                                </div>

                                                <!-- Warning Modal -->
                                                <div class="modal fade text-start" id="warningModal${report.id}" tabindex="-1" aria-hidden="true">
                                                    <div class="modal-dialog">
                                                        <form action="${pageContext.request.contextPath}/admin/reports/resolve" method="POST" class="modal-content">
                                                            <input type="hidden" name="reportId" value="${report.id}" />
                                                            <input type="hidden" name="actionType" value="WARNING" />
                                                            <div class="modal-header"><h5 class="modal-title fw-bold">Send Warning</h5><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div>
                                                            <div class="modal-body">
                                                                <label class="form-label fw-semibold">Violation Reason</label>
                                                                <select name="warningMessage" class="form-select" required>
                                                                    <option value="" disabled selected>Choose a reason...</option>
                                                                    <option value="Spamming or repetitive content.">Spamming</option>
                                                                    <option value="Using abusive or offensive language.">Abusive language</option>
                                                                    <option value="Copyright infringement detected.">Copyright infringement</option>
                                                                </select>
                                                            </div>
                                                            <div class="modal-footer"><button type="submit" class="btn btn-warning fw-bold">Transmit Warning</button></div>
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
                        <div class="text-center py-5 text-muted">
                            <i class="fa-solid fa-circle-check" style="font-size: 48px; color: #10b981; margin-bottom: 12px;"></i>
                            <p style="margin: 0; font-size: 16px;">No pending reports at the moment.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <footer class="site-footer">
        <div class="footer-container">
            <h3>CheatSheet Hub</h3>
            <p>© 2026 CheatSheet Hub. All Rights Reserved.</p>
        </div>
    </footer>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>