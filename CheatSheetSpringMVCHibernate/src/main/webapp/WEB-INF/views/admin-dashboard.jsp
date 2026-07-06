<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DevNote Admin - Ultra Premium Dashboard</title>
    
    <!-- Unified Core UI System Dependencies -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    
    <style>
        :root {
            --bg-canvas: #f6f9fc;       
            --brand-blue: #2563eb;     
            --brand-blue-gradient: linear-gradient(135deg, #1e40af, #3b82f6);
            --brand-success-gradient: linear-gradient(135deg, #059669, #10b981);
            --text-dark: #0f172a;
            --text-gray: #64748b;
            --border-light: rgba(226, 232, 240, 0.8);
            --shadow-premium: 0 12px 24px -4px rgba(15, 23, 42, 0.03), 0 4px 12px -2px rgba(15, 23, 42, 0.02);
            --shadow-card-hover: 0 20px 40px -4px rgba(37, 99, 235, 0.12);
            --glass-bg: rgba(255, 255, 255, 0.85);
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
            padding: 32px;
            gap: 32px;
            align-items: flex-start;
            flex: 1;
        }

        .main-workspace {
            flex-grow: 1;
            min-width: 0;
        }

        /* High-Definition Dashboard Header Banner */
        .dashboard-banner {
            background: var(--brand-blue-gradient);
            border-radius: 28px;
            padding: 55px 65px; 
            color: #ffffff;
            margin-bottom: 36px;
            box-shadow: 0 20px 35px -10px rgba(37, 99, 235, 0.3);
            position: relative;
            overflow: hidden;
        }
        
        .dashboard-banner::before {
            content: '';
            position: absolute;
            right: -5%;
            bottom: -20%;
            width: 350px;
            height: 350px;
            border-radius: 50%;
            background: radial-gradient(circle, rgba(255,255,255,0.12) 0%, rgba(255,255,255,0) 70%);
            pointer-events: none;
        }

        .banner-title {
            font-weight: 800;
            font-size: 46px; 
            margin-bottom: 12px;
            letter-spacing: -1.5px;
        }
        
        .banner-subtitle {
            font-size: 18px; 
            opacity: 0.95;
            margin: 0;
            max-width: 780px;
            line-height: 1.6;
            font-weight: 500;
        }

        /* Next-Gen Premium Metric Card System with Adaptive Theme Accents */
        .metric-card-premium {
            background: #ffffff;
            border-radius: 24px;
            padding: 30px;
            border: 1px solid var(--border-light);
            height: 100%;
            box-shadow: var(--shadow-premium);
            transition: all 0.35s cubic-bezier(0.25, 1, 0.5, 1);
            display: flex;
            align-items: center;
            justify-content: space-between;
            position: relative;
            overflow: hidden;
        }

        /* Specialized Contextual Card Styles */
        .card-premium-users {
            border-top: 4px solid #2563eb;
            background: linear-gradient(135deg, #ffffff 60%, #f0f6ff 100%);
        }
        .card-premium-users:hover {
            box-shadow: 0 20px 40px -4px rgba(37, 99, 235, 0.15);
            border-color: rgba(37, 99, 235, 0.3);
        }

        .card-premium-cheatsheets {
            border-top: 4px solid #16a34a;
            background: linear-gradient(135deg, #ffffff 60%, #f0fdf4 100%);
        }
        .card-premium-cheatsheets:hover {
            box-shadow: 0 20px 40px -4px rgba(22, 163, 74, 0.15);
            border-color: rgba(22, 163, 74, 0.3);
        }

        .card-premium-alerts {
            border-top: 4px solid #d97706;
            background: linear-gradient(135deg, #ffffff 60%, #fffbeb 100%);
        }
        .card-premium-alerts:hover {
            box-shadow: 0 20px 40px -4px rgba(217, 119, 6, 0.15);
            border-color: rgba(217, 119, 6, 0.3);
        }

        .card-premium-nodes {
            border-top: 4px solid #dc2626;
            background: linear-gradient(135deg, #ffffff 60%, #fef2f2 100%);
        }
        .card-premium-nodes:hover {
            box-shadow: 0 20px 40px -4px rgba(220, 38, 38, 0.15);
            border-color: rgba(220, 38, 38, 0.3);
        }

        .metric-card-premium:hover {
            transform: translateY(-6px);
        }

        .metric-data {
            display: flex;
            flex-direction: column;
            z-index: 2;
        }

        .metric-value-premium {
            font-size: 42px;
            font-weight: 800;
            color: var(--text-dark); 
            margin-bottom: 2px;
            line-height: 1;
            letter-spacing: -1px;
        }

        .metric-label-premium {
            color: var(--text-gray);
            font-size: 13px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.8px;
        }

        .metric-icon-box {
            width: 60px;
            height: 60px;
            border-radius: 18px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 26px;
            transition: all 0.3s ease;
            box-shadow: inset 0 -4px 10px rgba(0,0,0,0.02);
        }

        /* Structural Container Block Templates */
        .info-card-premium {
            background-color: #ffffff;
            border-radius: 24px;
            padding: 32px;
            border: 1px solid var(--border-light);
            height: 100%;
            box-shadow: var(--shadow-premium);
            transition: all 0.35s cubic-bezier(0.25, 1, 0.5, 1);
        }
        
        .info-card-premium:hover {
            transform: translateY(-4px);
        }

        /* System Monitoring Row Color Harmonization Classes */
        .card-premium-threshold {
            border-top: 4px solid #3b82f6;
            background: linear-gradient(135deg, #ffffff 65%, #eff6ff 100%);
        }
        .card-premium-threshold:hover {
            box-shadow: 0 20px 40px -4px rgba(59, 130, 246, 0.12);
            border-color: rgba(59, 130, 246, 0.3);
        }

        .card-premium-velocity {
            border-top: 4px solid #f59e0b;
            background: linear-gradient(135deg, #ffffff 65%, #fffbeb 100%);
        }
        .card-premium-velocity:hover {
            box-shadow: 0 20px 40px -4px rgba(245, 158, 11, 0.12);
            border-color: rgba(245, 158, 11, 0.3);
        }

        .card-premium-stream {
            border-top: 4px solid #06b6d4;
            background: linear-gradient(135deg, #ffffff 65%, #ecfeff 100%);
        }
        .card-premium-stream:hover {
            box-shadow: 0 20px 40px -4px rgba(6, 182, 212, 0.12);
            border-color: rgba(6, 182, 212, 0.3);
        }

        .card-premium-controls {
            border-top: 4px solid #10b981;
            background: linear-gradient(135deg, #ffffff 65%, #f0fdf4 100%);
        }
        .card-premium-controls:hover {
            box-shadow: 0 20px 40px -4px rgba(16, 185, 129, 0.12);
            border-color: rgba(16, 185, 129, 0.3);
        }

        .info-card-title-premium {
            font-weight: 800;
            color: var(--text-dark); 
            font-size: 21px;
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            gap: 12px;
            letter-spacing: -0.3px;
        }

        .info-card-text-premium {
            color: var(--text-gray);
            font-size: 15px;
            line-height: 1.8;
            margin: 0;
        }
        
        .today-list-premium {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .today-list-premium li {
            padding: 15px 0;
            font-size: 15px;
            color: var(--text-dark);
            border-bottom: 1px solid #f8fafc;
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-weight: 600;
        }

        .today-list-premium li:last-child {
            border-bottom: none;
            padding-bottom: 0;
        }

        .today-list-premium span {
            font-weight: 800;
            background: #eff6ff;
            color: var(--brand-blue);
            padding: 5px 14px;
            border-radius: 12px;
            font-size: 14px;
        }

        /* Live Status Components & Animations */
        .pulse-indicator {
            width: 10px;
            height: 10px;
            background-color: #10b981;
            border-radius: 50%;
            display: inline-block;
            position: relative;
        }

        .pulse-indicator::after {
            content: '';
            width: 10px;
            height: 10px;
            background-color: #10b981;
            border-radius: 50%;
            position: absolute;
            top: 0;
            left: 0;
            display: inline-block;
            animation: pulse-glow 1.8s infinite ease-in-out;
        }

        @keyframes pulse-glow {
            0% { transform: scale(1); opacity: 0.8; }
            100% { transform: scale(3.2); opacity: 0; }
        }

        .live-stream-box {
            max-height: 250px;
            overflow-y: auto;
            padding-right: 5px;
        }

        /* Customized Mini Scrollbar Component */
        .live-stream-box::-webkit-scrollbar,
        .premium-table-wrapper::-webkit-scrollbar {
            width: 6px;
            height: 6px;
        }
        .live-stream-box::-webkit-scrollbar-thumb,
        .premium-table-wrapper::-webkit-scrollbar-thumb {
            background-color: #cbd5e1;
            border-radius: 20px;
        }

        .stream-item {
            padding: 12px;
            border-radius: 14px;
            background: #f8fafc;
            margin-bottom: 12px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            border: 1px solid transparent;
            transition: all 0.2s ease;
        }

        .stream-item:hover {
            background: #ffffff;
            border-color: #e2e8f0;
            transform: translateX(4px);
        }

        /* Custom Action Controls Button Customizer Styling */
        .btn-admin-control {
            border: 1px solid #e2e8f0;
            background: #ffffff;
            color: var(--text-dark);
            border-radius: 12px;
            font-size: 13px;
            text-align: left;
            font-weight: 700;
            padding: 11px 14px;
            transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
        }
        .btn-admin-control:hover {
            background: #f8fafc;
            border-color: var(--brand-blue);
            color: var(--brand-blue);
            transform: translateY(-1px);
        }

        /* Modernized Data Table Layout */
        .premium-table-wrapper {
            border-radius: 24px;
            overflow: hidden;
            border: 1px solid #f1f5f9;
            box-shadow: 0 4px 12px rgba(0,0,0,0.01);
        }

        .table-premium thead {
            background-color: #f8fafc;
        }

        .site-footer {
            background: #0f172a;
            color: #94a3b8;
            margin-top: 80px;
            padding: 50px 24px;
            border-top: 1px solid #1e293b;
        }

        .footer-container h3 {
            color: #ffffff;
            font-weight: 800;
            margin-bottom: 12px;
            font-size: 24px;
        }
    </style>
</head>
<body>

    <div class="page-container">
        <!-- Main Navigation Header Container -->
        <header style="background: #ffffff; padding: 22px 50px; display: flex; justify-content: space-between; align-items: center; box-shadow: 0 4px 25px rgba(15, 23, 42, 0.03); border-bottom: 1px solid #f1f5f9; z-index: 10;">
            <h2 style="color: var(--brand-blue); margin: 0; font-weight: 800; letter-spacing: -0.8px;">CheatSheet Hub</h2>
            <nav style="display: flex; align-items: center; gap: 25px;">
                <a href="${pageContext.request.contextPath}/admin/profile" style="text-decoration: none; color: #475569; font-weight: 700; transition: color 0.2s ease;">Profile</a>
            </nav>
        </header>

        <!-- Functional Platform Layout Wrapper -->
        <div class="page-wrapper">
            
            <jsp:include page="/WEB-INF/views/sidebar.jsp" />

            <div class="main-workspace">
                
                <!-- Command Center Strategic Header Banner -->
                <div class="dashboard-banner">
                    <h1 class="banner-title">Admin Dashboard</h1>
                    <p class="banner-subtitle">Structural platform controller. Monitor active nodes, custom security verification layers, data metrics tracking, and cluster health statistics.</p>
                </div>

                <!-- Next-Gen Premium Elevation Metrics Grid with Applied Colors -->
                <div class="row g-4 mb-4">
                    <!-- Total Users Card (Blue Theme) -->
                    <div class="col-md-3">
                        <div class="metric-card-premium card-premium-users">
                            <div class="metric-data">
                                <div class="metric-value-premium" style="color: #1e40af;"><c:out value="${not empty totalUsers ? totalUsers : '1'}"/></div>
                                <div class="metric-label-premium">Total Users</div>
                            </div>
                            <div class="metric-icon-box" style="background-color: #eff6ff; color: #2563eb;">
                                <i class="bi bi-people-fill"></i>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Cheatsheets Card (Green Theme) -->
                    <div class="col-md-3">
                        <div class="metric-card-premium card-premium-cheatsheets">
                            <div class="metric-data">
                                <div class="metric-value-premium" style="color: #065f46;"><c:out value="${not empty totalCheatsheets ? totalCheatsheets : '0'}"/></div>
                                <div class="metric-label-premium">Cheatsheets</div>
                            </div>
                            <div class="metric-icon-box" style="background-color: #f0fdf4; color: #16a34a;">
                                <i class="bi bi-file-earmark-code-fill"></i>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Pending Alerts Card (Amber Theme) -->
                    <div class="col-md-3">
                        <div class="metric-card-premium card-premium-alerts">
                            <div class="metric-data">
                                <div class="metric-value-premium" style="color: #92400e;"><c:out value="${not empty pendingReports ? pendingReports : '0'}"/></div>
                                <div class="metric-label-premium">Pending Alerts</div>
                            </div>
                            <div class="metric-icon-box" style="background-color: #fffbeb; color: #d97706;">
                                <i class="bi bi-exclamation-octagon-fill"></i>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Banned Nodes Card (Red Theme) -->
                    <div class="col-md-3">
                        <div class="metric-card-premium card-premium-nodes">
                            <div class="metric-data">
                                <div class="metric-value-premium" style="color: #991b1b;"><c:out value="${not empty bannedContents ? bannedContents : '0'}"/></div>
                                <div class="metric-label-premium">Banned Nodes</div>
                            </div>
                            <div class="metric-icon-box" style="background-color: #fef2f2; color: #dc2626;">
                                <i class="bi bi-shield-lock-fill"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Balanced System Monitoring Grid Row -->
                <div class="row g-4 mb-5">
                    <!-- Standard Platform Threshold Configurations Block -->
                    <div class="col-md-3">
                        <div class="info-card-premium card-premium-threshold">
                            <h3 class="info-card-title-premium">
                                <i class="bi bi-sliders text-primary"></i> Threshold Rules
                            </h3>
                            <p class="info-card-text-premium" style="font-size: 14px;">
                                <span class="fw-bold text-dark"><c:out value="${not empty warningThreshold ? warningThreshold : '5'}"/> reports</span> dispatches automatic restriction warning notifications.<br><br>
                                <span class="fw-bold text-dark"><c:out value="${not empty banThreshold ? banThreshold : '10'}"/> reports</span> initializes isolation procedures.<br><br>
                                Direct administrative security overrides are active.
                            </p>
                        </div>
                    </div>

                    <!-- Dynamic Velocity Statistics Component -->
                    <div class="col-md-3">
                        <div class="info-card-premium card-premium-velocity">
                            <h3 class="info-card-title-premium">
                                <i class="bi bi-lightning-charge-fill text-warning"></i> Velocity Log
                            </h3>
                            <ul class="today-list-premium" style="font-size: 14px;">
                                <li>New Profiles: <span><c:out value="${not empty newUsersToday ? newUsersToday : '1'}"/></span></li>
                                <li>Cheatsheets: <span><c:out value="${not empty newCheatsheetsToday ? newCheatsheetsToday : '0'}"/></span></li>
                                <li>Flags Raised: <span><c:out value="${not empty newReportsToday ? newReportsToday : '0'}"/></span></li>
                            </ul>
                        </div>
                    </div>

                    <!-- Live Real-time Traffic Activity Stream -->
                    <div class="col-md-3">
                        <div class="info-card-premium card-premium-stream">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h3 class="info-card-title-premium m-0" style="font-size: 21px;">
                                    <i class="bi bi-activity text-info"></i> Activity Stream
                                </h3>
                                <div class="d-flex align-items-center gap-2">
                                    <span class="pulse-indicator"></span>
                                    <span class="fw-bold small text-success" style="font-size: 12px;">Live</span>
                                </div>
                            </div>
                            
                            <div class="live-stream-box">
                                <div class="stream-item">
                                    <div>
                                        <div class="fw-bold small text-dark">User Registered</div>
                                        <div class="text-muted" style="font-size: 11px;">Profile sync authorized</div>
                                    </div>
                                    <span class="badge bg-primary-subtle text-primary" style="font-size: 10px;">Just now</span>
                                </div>
                                <div class="stream-item">
                                    <div>
                                        <div class="fw-bold small text-dark">New Snippet Uploaded</div>
                                        <div class="text-muted" style="font-size: 11px;">Spring Security configuration</div>
                                    </div>
                                    <span class="badge bg-success-subtle text-success" style="font-size: 10px;">2 mins ago</span>
                                </div>
                                <div class="stream-item">
                                    <div>
                                        <div class="fw-bold small text-dark">Moderation Completed</div>
                                        <div class="text-muted" style="font-size: 11px;">Report token finalized</div>
                                    </div>
                                    <span class="badge bg-secondary-subtle text-secondary" style="font-size: 10px;">5 mins ago</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- NEW SYSTEM MANAGEMENT MODULE: Administrative Control Panel -->
                    <div class="col-md-3">
                        <div class="info-card-premium card-premium-controls">
                            <h3 class="info-card-title-premium">
                                <i class="bi bi-cpu-fill text-success"></i> Admin Controls
                            </h3>
                            <p class="info-card-text-premium mb-3" style="font-size: 13px; line-height: 1.5;">
                                Structural control operations for live system management and data maintenance.
                            </p>
                            <div class="d-flex flex-column gap-2">
                                <button type="button" class="btn btn-admin-control">
                                    <i class="bi bi-database-fill-gear text-primary me-2"></i> Flush Cache Pipeline
                                </button>
                                <button type="button" class="btn btn-admin-control">
                                    <i class="bi bi-cloud-arrow-down-fill text-success me-2"></i> Backup Storage Array
                                </button>
                                <button type="button" class="btn btn-admin-control">
                                    <i class="bi bi-file-earmark-lock2-fill text-danger"></i> System Audit Trail
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Dynamic Community Report Management Operations Grid Block -->
                <div class="row">
                    <div class="col-12">
                        <div class="info-card-premium">
                            <h3 class="info-card-title-premium" style="margin-bottom: 26px;">
                                <i class="fa-solid fa-gavel text-danger"></i> Pending Moderation Action Pipeline
                            </h3>
                            
                            <c:choose>
                                <c:when test="${not empty pendingReportsList}">
                                    <div class="table-responsive premium-table-wrapper">
                                        <table class="table table-premium align-middle mb-0" style="border-color: #f1f5f9;">
                                            <thead style="background-color: #f8fafc; color: #64748b; font-weight: 700; font-size: 13px; text-transform: uppercase; letter-spacing: 0.6px;">
                                                <tr>
                                                    <th style="padding: 20px;">Reference Key</th>
                                                    <th>Target Entity</th>
                                                    <th>Entity Pointer</th>
                                                    <th>Classification Type</th>
                                                    <th>Description Context</th>
                                                    <th class="text-end" style="padding-right: 20px;">Administrative Execution</th>
                                                </tr>
                                            </thead>
                                            <tbody style="font-size: 14px; font-weight: 600;">
                                                <c:forEach var="report" items="${pendingReportsList}">
                                                    <tr style="transition: background-color 0.2s ease;">
                                                        <td style="padding: 20px; color: #64748b; font-weight: 700;">#<c:out value="${report.id}"/></td>
                                                        <td>
                                                            <span class="badge ${report.target_type == 'USER' ? 'bg-primary-subtle text-primary' : (report.target_type == 'CHEATSHEET' ? 'bg-success-subtle text-success' : 'bg-warning-subtle text-warning')} text-uppercase" style="font-size: 11px; padding: 6px 12px; border-radius: 8px; font-weight: 700;">
                                                                <c:out value="${report.target_type}"/>
                                                            </span>
                                                        </td>
                                                        <td style="color: #334155;">ID Space: <c:out value="${report.target_id}"/></td>
                                                        <td>
                                                            <span style="color: #dc2626; font-weight: 700;"><c:out value="${report.reason}"/></span>
                                                        </td>
                                                        <td style="max-width: 320px; color: #475569; font-weight: 500; line-height: 1.6;"><c:out value="${report.description}"/></td>
                                                        <td class="text-end" style="padding-right: 20px;">
                                                            <form action="${pageContext.request.contextPath}/admindashboard/reports/resolve" method="POST" style="display: inline-flex; gap: 10px;">
                                                                <input type="hidden" name="reportId" value="${report.id}" />
                                                                <input type="hidden" name="targetType" value="${report.target_type}" />
                                                                <input type="hidden" name="targetId" value="${report.target_id}" />
                                                                
                                                                <button type="submit" name="actionType" value="WARNING" class="btn btn-sm btn-outline-warning" style="border-radius: 10px; font-weight: 700; padding: 8px 14px; font-size: 13px;">
                                                                    <i class="fa-solid fa-triangle-exclamation me-1"></i> Issue Infraction
                                                                </button>
                                                                
                                                                <button type="submit" name="actionType" value="BAN" class="btn btn-sm btn-danger" style="border-radius: 10px; font-weight: 700; padding: 8px 14px; font-size: 13px; background-color: #dc2626; border-color: #dc2626;">
                                                                    <i class="fa-solid fa-ban me-1"></i> Restrict Access
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
                                    <div style="text-align: center; padding: 55px 0; color: #94a3b8;">
                                        <i class="fa-solid fa-circle-check" style="font-size: 56px; color: #10b981; margin-bottom: 16px; opacity: 0.95;"></i>
                                        <p style="margin: 0; font-size: 16px; font-weight: 600; color: #334155;">Platform moderation queues structurally unassigned.</p>
                                        <p style="margin: 4px 0 0 0; font-size: 14px; color: #94a3b8;">All connected user activities remain clean and compliance verified.</p>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>

            </div>
        </div>

        <!-- Universal Infrastructure Global Footer Component -->
        <footer class="site-footer">
            <div class="footer-container">
                <h3>CheatSheet Hub</h3>
                <p style="font-weight: 500; color: #64748b;">Streamline Production Operations. Optimize Distributed Knowledge Architecture Frameworks.</p>
                <p class="copyright" style="color: #475569; margin-top: 26px;">&copy; 2026 CheatSheet Hub. Enterprise Administration Engine Platform.</p>
            </div>
        </footer>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>