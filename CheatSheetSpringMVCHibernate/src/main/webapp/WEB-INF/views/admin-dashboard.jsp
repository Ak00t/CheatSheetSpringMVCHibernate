<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DevNote Admin - Dashboard</title>
    
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
            --shadow-md: 0 12px 30px -5px rgba(37, 99, 235, 0.06);
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

        .dashboard-banner {
            background: var(--brand-blue-gradient);
            border-radius: 24px;
            padding: 45px 60px; 
            color: #ffffff;
            margin-bottom: 28px;
            box-shadow: 0 10px 25px -5px rgba(37, 99, 235, 0.25);
        }
        .banner-title {
            font-weight: 800;
            font-size: 50px; 
            margin-bottom: 12px;
            letter-spacing: -0.5px;
        }
        .banner-subtitle {
            font-size: 24px; 
            opacity: 0.95;
            margin: 0;
            max-width: 800px;
            line-height: 1.6;
        }

        /* Upgraded Premium Metric Cards styling matching image_e04ebe.jpg */
        .metric-card {
            background-color: #ffffff;
            border-radius: 20px;
            padding: 26px 24px;
            border: none;
            height: 100%;
            box-shadow: var(--shadow-sm);
            border-left: 5px solid var(--brand-blue);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .metric-card:hover {
            transform: translateY(-3px);
            box-shadow: var(--shadow-hover);
        }
        .metric-card.metric-users { border-left-color: #2563eb; }
        .metric-card.metric-cheatsheets { border-left-color: #10b981; }
        .metric-card.metric-reports { border-left-color: #f59e0b; }
        .metric-card.metric-banned { border-left-color: #ef4444; }

        .metric-value {
            font-size: 38px;
            font-weight: 800;
            color: var(--text-dark); 
            margin-bottom: 6px;
            line-height: 1;
        }
        .metric-users .metric-value { color: #2563eb; }
        .metric-cheatsheets .metric-value { color: #10b981; }
        .metric-reports .metric-value { color: #f59e0b; }
        .metric-banned .metric-value { color: #ef4444; }

        .metric-label {
            color: var(--text-gray);
            font-size: 14px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        /* Enhanced Info Card Designs with left indicators */
        .info-card {
            background-color: #ffffff;
            border-radius: 20px;
            padding: 28px;
            border: none;
            height: 100%;
            box-shadow: var(--shadow-sm);
            border-top: 4px solid var(--brand-blue);
        }
        .info-card-title {
            font-weight: 800;
            color: var(--text-dark); 
            font-size: 20px;
            margin-bottom: 18px;
            display: flex;
            align-items: center;
        }
        .info-card-text {
            color: var(--text-gray);
            font-size: 15px;
            line-height: 1.8;
            margin: 0;
        }
        
        .today-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        .today-list li {
            padding: 12px 0;
            font-size: 15px;
            color: var(--text-dark);
            border-bottom: 1px solid #f1f5f9;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .today-list li:last-child {
            border-bottom: none;
            padding-bottom: 0;
        }
        .today-list span {
            font-weight: 800;
            color: var(--brand-blue); 
            background: var(--brand-light);
            padding: 4px 12px;
            border-radius: 8px;
        }

        /* Continuous Vertical Ticker Animation Styling */
        .ticker-wrapper {
            height: 160px;
            overflow: hidden;
            position: relative;
            background: #fafcfe;
            border-radius: 12px;
            border: 1px dashed var(--border-light);
            padding: 10px;
        }
        .ticker-scroll-container {
            display: flex;
            flex-direction: column;
            gap: 10px;
            animation: verticalTicker 14s linear infinite;
        }
        .ticker-scroll-container:hover {
            animation-play-state: paused;
        }
        .ticker-item {
            background: #ffffff;
            padding: 12px 16px;
            border-radius: 10px;
            border-left: 4px solid #6366f1;
            font-size: 14px;
            font-weight: 600;
            color: var(--text-dark);
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 2px 8px rgba(0,0,0,0.01);
        }
        
        @keyframes verticalTicker {
            0% { transform: translateY(0); }
            100% { transform: translateY(-50%); }
        }

        /* Pulse Indicator Dots for Live Statuses */
        .pulse-dot {
            width: 8px;
            height: 8px;
            border-radius: 50%;
            display: inline-block;
            position: relative;
        }
        .pulse-dot.success { background-color: #10b981; }
        .pulse-dot.success::after {
            content: '';
            position: absolute;
            width: 100%;
            height: 100%;
            border-radius: 50%;
            background-color: #10b981;
            animation: livePulse 1.8s infinite ease-in-out;
            top: 0; left: 0;
        }
        .pulse-dot.primary { background-color: #2563eb; }
        .pulse-dot.primary::after {
            content: '';
            position: absolute;
            width: 100%;
            height: 100%;
            border-radius: 50%;
            background-color: #2563eb;
            animation: livePulse 1.8s infinite ease-in-out;
            top: 0; left: 0;
        }

        @keyframes livePulse {
            0% { transform: scale(1); opacity: 0.8; }
            100% { transform: scale(3); opacity: 0; }
        }

        /* System Status Row styling tweaks */
        .system-status-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 13.5px 0;
            border-bottom: 1px solid #f1f5f9;
        }
        .system-status-row:last-child {
            border-bottom: none;
            padding-bottom: 0;
        }
        .status-meta {
            font-size: 15px;
            font-weight: 600;
            color: var(--text-dark);
        }

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
        <header style="background:white; padding:20px 50px; display:flex; justify-content:space-between; align-items:center; box-shadow:0 2px 20px rgba(0,0,0,.05);">
            <h2 style="color:#2563eb; margin: 0;">CheatSheet Hub</h2>
            <nav style="display:flex; align-items:center; gap:25px;">
                <a href="${pageContext.request.contextPath}/admin/profile" style="text-decoration:none; color:#334155; font-weight: 600;">Profile</a>
            </nav>
        </header>

        <div class="page-wrapper">
            
            <!-- Sidebar Include remains untouched as requested -->
            <jsp:include page="/WEB-INF/views/sidebar.jsp" />

            <div class="main-workspace">
                
                <div class="dashboard-banner">
                    <h1 class="banner-title">Admin Dashboard</h1>
                    <p class="banner-subtitle">Monitor users, cheatsheets, reports, warning/ban thresholds, categories, tags and platform analytics.</p>
                </div>

                <!-- Color updated metric cards section -->
                <div class="row g-4 mb-4">
                    <div class="col-md-3">
                        <div class="metric-card metric-users">
                            <div class="metric-value"><c:out value="${not empty totalUsers ? totalUsers : '1'}"/></div>
                            <div class="metric-label">Total Users</div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="metric-card metric-cheatsheets">
                            <div class="metric-value"><c:out value="${not empty totalCheatsheets ? totalCheatsheets : '0'}"/></div>
                            <div class="metric-label">Cheatsheets</div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="metric-card metric-reports">
                            <div class="metric-value"><c:out value="${not empty pendingReports ? pendingReports : '0'}"/></div>
                            <div class="metric-label">Pending Reports</div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="metric-card metric-banned">
                            <div class="metric-value"><c:out value="${not empty bannedContents ? bannedContents : '0'}"/></div>
                            <div class="metric-label">Banned Contents</div>
                        </div>
                    </div>
                </div>

                <!-- Existing row styled with clean top-borders -->
                <div class="row g-4 mb-4">
                    <div class="col-md-7">
                        <div class="info-card" style="border-top-color: #2563eb;">
                            <h3 class="info-card-title" style="color: #2563eb;"><i class="bi bi-shield-exclamation me-2"></i> Report Threshold Rule</h3>
                            <p class="info-card-text">
                                <c:out value="${not empty warningThreshold ? warningThreshold : '5'}"/> reports = warning notification.<br>
                                <c:out value="${not empty banThreshold ? banThreshold : '10'}"/> reports = ban notification.<br><br>
                                Admin can manually ban anytime with reason.
                            </p>
                        </div>
                    </div>

                    <div class="col-md-5">
                        <div class="info-card" style="border-top-color: #10b981;">
                            <h3 class="info-card-title" style="color: #10b981;"><i class="bi bi-calendar-check me-2"></i> Today</h3>
                            <ul class="today-list">
                                <li>New users: <span><c:out value="${not empty newUsersToday ? newUsersToday : '1'}"/></span></li>
                                <li>New cheatsheets: <span><c:out value="${not empty newCheatsheetsToday ? newCheatsheetsToday : '0'}"/></span></li>
                                <li>New reports: <span><c:out value="${not empty newReportsToday ? newReportsToday : '0'}"/></span></li>
                                <li>Warnings sent: <span><c:out value="${not empty warningsSentToday ? warningsSentToday : '0'}"/></span></li>
                            </ul>
                        </div>
                    </div>
                </div>

                <!-- Modern Non-clickable Live Updates and Status Ticker Blocks -->
                <div class="row g-4 mb-4">
                    <div class="col-md-6">
                        <div class="info-card" style="border-top-color: #6366f1;">
                            <h3 class="info-card-title" style="color: #6366f1;"><i class="bi bi-activity me-2"></i> Live Platform Streams</h3>
                            
                            <div class="ticker-wrapper">
                                <!-- Duplicated for infinite seamless vertical loop -->
                                <div class="ticker-scroll-container">
                                    <div class="ticker-item"><span><i class="bi bi-check-circle-fill text-success me-2"></i> Security layer status checked verified</span> <small class="text-muted"></small></div>
                                    <div class="ticker-item" style="border-left-color: #f59e0b;"><span><i class="bi bi-exclamation-circle-fill text-warning me-2"></i> Incoming user data stream processing</span> <small class="text-muted"></small></div>
                                    <div class="ticker-item" style="border-left-color: #2563eb;"><span><i class="bi bi-info-circle-fill text-primary me-2"></i> Platform MVC schema validation stable</span> <small class="text-muted"></small></div>
                                    <div class="ticker-item"><span><i class="bi bi-arrow-repeat text-info me-2"></i> Database buffer synchronizing updates</span> <small class="text-muted"></small></div>
                                    
                                    <!-- Loop Duplicate Elements -->
                                    <div class="ticker-item"><span><i class="bi bi-check-circle-fill text-success me-2"></i> Security layer status checked verified</span> <small class="text-muted"></small></div>
                                    <div class="ticker-item" style="border-left-color: #f59e0b;"><span><i class="bi bi-exclamation-circle-fill text-warning me-2"></i> Incoming user data stream processing</span> <small class="text-muted"></small></div>
                                    <div class="ticker-item" style="border-left-color: #2563eb;"><span><i class="bi bi-info-circle-fill text-primary me-2"></i> Platform MVC schema validation stable</span> <small class="text-muted"></small></div>
                                    <div class="ticker-item"><span><i class="bi bi-arrow-repeat text-info me-2"></i> Database buffer synchronizing updates</span> <small class="text-muted"></small></div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="info-card" style="border-top-color: #f59e0b;">
                            <h3 class="info-card-title" style="color: #f59e0b;"><i class="bi bi-cpu me-2"></i> System Ecosystem Status</h3>
                            <div class="system-status-row">
                                <div class="status-meta"><i class="bi bi-database text-secondary me-2"></i> Database Service Connection</div>
                                <div class="d-flex align-items-center gap-2">
                                    <span class="pulse-dot success"></span>
                                    <span class="badge bg-success-subtle text-success border border-success-subtle rounded-pill px-3 py-1 fw-bold">Operational</span>
                                </div>
                            </div>
                            <div class="system-status-row">
                                <div class="status-meta"><i class="bi bi-git text-secondary me-2"></i> Context View Repository Link</div>
                                <div class="d-flex align-items-center gap-2">
                                    <span class="pulse-dot success"></span>
                                    <span class="badge bg-success-subtle text-success border border-success-subtle rounded-pill px-3 py-1 fw-bold">Active Connection</span>
                                </div>
                            </div>
                            <div class="system-status-row">
                                <div class="status-meta"><i class="bi bi-hdd-network text-secondary me-2"></i> MVC Architecture Pipeline</div>
                                <div class="d-flex align-items-center gap-2">
                                    <span class="pulse-dot primary"></span>
                                    <span class="badge bg-primary-subtle text-primary border border-primary-subtle rounded-pill px-3 py-1 fw-bold">Stable</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Pending Reports Management Table Section -->
                <div class="row mt-4">
                    <div class="col-12">
                        <div class="info-card" style="padding: 30px; border-top-color: #ef4444;">
                            <h3 class="info-card-title" style="margin-bottom: 20px; color: #text-dark;">
                                <i class="fa-solid fa-gavel me-2"></i> Pending Reports Management
                            </h3>
                            
                            <c:choose>
                                <c:when test="${not empty pendingReportsList}">
                                    <div class="table-responsive">
                                        <table class="table align-middle" style="border-color: #f1f5f9;">
                                            <thead style="background-color: #f8fafc; color: #64748b; font-weight: 700; font-size: 14px;">
                                                <tr>
                                                    <th style="padding: 14px;">ID</th>
                                                    <th>Reported Target</th>
                                                    <th>Target ID</th>
                                                    <th>Reason Category</th>
                                                    <th>Description Details</th>
                                                    <th class="text-end" style="padding-right: 14px;">Actions To Take</th>
                                                </tr>
                                            </thead>
                                            <tbody style="font-size: 15px;">
                                                <c:forEach var="report" items="${pendingReportsList}">
                                                    <tr>
                                                        <td style="padding: 16px; font-weight: 700; color: #64748b;">#<c:out value="${report.id}"/></td>
                                                        <td>
                                                            <span class="badge ${report.target_type == 'USER' ? 'bg-primary' : (report.target_type == 'CHEATSHEET' ? 'bg-success' : 'bg-warning')} text-uppercase" style="font-size: 11px; padding: 6px 10px; border-radius: 6px;">
                                                                <c:out value="${report.target_type}"/>
                                                            </span>
                                                        </td>
                                                        <td style="font-weight: 600;">ID: <c:out value="${report.target_id}"/></td>
                                                        <td>
                                                            <span style="color: #dc3545; font-weight: 600;"><c:out value="${report.reason}"/></span>
                                                        </td>
                                                        <td style="max-width: 300px; color: #475569;"><c:out value="${report.description}"/></td>
                                                        <td class="text-end" style="padding-right: 14px;">
                                                            <form action="${pageContext.request.contextPath}/admindashboard/reports/resolve" method="POST" style="display: inline-flex; gap: 8px;">
                                                                <input type="hidden" name="reportId" value="${report.id}" />
                                                                <input type="hidden" name="targetType" value="${report.target_type}" />
                                                                <input type="hidden" name="targetId" value="${report.target_id}" />
                                                                
                                                                <button type="submit" name="actionType" value="WARNING" class="btn btn-sm btn-outline-warning" style="border-radius: 8px; font-weight: 600; padding: 6px 12px;">
                                                                    <i class="fa-solid fa-triangle-exclamation"></i> Issue Warning
                                                                </button>
                                                                
                                                                <button type="submit" name="actionType" value="BAN" class="btn btn-sm btn-danger" style="border-radius: 8px; font-weight: 600; padding: 6px 12px; background-color: #dc3545;">
                                                                    <i class="fa-solid fa-ban"></i> Ban User
                                                                </button>
                                                            </form>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div style="text-align: center; padding: 40px 0; color: #94a3b8;">
                                        <i class="fa-solid fa-circle-check" style="font-size: 48px; color: #10b981; margin-bottom: 12px;"></i>
                                        <p style="margin: 0; font-size: 16px; font-weight: 500;">No pending reports at the moment. The community is clean!</p>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>

            </div>
        </div>

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