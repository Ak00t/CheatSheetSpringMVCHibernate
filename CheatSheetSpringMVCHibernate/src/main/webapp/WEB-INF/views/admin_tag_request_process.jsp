<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pending Requests - CheatSheet Hub</title>
    
    <!-- Design System Synchronization Framework -->
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
            --shadow-hover: 0 20px 35px rgba(37, 99, 235, 0.1);
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

        /* Standardized Dashboard Card Component */
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
            font-size: 20px;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
        }

        .table tbody tr:hover {
            background-color: #f8fafc;
            transition: background-color 0.2s ease;
        }

        .badge-custom {
            font-weight: 700;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 13px;
        }

        .btn-action {
            border-radius: 8px;
            font-weight: 600;
            padding: 6px 16px;
            transition: all 0.2s ease;
        }
        .btn-action:hover {
            transform: translateY(-1px);
        }

        /* Fixed Structural Layout Components */
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
        
        <!-- Synchronized Admin Global Header Area -->
        <header style="background:white; padding:20px 50px; display:flex; justify-content:space-between; align-items:center; box-shadow:0 2px 20px rgba(0,0,0,.05);">
            <h2 style="color:#2563eb; margin: 0; font-weight: 700;">CheatSheet Hub</h2>
            <nav style="display:flex; align-items:center; gap:25px;">
                <a href="${pageContext.request.contextPath}/admin/profile" style="text-decoration:none; color:#334155; font-weight: 600;">Profile</a>
            </nav>
        </header>

        <!-- Standardized Layout Framework wrapper -->
        <div class="page-wrapper">
            
            <!-- Context View Dashboard Sidebar Component -->
            <jsp:include page="/WEB-INF/views/sidebar.jsp" />

            <!-- Core Working Stream Grid Segment -->
            <div class="main-workspace">
                
                <div class="mb-4 ps-1">
                    <h2 class="fw-bold text-dark mb-1" style="font-weight: 800; letter-spacing: -0.5px;">Tag Requests</h2>
                    <p class="text-muted mb-0" style="font-size: 15px;">Review and approve pending tag submissions from the community.</p>
                </div>

                <!-- Unified Info Card Component Container -->
                <div class="info-card" style="border-top-color: #2563eb;">
                    <h3 class="info-card-title mb-4">
                        <i class="fa-solid fa-tags me-2 text-primary"></i> Pending Tag Submissions
                    </h3>

                    <div class="table-responsive">
                        <table class="table align-middle" style="border-color: #f1f5f9;">
                            <thead style="background-color: #f8fafc; color: #64748b; font-weight: 700; font-size: 14px;">
                                <tr>
                                    <th style="padding: 14px;">Tag Name</th>
                                    <th>Category</th>
                                    <th>Requested By</th>
                                    <th class="text-end" style="padding-right: 14px; width: 240px;">Actions</th>
                                </tr>
                            </thead>
                            <tbody style="font-size: 15px;">
                                <c:choose>
                                    <c:when test="${not empty pendingList}">
                                        <c:forEach items="${pendingList}" var="req">
                                            <tr>
                                                <td style="padding: 16px;">
                                                    <span class="badge-custom bg-primary-subtle text-primary border border-primary-subtle">
                                                        <c:out value="${req.name}"/>
                                                    </span>
                                                </td>
                                                <td class="fw-semibold" style="color: #475569;"><c:out value="${req.category.name}"/></td>
                                                <td><span class="text-dark fw-bold"><c:out value="${req.requestedBy.name}"/></span></td>
                                                <td class="text-end" style="padding-right: 14px;">
                                                    <form action="${pageContext.request.contextPath}/admin/tag-request-process/action" method="POST" style="display: inline-flex; gap: 8px;">
                                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                                        <input type="hidden" name="id" value="${req.id}" />
                                                        
                                                        <button type="button" class="btn btn-sm btn-success btn-action" 
                                                                onclick="processTagRequest(this.form, 'ACCEPT')">
                                                            <i class="fa-solid fa-check me-1"></i> Accept
                                                        </button>
                                                        
                                                        <button type="button" class="btn btn-sm btn-danger btn-action style" style="background-color: #dc3545;"
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
                                            <td colspan="4" class="text-center py-5 text-muted" style="font-size: 16px;">
                                                <i class="bi bi-folder-x d-block mb-2" style="font-size: 40px; color: #cbd5e1;"></i>
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

        <!-- Synchronized Global Footer System Component -->
        <footer class="site-footer">
            <div class="footer-container">
                <h3>CheatSheet Hub</h3>
                <p>Learn Faster. Share Knowledge. Build Better.</p>
                <p class="copyright">© 2026 CheatSheet Hub. All Rights Reserved.</p>
            </div>
        </footer>
    </div>

    <!-- Custom Alert Modal aligned with Admin Design Theme -->
    <div id="customAlert" style="display:none; position:fixed; top:30px; right:30px; background:#ffffff; border-left: 6px solid #f59e0b; padding:25px; border-radius:12px; box-shadow: 0 20px 25px rgba(0,0,0,0.1); z-index:9999; max-width:450px; border: 1px solid #e5e7eb;">
        <div style="display:flex; align-items:flex-start;">
            <div style="color:#f59e0b; font-size:28px; margin-right:18px;"><i class="fa-solid fa-triangle-exclamation"></i></div>
            <div>
                <div style="color:#92400e; font-weight:800; font-size:18px; font-family: 'Plus Jakarta Sans', sans-serif;">Duplicate Tag Exists</div>
                <p style="color:#4b5563; font-size:14px; margin-top: 4px; margin-bottom: 12px; font-family: 'Plus Jakarta Sans', sans-serif;">The tag already exists in the approved database.</p>
                <button onclick="document.getElementById('customAlert').style.display='none'" class="btn btn-warning btn-sm fw-bold" style="border-radius: 6px; padding: 5px 15px;">Dismiss</button>
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

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>