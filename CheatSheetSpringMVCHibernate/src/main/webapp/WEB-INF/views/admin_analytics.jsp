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
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f8fafc;
        }
        
        /* --- Workspace Core Layout --- */
        .workspace-wrapper {
            display: flex;
            gap: 35px;
            padding: 35px 45px 35px 15px; 
            width: 100%;
            margin: 0;
            align-items: flex-start;
        }
        .analytics-content-area {
            flex-grow: 1;
            min-width: 0; 
        }
        
        /* --- Combined Sidebar Container Module Styling --- */
        .sidebar-container {
            width: 330px;                 
            min-width: 330px;             
            background-color: #ffffff;
            border-radius: 24px;
            padding: 30px 22px;           
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            min-height: calc(100vh - 64px);
            align-self: flex-start;
            margin-left: 0px;             
        }
        .sidebar-menu-links {
            display: flex;
            flex-direction: column;
            gap: 14px;
        }
        .sidebar-link {
            display: flex;
            align-items: center;
            gap: 18px;
            padding: 16px 24px;           
            color: #1e293b; 
            text-decoration: none;
            font-weight: 850;
            font-size: 18px;              
            border-radius: 14px;
            transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
        }
        .sidebar-link:hover {
            background-color: #f0f7ff;
            color: #2563eb; 
            transform: translateY(-3px);
            box-shadow: 0 12px 24px -4px rgba(37, 99, 235, 0.35), 0 4px 12px -2px rgba(37, 99, 235, 0.2); 
        }
        .sidebar-link.active {
            background-color: #2563eb;
            color: #ffffff;
            box-shadow: 0 16px 28px -6px rgba(37, 99, 235, 0.5), 0 6px 16px -4px rgba(37, 99, 235, 0.3);
        }
        .sidebar-link i {
            font-size: 24px;
            width: 26px;
            text-align: center;
            stroke-width: 2.5;
        }
        .sidebar-link-logout {
            color: #ef4444;
            border-top: 2px solid #f1f5f9; 
            padding-top: 20px;
            margin-top: 20px;
            font-weight: 850;
            font-size: 18px;
        }
        .sidebar-link-logout:hover {
            background-color: #fef2f2;
            color: #dc2626;
            transform: translateY(-3px);
            box-shadow: 0 12px 24px -4px rgba(239, 68, 68, 0.35), 0 4px 12px -2px rgba(239, 68, 68, 0.2);
        }

        /* --- Content & Metrics Slider Cards Module --- */
        .premium-card {
            background: #ffffff;
            border: 1px solid #f1f5f9;
            border-radius: 18px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.02);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            position: relative;
        }
        .premium-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.04);
        }
        .clickable-metric-card {
            text-decoration: none !important;
            display: block;
            cursor: pointer;
            min-width: 350px;
            flex: 0 0 auto;
        }
        .icon-shape-box {
            width: 58px;
            height: 58px;
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
        }
        
        /* --- Slider Container Section --- */
        .slider-outer-wrapper {
            position: relative;
            margin-bottom: 35px;
            padding: 0 50px; 
        }
        .metrics-slider-container {
            display: flex;
            gap: 24px;
            overflow-x: auto;
            scroll-behavior: smooth;
            padding: 15px 0px; 
            scrollbar-width: none;
        }
        .metrics-slider-container::-webkit-scrollbar {
            display: none;
        }
        
        .slider-nav-btn {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            width: 44px;
            height: 44px;
            border-radius: 50%;
            background: #ffffff;
            border: 1px solid #cbd5e1;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            display: flex;
            align-items: center;
            justify-content: center;
            color: #1e293b;
            z-index: 10;
            cursor: pointer;
            transition: all 0.2s ease;
        }
        .slider-nav-btn:hover {
            background: #2563eb;
            color: #ffffff;
            border-color: #2563eb;
        }
        .slider-prev { left: 0; }   
        .slider-next { right: 0; }  

        /* --- Hover Trash Action Module Styling --- */
        .card-trash-btn {
            position: absolute;
            top: 12px;
            right: 12px;
            width: 28px;
            height: 28px;
            border-radius: 6px;
            background: rgba(239, 68, 68, 0.1);
            color: #ef4444;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.85rem;
            border: none;
            opacity: 0;
            transition: opacity 0.2s ease;
            z-index: 10;
        }
        .premium-card:hover .card-trash-btn {
            opacity: 1;
        }
        .card-trash-btn:hover {
            background: #ef4444;
            color: #ffffff;
        }
    </style>
