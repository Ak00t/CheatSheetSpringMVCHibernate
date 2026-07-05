<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>${parentCategory.name}</title>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', sans-serif;
        }

        body {
            background: #f8fafc;
            color: #1e293b;
        }

        .container {
            width: 95%;
            max-width: 1450px;
            margin: auto;
        }

        .hero {
            margin: 30px 0;
            padding: 58px;
            border-radius: 34px;
            background:
                radial-gradient(circle at top right, rgba(255, 255, 255, .24), transparent 34%),
                linear-gradient(135deg, #2563eb, #10b981);
            color: white;
            box-shadow: 0 22px 48px rgba(37, 99, 235, .22);
        }

        .hero h1 {
            font-size: 56px;
            margin-bottom: 15px;
        }

        .hero p {
            font-size: 19px;
            line-height: 1.8;
            max-width: 780px;
        }

        .stats-row {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            margin: 25px 0 45px;
        }

        .stat-card {
            background: white;
            border-radius: 24px;
            padding: 25px;
            box-shadow: 0 12px 30px rgba(15, 23, 42, .08);
            border: 1px solid #e2e8f0;
        }

        .stat-card h2 {
            font-size: 36px;
            color: #2563eb;
        }

        .stat-card p {
            color: #64748b;
            font-weight: 800;
        }

        .page-layout {
            display: grid;
            grid-template-columns: minmax(0, 1fr) 340px;
            gap: 30px;
            align-items: start;
        }

        .section {
            margin-bottom: 58px;
        }

        .section-title {
            font-size: 38px;
            font-weight: 900;
            margin-bottom: 10px;
        }

        .section-subtitle {
            color: #64748b;
            font-size: 17px;
            margin-bottom: 26px;
        }

        /* Child Categories */
        .child-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 24px;
        }

        .child-card {
            position: relative;
            min-height: 220px;
            background: white;
            border-radius: 30px;
            padding: 30px;
            text-decoration: none;
            color: #1e293b;
            border: 1px solid #e2e8f0;
            box-shadow: 0 12px 30px rgba(15, 23, 42, .07);
            transition: .3s;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .child-card::before {
            content: '';
            position: absolute;
            width: 190px;
            height: 190px;
            right: -75px;
            bottom: -75px;
            border-radius: 50%;
            background: radial-gradient(circle, #dbeafe, #ffffff);
            opacity: .9;
        }

        .child-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 22px 45px rgba(15, 23, 42, .12);
        }

        .child-card h3 {
            position: relative;
            z-index: 2;
            color: #2563eb;
            font-size: 30px;
            font-weight: 900;
            margin-bottom: 15px;
        }

        .child-card p {
            position: relative;
            z-index: 2;
            color: #475569;
            line-height: 1.7;
        }

        .child-open {
            position: relative;
            z-index: 2;
            color: #0f766e;
            font-weight: 900;
            margin-top: 20px;
        }

        /* Cheatsheet Cards */
        .sheet-grid {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 24px;
        }

        .sheet-card {
            border-radius: 22px;
            overflow: hidden;
            text-decoration: none;
            color: var(--text-color, white) !important;
            box-shadow: 0 12px 30px rgba(0, 0, 0, .13);
            transition: .3s;
            padding: 20px;
            display: flex;
            flex-direction: column;
            min-height: 470px;
            cursor: pointer;
            position: relative;
        }

        .sheet-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, .22);
        }

        .sheet-cover {
            width: 100%;
            height: 170px;
            border: 2px dashed rgba(255, 255, 255, 0.45);
            border-radius: 18px;
            display: flex;
            justify-content: center;
            align-items: center;
            color: var(--text-color, white);
            font-size: 18px;
            font-weight: 800;
            overflow: hidden;
            background: rgba(0, 0, 0, 0.06);
            flex-shrink: 0;
        }

        .sheet-cover img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .sheet-body {
            padding-top: 12px;
            display: flex;
            flex-direction: column;
            flex-grow: 1;
            overflow: hidden;
        }

        .category-badge {
            display: inline-block;
            padding: 6px 14px;
            border-radius: 999px;
            background: rgba(0, 0, 0, 0.12);
            color: var(--text-color, white);
            font-size: 12px;
            font-weight: 800;
            margin-bottom: 12px;
            align-self: flex-start;
        }

        .sheet-title {
            font-size: 21px;
            color: var(--text-color, white);
            margin-bottom: 8px;
            font-weight: 900;
            line-height: 1.35;
        }

        .sheet-description {
            color: var(--text-color, white);
            opacity: 0.9;
            line-height: 1.55;
            max-height: 95px;
            overflow: hidden;
            font-size: 15px;
        }

        .see-btn {
            display: inline-block;
            margin-top: 6px;
            color: var(--text-color, white);
            text-decoration: underline;
            font-weight: 800;
            cursor: pointer;
        }

        .sheet-footer {
            margin-top: auto;
            padding-top: 12px;
            border-top: 1px solid rgba(0, 0, 0, 0.1);
            color: var(--text-color, white);
            opacity: 0.8;
            font-size: 13px;
            line-height: 1.7;
        }

        .creator-link {
            color: var(--text-color, white);
            text-decoration: none;
            font-weight: 900;
        }

        /* Sidebar */
        .sidebar {
            position: sticky;
            top: 20px;
        }

        .sidebar-card {
            background: white;
            border-radius: 26px;
            padding: 24px;
            margin-bottom: 24px;
            border: 1px solid #e2e8f0;
            box-shadow: 0 14px 35px rgba(15, 23, 42, .08);
        }

        .sidebar-card h3 {
            font-size: 22px;
            margin-bottom: 18px;
        }

        .quick-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 14px 0;
            border-bottom: 1px solid #e2e8f0;
            color: #475569;
            font-weight: 800;
        }

        .quick-item:last-child {
            border-bottom: none;
        }

        .quick-value {
            color: #2563eb;
            font-size: 20px;
            font-weight: 900;
        }

        .sidebar-scroll-box {
            max-height: 350px;
            overflow-y: auto;
            padding-right: 6px;
            scroll-behavior: smooth;
        }

        .sidebar-scroll-box::-webkit-scrollbar {
            width: 6px;
        }

        .sidebar-scroll-box::-webkit-scrollbar-thumb {
            background: #cbd5e1;
            border-radius: 999px;
        }

        .mini-card {
            display: flex;
            gap: 12px;
            text-decoration: none;
            color: #1e293b;
            margin-bottom: 16px;
            align-items: center;
        }

        .mini-img {
            width: 78px;
            height: 62px;
            border-radius: 14px;
            overflow: hidden;
            background: #e2e8f0;
            flex-shrink: 0;
        }

        .mini-img img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .mini-title {
            font-size: 14px;
            font-weight: 900;
            line-height: 1.4;
        }

        .mini-meta {
            margin-top: 5px;
            font-size: 12px;
            color: #64748b;
        }

        .side-chip-list {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
        }

        .side-chip {
            padding: 10px 14px;
            border-radius: 999px;
            background: #eff6ff;
            color: #2563eb;
            text-decoration: none;
            font-weight: 800;
            font-size: 13px;
        }

        .scroll-controls {
            display: flex;
            gap: 10px;
            margin-top: 14px;
        }

        .scroll-btn {
            flex: 1;
            border: none;
            padding: 10px;
            border-radius: 12px;
            background: #eff6ff;
            color: #2563eb;
            font-weight: 900;
            cursor: pointer;
        }

        .empty-box {
            background: white;
            border: 2px dashed #cbd5e1;
            border-radius: 26px;
            padding: 30px;
            color: #64748b;
        }

        @media(max-width:1150px) {
            .page-layout {
                grid-template-columns: 1fr;
            }

            .sidebar {
                position: static;
            }

            .child-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media(max-width:768px) {
            .hero {
                padding: 32px;
            }

            .hero h1 {
                font-size: 38px;
            }

            .stats-row {
                grid-template-columns: 1fr;
            }

            .child-grid,
            .sheet-grid {
                grid-template-columns: 1fr;
            }
        }


        #quickTopicSidebar .mini-card {
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            padding: 14px;
            margin-bottom: 12px;
            transition: .2s;
        }

        #quickTopicSidebar .mini-card:hover {
            background: #eff6ff;
            transform: translateX(4px);
        }

        .side-chip-scroll-box {
            max-height: 230px;
            overflow-y: auto;
            padding-right: 6px;
            scroll-behavior: smooth;
        }

        .side-chip-scroll-box::-webkit-scrollbar {
            width: 6px;
        }

        .side-chip-scroll-box::-webkit-scrollbar-thumb {
            background: #cbd5e1;
            border-radius: 999px;
        }
    </style>
