<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="uri" value="${pageContext.request.requestURI}" />

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Platform Analytics - CheatSheet Hub</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --bg-canvas: #f4fbfc;
            --brand-blue: #2563eb;
            --text-dark: #1e293b;
        }
        body { font-family: 'Plus Jakarta Sans', sans-serif; background-color: var(--bg-canvas); }
        
        .workspace-wrapper { display: flex; gap: 24px; padding: 24px; width: 100%; margin: 0; align-items: flex-start; }
        .analytics-content-area { flex-grow: 1; min-width: 0; }
        
        /* Sidebar Styling */
        .sidebar-container { width: 330px; min-width: 330px; background-color: #ffffff; border-radius: 24px; padding: 30px 22px; box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05); display: flex; flex-direction: column; min-height: calc(100vh - 120px); align-self: flex-start; }
        .sidebar-link { display: flex; align-items: center; gap: 18px; padding: 16px 24px; color: #1e293b; text-decoration: none; font-weight: 700; font-size: 18px; border-radius: 14px; transition: all 0.2s; }
        .sidebar-link.active { background-color: var(--brand-blue); color: #ffffff; }

        /* Card Styling */
        .premium-card { background: #ffffff; border: none; border-radius: 20px; box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05); position: relative; transition: transform 0.2s; }
        .clickable-metric-card { text-decoration: none !important; display: block; cursor: pointer; min-width: 350px; flex: 0 0 auto; }
        .icon-shape-box { width: 58px; height: 58px; border-radius: 14px; display: flex; align-items: center; justify-content: center; font-size: 1.5rem; }
        
        .slider-outer-wrapper { position: relative; margin-bottom: 35px; padding: 0 50px; }
        .metrics-slider-container { display: flex; gap: 24px; overflow-x: auto; scroll-behavior: smooth; padding: 15px 0px; scrollbar-width: none; }
        .metrics-slider-container::-webkit-scrollbar { display: none; }
        
        .slider-nav-btn { position: absolute; top: 50%; transform: translateY(-50%); width: 44px; height: 44px; border-radius: 50%; background: #ffffff; border: 1px solid #e2e8f0; box-shadow: 0 4px 6px rgba(0,0,0,0.05); display: flex; align-items: center; justify-content: center; z-index: 10; cursor: pointer; }
        .card-trash-btn { position: absolute; top: 12px; right: 12px; width: 28px; height: 28px; border-radius: 6px; background: rgba(239, 68, 68, 0.1); color: #ef4444; border: none; opacity: 0; transition: opacity 0.2s; }
        .premium-card:hover .card-trash-btn { opacity: 1; }
    </style>
</head>
<body>

<header style="background:white; padding:20px 50px; display:flex; justify-content:space-between; align-items:center; box-shadow:0 2px 20px rgba(0,0,0,.05);">
    <h2 style="color:#2563eb; margin: 0; font-weight: normal;">CheatSheet Hub</h2>
    <nav style="display:flex; gap:25px;">
        <a href="${pageContext.request.contextPath}/admin/profile" style="text-decoration:none; color:#334155; font-weight: 600;">Profile</a>
    </nav>
</header>

<div class="workspace-wrapper">
    <jsp:include page="/WEB-INF/views/sidebar.jsp" />
    
    <div class="analytics-content-area">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h2 class="fw-bold text-dark m-0">Platform Analytics</h2>
                <p class="text-secondary small m-0 mt-1">Track metrics timeline adjustments and overall trends.</p>
            </div>
            <button class="btn btn-primary fw-bold btn-sm rounded-3 px-3 py-2" data-bs-toggle="modal" data-bs-target="#createCardModal">
                <i class="fa-solid fa-plus me-2"></i>Create Custom Card
            </button>
        </div>

        <!-- Engine Form -->
        <div class="card premium-card p-4 mb-4">
            <h5 class="fw-bold text-dark mb-3"><i class="fa-solid fa-sliders text-primary me-2"></i>Advanced Target Scope Engine</h5>
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

        <div class="slider-outer-wrapper">
            <button class="slider-nav-btn slider-prev" onclick="scrollMetricsSlider(-370)"><i class="fa-solid fa-chevron-left"></i></button>
            <button class="slider-nav-btn slider-next" onclick="scrollMetricsSlider(370)"><i class="fa-solid fa-chevron-right"></i></button>
            <div class="metrics-slider-container" id="metricsSlider"></div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function scrollMetricsSlider(amount) { document.getElementById("metricsSlider").scrollBy({ left: amount, behavior: 'smooth' }); }

    // မင်းရဲ့ မူလ Logic များ
    const liveDatabaseMetrics = {
        "newUsers": "${analytics.newUsers != null ? analytics.newUsers : '0'}",
        "newCheatsheets": "${analytics.newCheatsheets != null ? analytics.newCheatsheets : '0'}",
        "newComments": "${analytics.newComments != null ? analytics.newComments : '0'}",
        "pendingReports": "${analytics.pendingReports != null ? analytics.pendingReports : '0'}",
        "pendingTagRequests": "${pendingTagRequests != null ? pendingTagRequests : '0'}"
    };

    const systemDefaultCards = [
        { id: "users", title: "New Users Joined", dataSourceKey: "newUsers", iconClass: "fa-user-plus", themeClass: "bg-primary-subtle text-primary", baseUrl: "${pageContext.request.contextPath}/admin/users/list" },
        { id: "cheatsheets", title: "Cheatsheets Linked", dataSourceKey: "newCheatsheets", iconClass: "fa-file-code", themeClass: "bg-success-subtle text-success", baseUrl: "${pageContext.request.contextPath}/admin/cheatsheets/top-views" },
        { id: "reports", title: "Pending Requests", dataSourceKey: "pendingTagRequests", iconClass: "fa-triangle-exclamation", themeClass: "bg-danger-subtle text-danger", baseUrl: "${pageContext.request.contextPath}/admin/tag-request-process" }
    ];

    function initializeDashboardCardsEngine() {
        let savedCards = localStorage.getItem("platform_analytics_cards_v5");
        let activeCards = !savedCards ? systemDefaultCards : JSON.parse(savedCards).filter(card => card.id !== 'views');
        
        let updatedCards = activeCards.map(card => {
            let sysCard = systemDefaultCards.find(c => c.id === card.id);
            return { ...card, value: liveDatabaseMetrics[card.dataSourceKey] || '0' };
        });
        renderMetricsSliderLayout(updatedCards);
    }

    function renderMetricsSliderLayout(cardsArray) {
        const sliderContainer = document.getElementById("metricsSlider");
        sliderContainer.innerHTML = "";
        cardsArray.forEach(card => {
            const cardElement = document.createElement("div");
            cardElement.className = "card premium-card p-4 clickable-metric-card";
            cardElement.innerHTML = 
                '<button class="card-trash-btn" onclick="handleDeleteCardModule(event, \'' + card.id + '\')"><i class="fa-solid fa-trash-can"></i></button>' +
                '<div class="d-flex align-items-center justify-content-between">' +
                    '<div><span class="text-secondary d-block fw-semibold small mb-1">' + card.title + '</span><h3 class="fw-bold text-dark m-0">' + card.value + '</h3></div>' +
                    '<div class="icon-shape-box ' + card.themeClass + '"><i class="fa-solid ' + card.iconClass + '"></i></div>' +
                '</div>';
            sliderContainer.appendChild(cardElement);
        });
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