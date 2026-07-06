<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Cheatsheets - Platform Analytics</title>
    
    <!-- Design System Synchronization Framework -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    
    <style>
        :root {
            --bg-canvas: #f4fbfc;       
            --brand-blue: #2563eb;     
            --brand-blue-gradient: linear-gradient(135deg, #1e40af, #2563eb);
            --brand-light: #eff6ff;     
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
            font-size: 22px;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
        }

        /* Row Index Component Metric Framework */
        .rank-number { 
            width: 34px; 
            height: 34px; 
            display: flex; 
            align-items: center; 
            justify-content: center; 
            border-radius: 10px; 
            background: #f1f5f9; 
            font-weight: 800; 
            color: #475569; 
        }

        /* Distinct highlighting for the top 3 items in the list */
        tr:nth-child(1) .rank-number { background: #fef3c7; color: #d97706; }
        tr:nth-child(2) .rank-number { background: #e2e8f0; color: #475569; }
        tr:nth-child(3) .rank-number { background: #ffedd5; color: #ea580c; }
        
        .badge-rating { 
            background: #fffbeb; 
            color: #d97706; 
            font-weight: 700; 
            padding: 6px 14px; 
            border-radius: 20px; 
            border: 1px solid #fde68a; 
            font-size: 14px;
        }

        .table tbody tr:hover {
            background-color: #f8fafc;
            transition: background-color 0.2s ease;
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
                    <h2 class="fw-extrabold text-dark mb-1" style="font-weight: 800; letter-spacing: -0.5px;">Platform Analytics</h2>
                    <p class="text-muted mb-0" style="font-size: 15px;">
                        Live dynamic performance details for Year: <strong>${currentYear}</strong> | Month: <strong>${currentMonth}</strong>
                    </p>
                </div>

                <!-- Unified Info Card Component Container -->
                <div class="info-card">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div>
                            <h3 class="info-card-title">
                                <i class="fa-solid fa-file-code me-2 text-primary"></i> All Cheatsheets Repository
                            </h3>
                            <p class="text-muted m-0" style="font-size: 14px;">
                                Displaying target records matching the active external context timeframe boundary.
                            </p>
                        </div>
                    </div>

                    <div class="table-responsive">
                        <table class="table align-middle" style="border-color: #f1f5f9;">
                            <thead style="background-color: #f8fafc; color: #64748b; font-weight: 700; font-size: 14px;">
                                <tr>
                                    <th class="text-center" style="padding: 14px; width: 100px;">No.</th>
                                    <th>Title</th>
                                    <th>Author</th>
                                    <th style="width: 160px;">Rating</th>
                                </tr>
                            </thead>
                            <tbody style="font-size: 15px;">
                                <c:choose>
                                    <c:when test="${not empty topRatingList}">
                                        <c:forEach items="${topRatingList}" var="item" varStatus="loop">
                                            <tr>
                                                <td class="text-center">
                                                    <div class="rank-number mx-auto">${loop.count}</div>
                                                </td>
                                                <td class="fw-semibold text-dark" style="padding: 18px 12px;">${item.title}</td>
                                                <td style="color: #475569;">${item.user.name}</td>
                                                <td>
                                                    <span class="badge-rating">
                                                        <i class="fas fa-star text-warning me-1"></i>${item.ratingAvg}
                                                    </span>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="4" class="text-center py-5 text-muted" style="font-size: 16px;">
                                                <i class="bi bi-folder-x d-block mb-2" style="font-size: 40px; color: #cbd5e1;"></i>
                                                No records discovered for the specified timeframe setup.
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
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>