</head>

<body>

    <jsp:include page="header.jsp" />

    <div class="container">

        <section class="hero">
        
      

    <a href="${pageContext.request.contextPath}/"
       style="
            display:inline-flex;
            align-items:center;
            gap:8px;
            margin-bottom:20px;
            padding:12px 18px;
            background:rgba(255,255,255,.18);
            backdrop-filter:blur(10px);
            border:1px solid rgba(255,255,255,.25);
            border-radius:14px;
            color:white;
            text-decoration:none;
            font-weight:800;
            box-shadow:0 8px 20px rgba(0,0,0,.12);
            transition:.2s;">
        ← Back to Home
    </a>

        
        
        
            <h1>${parentCategory.name}</h1>

            <p>
                <c:choose>
                    <c:when test="${not empty parentCategory.description}">
                        ${parentCategory.description}
                    </c:when>
                    <c:otherwise>
                        Browse child categories and discover related cheatsheets.
                    </c:otherwise>
                </c:choose>
            </p>
        </section>

        <div class="stats-row">
            <div class="stat-card">
                <h2>${childCount}</h2>
                <p>Categories</p>
            </div>

            <div class="stat-card">
                <h2>${popularCheatsheets.size()}</h2>
                <p>Popular Cheatsheets</p>
            </div>

            <div class="stat-card">
                <h2>${recentCheatsheets.size()}</h2>
                <p>Recent Cheatsheets</p>
            </div>
        </div>

        <div class="page-layout">

            <main>
                <!-- Popular Section -->
                <section class="section">
                    <h2 class="section-title">🔥 Popular in ${parentCategory.name}</h2>
                    <p class="section-subtitle">Popular cheatsheets from topics under ${parentCategory.name}.</p>

                    <c:choose>
                        <c:when test="${not empty popularCheatsheets}">
                            <div class="sheet-grid">
                                <c:forEach items="${popularCheatsheets}" var="sheet">
                                    
                                    <div class="sheet-card auto-text-color"
                                        data-color="${not empty sheet.themeColor ? sheet.themeColor : '#2563eb'}"
                                        style="background-color:${not empty sheet.themeColor ? sheet.themeColor : '#2563eb'};"
                                        onclick="location.href='${pageContext.request.contextPath}/cheatsheet/${sheet.id}'">

                                                                                <div class="sheet-cover">
                                            <c:choose>
                                                <c:when test="${not empty sheet.mediaList}">
                                                    <c:choose>
                                                        <c:when test="${fn:contains(sheet.mediaList[0].mediaUrl, '/')}">
                                                            <img src="${sheet.mediaList[0].mediaUrl}" alt="${sheet.title}">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <img src="${pageContext.request.contextPath}/cheatsheet/uploads/${sheet.mediaList[0].mediaUrl}" alt="${sheet.title}">
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:when>
                                                <c:otherwise>
                                                    No Cover
                                                </c:otherwise>
                                            </c:choose>
                                        </div>

                                        <div class="sheet-body">

                                            <div class="category-badge">
                                                ${sheet.category.name}
                                            </div>

                                            <div style="
                                                display:flex;
                                                justify-content:space-between;
                                                align-items:flex-start;
                                                margin-bottom:10px;">

                                                <h3 class="sheet-title"
                                                    style="
                                                        flex-grow:1;
                                                        padding-right:10px;
                                                        margin:0;">
                                                    ${sheet.title}
                                                </h3>

                                               <div class="dropdown" onclick="event.stopPropagation();">
                                                    <button
                                                        class="btn p-1 text-reset border-0 shadow-none d-flex align-items-center justify-content-center"
                                                        type="button"
                                                        data-bs-toggle="dropdown"
                                                        aria-expanded="false"
                                                        style="color: var(--text-color, white) !important; opacity: 0.8;">
                                                        <i class="bi bi-three-dots-vertical fs-5"></i>
                                                    </button>

                                                    <ul class="dropdown-menu dropdown-menu-end shadow border-0 py-2"
                                                        style="border-radius: 10px; font-size: 14px;">
                                                        <li>
                                                            <a class="dropdown-item d-flex align-items-center gap-2 py-2 fw-semibold"
                                                               href="javascript:void(0);"
                                                               onclick="event.stopPropagation(); openPlaylistModal('${sheet.id}');">
                                                                <i class="bi bi-plus-circle-fill text-primary"></i>
                                                                Save to Collections
                                                            </a>
                                                        </li>
                                                    </ul>
                                                </div>

                                            </div>

                                            <p class="sheet-description">
                                                ${sheet.description}
                                            </p>

                                            <span class="see-btn">
                                                See More
                                            </span>

                                            <div class="sheet-footer"
                                                 style="
                                                    display:flex;
                                                    justify-content:space-between;
                                                    align-items:center;">

                                                <div>
                                                    <span style="
                                                        font-size:11px;
                                                        opacity:.7;
                                                        display:block;">
                                                        Created By:
                                                    </span>

                                                    <a href="${pageContext.request.contextPath}/profile/${sheet.user.id}"
                                                       class="creator-link"
                                                       onclick="event.stopPropagation();">
                                                        ${sheet.user.name}
                                                    </a>

                                                    <div style="
                                                        font-size:11px;
                                                        opacity:.7;
                                                        margin-top:4px;">

                                                        <c:set var="datePart"
                                                               value="${fn:substring(sheet.createdAt, 0, 10)}" />

                                                        <c:set var="timePart"
                                                               value="${fn:substring(sheet.createdAt, 11, 16)}" />

                                                        🗓 ${datePart} ${timePart}
                                                    </div>
                                                </div>

                                                <a href="${pageContext.request.contextPath}/profile/${sheet.user.id}"
                                                   onclick="event.stopPropagation();"
                                                   style="flex-shrink:0;">
                                                    <img src="${pageContext.request.contextPath}/uploads/profiles/${not empty sheet.user.profileImg ? sheet.user.profileImg : 'default.png'}"
                                                         style="
                                                            width:40px;
                                                            height:40px;
                                                            object-fit:cover;
                                                            border-radius:50%;
                                                            border:2px solid white;
                                                            box-shadow:0 2px 6px rgba(0,0,0,0.15);"
                                                         alt="creator" />
                                                </a>

                                            </div>

                                        </div>

                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-box">No popular cheatsheets found.</div>
                        </c:otherwise>
                    </c:choose>
                </section>

                <!-- Recent Section -->
                <section class="section">
                    <h2 class="section-title">🆕 Recent in ${parentCategory.name}</h2>
                    <p class="section-subtitle">Recently published cheatsheets from this parent category.</p>

                    <c:choose>
                        <c:when test="${not empty recentCheatsheets}">
                            <div class="sheet-grid">
                                <c:forEach items="${recentCheatsheets}" var="sheet">
                                    
                                    <div class="sheet-card auto-text-color"
                                        data-color="${not empty sheet.themeColor ? sheet.themeColor : '#10b981'}"
                                        style="background-color:${not empty sheet.themeColor ? sheet.themeColor : '#10b981'};"
                                        onclick="location.href='${pageContext.request.contextPath}/cheatsheet/${sheet.id}'">

                                                                                <div class="sheet-cover">
                                            <c:choose>
                                                <c:when test="${not empty sheet.mediaList}">
                                                    <c:choose>
                                                        <c:when test="${fn:contains(sheet.mediaList[0].mediaUrl, '/')}">
                                                            <img src="${sheet.mediaList[0].mediaUrl}" alt="${sheet.title}">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <img src="${pageContext.request.contextPath}/cheatsheet/uploads/${sheet.mediaList[0].mediaUrl}" alt="${sheet.title}">
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:when>
                                                <c:otherwise>
                                                    No Cover
                                                </c:otherwise>
                                            </c:choose>
                                        </div>

                                        <div class="sheet-body">

                                            <div class="category-badge">
                                                ${sheet.category.name}
                                            </div>

                                            <div style="
                                                display:flex;
                                                justify-content:space-between;
                                                align-items:flex-start;
                                                margin-bottom:10px;">

                                                <h3 class="sheet-title"
                                                    style="
                                                        flex-grow:1;
                                                        padding-right:10px;
                                                        margin:0;">
                                                    ${sheet.title}
                                                </h3>

                                                <div class="dropdown" onclick="event.stopPropagation();">
                                                    <button
                                                        class="btn p-1 text-reset border-0 shadow-none d-flex align-items-center justify-content-center"
                                                        type="button"
                                                        data-bs-toggle="dropdown"
                                                        aria-expanded="false"
                                                        style="color: var(--text-color, white) !important; opacity: 0.8;">
                                                        <i class="bi bi-three-dots-vertical fs-5"></i>
                                                    </button>

                                                    <ul class="dropdown-menu dropdown-menu-end shadow border-0 py-2"
                                                        style="border-radius: 10px; font-size: 14px;">
                                                        <li>
                                                            <a class="dropdown-item d-flex align-items-center gap-2 py-2 fw-semibold"
                                                               href="javascript:void(0);"
                                                               onclick="event.stopPropagation(); openPlaylistModal('${sheet.id}');">
                                                                <i class="bi bi-plus-circle-fill text-primary"></i>
                                                                Save to Collections
                                                            </a>
                                                        </li>
                                                    </ul>
                                                </div>

                                            </div>

                                            <p class="sheet-description">
                                                ${sheet.description}
                                            </p>

                                            <span class="see-btn">
                                                See More
                                            </span>

                                            <div class="sheet-footer"
                                                 style="
                                                    display:flex;
                                                    justify-content:space-between;
                                                    align-items:center;">

                                                <div>
                                                    <span style="
                                                        font-size:11px;
                                                        opacity:.7;
                                                        display:block;">
                                                        Created By:
                                                    </span>

                                                    <a href="${pageContext.request.contextPath}/profile/${sheet.user.id}"
                                                       class="creator-link"
                                                       onclick="event.stopPropagation();">
                                                        ${sheet.user.name}
                                                    </a>

                                                    <div style="
                                                        font-size:11px;
                                                        opacity:.7;
                                                        margin-top:4px;">

                                                        <c:set var="datePart"
                                                               value="${fn:substring(sheet.createdAt, 0, 10)}" />

                                                        <c:set var="timePart"
                                                               value="${fn:substring(sheet.createdAt, 11, 16)}" />

                                                        🗓 ${datePart} ${timePart}
                                                    </div>
                                                </div>

                                                <a href="${pageContext.request.contextPath}/profile/${sheet.user.id}"
                                                   onclick="event.stopPropagation();"
                                                   style="flex-shrink:0;">
                                                    <img src="${pageContext.request.contextPath}/uploads/profiles/${not empty sheet.user.profileImg ? sheet.user.profileImg : 'default.png'}"
                                                         style="
                                                            width:40px;
                                                            height:40px;
                                                            object-fit:cover;
                                                            border-radius:50%;
                                                            border:2px solid white;
                                                            box-shadow:0 2px 6px rgba(0,0,0,0.15);"
                                                         alt="creator" />
                                                </a>

                                            </div>

                                        </div>

                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-box">No recent cheatsheets found.</div>
                        </c:otherwise>
                    </c:choose>
                </section>
            </main>

            <aside class="sidebar">                       
                <!-- Card 1: Quick Topics -->
                <div class="sidebar-card">
                    <h3>🧭 Quick Topics</h3>

                    <c:choose>
                        <c:when test="${not empty childCategories}">
                            <div id="quickTopicSidebar" class="side-chip-scroll-box">
                                <div class="side-chip-list">
                                    <c:forEach items="${childCategories}" var="child">
                                        <a href="${pageContext.request.contextPath}/child-category/${child.id}" class="side-chip">
                                            ${child.name}
                                        </a>
                                    </c:forEach>
                                </div>
                            </div>

                            <div class="scroll-controls">
                                <button type="button" class="scroll-btn" onclick="scrollBox('quickTopicSidebar', -120)">▲</button>
                                <button type="button" class="scroll-btn" onclick="scrollBox('quickTopicSidebar', 120)">▼</button>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-box">No topics.</div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Card 2: Popular Picks -->
                <div class="sidebar-card">
                    <h3>🔥 Popular Picks</h3>

                    <c:choose>
                        <c:when test="${not empty popularCheatsheets}">
                            <div id="popularSidebar" class="sidebar-scroll-box">
                                <c:forEach items="${popularCheatsheets}" var="sheet">
                                    <a href="${pageContext.request.contextPath}/cheatsheet/${sheet.id}" class="mini-card">
                                        <div class="mini-img">
                                            <c:choose>
                                                <c:when test="${not empty sheet.mediaList}">
                                                <c:choose>
    <%-- If it contains a slash, it's an old legacy relativePath --%>
    <c:when test="${sheet.mediaList[0].mediaUrl.contains('/')}">
        <img src="${sheet.mediaList[0].mediaUrl}" alt="${sheet.title}">
    </c:when>
    
    <%-- Otherwise, it's a new clean fileName entry --%>
    <c:otherwise>
        <img src="${pageContext.request.contextPath}/cheatsheet/uploads/${sheet.mediaList[0].mediaUrl}" alt="${sheet.title}">
    </c:otherwise>
