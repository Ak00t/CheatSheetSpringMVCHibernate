<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>CheatSheet Hub</title>

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
                    max-width: 1400px;
                    margin: auto;
                }

                .hero {
                    margin: 30px 0;
                    padding: 55px;
                    border-radius: 32px;
                    background: linear-gradient(135deg, #2563eb, #10b981);
                    color: white;
                    box-shadow: 0 20px 45px rgba(37, 99, 235, .22);
                }

                .hero h1 {
                    font-size: 54px;
                    margin-bottom: 15px;
                }

                .hero p {
                    font-size: 18px;
                    line-height: 1.8;
                    max-width: 820px;
                }

                .hero-stats {
                    display: grid;
                    grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
                    gap: 20px;
                    margin-top: 35px;
                }

                .stat-card {
                    background: rgba(255, 255, 255, .18);
                    border: 1px solid rgba(255, 255, 255, .25);
                    padding: 24px;
                    border-radius: 22px;
                }

                .stat-card h2 {
                    font-size: 38px;
                    margin-bottom: 6px;
                }

                .page-layout {
                    display: grid;
                    grid-template-columns: 1fr 330px;
                    gap: 28px;
                    align-items: start;
                    margin-top: 45px;
                }

                .section {
                    margin-bottom: 55px;
                }

                .section-title {
                    font-size: 34px;
                    font-weight: 900;
                    margin-bottom: 8px;
                }

                .section-subtitle {
                    color: #64748b;
                    margin-bottom: 25px;
                }

                /* Category Cards */

                .category-grid {
                    display: grid;
                    grid-template-columns: repeat(3, 1fr);
                    gap: 32px;
                }

                .category-card {
                    position: relative;
                    min-height: 250px;
                    padding: 36px;
                    border-radius: 32px;
                    background: #fff;
                    border: 1px solid #edf2f7;
                    text-decoration: none;
                    color: #1e293b;
                    overflow: hidden;
                    box-shadow: 0 10px 35px rgba(15, 23, 42, .06);
                    transition: .3s;

                    display: flex;
                    flex-direction: column;
                    justify-content: space-between;
                }

                .category-card:hover {
                    transform: translateY(-8px);
                    box-shadow: 0 20px 50px rgba(15, 23, 42, .10);
                }

                .category-card::before {
                    content: '';
                    position: absolute;
                    width: 230px;
                    height: 230px;
                    right: -90px;
                    bottom: -90px;
                    border-radius: 50%;
                    opacity: .75;
                    z-index: 1;
                }

                .gradient-0::before {
                    background: radial-gradient(circle, #dbeafe, #ffffff);
                }

                .gradient-1::before {
                    background: radial-gradient(circle, #ede9fe, #ffffff);
                }

                .gradient-2::before {
                    background: radial-gradient(circle, #fee2e2, #ffffff);
                }

                .gradient-3::before {
                    background: radial-gradient(circle, #dcfce7, #ffffff);
                }

                .gradient-4::before {
                    background: radial-gradient(circle, #fef3c7, #ffffff);
                }

                .gradient-5::before {
                    background: radial-gradient(circle, #e0e7ff, #ffffff);
                }

                .category-top {
                    position: relative;
                    z-index: 2;
                }

                .category-name {
                    color: #2563eb;
                    font-size: 28px;
                    font-weight: 800;
                }

                .category-desc {
                    margin-top: 28px;
                    color: #64748b;
                    line-height: 1.8;
                    font-size: 16px;
                    position: relative;
                    z-index: 2;
                }

                .category-count {
                    margin-top: 40px;
                    color: #475569;
                    font-size: 18px;
                    font-weight: 700;
                    position: relative;
                    z-index: 2;
                }


                /* Pagination */
                .category-pagination {
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    gap: 10px;
                    margin-top: 40px;
                    flex-wrap: wrap;
                }

                .page-btn {
                    padding: 12px 18px;
                    border-radius: 12px;
                    background: white;
                    text-decoration: none;
                    color: #0f172a;
                    font-weight: 800;
                    box-shadow: 0 4px 12px rgba(0, 0, 0, .08);
                    transition: .2s;
                }

                .page-btn:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 8px 18px rgba(0, 0, 0, .12);
                }

                .sheet-grid {
                    display: grid;
                    grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
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

                .sidebar-card {
                    background: white;
                    border-radius: 24px;
                    padding: 24px;
                    margin-bottom: 24px;
                    box-shadow: 0 12px 30px rgba(15, 23, 42, .08);
                    border: 1px solid #e2e8f0;
                }

                .sidebar-card h3 {
                    font-size: 22px;
                    margin-bottom: 20px;
                }

                .sidebar-scroll-box {
                    max-height: 330px;
                    overflow-y: auto;
                    scroll-behavior: smooth;
                    padding-right: 6px;
                }

                .sidebar-scroll-box::-webkit-scrollbar {
                    width: 6px;
                }

                .sidebar-scroll-box::-webkit-scrollbar-thumb {
                    background: #cbd5e1;
                    border-radius: 999px;
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

                .author-item {
                    display: flex;
                    gap: 14px;
                    align-items: center;
                    padding: 14px 0;
                    border-bottom: 1px solid #e2e8f0;
                    text-decoration: none;
                    color: #1e293b;
                }

                .avatar {
                    width: 48px;
                    height: 48px;
                    border-radius: 50%;
                    background: linear-gradient(135deg, #2563eb, #10b981);
                    color: white;
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    font-weight: 900;
                    overflow: hidden;
                }

                .avatar img{
    width:100%;
    height:100%;
    object-fit:cover;
    display:block;
}

                .author-name {
                    font-weight: 900;
                }

                .author-count {
                    color: #64748b;
                    font-size: 13px;
                    margin-top: 3px;
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
                    width: 72px;
                    height: 58px;
                    border-radius: 12px;
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
                    margin-top: 4px;
                    font-size: 12px;
                    color: #64748b;
                }

                .empty-box {
                    background: white;
                    border: 2px dashed #cbd5e1;
                    color: #64748b;
                    padding: 25px;
                    border-radius: 20px;
                }

                @media(max-width:1200px) {
                    .category-grid {
                        grid-template-columns: repeat(2, 1fr);
                    }
                }

                @media(max-width:950px) {
                    .page-layout {
                        grid-template-columns: 1fr;
                    }
                }

                @media(max-width:768px) {
                    .hero {
                        padding: 32px;
                    }

                    .hero h1 {
                        font-size: 38px;
                    }

                    .category-grid {
                        grid-template-columns: 1fr;
                    }
                }
            </style>

        </head>

        <body>

            <jsp:include page="header.jsp" />

            <div class="container">

                <section class="hero">
                    <h1>Explore Public Cheatsheets</h1>

                    <p>
                        Discover useful cheatsheets shared by the community.
                        Browse categories, learn faster, and find quick references
                        for your study and development work.
                    </p>

                    <div class="hero-stats">
                        <div class="stat-card">
                            <h2>${totalCheatsheets}</h2>
                            <span>Public Cheatsheets</span>
                        </div>

                        <div class="stat-card">
                            <h2>${totalCategories}</h2>
                            <span>Categories</span>
                        </div>

                        <div class="stat-card">
                            <h2>${totalUsers}</h2>
                            <span>Community Members</span>
                        </div>
                    </div>
                </section>

                <div class="page-layout">

                    <main>

                        <section class="section">
                            <h2 class="section-title">Explore Categories</h2>

                            <p class="section-subtitle">
                                Choose a main category and browse related topics.
                            </p>

                            <c:choose>
                                <c:when test="${not empty parentCategories}">

                                    <div class="category-grid">

                                        <c:forEach items="${parentCategories}" var="cat" varStatus="st">

                                            <a href="${pageContext.request.contextPath}/category/${cat.id}"
                                                class="category-card gradient-${st.index % 6}">

                                                <div class="category-top">
                                                    <div class="category-name">
                                                        ${cat.name}
                                                    </div>

                                                    <!--   <div class="category-arrow">
                                            →
                                        </div>-->
                                                </div>

                                                <div class="category-desc">
                                                    <c:choose>
                                                        <c:when test="${not empty cat.description}">
                                                            ${cat.description}
                                                        </c:when>
                                                        <c:otherwise>
                                                            Explore related topics and public cheatsheets.
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>



                                            </a>

                                        </c:forEach>

                                    </div>

                                    <c:if test="${totalCategoryPages > 1}">
                                        <div class="category-pagination">

                                            <c:if test="${categoryPage > 0}">
                                                <a href="?categoryPage=${categoryPage - 1}" class="page-btn">
                                                    ← Prev
                                                </a>
                                            </c:if>

                                            <c:forEach begin="0" end="${totalCategoryPages - 1}" var="i">

                                                <a href="?categoryPage=${i}" class="page-btn" style="
                                       background:${i == categoryPage ? '#2563eb' : 'white'};
                                       color:${i == categoryPage ? 'white' : '#0f172a'};">

                                                    ${i + 1}

                                                </a>

                                            </c:forEach>

                                            <c:if test="${categoryPage < totalCategoryPages - 1}">
                                                <a href="?categoryPage=${categoryPage + 1}" class="page-btn">
                                                    Next →
                                                </a>
                                            </c:if>

                                        </div>
                                    </c:if>

                                </c:when>

                                <c:otherwise>
                                    <div class="empty-box">
                                        No parent categories found.
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </section>


                        <section class="section">
                            <h2 class="section-title">🔥 Popular Cheatsheets</h2>

                            <p class="section-subtitle">
                                Most viewed and liked public cheatsheets.
                            </p>

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
                                                                <c:when test="${sheet.mediaList[0].mediaUrl.contains('/')}">
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

                                                        <div class="dropdown"
                                                             onclick="event.stopPropagation();">

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
                                                                        Save to Playlist
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
                                    <div class="empty-box">
                                        No popular cheatsheets yet.
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </section>


                    </main>

                    <aside>

                        <div class="sidebar-card">
                            <h3>🏆 Top Contributors</h3>

                            <c:choose>
                                <c:when test="${not empty topContributors}">
                                    <div id="authorSidebar" class="sidebar-scroll-box">

                                        <c:forEach items="${topContributors}" var="row">
                                            <a href="${pageContext.request.contextPath}/profile/${row[0].id}"
                                                class="author-item">

                                               
                                               <div class="avatar">
    <c:choose>
        <c:when test="${not empty row[0].profileImg}">
            <img src="${pageContext.request.contextPath}/uploads/profiles/${row[0].profileImg}"
                 alt="${row[0].name}">
        </c:when>
        <c:otherwise>
            ${row[0].name.substring(0,1)}
        </c:otherwise>
    </c:choose>
</div>
                                               
                                               
                                               

                                                <div>
                                                    <div class="author-name">
                                                        ${row[0].name}
                                                    </div>

                                                    <div class="author-count">
                                                        ${row[1]} public cheatsheets
                                                    </div>
                                                </div>

                                            </a>
                                        </c:forEach>

                                    </div>

                                    <div class="scroll-controls">
                                        <button type="button" class="scroll-btn"
                                            onclick="scrollBox('authorSidebar', -160)">
                                            ▲
                                        </button>

                                        <button type="button" class="scroll-btn"
                                            onclick="scrollBox('authorSidebar', 160)">
                                            ▼
                                        </button>
                                    </div>
                                </c:when>

                                <c:otherwise>
                                    <div class="empty-box">
                                        No contributors found.
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>


                        <div class="sidebar-card">
                            <h3>🆕 Recent Cheatsheets</h3>

                            <c:choose>
                                <c:when test="${not empty recentCheatsheets}">
                                    <div id="recentSidebar" class="sidebar-scroll-box">

                                        <c:forEach items="${recentCheatsheets}" var="sheet">
                                            <a href="${pageContext.request.contextPath}/cheatsheet/${sheet.id}"
                                                class="mini-card">

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
                                                        
                                                           <%--  <img src="${sheet.mediaList[0].mediaUrl}"
                                                                alt="${sheet.title}"> --%>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div></div>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>

                                                <div>
                                                    <div class="mini-title">
                                                        ${sheet.title}
                                                    </div>

                                                    <div class="mini-meta">
                                                      <!--   👤 -->
                                                        <span
                                                            onclick="event.preventDefault(); event.stopPropagation(); window.location.href='${pageContext.request.contextPath}/profile/${sheet.user.id}';"
                                                            style="cursor:pointer;text-decoration:underline;font-weight:700;">
                                                           <%--  ${sheet.user.name} --%>
                                                        </span>
                                                    </div>
                                                </div>

                                            </a>
                                        </c:forEach>

                                    </div>

                                    <div class="scroll-controls">
                                        <button type="button" class="scroll-btn"
                                            onclick="scrollBox('recentSidebar', -160)">
                                            ▲
                                        </button>

                                        <button type="button" class="scroll-btn"
                                            onclick="scrollBox('recentSidebar', 160)">
                                            ▼
                                        </button>
                                    </div>
                                </c:when>

                                <c:otherwise>
                                    <div class="empty-box">
                                        No recent cheatsheets yet.
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>



                    </aside>

                </div>

            </div>


            <div class="modal fade" id="bootstrapPlaylistModal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" style="max-width: 400px;">
                    <div class="modal-content border-0 shadow-lg" style="border-radius: 16px; color: #1e293b;">
                        <div class="modal-header border-0 pb-0 pt-4 px-4">
                            <h5 class="modal-title fw-bold text-dark fs-4">Save to playlist</h5>
                            <button type="button" class="btn-close shadow-none" data-bs-dismiss="modal"
                                aria-label="Close"></button>
                        </div>

                        <div class="modal-body p-4">
                            <label class="small fw-semibold text-muted mb-2">Choose Playlist</label>

                            <select id="playlistSelect" class="form-select form-select-lg mb-4"
                                style="border-radius: 8px; font-size: 0.95rem;">
                                <option value="">-- Select a playlist --</option>
                            </select>

                            <button onclick="saveToSelectedPlaylist()"
                                class="btn btn-primary btn-lg w-100 fw-bold mb-3"
                                style="border-radius: 8px; font-size: 1rem;">
                                Save to Selected
                            </button>

                            <hr class="text-muted my-3">

                            <div id="createSection">
                                <label class="small fw-semibold text-muted mb-2">Create New Playlist</label>

                                <input type="text" id="newPlaylistName" class="form-control mb-2"
                                    placeholder="Choose a title" style="border-radius: 8px;">

                                <label class="small fw-semibold text-muted mb-1">Visibility</label>

                                <select id="newPlaylistVisibility" class="form-select form-select-sm mb-3"
                                    style="border-radius: 8px;">
                                    <option value="PRIVATE">Private</option>
                                    <option value="PUBLIC">Public</option>
                                    
                                </select>

                                <div class="d-flex justify-content-between align-items-center mb-4">
                                    <label class="form-check-label fw-semibold text-dark"
                                        for="newPlaylistCollaborate">Collaborate</label>

                                    <div class="form-check form-switch">
                                        <input class="form-check-input" type="checkbox"
                                            id="newPlaylistCollaborate"
                                            style="width: 2.5em; height: 1.3em; cursor:pointer;">
                                    </div>
                                </div>

                                <button onclick="createNewPlaylist()" class="btn btn-dark fw-bold w-100"
                                    type="button" style="border-radius: 8px;">
                                    Create
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


            <jsp:include page="footer.jsp" />

            <script>
                function scrollBox(id, amount) {
                    const box = document.getElementById(id);

                    if (box) {
                        box.scrollBy({
                            top: amount,
                            behavior: "smooth"
                        });
                    }
                }

                function getContrastColor(hexColor) {
                    if (!hexColor || hexColor === "null") {
                        hexColor = "#2563eb";
                    }

                    hexColor = hexColor.replace("#", "");

                    if (hexColor.length === 3) {
                        hexColor =
                            hexColor[0] + hexColor[0] +
                            hexColor[1] + hexColor[1] +
                            hexColor[2] + hexColor[2];
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

                let selectedCheatsheetIdForPlaylist = null;
                let playlistModalObj = null;

                function openPlaylistModal(cheatsheetId) {
                    selectedCheatsheetIdForPlaylist = cheatsheetId;

                    if (!playlistModalObj) {
                        playlistModalObj =
                            new bootstrap.Modal(
                                document.getElementById('bootstrapPlaylistModal'));
                    }

                    playlistModalObj.show();
                    loadPlaylists();
                }

                function loadPlaylists() {
                    fetch('${pageContext.request.contextPath}/collection/list')
                        .then(res => res.json())
                        .then(data => {
                            const select =
                                document.getElementById('playlistSelect');

                            select.innerHTML =
                                '<option value="">-- Choose Playlist --</option>';

                            data.forEach(c => {
                                select.innerHTML +=
                                    `<option value="\${c.id}">\${c.name}</option>`;
                            });
                        })
                        .catch(err => console.error("Error loading playlists:", err));
                }

                function createNewPlaylist() {
                    const nameInput =
                        document.getElementById('newPlaylistName');

                    const visibilitySelect =
                        document.getElementById('newPlaylistVisibility');

                    const collaborateCheck =
                        document.getElementById('newPlaylistCollaborate');

                    const name = nameInput.value.trim();
                    const visibility = visibilitySelect.value;
                    const collaborate = collaborateCheck.checked;

                    if (!name) {
                        return alert("Please enter a playlist name!");
                    }

                    fetch('${pageContext.request.contextPath}/collection/create', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded'
                        },
                        body:
                            `name=\${encodeURIComponent(name)}&visibility=\${visibility}&collaborate=\${collaborate}`
                    })
                        .then(res => res.text())
                        .then(() => {
                            alert("Playlist Created!");
                            nameInput.value = "";
                            collaborateCheck.checked = false;
                            loadPlaylists();
                        })
                        .catch(() => alert("Error creating playlist"));
                }

                function saveToSelectedPlaylist() {
                    const collectionId =
                        document.getElementById('playlistSelect').value;

                    const cheatsheetId =
                        selectedCheatsheetIdForPlaylist;

                    if (!collectionId) {
                        return alert("Please select a playlist first!");
                    }

                    if (!cheatsheetId) {
                        return alert("No cheatsheet context captured!");
                    }

                    fetch('${pageContext.request.contextPath}/collection/add-to-playlist', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded'
                        },
                        body:
                            `collectionId=\${collectionId}&cheatsheetId=\${cheatsheetId}`
                    })
                        .then(res => res.text())
                        .then(data => {
                            if (data === "Item already added!") {
                                alert("This cheat sheet is already in the selected playlist.");
                            } else {
                                alert("Successfully added to your playlist!");

                                if (playlistModalObj) {
                                    playlistModalObj.hide();
                                }
                            }
                        })
                        .catch(() => alert("Error saving to playlist"));
                }
            </script>

        </body>

        </html>