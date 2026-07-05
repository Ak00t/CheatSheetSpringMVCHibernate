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
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #f8fafc; }
        .workspace-wrapper { display: flex; gap: 35px; padding: 35px 45px 35px 15px; width: 100%; margin: 0; align-items: flex-start; }
        .analytics-content-area { flex-grow: 1; min-width: 0; }
        .sidebar-container { width: 330px; min-width: 330px; background-color: #ffffff; border-radius: 24px; padding: 30px 22px; box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05); display: flex; flex-direction: column; justify-content: space-between; min-height: calc(100vh - 64px); align-self: flex-start; margin-left: 0px; }
        .sidebar-menu-links { display: flex; flex-direction: column; gap: 14px; }
        .sidebar-link { display: flex; align-items: center; gap: 18px; padding: 16px 24px; color: #1e293b; text-decoration: none; font-weight: 850; font-size: 18px; border-radius: 14px; transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1); }
        .sidebar-link:hover { background-color: #f0f7ff; color: #2563eb; transform: translateY(-3px); box-shadow: 0 12px 24px -4px rgba(37, 99, 235, 0.35), 0 4px 12px -2px rgba(37, 99, 235, 0.2); }
        .sidebar-link.active { background-color: #2563eb; color: #ffffff; box-shadow: 0 16px 28px -6px rgba(37, 99, 235, 0.5), 0 6px 16px -4px rgba(37, 99, 235, 0.3); }
        .sidebar-link i { font-size: 24px; width: 26px; text-align: center; stroke-width: 2.5; }
        .sidebar-link-logout { color: #ef4444; border-top: 2px solid #f1f5f9; padding-top: 20px; margin-top: 20px; font-weight: 850; font-size: 18px; }
        .sidebar-link-logout:hover { background-color: #fef2f2; color: #dc2626; transform: translateY(-3px); box-shadow: 0 12px 24px -4px rgba(239, 68, 68, 0.35), 0 4px 12px -2px rgba(239, 68, 68, 0.2); }
        .premium-card { background: #ffffff; border: 1px solid #f1f5f9; border-radius: 18px; box-shadow: 0 10px 25px rgba(0, 0, 0, 0.02); transition: transform 0.2s ease, box-shadow 0.2s ease; position: relative; }
        .premium-card:hover { transform: translateY(-2px); box-shadow: 0 12px 30px rgba(0, 0, 0, 0.04); }
        .clickable-metric-card { text-decoration: none !important; display: block; cursor: pointer; min-width: 350px; flex: 0 0 auto; }
        .icon-shape-box { width: 58px; height: 58px; border-radius: 14px; display: flex; align-items: center; justify-content: center; font-size: 1.5rem; }
        .slider-outer-wrapper { position: relative; margin-bottom: 35px; padding: 0 50px; }
        .metrics-slider-container { display: flex; gap: 24px; overflow-x: auto; scroll-behavior: smooth; padding: 15px 0px; scrollbar-width: none; }
        .metrics-slider-container::-webkit-scrollbar { display: none; }
        .slider-nav-btn { position: absolute; top: 50%; transform: translateY(-50%); width: 44px; height: 44px; border-radius: 50%; background: #ffffff; border: 1px solid #cbd5e1; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08); display: flex; align-items: center; justify-content: center; color: #1e293b; z-index: 10; cursor: pointer; transition: all 0.2s ease; }
        .slider-nav-btn:hover { background: #2563eb; color: #ffffff; border-color: #2563eb; }
        .slider-prev { left: 0; } .slider-next { right: 0; }
        .card-trash-btn { position: absolute; top: 12px; right: 12px; width: 28px; height: 28px; border-radius: 6px; background: rgba(239, 68, 68, 0.1); color: #ef4444; display: flex; align-items: center; justify-content: center; font-size: 0.85rem; border: none; opacity: 0; transition: opacity 0.2s ease; z-index: 10; }
        .premium-card:hover .card-trash-btn { opacity: 1; }
        .card-trash-btn:hover { background: #ef4444; color: #ffffff; }
    </style>
</head>
<body>

        <header style="background:white; padding:20px 50px; display:flex; justify-content:space-between; align-items:center; box-shadow:0 2px 20px rgba(0,0,0,.05);">
            <h2 style="color:#2563eb; margin: 0;">CheatSheet Hub</h2>
            <nav style="display:flex; gap:25px;">
         
                <a href="${pageContext.request.contextPath}/admin/profile" style="text-decoration:none; color:#334155; font-weight: 600;">Profile</a>
            </nav>
        </header>

<div class="workspace-wrapper">
    <jsp:include page="/WEB-INF/views/sidebar.jsp" />
    
    <div class="analytics-content-area">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h2 class="fw-bold text-dark m-0" style="letter-spacing: -0.5px;">Platform Analytics</h2>
                <p class="text-secondary small m-0 mt-1">Track metrics timeline adjustments, category volume, and overall trends.</p>
            </div>
            <button class="btn btn-primary fw-bold btn-sm rounded-3 px-3 py-2" style="background: #2563eb; border-color: #2563eb;" data-bs-toggle="modal" data-bs-target="#createCardModal">
                <i class="fa-solid fa-plus me-2"></i>Create Custom Card
            </button>
        </div>

        <div class="card premium-card p-4 mb-4 border-0">
            <h5 class="fw-bold text-dark mb-3"><i class="fa-solid fa-sliders text-primary me-2"></i>Advanced Target Scope Engine</h5>
            <form action="${pageContext.request.contextPath}/admin/analytics" method="GET" class="row g-3 align-items-end">
                <div class="col-md-3">
                    <label class="form-label fw-semibold small text-muted">Analyze Boundary</label>
                    <select name="type" class="form-select fw-medium text-dark" id="filterType" onchange="toggleEngineInputs()">
                        <option value="DAY" ${param.type == 'DAY' ? 'selected' : ''}>Today / Specific Day</option>
                        <option value="WEEK" ${param.type == 'WEEK' ? 'selected' : ''}>Specific Week Period</option>
                        <option value="MONTH" ${param.type == 'MONTH' || empty param.type ? 'selected' : ''}>Specific Month Framework</option>
                        <option value="YEAR" ${param.type == 'YEAR' ? 'selected' : ''}>Specific Full Year</option>
                    </select>
                </div>
                <div class="col-md-3 filter-input" id="dayContainer"><label class="form-label fw-semibold small text-muted">Choose Date</label><input type="date" name="day" class="form-control text-dark" value="${param.day}"></div>
                <div class="col-md-2 filter-input" id="yearContainer"><label class="form-label fw-semibold small text-muted">Year Frame</label><select name="year" class="form-select text-dark"><c:forEach var="yr" begin="2026" end="2090"><option value="${yr}" ${param.year == yr ? 'selected' : ''}>${yr}</option></c:forEach></select></div>
                <div class="col-md-2 filter-input" id="monthContainer"><label class="form-label fw-semibold small text-muted">Month Frame</label><select name="month" class="form-select text-dark"><c:forEach var="entry" items="${monthsMap}"><option value="${entry.key}" ${param.month == entry.key ? 'selected' : ''}>${entry.value}</option></c:forEach></select></div>
                <div class="col-md-2 filter-input" id="weekContainer"><label class="form-label fw-semibold small text-muted">Week Segment</label><select name="week" class="form-select text-dark"><option value="1" ${param.week == 1 ? 'selected' : ''}>Week 1</option><option value="2" ${param.week == 2 ? 'selected' : ''}>Week 2</option><option value="3" ${param.week == 3 ? 'selected' : ''}>Week 3</option><option value="4" ${param.week == 4 ? 'selected' : ''}>Week 4</option></select></div>
                <div class="col-md-2"><button type="submit" class="btn btn-primary w-100 fw-bold py-2 shadow-sm" style="background: #2563eb; border-color: #2563eb;"><i class="fa-solid fa-bolt me-2"></i>Search</button></div>
            </form>
        </div>

        <div class="card premium-card border-0 bg-white p-3 mb-4 d-flex flex-row align-items-center">
            <div class="icon-shape-box bg-primary-subtle text-primary me-3"><i class="fa-solid fa-calendar-alt"></i></div>
            <div>
                <span class="text-muted d-block small fw-bold text-uppercase" style="letter-spacing: 0.5px; font-size: 11px;">Evaluated Target Scope</span>
                <strong class="text-dark fs-5 fw-bold">${analytics.dateRangeString}</strong>
            </div>
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
function scrollMetricsSlider(amount) {
    document.getElementById("metricsSlider").scrollBy({ left: amount, behavior: 'smooth' });
}

function getFixedParams() {
    let type = "${param.type}" || "MONTH";
    let year = ("${param.year}" === "" || "${param.year}" === "0") ? "2026" : "${param.year}";
    let month = ("${param.month}" === "" || "${param.month}" === "0") ? "7" : "${param.month}";
    let week = "${param.week}" || "1";
    let day = "${param.day}" || "";
    return "?type=" + type + "&year=" + year + "&month=" + month + "&week=" + week + "&day=" + day;
}

const targetScopeParams = getFixedParams();

const liveDatabaseMetrics = {
    "newUsers": "${analytics.newUsers != null ? analytics.newUsers : '0'}",
    "newCheatsheets": "${analytics.newCheatsheets != null ? analytics.newCheatsheets : '0'}",
    "newComments": "${analytics.newComments != null ? analytics.newComments : '0'}",
    "pendingReports": "${analytics.pendingReports != null ? analytics.pendingReports : '0'}",
    "pendingTagRequests": "${pendingTagRequests != null ? pendingTagRequests : '0'}"
};

// "views" ကဒ်ကို ဤစာရင်းထဲမှ ဖယ်ရှားလိုက်ပါပြီ
const systemDefaultCards = [
    { id: "users", title: "New Users Joined", dataSourceKey: "newUsers", iconClass: "fa-user-plus", themeClass: "bg-primary-subtle text-primary", baseUrl: "${pageContext.request.contextPath}/admin/users/list" },
    { id: "cheatsheets", title: "Cheatsheets Linked", dataSourceKey: "newCheatsheets", iconClass: "fa-file-code", themeClass: "bg-success-subtle text-success", baseUrl: "${pageContext.request.contextPath}/admin/cheatsheets/top-views" },
    { id: "reports", title: "Pending Requests", dataSourceKey: "pendingTagRequests", iconClass: "fa-triangle-exclamation", themeClass: "bg-danger-subtle text-danger", baseUrl: "${pageContext.request.contextPath}/admin/tag-request-process" }
];

function initializeDashboardCardsEngine() {
    let savedCards = localStorage.getItem("platform_analytics_cards_v5");
    
    // LocalStorage မှာ အရင်က သိမ်းထားတာရှိရင် "views" ကဒ်ကို စစ်ထုတ်ပြီး ဖယ်ထုတ်လိုက်ပါသည်
    let activeCards = !savedCards ? systemDefaultCards : JSON.parse(savedCards).filter(card => card.id !== 'views');
    
    let updatedCards = activeCards.map(card => {
        let sysCard = systemDefaultCards.find(c => c.id === card.id);
        
        let finalLink = "#";
        if (sysCard && sysCard.baseUrl) {
            finalLink = sysCard.baseUrl.includes('?') ? sysCard.baseUrl + targetScopeParams.replace('?', '&') : sysCard.baseUrl + targetScopeParams;
        } else if (card.linkUrl) {
            finalLink = card.linkUrl;
        }
        
        return { ...card, value: liveDatabaseMetrics[card.dataSourceKey] || '0', linkUrl: finalLink };
    });
    
    renderMetricsSliderLayout(updatedCards);
}

function renderMetricsSliderLayout(cardsArray) {
    const sliderContainer = document.getElementById("metricsSlider");
    sliderContainer.innerHTML = "";
    cardsArray.forEach(card => {
        const isActionable = card.linkUrl && card.linkUrl !== "#";
        const cardElement = document.createElement(isActionable ? "a" : "div");
        cardElement.className = "card premium-card p-4 clickable-metric-card";
        if(isActionable) cardElement.setAttribute("href", card.linkUrl);
        cardElement.innerHTML = 
            '<button class="card-trash-btn" onclick="handleDeleteCardModule(event, \'' + card.id + '\')"><i class="fa-solid fa-trash-can"></i></button>' +
            '<div class="d-flex align-items-center justify-content-between">' +
                '<div><span class="text-secondary d-block fw-semibold small mb-1">' + card.title + '</span><h3 class="fw-bold text-dark m-0">' + card.value + '</h3></div>' +
                '<div class="icon-shape-box ' + card.themeClass + '"><i class="fa-solid ' + card.iconClass + '"></i></div>' +
            '</div>';
        sliderContainer.appendChild(cardElement);
    });
}

function handleDeleteCardModule(event, cardId) {
    event.preventDefault();
    event.stopPropagation();
    let currentCards = JSON.parse(localStorage.getItem("platform_analytics_cards_v5") || "[]");
    localStorage.setItem("platform_analytics_cards_v5", JSON.stringify(currentCards.filter(card => card.id !== cardId)));
    initializeDashboardCardsEngine();
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