</c:choose>
                                                  <%--   <img src="${sheet.mediaList[0].mediaUrl}" alt="${sheet.title}"> --%>
                                                </c:when>
                                                <c:otherwise>
                                                    <div></div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div>
                                            <div class="mini-title">${sheet.title}</div>
                                            <div class="mini-meta">
                                               <%--  👁 ${sheet.viewCount} --%> &nbsp; ❤ ${sheet.likeCount}
                                            </div>
                                        </div>
                                    </a>
                                </c:forEach>
                            </div>

                            <div class="scroll-controls">
                                <button type="button" class="scroll-btn" onclick="scrollBox('popularSidebar', -150)">▲</button>
                                <button type="button" class="scroll-btn" onclick="scrollBox('popularSidebar', 150)">▼</button>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-box">No popular items.</div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Card 3: Latest -->
                <div class="sidebar-card">
                    <h3>🆕 Latest</h3>

                    <c:choose>
                        <c:when test="${not empty recentCheatsheets}">
                            <div id="recentSidebar" class="sidebar-scroll-box">
                                <c:forEach items="${recentCheatsheets}" var="sheet">
                                    <a href="${pageContext.request.contextPath}/cheatsheet/${sheet.id}" class="mini-card">
                                        <div class="mini-img">
                                            <c:choose>
                                                <c:when test="${not empty sheet.mediaList}">
                                                    <img src="${sheet.mediaList[0].mediaUrl}" alt="${sheet.title}">
                                                </c:when>
                                                <c:otherwise>
                                                    <div></div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div>
                                            <div class="mini-title">${sheet.title}</div>
                                            <div class="mini-meta">👤 ${sheet.user.name}</div>
                                            <!-- Safely placed card footers outside of structural tag validation trees -->
                                            <div class="sheet-footer" style="border-top:none; padding-top:4px;">
                                                <c:set var="datePart" value="${fn:substring(sheet.createdAt, 0, 10)}" />
                                                <span style="font-size: 11px; color:#64748b;">🗓 ${datePart}</span>
                                            </div>
                                        </div>
                                    </a>
                                </c:forEach>
                            </div>

                            <div class="scroll-controls">
                                <button type="button" class="scroll-btn" onclick="scrollBox('recentSidebar', -150)">▲</button>
                                <button type="button" class="scroll-btn" onclick="scrollBox('recentSidebar', 150)">▼</button>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-box">No recent items.</div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </aside>

        </div>
    </div>

