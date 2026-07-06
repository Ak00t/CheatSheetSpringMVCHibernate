<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="uri" value="${pageContext.request.requestURI}" />

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Platform Analytics - CheatSheet Hub</title>
    
    <!-- Design System Framework Synchronization -->
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
            gap: 24px; 
            padding: 24px; 
            align-items: flex-start; 
            flex: 1;
        }
        
        .analytics-content-area { 
            flex-grow: 1; 
            min-width: 0; 
        }
        
        /* Premium Target Filter Engine Card */
        .premium-card { 
            background: #ffffff; 
            border: none; 
            border-radius: 20px; 
            box-shadow: var(--shadow-sm); 
        }

        /* Responsive Metric Grid Cards Component */
        .metric-card-link {
            text-decoration: none !important;
            display: block;
        }
        
        .metric-card {
            background-color: #ffffff;
            border-radius: 20px;
            padding: 28px 24px;
            border: none;
            height: 100%;
            box-shadow: var(--shadow-sm);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            display: flex;
            align-items: center;
            justify-content: space-between;
            position: relative;
        }
        
        .metric-card:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow-hover);
        }
        
        /* Premium Floating Delete Button Style */
        .delete-card-btn {
            position: absolute;
            top: 12px;
            right: 12px;
            background: #fee2e2;
            color: #ef4444;
            border: none;
            width: 28px;
            height: 28px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 13px;
            opacity: 0;
            transform: scale(0.8);
            transition: all 0.25s ease;
            z-index: 15;
            cursor: pointer;
        }
        
        .metric-card:hover .delete-card-btn {
            opacity: 1;
            transform: scale(1);
        }
        
        .delete-card-btn:hover {
            background: #ef4444;
            color: white;
            box-shadow: 0 4px 12px rgba(239, 68, 68, 0.2);
        }
        
        /* Left Accent Border Color Themes */
        .metric-card.metric-users { border-left: 5px solid #2563eb; }
        .metric-card.metric-cheatsheets { border-left: 5px solid #10b981; }
        .metric-card.metric-reports { border-left: 5px solid #ef4444; }
        .metric-card.metric-comments { border-left: 5px solid #f59e0b; }
        .metric-card.metric-purple { border-left: 5px solid #8b5cf6; }

        .metric-value {
            font-size: 38px;
            font-weight: 800;
            color: var(--text-dark); 
            margin-top: 4px;
            line-height: 1;
        }
        
        .metric-users .metric-value { color: #2563eb; }
        .metric-cheatsheets .metric-value { color: #10b981; }
        .metric-reports .metric-value { color: #ef4444; }
        .metric-comments .metric-value { color: #f59e0b; }
        .metric-purple .metric-value { color: #8b5cf6; }

        .metric-label {
            color: var(--text-gray);
            font-size: 14px;
            font-weight: 700;
            padding-right: 20px;
        }
        
        .icon-shape-box { 
            width: 56px; 
            height: 56px; 
            border-radius: 14px; 
            display: flex; 
            align-items: center; 
            justify-content: center; 
            font-size: 1.4rem; 
        }

        /* Standardized Global Sticky Footer Component */
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
    
    <!-- Synchronized Global Navigation Bar Header Area -->
    <header style="background:white; padding:20px 50px; display:flex; justify-content:space-between; align-items:center; box-shadow:0 2px 20px rgba(0,0,0,.05);">
        <h2 style="color:#2563eb; margin: 0; font-weight: 700;">CheatSheet Hub</h2>
        <nav style="display:flex; gap:25px;">
            <a href="${pageContext.request.contextPath}/admin/profile" style="text-decoration:none; color:#334155; font-weight: 600;">Profile</a>
        </nav>
    </header>

    <!-- Structural Layout Wrapper Grid -->
    <div class="page-wrapper">
        
        <!-- Sidebar Dynamic Include Element -->
        <jsp:include page="/WEB-INF/views/sidebar.jsp" />
        
        <div class="analytics-content-area">
            <div class="d-flex justify-content-between align-items-center mb-4 ps-1">
                <div>
                    <h2 class="fw-bold text-dark m-0" style="font-weight: 800; letter-spacing: -0.5px;">Platform Analytics</h2>
                    <p class="text-muted small m-0 mt-1" style="font-size: 14px;">Track metrics timeline adjustments and overall trends across the scope.</p>
                </div>
                <div class="d-flex gap-2">
                    <button class="btn btn-outline-secondary fw-bold btn-sm rounded-3 px-3 py-2" onclick="resetToDefaultMetricsCards()" title="Restore default layout">
                        <i class="fa-solid fa-rotate-left me-1"></i> Reset Layout
                    </button>
                    <button class="btn btn-primary fw-bold btn-sm rounded-3 px-3 py-2" data-bs-toggle="modal" data-bs-target="#createCardModal">
                        <i class="fa-solid fa-plus me-2"></i>Create Custom Card
                    </button>
                </div>
            </div>

            <!-- Advanced Scope Engine Input Panel -->
            <div class="card premium-card p-4 mb-4">
                <h5 class="fw-bold text-dark mb-3" style="font-size: 16px; font-weight: 700;"><i class="fa-solid fa-sliders text-primary me-2"></i>Advanced Target Scope Engine</h5>
                <form action="${pageContext.request.contextPath}/admin/analytics" method="GET" class="row g-3 align-items-end">
                    <div class="col-md-3">
                        <label class="form-label fw-semibold small text-muted">Analyze Boundary</label>
                        <select name="type" class="form-select" id="filterType" onchange="toggleEngineInputs()">
                            <option value="DAY" ${param.type == 'DAY' ? 'selected' : ''}>Today / Specific Day</option>
                            <option value="WEEK" ${param.type == 'WEEK' ? 'selected' : ''}>Specific Week Period</option>
                            <option value="MONTH" ${param.type == 'MONTH' || empty param.type ? 'selected' : ''}>Specific Month Framework</option>
                            <option value="YEAR" ${param.type == 'YEAR' ? 'selected' : ''}>Specific Full Year</option>
                        </select>
                    </div>
                    <div class="col-md-3 filter-input" id="dayContainer"><label class="form-label fw-semibold small text-muted">Choose Date</label><input type="date" name="day" class="form-control" value="${param.day}"></div>
                    <div class="col-md-2 filter-input" id="yearContainer"><label class="form-label fw-semibold small text-muted">Year Frame</label><select name="year" class="form-select"><c:forEach var="yr" begin="2026" end="2090"><option value="${yr}" ${param.year == yr ? 'selected' : ''}>${yr}</option></c:forEach></select></div>
                    <div class="col-md-2 filter-input" id="monthContainer"><label class="form-label fw-semibold small text-muted">Month Frame</label><select name="month" class="form-select"><c:forEach var="entry" items="${monthsMap}"><option value="${entry.key}" ${param.month == entry.key ? 'selected' : ''}>${entry.value}</option></c:forEach></select></div>
                    <div class="col-md-2 filter-input" id="weekContainer"><label class="form-label fw-semibold small text-muted">Week Segment</label><select name="week" class="form-select"><option value="1" ${param.week == 1 ? 'selected' : ''}>Week 1</option><option value="2" ${param.week == 2 ? 'selected' : ''}>Week 2</option><option value="3" ${param.week == 3 ? 'selected' : ''}>Week 3</option><option value="4" ${param.week == 4 ? 'selected' : ''}>Week 4</option></select></div>
                    <div class="col-md-2"><button type="submit" class="btn btn-primary w-100 fw-bold">Search</button></div>
                </form>
            </div>

            <!-- Responsive Card Layout Grid Ecosystem -->
            <div class="row g-4 mb-4" id="metricsGridContainer">
                <!-- Grid items generated dynamically -->
            </div>
        </div>
    </div>

    <!-- Standardized Sticky Site Footer Block Structure -->
    <footer class="site-footer">
        <div class="footer-container">
            <h3>CheatSheet Hub</h3>
            <p>Learn Faster. Share Knowledge. Build Better.</p>
            <p class="copyright">© 2026 CheatSheet Hub. All Rights Reserved.</p>
        </div>
    </footer>
</div>

<!-- Modal Configuration Engine for Custom Card Creation -->
<div class="modal fade" id="createCardModal" tabindex="-1" aria-labelledby="createCardModalLabel" aria-hidden="true">
    <div class="modal-shadow modal-dialog modal-dialog-centered">
        <div class="modal-content border-0" style="border-radius: 20px;">
            <div class="modal-header border-0 pt-4 px-4">
                <h5 class="modal-title fw-bold text-dark" id="createCardModalLabel"><i class="fa-solid fa-square-plus text-primary me-2"></i>Create Custom Metric Card</h5>
                <button type="button" class="btn-close" data-bs-close="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body px-4 pb-4">
                <form id="customCardCreationForm" onsubmit="handleCreateCustomCard(event)">
                    <div class="mb-3">
                        <label class="form-label fw-semibold text-secondary small">Card Title Description</label>
                        <input type="text" id="customCardTitle" class="form-control rounded-3" placeholder="e.g., Total Tracked Comments" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold text-secondary small">Database Live Metric Link</label>
                        <select id="customCardSource" class="form-select rounded-3" required>
                            <option value="newUsers">New Users Joined</option>
                            <option value="newCheatsheets">Cheatsheets Linked</option>
                            <option value="newComments">New Comments Added</option>
                            <option value="pendingReports">Pending Content Reports</option>
                            <option value="pendingTagRequests">Pending Tag Requests</option>
                        </select>
                    </div>
                    <div class="row g-3 mb-4">
                        <div class="col-6">
                            <label class="form-label fw-semibold text-secondary small">Visual Component Icon</label>
                            <select id="customCardIcon" class="form-select rounded-3" required>
                                <option value="fa-comments">Message Comments</option>
                                <option value="fa-chart-line">Trending Chart</option>
                                <option value="fa-tags">Tag Requests</option>
                                <option value="fa-shield-halved">Security Guard</option>
                                <option value="fa-folder-plus">Folder Action</option>
                            </select>
                        </div>
                        <div class="col-6">
                            <label class="form-label fw-semibold text-secondary small">Left Border Theme Color</label>
                            <select id="customCardTheme" class="form-select rounded-3" required>
                                <option value="metric-comments|bg-warning-subtle text-warning">Orange Accent</option>
                                <option value="metric-users|bg-primary-subtle text-primary">Blue Accent</option>
                                <option value="metric-cheatsheets|bg-success-subtle text-success">Green Accent</option>
                                <option value="metric-purple|bg-purple-subtle text-purple" style="color:#8b5cf6;">Purple Accent</option>
                            </select>
                        </div>
                    </div>
                    <div class="d-flex gap-2 justify-content-end">
                        <button type="button" class="btn btn-light fw-bold rounded-3 px-4" data-bs-close="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary fw-bold rounded-3 px-4">Generate Card</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const liveDatabaseMetrics = {
        "newUsers": "${analytics.newUsers != null ? analytics.newUsers : '0'}",
        "newCheatsheets": "${analytics.newCheatsheets != null ? analytics.newCheatsheets : '0'}",
        "newComments": "${analytics.newComments != null ? analytics.newComments : '0'}",
        "pendingReports": "${analytics.pendingReports != null ? analytics.pendingReports : '0'}",
        "pendingTagRequests": "${pendingTagRequests != null ? pendingTagRequests : '0'}"
    };

    // systemDefaultCards array အား URL Dynamic Parameter Engine ဖြင့် ပြင်ဆင်ဖွဲ့စည်းထားသည်
    const systemDefaultCards = [
        { id: "users", title: "New Users Joined", dataSourceKey: "newUsers", iconClass: "fa-user-plus", themeClass: "bg-primary-subtle text-primary", typeClass: "metric-users", baseUrl: "${pageContext.request.contextPath}/admin/users/list" },
        { 
            id: "cheatsheets", 
            title: "Cheatsheets Linked", 
            dataSourceKey: "newCheatsheets", 
            iconClass: "fa-file-code", 
            themeClass: "bg-success-subtle text-success", 
            typeClass: "metric-cheatsheets", 
            baseUrl: "${pageContext.request.contextPath}/admin/cheatsheets/top-views?year=${not empty param.year ? param.year : 2026}&month=${not empty param.month ? param.month : 6}" 
        },
        { id: "reports", title: "Pending Requests", dataSourceKey: "pendingTagRequests", iconClass: "fa-triangle-exclamation", themeClass: "bg-danger-subtle text-danger", typeClass: "metric-reports", baseUrl: "${pageContext.request.contextPath}/admin/tag-request-process" }
    ];

    function initializeDashboardCardsEngine() {
        let savedCards = localStorage.getItem("platform_analytics_cards_v5");
        let activeCards = !savedCards ? systemDefaultCards : JSON.parse(savedCards).filter(card => card.id !== 'views');
        
        // LocalStorage မှ ကတ်ဟောင်းများရှိနေပါကလည်း Cheatsheets Linked Card ၏ URL အား နောက်ဆုံးရွေးချယ်ထားသော State အတိုင်း ထိန်းသိမ်းပေးရန်
        let updatedCards = activeCards.map(card => {
            if (card.id === "cheatsheets") {
                card.baseUrl = "${pageContext.request.contextPath}/admin/cheatsheets/top-views?year=${not empty param.year ? param.year : 2026}&month=${not empty param.month ? param.month : 6}";
            }
            return { ...card, value: liveDatabaseMetrics[card.dataSourceKey] || '0' };
        });
        renderMetricsGridLayout(updatedCards);
    }

    function renderMetricsGridLayout(cardsArray) {
        const gridContainer = document.getElementById("metricsGridContainer");
        gridContainer.innerHTML = "";
        
        cardsArray.forEach(card => {
            const columnWrapper = document.createElement("div");
            columnWrapper.className = "col-md-4 col-sm-6 col-12";
            
            columnWrapper.innerHTML = 
                '<a href="' + (card.baseUrl || '#') + '" class="metric-card-link">' +
                    '<div class="metric-card ' + card.typeClass + '">' +
                        '<button class="delete-card-btn" onclick="deleteMetricCard(event, \'' + card.id + '\')" title="Remove this metric card">' +
                            '<i class="fa-solid fa-trash-can"></i>' +
                        '</button>' +
                        '<div>' +
                            '<div class="metric-label">' + card.title + '</div>' +
                            '<div class="metric-value">' + card.value + '</div>' +
                        '</div>' +
                        '<div class="icon-shape-box ' + card.themeClass + '">' +
                            '<i class="fa-solid ' + card.iconClass + '"></i>' +
                        '</div>' +
                    '</div>' +
                '</a>';
                
            gridContainer.appendChild(columnWrapper);
        });
    }

    // Dynamic controller to safely handle card extraction from state storage
    function deleteMetricCard(event, cardId) {
        event.preventDefault();
        event.stopPropagation();
        
        let savedCards = localStorage.getItem("platform_analytics_cards_v5");
        let activeCards = !savedCards ? [...systemDefaultCards] : JSON.parse(savedCards);
        
        // Exclude the targeted card element from array framework
        activeCards = activeCards.filter(card => card.id !== cardId);
        localStorage.setItem("platform_analytics_cards_v5", JSON.stringify(activeCards));
        
        initializeDashboardCardsEngine();
    }

    // Force restore layout configuration baseline
    function resetToDefaultMetricsCards() {
        localStorage.removeItem("platform_analytics_cards_v5");
        initializeDashboardCardsEngine();
    }

    function handleCreateCustomCard(event) {
        event.preventDefault();
        
        const title = document.getElementById("customCardTitle").value;
        const sourceKey = document.getElementById("customCardSource").value;
        const icon = document.getElementById("customCardIcon").value;
        const themeConfig = document.getElementById("customCardTheme").value.split('|');
        
        const typeClass = themeConfig[0];
        const themeClass = themeConfig[1];
        
        let savedCards = localStorage.getItem("platform_analytics_cards_v5");
        let activeCards = !savedCards ? [...systemDefaultCards] : JSON.parse(savedCards);
        
        const newCustomCardObj = {
            id: "custom_" + Date.now(),
            title: title,
            dataSourceKey: sourceKey,
            iconClass: icon,
            themeClass: themeClass,
            typeClass: typeClass,
            baseUrl: "#"
        };
        
        activeCards.push(newCustomCardObj);
        localStorage.setItem("platform_analytics_cards_v5", JSON.stringify(activeCards));
        
        initializeDashboardCardsEngine();
        
        document.getElementById("customCardCreationForm").reset();
        const modalElement = document.getElementById('createCardModal');
        const modalInstance = bootstrap.Modal.getInstance(modalElement);
        modalInstance.hide();
    }

    function toggleEngineInputs() {
        var mode = document.getElementById("filterType").value;
        document.getElementById("yearContainer").style.display = (mode === "WEEK" || mode === "MONTH" || mode === "YEAR") ? "block" : "none";
        document.getElementById("monthContainer").style.display = (mode === "WEEK" || mode === "MONTH") ? "block" : "none";
        document.getElementById("weekContainer").style.display = (mode === "WEEK") ? "block" : "none";
        document.getElementById("dayContainer").style.display = (mode === "DAY") ? "block" : "none";
    }

    window.onload = function() { toggleEngineInputs(); initializeDashboardCardsEngine(); };
</script>
</body>
</html>