</head>
<body>

<jsp:include page="header.jsp" />

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

                <div class="col-md-3 filter-input" id="dayContainer">
                    <label class="form-label fw-semibold small text-muted">Choose Date</label>
                    <input type="date" name="day" class="form-control text-dark" value="${param.day}">
                </div>

                <div class="col-md-2 filter-input" id="yearContainer">
                    <label class="form-label fw-semibold small text-muted">Year Frame</label>
                    <select name="year" class="form-select text-dark">
                        <c:forEach var="yr" begin="2026" end="2090">
                            <option value="${yr}" ${param.year == yr ? 'selected' : ''}>${yr}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="col-md-2 filter-input" id="monthContainer">
                    <label class="form-label fw-semibold small text-muted">Month Frame</label>
                    <select name="month" class="form-select text-dark">
                        <c:forEach var="entry" items="${monthsMap}">
                            <option value="${entry.key}" ${param.month == entry.key ? 'selected' : ''}>${entry.value}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="col-md-2 filter-input" id="weekContainer">
                    <label class="form-label fw-semibold small text-muted">Week Segment</label>
                    <select name="week" class="form-select text-dark">
                        <option value="1" ${param.week == 1 ? 'selected' : ''}>Week 1</option>
                        <option value="2" ${param.week == 2 ? 'selected' : ''}>Week 2</option>
                        <option value="3" ${param.week == 3 ? 'selected' : ''}>Week 3</option>
                        <option value="4" ${param.week == 4 ? 'selected' : ''}>Week 4</option>
                    </select>
                </div>

                <div class="col-md-2">
                    <button type="submit" class="btn btn-primary w-100 fw-bold py-2 shadow-sm" style="background: #2563eb; border-color: #2563eb;">
                        <i class="fa-solid fa-bolt me-2"></i>Search
                    </button>
                </div>
            </form>
        </div>

        <div class="card premium-card border-0 bg-white p-3 mb-4 d-flex flex-row align-items-center">
            <div class="icon-shape-box bg-primary-subtle text-primary me-3">
                <i class="fa-solid fa-calendar-alt"></i>
            </div>
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

        <div class="row">
            <div class="col-lg-12">
                <div class="card premium-card p-4 border-0">
                    <h5 class="fw-bold text-dark mb-3"><i class="fa-solid fa-chart-pie text-primary me-2"></i>Content Category Volume Distribution</h5>
                    <div class="table-responsive">
                        <table class="table table-hover align-middle m-0">
                            <thead class="table-light">
                                <tr>
                                    <th class="text-secondary fw-semibold py-3 px-3">Category Name</th>
                                    <th class="text-end text-secondary fw-semibold py-3 px-3">Cheatsheets Vol.</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="entry" items="${analytics.categoryDistribution}">
                                    <tr>
                                        <td class="fw-semibold text-dark px-3 py-3">${entry.key}</td>
                                        <td class="text-end fw-bold text-primary px-3 py-3">${entry.value}</td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty analytics.categoryDistribution}">
                                    <tr>
                                        <td colspan="2" class="text-center text-muted py-5 fw-medium">No content activity found within this period.</td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

