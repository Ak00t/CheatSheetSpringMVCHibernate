<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%
    DateTimeFormatter reviewedAtFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
    request.setAttribute("reviewedAtFormatter", reviewedAtFormatter);
%>
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

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: var(--bg-canvas);
            color: var(--text-dark);
            margin: 0;
            padding: 0;
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

        .info-card {
            background-color: #ffffff;
            border-radius: 20px;
            padding: 30px;
            border: none;
            box-shadow: var(--shadow-sm);
        }

        .info-card-title {
            font-weight: 800;
            color: var(--brand-blue);
            font-size: 20px;
            margin-bottom: 20px;
        }

        .section-title {
            font-weight: 800;
            color: #0f172a;
        }

        .report-target-button {
            border: 0;
            background: transparent;
            padding: 0;
            text-align: left;
            width: 100%;
        }

        .report-target-button:hover .target-preview-title {
            color: #0f172a;
            text-decoration: underline;
        }

        .target-preview-title {
            display: inline-block;
            font-weight: 700;
            color: #334155;
            line-height: 1.35;
        }

        .target-preview-subtitle {
            font-size: 12px;
            color: #64748b;
            margin-top: 4px;
        }

        .card-title-bar {
            cursor: pointer;
            border-top: 5px solid var(--preview-accent, #2563eb);
            color: #0f172a;
        }

        .card-title-bar .fa-chevron-down {
            transition: transform 0.2s ease;
        }

        .card-title-bar[aria-expanded="false"] .fa-chevron-down {
            transform: rotate(-90deg);
        }

        .row-block {
            display: grid;
            grid-template-columns: 1.2fr 1fr 1fr;
            align-items: center;
            gap: 10px;
            padding: 10px 12px;
            border-radius: 4px;
        }

        .row-block:nth-child(odd) {
            background: #ffffff;
        }

        .row-block:nth-child(even) {
            background: rgba(0, 0, 0, 0.01);
        }

        .cell-key-left {
            font-weight: 700;
            color: #0f172a;
            word-break: break-word;
        }

        .highlight-box {
            background: #fffbeb;
            border-left: 4px solid #f59e0b;
        }

        .site-footer {
            background: #111827;
            color: white;
            margin-top: 60px;
            padding: 40px 20px;
            text-align: center;
        }
        .admin-sticky-header {
    position: fixed !important;
    top: 0;
    left: 0;
    width: 100%;
    z-index: 1060; /* အခြား element များ၏ အပေါ်၌ အမြဲလွှမ်းမိုးထားရန် */
}

/* 🌟 Header ကြောင့် အောက်ခြေ Content များ အပေါ်သို့ အတင်းတိုးမဝင်စေရန် Spacer */
body {
    padding-top: 80px !important; /* Header ၏ အမြင့်အလိုက် Content များကို အောက်သို့ တန်းစီတွန်းချပေးခြင်း */
}
    </style>
</head>
<body>
<div class="page-container">
        <header class="admin-sticky-header" style="background:white; padding:20px 50px; display:flex; justify-content:space-between; align-items:center; box-shadow:0 2px 20px rgba(0,0,0,.05); box-sizing: border-box;">
    <h2 style="color:#2563eb; margin: 0; flex-shrink: 0;">
        <a href="${pageContext.request.contextPath}/" class="text-decoration-none" style="color: #2563eb;">
            CheatSheet Hub
        </a>
    </h2>
    <nav style="display:flex; align-items:center; gap:25px; flex-shrink: 0; white-space: nowrap;">
        <a href="${pageContext.request.contextPath}/admin/profile" style="text-decoration:none; color:#334155; font-weight: 600;">Profile</a>
    </nav>
</header>

    <div class="page-wrapper">
        <jsp:include page="sidebar.jsp" />

        <div class="main-workspace">
            <div class="info-card">
                <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 gap-3">
                    <div>
                        <h3 class="info-card-title mb-1">
                            <i class="fa-solid fa-gavel me-2"></i> Community Violation Reports Room
                        </h3>
                        <p class="text-muted mb-0">
                            Review pending reports, issue warnings or bans, and track processed decisions in one place.
                        </p>
                    </div>
                    <div class="badge bg-light text-dark border px-3 py-2">
                        Warning, ban, and reject actions are only allowed for pending reports.
                    </div>
                </div>

                <section class="mb-5">
                    <div class="d-flex align-items-center justify-content-between mb-3">
                        <h4 class="section-title mb-0">Pending Reports</h4>
                        <span class="text-muted small">
                            <c:out value="${empty pendingReportsList ? 0 : fn:length(pendingReportsList)}" /> open items
                        </span>
                    </div>

                    <c:choose>
                        <c:when test="${not empty pendingReportsList}">
                            <div class="table-responsive">
                                <table class="table align-middle">
                                    <thead class="table-light">
                                    <tr>
                                        <th>ID</th>
                                        <th>Reporter</th>
                                        <th>Target</th>
                                        <th>Reason</th>
                                        <th>Description</th>
                                        <th class="text-end">Actions</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="report" items="${pendingReportsList}" varStatus="status">
                                        <c:set var="preview" value="${pendingTargetPreviews[report.id]}" />
                                        <c:set var="isActionableTarget" value="${report.targetType eq 'USER' or report.targetType eq 'CHEATSHEET' or report.targetType eq 'COMMENT'}" />
                                        <tr>
                                            <td class="fw-bold"><c:out value="${status.count}" /></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty report.reporterUser}">
                                                        <c:out value="${report.reporterUser.name}" />
                                                        <div class="text-muted small">ID: <c:out value="${report.reporterUser.id}" /></div>
                                                    </c:when>
                                                    <c:otherwise>Unknown</c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${report.targetType eq 'COMMENT' and not empty preview.comment}">
                                                        <button type="button" class="report-target-button" data-bs-toggle="modal" data-bs-target="#commentModal-${report.id}">
                                                            <span class="badge bg-info text-dark text-uppercase">COMMENT</span>
                                         
                                                            <div class="target-preview-subtitle">
                                                                <c:out value="${preview.displaySubtitle}" />
                                                            </div>
                                                        </button>
                                                    </c:when>
                                                    <c:when test="${report.targetType eq 'CHEATSHEET' and not empty preview.cheatsheet}">
                                                        <button type="button" class="report-target-button" data-bs-toggle="modal" data-bs-target="#cheatsheetModal-${report.id}">
                                                            <span class="badge bg-success text-uppercase">CHEATSHEET</span>
                                            
                                                            <div class="target-preview-subtitle">
                                                                <c:out value="${preview.displaySubtitle}" />
                                                            </div>
                                                        </button>
                                                    </c:when>
                                                    <c:when test="${report.targetType eq 'USER' and not empty preview.user}">
                                                        <div class="d-flex flex-column gap-1">
                                                            <span class="badge bg-primary text-uppercase d-inline-block">USER</span>
                                                            <span class="target-preview-title">
                                                                <c:out value="${preview.displayLabel}" />
                                                            </span>
                                                            <span class="target-preview-subtitle">
                                                                <c:out value="${preview.displaySubtitle}" />
                                                            </span>
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="d-flex flex-column gap-1">
                                                            <span class="badge bg-dark text-uppercase d-inline-block">
                                                                <c:out value="${report.targetType}" />
                                                            </span>
                                                            <span class="target-preview-title">
                                                                <c:out value="${preview.displayLabel}" />
                                                            </span>
                                                            <span class="target-preview-subtitle">
                                                                <c:out value="${preview.displaySubtitle}" />
                                                            </span>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <span class="badge bg-danger">
                                                    <c:out value="${report.reason}" />
                                                </span>
                                            </td>
                                            <td style="max-width: 260px;">
                                                <c:out value="${report.description}" />
                                            </td>
                                            <td class="text-end">
                                                <div class="d-inline-flex gap-2">
                                                    <c:if test="${isActionableTarget}">
                                                        <button type="button" class="btn btn-sm btn-outline-warning fw-semibold" data-bs-toggle="modal" data-bs-target="#warningModal-${report.id}">
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
                                                    </c:if>
                                                    <c:if test="${not isActionableTarget}">
                                                        <span class="text-muted small align-self-center">No direct action available</span>
                                                    </c:if>
                                                </div>

                                                <c:if test="${isActionableTarget}">
                                                    <div class="modal fade text-start" id="warningModal-${report.id}" tabindex="-1" aria-hidden="true">
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
                                                                    <textarea name="warningMessage" class="form-control" rows="4" required>Your account/content (ID: ${report.targetId}) has been reported for ${report.reason}. Please review community guidelines.</textarea>
                                                                </div>
                                                                <div class="modal-footer">
                                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                                    <button type="submit" class="btn btn-warning fw-bold">Transmit Warning</button>
                                                                </div>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </c:if>

                                                <c:if test="${report.targetType eq 'COMMENT' and not empty preview.comment}">
                                                    <div class="modal fade text-start" id="commentModal-${report.id}" tabindex="-1" aria-hidden="true">
                                                        <div class="modal-dialog modal-dialog-centered modal-lg modal-dialog-scrollable">
                                                            <div class="modal-content border-0 shadow">
                                                                <div class="modal-header bg-dark text-white">
                                                                    <div>
                                                                        <div class="small text-uppercase opacity-75">Comment Preview</div>
                                                                        <h5 class="modal-title fw-bold mb-0">
                                                                            <c:out value="${preview.comment.user.name}" />
                                                                        </h5>
                                                                    </div>
                                                                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                                                                </div>
                                                                <div class="modal-body">
                                                                    <div class="p-3 rounded-4 border bg-light">
                                                                        <div class="d-flex flex-wrap align-items-center gap-2 mb-3">
                                                                            <span class="badge bg-info text-dark">COMMENT</span>
                                                                            <span class="fw-semibold"><c:out value="${preview.comment.user.name}" /></span>
                                                                            <span class="text-muted small">on <c:out value="${preview.comment.cheatsheet.title}" /></span>
                                                                        </div>
                                                                        <div class="p-3 rounded-3 bg-white border" style="white-space: pre-wrap; line-height: 1.7;">
                                                                            <c:out value="${preview.comment.content}" />
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:if>

                                                <c:if test="${report.targetType eq 'CHEATSHEET' and not empty preview.cheatsheet}">
                                                    <div class="modal fade text-start" id="cheatsheetModal-${report.id}" tabindex="-1" aria-hidden="true">
                                                        <div class="modal-dialog modal-dialog-centered modal-xl modal-dialog-scrollable">
                                                            <div class="modal-content border-0 overflow-hidden">
                                                                <div class="modal-header text-white"
                                                                     style="background: ${not empty preview.cheatsheet.themeColor ? preview.cheatsheet.themeColor : '#2563eb'};">
                                                                    <div>
                                                                        <div class="small text-uppercase opacity-75">Cheatsheet Preview</div>
                                                                        <h5 class="modal-title fw-bold mb-0">
                                                                            <c:out value="${preview.cheatsheet.title}" />
                                                                        </h5>
                                                                    </div>
                                                                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                                                                </div>
                                                                <div class="modal-body bg-white">
                                                                    <div class="mb-4">
                                                                        <h4 class="fw-bold mb-2">
                                                                            <c:out value="${preview.cheatsheet.title}" />
                                                                            Cheat Sheet
                                                                            <span class="text-primary">by
                                                                                <c:out value="${preview.cheatsheet.user.name}" />
                                                                            </span>
                                                                        </h4>
                                                                        <p class="text-muted mb-0">
                                                                            <c:out value="${preview.cheatsheet.description}" />
                                                                        </p>
                                                                    </div>
                                                                    <div class="row g-4 mb-4">
                                                                        <c:forEach items="${preview.cheatsheet.sections}" var="section">
                                                                            <div class="col-12 col-md-6 col-lg-4">
                                                                                <div class="card shadow-sm h-100 border-0 overflow-hidden"
                                                                                     style="border-radius: 12px; --preview-accent: ${not empty preview.cheatsheet.themeColor ? preview.cheatsheet.themeColor : '#2563eb'};">
                                                                                    <div class="card-header card-title-bar bg-white d-flex justify-content-between align-items-center py-3 px-3 fs-6 fw-bold"
                                                                                         data-bs-toggle="collapse"
                                                                                         data-bs-target="#pending-collapse-${report.id}-${section.id}"
                                                                                         aria-expanded="true">
                                                                                        <span><c:out value="${section.title}" /></span>
                                                                                        <i class="fa-solid fa-chevron-down small text-muted"></i>
                                                                                    </div>
                                                                                    <div id="pending-collapse-${report.id}-${section.id}" class="collapse show">
                                                                                        <div class="card-body p-3">
                                                                                            <c:forEach items="${section.rows}" var="row">
                                                                                                <c:forEach items="${row.cells}" var="cell">
                                                                                                    <div class="row-block mb-1">
                                                                                                        <div class="cell-key-left small">
                                                                                                            <c:out value="${row.rowTitle}" />
                                                                                                        </div>
                                                                                                        <div class="text-muted small">
                                                                                                            <c:out value="${not empty cell.cellKey ? cell.cellKey : ''}" />
                                                                                                        </div>
                                                                                                        <div class="text-muted small text-end">
                                                                                                            <c:out value="${cell.cellValue}" />
                                                                                                        </div>
                                                                                                    </div>
                                                                                                </c:forEach>
                                                                                            </c:forEach>

                                                                                            <c:forEach items="${section.notes}" var="note">
                                                                                                <div class="highlight-box p-3 mt-3 rounded">
                                                                                                    <c:if test="${not empty note.noteTitle}">
                                                                                                        <div class="fw-bold text-warning-emphasis mb-1">
                                                                                                            <c:out value="${note.noteTitle}" />
                                                                                                        </div>
                                                                                                    </c:if>
                                                                                                    <div class="small text-dark">
                                                                                                        <c:out value="${note.noteContent}" />
                                                                                                    </div>
                                                                                                </div>
                                                                                            </c:forEach>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </c:forEach>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:if>
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
                                <p style="margin: 0; font-size: 16px; font-weight: 500;">No pending reports at the moment. The community is clean!</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </section>

                <section>
                    <div class="d-flex align-items-center justify-content-between mb-3">
                        <h4 class="section-title mb-0">Review History</h4>
                        <span class="text-muted small">Processed warning, ban, and reject decisions</span>
                    </div>

                    <c:choose>
                        <c:when test="${not empty reportHistoryList}">
                            <div class="table-responsive">
                                <table class="table align-middle">
                                    <thead class="table-light">
                                    <tr>
                                        <th>No.</th>
                                        <th>Target</th>
                                        <th>Status</th>
                                        <th>Reviewed By</th>
                                        <th>Reviewed At</th>
                                        <th>Reason</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="report" items="${reportHistoryList}" varStatus="status">
                                        <c:set var="preview" value="${historyTargetPreviews[report.id]}" />
                                        <tr>
                                            <td class="fw-bold"><c:out value="${status.count}" /></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${report.targetType eq 'COMMENT' and not empty preview.comment}">
                                                        <span class="badge bg-info text-dark text-uppercase">COMMENT</span>
                                            
                                                        <div class="target-preview-subtitle">
                                                            <c:out value="${preview.displaySubtitle}" />
                                                        </div>
                                                    </c:when>
                                                    <c:when test="${report.targetType eq 'CHEATSHEET' and not empty preview.cheatsheet}">
                                                        <span class="badge bg-success text-uppercase">CHEATSHEET</span>
                                       
                                                        <div class="target-preview-subtitle">
                                                            <c:out value="${preview.displaySubtitle}" />
                                                        </div>
                                                    </c:when>
                                                    <c:when test="${report.targetType eq 'USER' and not empty preview.user}">
                                                        <span class="badge bg-primary text-uppercase d-inline-block">USER</span>
                                                        <div class="target-preview-title">
                                                            <c:out value="${preview.displayLabel}" />
                                                        </div>
                                                        <div class="target-preview-subtitle">
                                                            <c:out value="${preview.displaySubtitle}" />
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-dark text-uppercase d-inline-block">
                                                            <c:out value="${report.targetType}" />
                                                        </span>
                                                        <div class="target-preview-title">
                                                            <c:out value="${preview.displayLabel}" />
                                                        </div>
                                                        <div class="target-preview-subtitle">
                                                            <c:out value="${preview.displaySubtitle}" />
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${report.status eq 'REVIEWED'}">
                                                        <span class="badge bg-warning text-dark">Warning Sent</span>
                                                    </c:when>
                                                    <c:when test="${report.status eq 'RESOLVED'}">
                                                        <span class="badge bg-danger">Banned / Resolved</span>
                                                    </c:when>
                                                    <c:when test="${report.status eq 'REJECTED'}">
                                                        <span class="badge bg-secondary">Rejected</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-info text-dark">
                                                            <c:out value="${report.status}" />
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty report.reviewedBy}">
                                                        <c:out value="${report.reviewedBy.name}" />
                                                    </c:when>
                                                    <c:otherwise>System</c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty report.reviewedAt}">
                                                        <c:out value="${report.reviewedAt.format(reviewedAtFormatter)}" />
                                                    </c:when>
                                                    <c:otherwise>-</c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td style="max-width: 280px;">
                                                <c:out value="${report.description}" />
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
                                <p style="margin: 0; font-size: 16px;">No review history yet.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </section>
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
