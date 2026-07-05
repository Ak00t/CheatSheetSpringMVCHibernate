<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Bookmarks Collection</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Segoe UI', sans-serif; }
        body { background-color: #f8fafc; color: #1e293b; }
        .page-header { margin-top: 40px; margin-bottom: 30px; }
        
        /* 🌟 Modern Clean Grid Layout */
        .sheet-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 24px;
            margin-bottom: 35px;
        }
        
        /* 🌟 child-category-view.jsp အတိုင်း Dynamic Theme Color သုံး Full-Body Layout ပုံစံသစ် */
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

        /* 🌟 Cover Photo ပြသမည့် အကွက်လေး တိုးမြှင့်လိုက်သည် */
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

        /* Category Badge Stylings */
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
            text-transform: uppercase;
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
        
        /* Pagination Styling */
        .pagination .page-link {
            color: #475569;
            border-radius: 10px;
            margin: 0 3px;
            border: 1px solid #e2e8f0;
            font-weight: 600;
            transition: all 0.2s;
        }
        .pagination .page-item.active .page-link {
            background-color: #2563eb;
            border-color: #2563eb;
            color: white;
        }
    </style>
</head>
<body>

<jsp:include page="header.jsp"/>

<div class="container">
    
    <div class="d-flex justify-content-between align-items-center page-header">
        <div>
            <h2 class="fw-bold m-0 text-dark">
                <i class="bi bi-bookmark-heart-fill text-warning me-2"></i> Cheatsheet Bookmarks
            </h2>
            <p class="text-muted m-0 mt-1">Your favorited custom library</p>
        </div>
        <a href="${pageContext.request.contextPath}/profile/${sessionScope.currentUser.id}" class="btn btn-outline-secondary btn-sm rounded-3 px-3 fw-semibold shadow-sm">
            <i class="bi bi-arrow-left"></i> Profile
        </a>
    </div>

    <c:choose>
        <c:when test="${not empty bookmarkedSheets}">
            <div class="sheet-grid">
                <c:forEach items="${bookmarkedSheets}" var="sheet">
                    
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
                            <div class="category-badge">${sheet.category.name}</div>
                            
                            <div class="d-flex justify-content-between align-items-start mb-2">
                                <h3 class="sheet-title mb-0" style="flex-grow: 1; padding-right: 10px;">
                                    ${sheet.title}
                                </h3>
                                
                                <div class="dropdown" onclick="event.stopPropagation();">
                                    <button class="btn p-1 text-reset border-0 shadow-none d-flex align-items-center justify-content-center"
                                            type="button" data-bs-toggle="dropdown" aria-expanded="false"
                                            style="color: var(--text-color, white) !important; opacity: 0.8;">
                                        <i class="bi bi-three-dots-vertical fs-5"></i>
                                    </button>
                                    <ul class="dropdown-menu dropdown-menu-end shadow border-0 py-2" style="border-radius: 10px; font-size: 14px;">
                                        <li>
                                            <form action="${pageContext.request.contextPath}/cheatsheet/bookmark" method="POST" onsubmit="return confirm('Remove this from your bookmarks?');" class="m-0">
                                                <input type="hidden" name="cheatsheetId" value="${sheet.id}" />
                                                <button type="submit" class="dropdown-item d-flex align-items-center gap-2 py-2 fw-semibold text-danger">
                                                    <i class="bi bi-trash3-fill"></i> Remove Bookmark
                                                </button>
                                            </form>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            
                            <p class="sheet-description">${sheet.description}</p>
                            <span class="see-btn">See More</span>
                            
                            <div class="sheet-footer d-flex align-items-center justify-content-between mt-auto pt-2">
                                <div>
                                    <span style="font-size: 11px; opacity: 0.7; display:block;">Created By:</span>
                                    <a href="${pageContext.request.contextPath}/profile/${sheet.user.id}" class="creator-link" onclick="event.stopPropagation();">
                                        ${sheet.user.name}
                                    </a>
                                    <div style="font-size: 11px; opacity: 0.7; margin-top: 4px;">
                                        🗓
                                        <c:set var="datePart" value="${fn:substring(sheet.createdAt, 0, 10)}" />
                                        <c:set var="timePart" value="${fn:substring(sheet.createdAt, 11, 16)}" />
                                        <span style="font-size: 12px; opacity: 0.9;">${datePart} ${timePart}</span>
                                    </div>
                                </div>

                                <a href="${pageContext.request.contextPath}/profile/${sheet.user.id}" onclick="event.stopPropagation();" style="flex-shrink:0;">
                                    <img src="${pageContext.request.contextPath}/uploads/profiles/${not empty sheet.user.profileImg ? sheet.user.profileImg : 'default.png'}"
                                         style="width: 40px; height: 40px; object-fit: cover; border-radius: 50%; border: 2px solid white; box-shadow: 0 2px 6px rgba(0,0,0,0.15);"
                                         alt="creator" />
                                </a>
                            </div>
                        </div>
                        
                    </div>

                </c:forEach>
            </div>

            <nav aria-label="Page navigation" class="d-flex justify-content-center my-5">
                <ul class="pagination shadow-sm p-1 bg-white rounded-3">
                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                        <a class="page-link py-2 px-3 d-flex align-items-center gap-1" href="?page=${currentPage - 1}">
                            <i class="bi bi-chevron-left"></i> Previous
                        </a>
                    </li>
                    <li class="page-item active">
                        <span class="page-link py-2 px-3">${not empty currentPage ? currentPage : 1}</span>
                    </li>
                    <li class="page-item ${hasMorePages == false ? 'disabled' : ''}">
                        <a class="page-link py-2 px-3 d-flex align-items-center gap-1" href="?page=${currentPage + 1}">
                            Next <i class="bi bi-chevron-right"></i>
                        </a>
                    </li>
                </ul>
            </nav>

        </c:when>
        
        <c:otherwise>
            <div class="text-center py-5 bg-white rounded-4 shadow-sm border my-4">
                <i class="bi bi-bookmark-dash text-muted" style="font-size: 4rem;"></i>
                <h4 class="fw-bold mt-3 text-secondary">No Bookmarks Found</h4>
                <p class="text-muted">Explore cheat sheets and bookmark them to see them here.</p>
                <a href="${pageContext.request.contextPath}/" class="btn btn-primary btn-sm rounded-3 px-4 mt-2">Browse Home</a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // --- High-Contrast Text Dynamic Color Sync ---
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

    // See More / See Less Context Sync
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
</script>
</body>
</html>