<!-- 🌟 🛑 [image_a15920.jpg အတိုင်း ကွက်တိပုံဖော်ထားသော Premium Playlist Modal] -->
<div class="modal fade" id="bootstrapPlaylistModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" style="max-width: 420px;">
        <div class="modal-content border-0 p-2" style="border-radius: 24px; box-shadow: 0 10px 40px rgba(0,0,0,0.12);">
            <div class="modal-header border-0 pb-0 pt-3 px-4">
                <h5 class="modal-title fw-bold text-dark" style="font-size: 22px;">Save to Collections</h5>
                <button type="button" class="btn-close shadow-none" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body px-4 pb-4 pt-3">
                
                <!-- Choose Playlist Section -->
                <div class="mb-3">
                    <label class="form-label text-secondary fw-semibold small mb-1" style="font-size: 13px;">Choose Collections</label>
                    <select id="playlistSelect" class="form-select py-2 rounded-3 text-secondary" style="border-color: #cbd5e1; font-size: 14px;">
                        <option value="">-- --</option>
                    </select>
                </div>

                <!-- Save Button -->
                <button onclick="saveToSelectedPlaylist()" class="btn btn-primary w-100 py-2 fw-bold mb-4 rounded-3 shadow-sm" style="background-color: #2563eb; border: none; font-size: 15px;">
                    Save to Selected
                </button>

                <hr class="my-3" style="opacity: 0.1;">

                <!-- Create New Playlist Section -->
                <div class="mb-3">
                    <label class="form-label text-secondary fw-semibold small mb-1" style="font-size: 13px;">Create New Collections</label>
                    <input id="newPlaylistName" class="form-control py-2 rounded-3" style="border-color: #cbd5e1; font-size: 14px;" placeholder="Choose a title">
                </div>

                <!-- Visibility Section -->
                <div class="mb-3">
                    <label class="form-label text-secondary fw-semibold small mb-1" style="font-size: 13px;">Visibility</label>
                    <select id="newPlaylistVisibility" class="form-select py-2 rounded-3 text-dark" style="border-color: #cbd5e1; font-size: 14px;">
                        <option value="PRIVATE">Private</option>
                        <option value="PUBLIC">Public</option>
                    </select>
                </div>

                <!-- Collaborate Section (Toggle Switch) -->
                <!-- <div class="d-flex justify-content-between align-items-center mb-4">
                    <label class="form-label text-dark fw-semibold small m-0" style="font-size: 14px;">Collaborate</label>
                    <div class="form-check form-switch p-0 m-0 d-flex align-items-center">
                        <input class="form-check-input m-0" type="checkbox" role="switch" id="collaborateToggle" style="width: 2.5em; height: 1.25em; cursor: pointer;">
                    </div>
                </div> -->

                <!-- Create Button -->
                <button onclick="createNewPlaylist()" class="btn btn-dark w-100 py-2 fw-bold rounded-3" style="background-color: #1e293b; border: none; font-size: 15px;">
                    Create
                </button>

            </div>
        </div>
    </div>