<div class="modal fade" id="createCardModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 rounded-4 shadow">
            <div class="modal-header border-bottom-0 pb-0">
                <h5 class="fw-bold text-dark m-0">Create Custom Metric Card</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body py-4">
                <form id="createCardForm" onsubmit="handleCreateCard(event)">
                    <div class="mb-3">
                        <label class="form-label small fw-bold text-secondary">Card Title Description</label>
                        <input type="text" id="newCardTitle" class="form-control text-dark" placeholder="e.g., Highest Views Today" required>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label small fw-bold text-secondary">Select Live Data Source</label>
                        <select id="newCardDataSource" class="form-select text-dark">
                            <option value="maxViews">Highest / Maximum Views</option>
                            <option value="totalViews">Total Platform Views</option>
                            <option value="totalLikes">Total Likes Given</option>
                            <option value="newUsers">New Users Count</option>
                            <option value="newCheatsheets">New Cheatsheets Count</option>
                            <option value="newComments">Comments Received</option>
                            <option value="pendingReports">Pending Reports</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label small fw-bold text-secondary">Select Graphical Visual Symbol Icon</label>
                        <select id="newCardIcon" class="form-select text-dark">
                            <option value="fa-eye text-warning bg-warning-subtle">Visual Monitor Lens Symbol (Yellow)</option>
                            <option value="fa-arrow-trend-up text-success bg-success-subtle">Trending Up Arrow (Green)</option>
                            <option value="fa-user-plus text-primary bg-primary-subtle">User Profile Symbol (Blue)</option>
                            <option value="fa-file-code text-success bg-success-subtle">Source Code Document Symbol (Green)</option>
                            <option value="fa-comments text-info bg-info-subtle">Message Conversational Symbol (Cyan)</option>
                            <option value="fa-heart text-danger bg-danger-subtle">Heart Engagement Shape Symbol (Red)</option>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-primary fw-bold w-100 py-2 rounded-3 mt-2" style="background: #2563eb; border-color: #2563eb;">Append Custom Card Module</button>
                </form>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
function scrollMetricsSlider(amount) {
    var container = document.getElementById("metricsSlider");
    container.scrollBy({ left: amount, behavior: 'smooth' });
}

// Analytics Filter Parameters များ (ဒီနေရာကို ပြင်ဆင်ထားပါတယ်)
const targetScopeParams = "?type=${param.type}&year=${param.year}&month=${param.month}&week=${param.week}&day=${param.day}";

// LIVE DATABASE METRICS HUB
const liveDatabaseMetrics = {
    "newUsers": "${analytics.newUsers != null ? analytics.newUsers : '0'}",
    "newCheatsheets": "${analytics.newCheatsheets != null ? analytics.newCheatsheets : '0'}",
    "newComments": "${analytics.newComments != null ? analytics.newComments : '0'}",
    "pendingReports": "${analytics.pendingReports != null ? analytics.pendingReports : '0'}",
    "totalViews": "${analytics.totalViews != null ? analytics.totalViews : '0'}",
    "totalLikes": "${analytics.totalLikes != null ? analytics.totalLikes : '0'}",
    "maxViews": "${analytics.maxViews != null ? analytics.maxViews : '0'}"
};

// ပြင်ဆင်ထားသည့် System Default Cards များ
const systemDefaultCards = [
    {
        id: "users",
        title: "New Users Joined",
        dataSourceKey: "newUsers",
        iconClass: "fa-user-plus",
        themeClass: "bg-primary-subtle text-primary",
        linkUrl: "${pageContext.request.contextPath}/admin/users/list" + targetScopeParams
    },
    {
        id: "cheatsheets",
        title: "Cheatsheets Linked",
        dataSourceKey: "newCheatsheets",
        iconClass: "fa-file-code",
        themeClass: "bg-success-subtle text-success",
        linkUrl: "${pageContext.request.contextPath}/admin/cheatsheets/top-views" + targetScopeParams
    },
    {
        id: "comments",
        title: "Comments Received",
        dataSourceKey: "newComments",
        iconClass: "fa-comments",
        themeClass: "bg-info-subtle text-info",
        linkUrl: "${pageContext.request.contextPath}/admin/comments" + targetScopeParams
    },
    {
        id: "reports",
        title: "Pending Flagged",
        dataSourceKey: "pendingReports",
        iconClass: "fa-triangle-exclamation",
        themeClass: "bg-danger-subtle text-danger",
        linkUrl: "${pageContext.request.contextPath}/admin/reports?status=PENDING" + targetScopeParams
    },
    {
        id: "views",
        title: "Views Summary",
        dataSourceKey: "totalViews",
        iconClass: "fa-eye",
        themeClass: "bg-warning-subtle text-warning",
        linkUrl: "#"
    },
    {
        id: "likes",
        title: "Total Likes Given",
        dataSourceKey: "totalLikes",
        iconClass: "fa-heart",
        themeClass: "bg-danger-subtle text-danger",
        linkUrl: "#"
    }
];

