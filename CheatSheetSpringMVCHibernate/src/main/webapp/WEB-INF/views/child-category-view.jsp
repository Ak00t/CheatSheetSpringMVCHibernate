<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
                <!DOCTYPE html>
                <html>

                <head>
                    <meta charset="UTF-8">
                    <title>${childCategory.name}</title>

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
                            margin: 30px 0 25px;
                            border-radius: 28px;
                            overflow: hidden;
                            background: white;
                            box-shadow: 0 12px 35px rgba(15, 23, 42, .08);
                        }

                        .hero-top {
                            padding: 50px;
                            background: linear-gradient(135deg, #2563eb, #10b981);
                            color: white;
                            display: flex;
                            justify-content: space-between;
                            align-items: center;
                            gap: 30px;
                        }

                        .hero h1 {
                            font-size: 48px;
                            margin-bottom: 12px;
                        }

                        .hero p {
                            font-size: 17px;
                            line-height: 1.7;
                        }

                        .hero-stats {
                            display: flex;
                            gap: 45px;
                            text-align: center;
                        }

                        .hero-stats h2 {
                            font-size: 34px;
                        }

                        .hero-stats span {
                            font-size: 15px;
                        }

                        .follow-bar {
                            padding: 22px 35px;
                            display: flex;
                            justify-content: space-between;
                            align-items: center;
                        }

                        .follow-info small {
                            color: #64748b;
                            font-weight: 700;
                        }

                        .follow-info h3 {
                            margin-top: 6px;
                            font-size: 20px;
                        }

                        .follow-btn,
                        .following-btn {
                            border: none;
                            padding: 13px 28px;
                            border-radius: 14px;
                            color: white;
                            font-weight: 800;
                            cursor: pointer;
                            font-size: 15px;
                        }

                        .follow-btn {
                            background: #2563eb;
                        }

                        .following-btn {
                            background: #ef4444;
                        }

                        .page-layout {
                            display: grid;
                            grid-template-columns: 300px 1fr;
                            gap: 25px;
                            align-items: start;
                        }

                        .sidebar-card,
                        .main-card {
                            background: white;
                            border-radius: 20px;
                            box-shadow: 0 10px 30px rgba(15, 23, 42, .07);
                            border: 1px solid #e2e8f0;
                        }

                        .sidebar-card {
                            padding: 22px;
                            margin-bottom: 22px;
                        }

                        .sidebar-card h3 {
                            font-size: 20px;
                            margin-bottom: 18px;
                        }

                        .tags {
                            display: flex;
                            flex-wrap: wrap;
                            gap: 12px;
                        }

                        .tag-card {
                            padding: 10px 16px;
                            border-radius: 999px;
                            background: white;
                            color: #2563eb;
                            text-decoration: none;
                            font-weight: 800;
                            border: 1px solid #bfdbfe;
                            box-shadow: 0 6px 16px rgba(37, 99, 235, .08);
                            font-size: 14px;
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
                            width: 70px;
                            height: 55px;
                            border-radius: 10px;
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
                            font-weight: 800;
                            line-height: 1.4;
                        }

                        .mini-meta {
                            margin-top: 4px;
                            font-size: 12px;
                            color: #64748b;
                        }

                        .main-card {
                            padding: 25px;
                        }

                        .main-head {
                            display: flex;
                            justify-content: space-between;
                            align-items: center;
                            margin-bottom: 25px;
                        }

                        .main-title {
                            font-size: 30px;
                            font-weight: 900;
                        }

                        .main-subtitle {
                            color: #64748b;
                            margin-top: 6px;
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

                        .empty-box {
                            background: white;
                            border: 2px dashed #cbd5e1;
                            border-radius: 20px;
                            padding: 25px;
                            color: #64748b;
                        }

                        @media(max-width:900px) {
                            .page-layout {
                                grid-template-columns: 1fr;
                            }

                            .hero-top {
                                flex-direction: column;
                                align-items: flex-start;
                            }

                            .hero-stats {
                                width: 100%;
                                justify-content: space-between;
                            }
                        }

                        @media(max-width:768px) {
                            .hero-top {
                                padding: 30px;
                            }

                            .hero h1 {
                                font-size: 36px;
                            }

                            .sheet-grid {
                                grid-template-columns: 1fr;
                            }
                        }

                        /* Pagination UI */
                        .category-pagination {
                            display: flex;
                            justify-content: center;
                            align-items: center;
                            gap: 12px;
                            margin-top: 40px;
                            width: 100%;
                            flex-wrap: wrap;
                        }

                        .category-pagination .page-btn {
                            min-width: 48px;
                            height: 48px;
                            padding: 0 20px;
                            display: flex;
                            justify-content: center;
                            align-items: center;
                            border-radius: 14px;
                            background: #ffffff;
                            color: #0f172a !important;
                            text-decoration: none !important;
                            font-size: 15px;
                            font-weight: 900;
                            border: 1px solid #e2e8f0;
                            box-shadow: 0 8px 20px rgba(15, 23, 42, .08);
                            transition: .25s ease;
                        }

                        .category-pagination .page-btn:hover {
                            background: #2563eb;
                            color: white !important;
                            border-color: #2563eb;
                            transform: translateY(-3px);
                            box-shadow: 0 14px 28px rgba(37, 99, 235, .22);
                        }

                        .category-pagination .page-btn.active {
                            background: #2563eb;
                            color: white !important;
                            border-color: #2563eb;
                            box-shadow: 0 14px 28px rgba(37, 99, 235, .22);
                        }
                    </style>
                </head>

                <body>

                    <jsp:include page="header.jsp" />

                    <div class="container">

                        <section class="hero">
                            <div class="hero-top">
                            
                            <a href="${pageContext.request.contextPath}/category/${childCategory.parent.id}"
   style="
        display:inline-flex;
        align-items:center;
        gap:8px;
        margin:20px 0 0 20px;
        padding:12px 18px;
        background:rgba(255,255,255,.15);
        backdrop-filter:blur(10px);
        border:1px solid rgba(255,255,255,.25);
        border-radius:14px;
        color:white;
        text-decoration:none;
        font-weight:800;
        box-shadow:0 8px 20px rgba(0,0,0,.12);
        transition:.2s;">
    ← Back to Category
</a>
                            
                            
                            
                            
                                <div>
                                    <h1>${childCategory.name}</h1>
                                    <p>
                                        <c:choose>
                                            <c:when test="${not empty childCategory.description}">
                                                ${childCategory.description}
                                            </c:when>
                                            <c:otherwise>
                                                Browse cheatsheets, tags and resources related to ${childCategory.name}.
                                            </c:otherwise>
                                        </c:choose>
                                    </p>
                                </div>
                                <div class="hero-stats">
                                    <div>
                                        <h2>${followersCount}</h2>
                                        <span>Followers</span>
                                    </div>
                                    <div>
                                        <h2>${cheatsheets.size()}</h2>
                                        <span>Cheatsheets</span>
                                    </div>
                                </div>
                            </div>

                            <div class="follow-bar">
                                <div class="follow-info">
                                    <small>Category</small>
                                    <h3>${childCategory.name}</h3>
                                </div>
                                <c:choose>
                                    <c:when test="${isFollowing}">
                                        <form method="post"
                                            action="${pageContext.request.contextPath}/category/unfollow/${childCategory.id}">
                                            <button type="submit" class="following-btn">✓ Following</button>
                                        </form>
                                    </c:when>
                                    <c:otherwise>
                                        <form method="post"
                                            action="${pageContext.request.contextPath}/category/follow/${childCategory.id}">
                                            <button type="submit" class="follow-btn">+ Follow</button>
                                        </form>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </section>

                        <div class="page-layout">
                            <aside>
                                <div class="sidebar-card">
                                    <h3>🏷 Tags</h3>
                                    <c:choose>
                                        <c:when test="${not empty tags}">
                                            <div class="tags">
                                                <c:forEach items="${tags}" var="tag">
                                                    <a href="${pageContext.request.contextPath}/tag/${tag.id}"
                                                        class="tag-card">#${tag.name}</a>
                                                </c:forEach>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="empty-box">No tags found.</div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                
<div class="sidebar-card">
    <h3>🔥 Popular Picks</h3>

    <c:choose>
        <c:when test="${not empty popularCheatsheets}">
            <div id="popularSidebar" class="sidebar-scroll-box">

                <c:forEach items="${popularCheatsheets}" var="sheet">
                    <a href="${pageContext.request.contextPath}/cheatsheet/${sheet.id}"
                       class="mini-card">

                        <div class="mini-img">
                            <c:choose>
                                <c:when test="${not empty sheet.mediaList}">
                                    <img src="${sheet.mediaList[0].mediaUrl}"
                                         alt="${sheet.title}">
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
                             <%--    👁 ${sheet.viewCount} --%>
                                &nbsp; ❤ ${sheet.likeCount}
                            </div>
                        </div>

                    </a>
                </c:forEach>

            </div>

            <div class="scroll-controls">
                <button type="button"
                        class="scroll-btn"
                        onclick="scrollBox('popularSidebar', -150)">
                    ▲
                </button>

                <button type="button"
                        class="scroll-btn"
                        onclick="scrollBox('popularSidebar', 150)">
                    ▼
                </button>
            </div>
        </c:when>

        <c:otherwise>
            <div class="empty-box">
                No popular items.
            </div>
        </c:otherwise>
    </c:choose>
</div>


<div class="sidebar-card">
    <h3>🆕 Latest</h3>

    <c:choose>
        <c:when test="${not empty recentCheatsheets}">
            <div id="recentSidebar" class="sidebar-scroll-box">

                <c:forEach items="${recentCheatsheets}" var="sheet">
                    <a href="${pageContext.request.contextPath}/cheatsheet/${sheet.id}"
                       class="mini-card">

                        <div class="mini-img">
                            <c:choose>
                                <c:when test="${not empty sheet.mediaList}">
                                    <img src="${sheet.mediaList[0].mediaUrl}"
                                         alt="${sheet.title}">
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
                                👤 ${sheet.user.name}
                            </div>

                            <div style="margin-top:4px;">
                                <c:set var="datePart"
                                       value="${fn:substring(sheet.createdAt, 0, 10)}" />

                                <span style="font-size:11px;color:#64748b;">
                                    🗓 ${datePart}
                                </span>
                            </div>
                        </div>

                    </a>
                </c:forEach>

            </div>

            <div class="scroll-controls">
                <button type="button"
                        class="scroll-btn"
                        onclick="scrollBox('recentSidebar', -150)">
                    ▲
                </button>

                <button type="button"
                        class="scroll-btn"
                        onclick="scrollBox('recentSidebar', 150)">
                    ▼
                </button>
            </div>
        </c:when>

        <c:otherwise>
            <div class="empty-box">
                No recent items.
            </div>
        </c:otherwise>
    </c:choose>
</div>

</aside>



                            <main class="main-card">
                                <div class="main-head">
                                    <div>
                                        <div class="main-title">📚 All Cheatsheets</div>
                                        <p class="main-subtitle">Browse all public cheatsheets under
                                            ${childCategory.name}.</p>
                                    </div>
                                </div>

                                <c:choose>
                                    <c:when test="${not empty cheatsheets}">
                                        <div class="sheet-grid">
                                            <c:forEach items="${cheatsheets}" var="sheet">
                                                <div class="sheet-card auto-text-color"
                                                    data-color="${not empty sheet.themeColor ? sheet.themeColor : '#2563eb'}"
                                                    style="background-color:${not empty sheet.themeColor ? sheet.themeColor : '#2563eb'}; cursor: pointer; position: relative;"
                                                    onclick="location.href='${pageContext.request.contextPath}/cheatsheet/${sheet.id}'">

                                                    <div class="sheet-cover">
                                                        <c:choose>
                                                            <c:when test="${not empty sheet.mediaList}">
                                                                <%-- 💡 🛑 အဓိကပြင်ဆင်ချက်: All Cheatsheets Card
                                                                    ကြီးတွေမှာလည်း Cover Photo ပုံမှန်အတိုင်း
                                                                    ပြန်ပေါ်လာအောင် သက်ဆိုင်ရာ Upload API လမ်းကြောင်း
                                                                    /profile/uploads/ ခံပြီး ပတ်လမ်းညှိပေးလိုက်ခြင်း
                                                                    ဖြစ်ပါတယ်ဗျာ။ --%>
                                                                   <%--  <img src="${pageContext.request.contextPath}/admin/cheatsheet/uploads/${sheet.mediaList[0].mediaUrl}"
                                                                        alt="${sheet.title}"> --%>
                                                                        
                                                                        
                                                                        <img src="${sheet.mediaList[0].mediaUrl}"
     alt="${sheet.title}">
                                                            </c:when>
                                                            <c:otherwise>No Cover</c:otherwise>
                                                        </c:choose>
                                                    </div>

                                                    <div class="sheet-body">
                                                        <div class="category-badge">${sheet.category.name}</div>

                                                        <div
                                                            class="d-flex justify-content-between align-items-start mb-2">
                                                            <h3 class="sheet-title mb-0"
                                                                style="flex-grow: 1; padding-right: 10px;">
                                                                ${sheet.title}
                                                            </h3>

                                                            <div class="dropdown" onclick="event.stopPropagation();">
                                                                <button
                                                                    class="btn p-1 text-reset border-0 shadow-none d-flex align-items-center justify-content-center"
                                                                    type="button" data-bs-toggle="dropdown"
                                                                    aria-expanded="false"
                                                                    style="color: var(--text-color, white) !important; opacity: 0.8;">
                                                                    <i class="bi bi-three-dots-vertical fs-5"></i>
                                                                </button>
                                                                <ul class="dropdown-menu dropdown-menu-end shadow border-0 py-2"
                                                                    style="border-radius: 10px; font-size: 14px;">
                                                                    <li>
                                                                        <a class="dropdown-item d-flex align-items-center gap-2 py-2 fw-semibold"
                                                                            href="javascript:void(0);"
                                                                            onclick="openPlaylistModal('${sheet.id}')">
                                                                            <i
                                                                                class="bi bi-plus-circle-fill text-primary"></i>
                                                                            Save to Collections
                                                                        </a>
                                                                    </li>
                                                                </ul>
                                                            </div>
                                                        </div>

                                                        <p class="sheet-description">${sheet.description}</p>
                                                        <span class="see-btn">See More</span>

                                                        <div class="sheet-footer d-flex align-items-center justify-content-between mt-auto pt-2"
                                                            style="border-top: 1px solid rgba(0,0,0,0.1);">
                                                            <div>
                                                                <span
                                                                    style="font-size: 11px; opacity: 0.7; display:block;">Created
                                                                    By:</span>
                                                                <a href="${pageContext.request.contextPath}/profile/${sheet.user.id}"
                                                                    class="creator-link"
                                                                    onclick="event.stopPropagation();">
                                                                    ${sheet.user.name}
                                                                </a>
                                                                <div
                                                                    style="font-size: 11px; opacity: 0.7; margin-top: 2px;">
                                                                    🗓
                                                                    <c:set var="datePart"
                                                                        value="${fn:substring(sheet.createdAt, 0, 10)}" />
                                                                    <c:set var="timePart"
                                                                        value="${fn:substring(sheet.createdAt, 11, 16)}" />
                                                                    <span
                                                                        style="font-size: 12px; opacity: 0.9;">${datePart}
                                                                        ${timePart}</span>
                                                                </div>
                                                            </div>

                                                            <a href="${pageContext.request.contextPath}/profile/${sheet.user.id}"
                                                                onclick="event.stopPropagation();"
                                                                style="flex-shrink:0;">
                                                                <img src="${pageContext.request.contextPath}/uploads/profiles/${not empty sheet.user.profileImg ? sheet.user.profileImg : 'default.png'}"
                                                                    style="width: 40px; height: 40px; object-fit: cover; border-radius: 50%; border: 2px solid white; box-shadow: 0 2px 6px rgba(0,0,0,0.15);"
                                                                    alt="creator" />
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>


                                            <c:if test="${totalPages > 1}">

                                                <div class="category-pagination">

                                                    <c:if test="${page > 0}">
                                                        <a href="${pageContext.request.contextPath}${baseUrl}?page=${page - 1}"
                                                            class="page-btn">
                                                            ← Prev
                                                        </a>
                                                    </c:if>

                                                    <c:forEach begin="0" end="${totalPages - 1}" var="i">

                                                        <a href="${pageContext.request.contextPath}${baseUrl}?page=${i}"
                                                            class="page-btn ${i == page ? 'active' : ''}">
                                                            ${i + 1}
                                                        </a>

                                                    </c:forEach>

                                                    <c:if test="${page < totalPages - 1}">
                                                        <a href="${pageContext.request.contextPath}${baseUrl}?page=${page + 1}"
                                                            class="page-btn">
                                                            Next →
                                                        </a>
                                                    </c:if>

                                                </div>

                                            </c:if>


                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="empty-box">No published cheatsheets found for this category.</div>
                                    </c:otherwise>
                                </c:choose>
                            </main>
                        </div>
                    </div>

                    <jsp:include page="footer.jsp" />

                    <div class="modal fade" id="bootstrapPlaylistModal" tabindex="-1" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered" style="max-width: 400px;">
                            <div class="modal-content border-0 shadow-lg" style="border-radius: 16px; color: #1e293b;">
                                <div class="modal-header border-0 pb-0 pt-4 px-4">
                                    <h5 class="modal-title fw-bold text-dark fs-4">Save to Collections</h5>
                                    <button type="button" class="btn-close shadow-none" data-bs-dismiss="modal"
                                        aria-label="Close"></button>
                                </div>
                                <div class="modal-body p-4">
                                    <label class="small fw-semibold text-muted mb-2">Choose Collections</label>
                                    <select id="playlistSelect" class="form-select form-select-lg mb-4"
                                        style="border-radius: 8px; font-size: 0.95rem;">
                                        <option value="">-- Select a Collections --</option>
                                    </select>

                                    <button onclick="saveToSelectedPlaylist()"
                                        class="btn btn-primary btn-lg w-100 fw-bold mb-3"
                                        style="border-radius: 8px; font-size: 1rem;">
                                        Save to Collections
                                    </button>

                                    <hr class="text-muted my-3">

                                    <div id="createSection">
                                        <label class="small fw-semibold text-muted mb-2">Create Collections</label>
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
                                            type="button" style="border-radius: 8px;">Create</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <script>
                        function getContrastColor(hexColor) {
                            if (!hexColor || hexColor === "null") hexColor = "#2563eb";
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

                        document.addEventListener("DOMContentLoaded", applyDynamicTextColors);

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

                        let selectedCheatsheetIdForPlaylist = null;
                        let playlistModalObj = null;

                        function openPlaylistModal(cheatsheetId) {
                            selectedCheatsheetIdForPlaylist = cheatsheetId;
                            if (!playlistModalObj) {
                                playlistModalObj = new bootstrap.Modal(document.getElementById('bootstrapPlaylistModal'));
                            }
                            playlistModalObj.show();
                            loadPlaylists();
                        }

                        function loadPlaylists() {
                            fetch('${pageContext.request.contextPath}/collection/list')
                                .then(res => res.json())
                                .then(data => {
                                    const select = document.getElementById('playlistSelect');
                                    select.innerHTML = '<option value="">-- Choose Playlist --</option>';
                                    data.forEach(c => {
                                        select.innerHTML += `<option value="\${c.id}">\${c.name}</option>`;
                                    });
                                })
                                .catch(err => console.error("Error loading playlists:", err));
                        }

                        function createNewPlaylist() {
                            const nameInput = document.getElementById('newPlaylistName');
                            const visibilitySelect = document.getElementById('newPlaylistVisibility');
                            const collaborateCheck = document.getElementById('newPlaylistCollaborate');

                            const name = nameInput.value.trim();
                            const visibility = visibilitySelect.value;
                            const collaborate = collaborateCheck.checked;

                            if (!name) return alert("Please enter a playlist name!");

                            fetch('${pageContext.request.contextPath}/collection/create', {
                                method: 'POST',
                                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                                body: `name=\${encodeURIComponent(name)}&visibility=\${visibility}&collaborate=\${collaborate}`
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
                            const collectionId = document.getElementById('playlistSelect').value;
                            const cheatsheetId = selectedCheatsheetIdForPlaylist;

                            if (!collectionId) return alert("Please select a playlist first!");
                            if (!cheatsheetId) return alert("No cheatsheet context captured!");

                            fetch('${pageContext.request.contextPath}/collection/add-to-playlist', {
                                method: 'POST',
                                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                                body: `collectionId=\${collectionId}&cheatsheetId=\${cheatsheetId}`
                            })
                                .then(res => res.text())
                                .then(data => {
                                    if (data === "Item already added!") {
                                        alert("This cheat sheet is already in the selected playlist.");
                                    } else {
                                        alert("Successfully added to your playlist!");
                                        if (playlistModalObj) playlistModalObj.hide();
                                    }
                                })
                                .catch(() => alert("Error saving to playlist"));
                        }
                    </script>
                
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
</script>
</body>

                </html>