</div>



    <jsp:include page="footer.jsp" />

    <script>

 

    function getContrastColor(hexColor) {
        if (!hexColor || hexColor === "null") {
            hexColor = "#2563eb";
        }
        hexColor = hexColor.replace("#", "");
        if (hexColor.length === 3) {
            hexColor = hexColor[0] + hexColor[0] + hexColor[1] + hexColor[1] + hexColor[2] + hexColor[2];
        }
        const r = parseInt(hexColor.substr(0, 2), 16);
        const g = parseInt(hexColor.substr(2, 2), 16);
        const b = parseInt(hexColor.substr(4, 2), 16);
        const yiq = ((r * 299) + (g * 587) + (b * 114)) / 1000;
        return (yiq >= 128) ? "#1e293b" : "#ffffff";
    }

    function applyDynamicTextColors() {
        document.querySelectorAll(".auto-text-color").forEach(function (card) {
            const bgHex = card.getAttribute("data-color");
            const idealTextColor = getContrastColor(bgHex);
            card.style.setProperty("--text-color", idealTextColor);
        });
    }

    document.addEventListener("DOMContentLoaded", function () {
        applyDynamicTextColors();

        document.querySelectorAll(".see-btn").forEach(function (btn) {
            btn.addEventListener("click", function (e) {
                e.preventDefault();
                e.stopPropagation();
                const desc = this.previousElementSibling;
                if (desc.style.maxHeight === "none") {
                    desc.style.maxHeight = "95px";
                    this.innerText = "See More";
                } else {
                    desc.style.maxHeight = "none";
                    this.innerText = "See Less";
                }
            });
        });
    });

    function scrollBox(id, amount) {
        const box = document.getElementById(id);
        if (box) {
            box.scrollBy({ top: amount, behavior: "smooth" });
        }
    }

    // =========================================================================
    // 🚀 PLAYLIST MODAL CORE LOGIC ENGINE (JSP Escaping ပြဿနာ ရှင်းလင်းပြီးသား)
    // =========================================================================
    let selectedCheatsheetIdForPlaylist = null;
    let playlistModalObj = null;

    function openPlaylistModal(cheatsheetId) {
        selectedCheatsheetIdForPlaylist = cheatsheetId;
        
        // Modal Instance အား စနစ်တကျ ခေါ်ယူခြင်း
        const modalEl = document.getElementById('bootstrapPlaylistModal');
        if (!playlistModalObj) {
            playlistModalObj = new bootstrap.Modal(modalEl);
        }
        
        playlistModalObj.show();
        loadPlaylists(); // ဒေတာများ လှမ်းဆွဲမည်
    }

    function loadPlaylists() {
        fetch('${pageContext.request.contextPath}/collection/list')
            .then(res => {
                if (!res.ok) throw new Error("Network issues");
                return res.json();
            })
            .then(data => {
                const select = document.getElementById('playlistSelect');
                select.innerHTML = '<option value="">-- Choose Playlist --</option>';
                
                if(data.length === 0) {
                    select.innerHTML = '<option value="">No playlists found. Create one below!</option>';
                    return;
                }

                // 💡 🛑 Backtick ကင်းလွတ်သော Safe Object Builder ဖြင့် ပြင်ဆင်ခြင်း
                data.forEach(c => {
                    let option = document.createElement("option");
                    option.value = c.id;
                    option.text = c.name;
                    select.appendChild(option);
                });
            })
            .catch(err => {
                console.error("Error loading playlists:", err);
            });
    }

 // 💡 🛑 [အသစ်ပြင်ဆင်ထားသော Create Function] - အလွတ်ပုံစံမဟုတ်ဘဲ Dropdown က တန်ဖိုးပါ ယူသွားပါမည်
    function createNewPlaylist() {
        const nameInput = document.getElementById('newPlaylistName');
        const visibilitySelect = document.getElementById('newPlaylistVisibility');
        
        const name = nameInput.value.trim();
        const visibility = visibilitySelect.value; // Dropdown ဆီမှ PRIVATE သို့မဟုတ် PUBLIC အား ယူခြင်း

        if (!name) return alert("Please type a playlist name!");

        // Controller ရဲ့ /collection/create API တောင်းဆိုချက်အတိုင်း parameters များကို dynamic တွဲဖက်ပို့ဆောင်ခြင်း
        fetch('${pageContext.request.contextPath}/collection/create', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: 'name=' + encodeURIComponent(name) + '&visibility=' + encodeURIComponent(visibility)
        })
        .then(res => res.text())
        .then(() => {
            nameInput.value = ""; // စာသားရှင်းလင်းမည်
            loadPlaylists(); // Playlist နေရာအား Refresh ပြန်လုပ်မည်
        })
        .catch(err => alert("Failed to create playlist."));
    }

    function saveToSelectedPlaylist() {
        const collectionId = document.getElementById('playlistSelect').value;
        const cheatsheetId = selectedCheatsheetIdForPlaylist;

        if (!collectionId) return alert("Please select a playlist first!");
        if (!cheatsheetId) return alert("Context error: Cheat sheet data missing!");

        // 💡 🛑 URL Encoded Form Data တန်ဖိုးအား လွဲချော်မှုမရှိအောင် ပေါင်းစပ်ခြင်း
        fetch('${pageContext.request.contextPath}/collection/add-to-playlist', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: 'collectionId=' + encodeURIComponent(collectionId) + '&cheatsheetId=' + encodeURIComponent(cheatsheetId)
        })
        .then(res => res.text())
        .then(data => {
            if (data === "Item already added!") {
                alert("This cheat sheet is already inside this playlist.");
            } else {
                alert("Successfully added to your playlist!");
                if (playlistModalObj) playlistModalObj.hide();
            }
        })
        .catch(() => alert("Error saving to playlist"));
    }
        
        
    </script>

</body>
</html>