function initializeDashboardCardsEngine() {
    // Cache မငြိအောင် Key နာမည်ကို v4 ပြောင်းပေးထားပါတယ်
    let savedCards = localStorage.getItem("platform_analytics_cards_v4");
    let activeCards = [];
    
    if (!savedCards) {
        activeCards = systemDefaultCards;
    } else {
        activeCards = JSON.parse(savedCards);
    }
    
    let updatedCards = activeCards.map(card => {
        return {
            ...card,
            value: liveDatabaseMetrics[card.dataSourceKey] || '0'
        };
    });
    
    localStorage.setItem("platform_analytics_cards_v4", JSON.stringify(updatedCards));
    renderMetricsSliderLayout(updatedCards);
}

function renderMetricsSliderLayout(cardsArray) {
    const sliderContainer = document.getElementById("metricsSlider");
    sliderContainer.innerHTML = "";
    
    cardsArray.forEach(card => {
        const isActionable = card.linkUrl && card.linkUrl !== "#";
        const wrapperTag = isActionable ? "a" : "div";

        const cardElement = document.createElement(wrapperTag);
        cardElement.className = "card premium-card p-4 clickable-metric-card";
        if(isActionable) {
            cardElement.setAttribute("href", card.linkUrl);
        }
        cardElement.id = "rendered_card_" + card.id;
        
        cardElement.innerHTML = 
            '<button class="card-trash-btn" onclick="handleDeleteCardModule(event, \'' + card.id + '\')">' +
                '<i class="fa-solid fa-trash-can"></i>' +
            '</button>' +
            '<div class="d-flex align-items-center justify-content-between">' +
                '<div>' +
                    '<span class="text-secondary d-block fw-semibold small mb-1">' + card.title + '</span>' +
                    '<h3 class="fw-bold text-dark m-0">' + card.value + '</h3>' +
                '</div>' +
                '<div class="icon-shape-box ' + card.themeClass + '"><i class="fa-solid ' + card.iconClass + '"></i></div>' +
            '</div>';
            
        sliderContainer.appendChild(cardElement);
    });
}

function handleCreateCard(event) {
    event.preventDefault();
    const title = document.getElementById("newCardTitle").value;
    const dataSourceKey = document.getElementById("newCardDataSource").value;
    const iconMeta = document.getElementById("newCardIcon").value.split(" ");
    
    const iconClass = iconMeta[0];
    const themeClass = iconMeta[1] + " " + iconMeta[2];
    const generatedId = "custom_" + Date.now();

    const currentCards = JSON.parse(localStorage.getItem("platform_analytics_cards_v4"));
    
    currentCards.push({
        id: generatedId,
        title: title,
        dataSourceKey: dataSourceKey,
        iconClass: iconClass,
        themeClass: themeClass,
        linkUrl: "#"
    });

    localStorage.setItem("platform_analytics_cards_v4", JSON.stringify(currentCards));
    initializeDashboardCardsEngine(); 
    
    document.getElementById("createCardForm").reset();
    const modalElement = document.getElementById("createCardModal");
    const modalInstance = bootstrap.Modal.getInstance(modalElement);
    modalInstance.hide();
}

function handleDeleteCardModule(event, cardId) {
    event.preventDefault();
    event.stopPropagation();
    
    const currentCards = JSON.parse(localStorage.getItem("platform_analytics_cards_v4"));
    const updatedCards = currentCards.filter(card => card.id !== cardId);
    
    localStorage.setItem("platform_analytics_cards_v4", JSON.stringify(updatedCards));
    renderMetricsSliderLayout(updatedCards);
}

function toggleEngineInputs() {
    var mode = document.getElementById("filterType").value;
    document.getElementById("yearContainer").style.display = (mode === "WEEK" || mode === "MONTH" || mode === "YEAR") ? "block" : "none";
    document.getElementById("monthContainer").style.display = (mode === "WEEK" || mode === "MONTH") ? "block" : "none";
    document.getElementById("weekContainer").style.display = (mode === "WEEK") ? "block" : "none";
    document.getElementById("dayContainer").style.display = (mode === "DAY") ? "block" : "none";
}

window.onload = function() {
    toggleEngineInputs();
    initializeDashboardCardsEngine();
};
</script>
</body>
</html>