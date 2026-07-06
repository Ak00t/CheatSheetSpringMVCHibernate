<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Results - CheatSheet Hub</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    
    <style>
        :root {
            --bg-canvas: #f4fbfc;       
            --brand-blue: #2563eb;     
            --brand-light: #eff6ff;     
            --text-dark: #1e293b;
            --text-gray: #64748b;
            --border-light: #e2e8f0;
            --shadow-sm: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: var(--bg-canvas);
            color: var(--text-dark);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .main-container {
            flex: 1;
            padding: 40px 24px;
            max-width: 1200px;
            width: 100%;
            margin: 0 auto;
        }

        .search-header-box {
            background: white;
            border-radius: 20px;
            padding: 30px;
            box-shadow: var(--shadow-sm);
            margin-bottom: 30px;
        }

        .search-bar-wrapper {
            position: relative;
            max-width: 600px;
        }

        .suggestion-box {
            position: absolute;
            top: 100%;
            left: 0;
            right: 0;
            background: white;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
            z-index: 1050;
            margin-top: 8px;
            max-height: 350px;
            overflow-y: auto;
            border: 1px solid var(--border-light);
        }

        .suggestion-box .dropdown-item:hover {
            background-color: var(--brand-light);
            color: var(--brand-blue);
        }

        .result-card {
            background: white;
            border-radius: 16px;
            padding: 20px;
            border: none;
            box-shadow: var(--shadow-sm);
            transition: transform 0.2s, box-shadow 0.2s;
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .result-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 20px rgba(37, 99, 235, 0.08);
        }

        .nav-tabs {
            border-bottom: 2px solid var(--border-light);
        }

        .nav-link {
            font-weight: 600;
            color: var(--text-gray);
            border: none !important;
            padding: 12px 20px;
            position: relative;
        }

        .nav-link.active {
            color: var(--brand-blue) !important;
            background: transparent !important;
        }

        .nav-link.active::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            right: 0;
            height: 3px;
            background-color: var(--brand-blue);
            border-radius: 3px;
        }

        .badge-count {
            font-size: 12px;
            padding: 4px 8px;
            border-radius: 20px;
            margin-left: 6px;
        }

        .site-footer {
            background: #111827;
            color: white;
            padding: 30px 20px;
            text-align: center;
            margin-top: 60px;
        }
    </style>
</head>
<body>

 <jsp:include page="header.jsp" />

    <div class="main-container">
        
        <!-- Live Global Search Bar Unit Context Area -->
        <div class="search-header-box">
            <h2 class="fw-bold mb-3">Search Results</h2>
            <form action="${pageContext.request.contextPath}/search" method="GET" autocomplete="off">
                <div class="search-bar-wrapper">
                    <div class="input-group">
                        <span class="input-group-text bg-white border-end-0 text-muted"><i class="bi bi-search"></i></span>
                        <input type="text" id="globalSearchInput" name="query" class="form-control border-start-0 py-2.5 shadow-none" 
                               placeholder="Search across sheets, categories, or creators..." value="<c:out value='${query}'/>">
                        <button type="submit" class="btn btn-primary px-4">Search</button>
                    </div>
                    <!-- Live JSON Dropdown Render target -->
                    <div id="globalSuggestBox" class="suggestion-box d-none">
                        <div id="globalSuggestContent" class="p-2"></div>
                    </div>
                </div>
            </form>
            
            <p class="text-muted mt-3 mb-0">
                <c:set var="totalItems" value="${fn:length(results.cheatsheets) + fn:length(results.categories) + fn:length(results.users)}" />
                Showing ${totalItems} results matching <span class="fw-bold text-dark">"<c:out value="${query}"/>"</span>
            </p>
        </div>

        <!-- Multi-Category Filter Nav Tabs Array Navigation Segment -->
        <ul class="nav nav-tabs mb-4" id="searchTabs" role="tablist">
            <li class="nav-item" role="presentation">
                <button class="nav-link active" id="sheets-tab" data-bs-toggle="tab" data-bs-target="#sheets-pane" type="button" role="tab">
                    <i class="bi bi-file-earmark-text me-1 text-primary"></i> Cheatsheets 
                    <span class="badge badge-count bg-primary-subtle text-primary">${fn:length(results.cheatsheets)}</span>
                </button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="categories-tab" data-bs-toggle="tab" data-bs-target="#categories-pane" type="button" role="tab">
                    <i class="bi bi-folder me-1 text-success"></i> Categories 
                    <span class="badge badge-count bg-success-subtle text-success">${fn:length(results.categories)}</span>
                </button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="users-tab" data-bs-toggle="tab" data-bs-target="#users-pane" type="button" role="tab">
                    <i class="bi bi-person me-1 text-warning"></i> Users 
                    <span class="badge badge-count bg-warning-subtle text-warning">${fn:length(results.users)}</span>
                </button>
            </li>
        </ul>

        <!-- Container panes parsing out elements sequentially -->
        <div class="tab-content" id="searchTabsContent">
            
            <!-- 📄 PANE 1: CHEATSHEETS -->
            <div class="tab-pane fade show active" id="sheets-pane" role="tabpanel" aria-labelledby="sheets-tab">
                <c:choose>
                    <c:when test="${not empty results.cheatsheets}">
                        <div class="row g-4">
                            <c:forEach var="sheet" items="${results.cheatsheets}">
                                <div class="col-md-4">
                                    <div class="result-card">
                                        <div>
                                            <h5 class="fw-bold text-dark mb-2 text-truncate"><c:out value="${sheet.title}"/></h5>
                                            <p class="text-muted small text-wrap-limit mb-3" style="display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;">
                                                <c:out value="${sheet.description}"/>
                                            </p>
                                        </div>
                                        <div class="d-flex justify-content-between align-items-center mt-3 pt-2 border-top">
                                            <span class="text-muted small"><i class="bi bi-eye"></i> View details</span>
                                            <a href="${pageContext.request.contextPath}/cheatsheet/${sheet.id}" class="btn btn-sm btn-primary px-3 rounded-pill">Open Sheet</a>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center py-5 bg-white rounded-4 shadow-sm">
                            <i class="bi bi-file-earmark-x fs-1 text-muted mb-2 d-block"></i>
                            <p class="text-muted m-0">No matching cheatsheets found.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- 📁 PANE 2: CATEGORIES -->
            <div class="tab-pane fade" id="categories-pane" role="tabpanel" aria-labelledby="categories-tab">
                <c:choose>
                    <c:when test="${not empty results.categories}">
                        <div class="row g-4">
                            <c:forEach var="cat" items="${results.categories}">
                                <div class="col-md-3">
                                    <div class="result-card p-4 align-items-center text-center">
                                        <div class="bg-success-subtle text-success rounded-circle p-3 mb-3 d-inline-flex justify-content-center align-items-center" style="width:60px; height:60px;">
                                            <i class="bi bi-folder2-open fs-3"></i>
                                        </div>
                                        <h6 class="fw-bold text-dark text-truncate w-100 mb-3"><c:out value="${cat.name}"/></h6>
                                        <a href="${pageContext.request.contextPath}/category/${cat.id}" class="btn btn-sm btn-outline-success w-100 rounded-pill">Browse Category</a>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center py-5 bg-white rounded-4 shadow-sm">
                            <i class="bi bi-folder-x fs-1 text-muted mb-2 d-block"></i>
                            <p class="text-muted m-0">No matching categories found.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- 👤 PANE 3: USERS -->
            <div class="tab-pane fade" id="users-pane" role="tabpanel" aria-labelledby="users-tab">
                <c:choose>
                    <c:when test="${not empty results.users}">
                        <div class="row g-4">
                            <c:forEach var="usr" items="${results.users}">
                                <div class="col-md-3">
                                    <div class="result-card p-4 align-items-center text-center">
                                        <div class="bg-warning-subtle text-warning rounded-circle p-3 mb-3 d-inline-flex justify-content-center align-items-center" style="width:60px; height:60px;">
                                            <i class="bi bi-person-bounding-box fs-3"></i>
                                        </div>
                                        <h6 class="fw-bold text-dark text-truncate w-100 mb-1"><c:out value="${usr.name}"/></h6>
                                        <p class="text-muted small mb-3"><c:out value="${usr.email}"/></p>
                                        <a href="${pageContext.request.contextPath}/user/${usr.id}" class="btn btn-sm btn-outline-warning w-100 rounded-pill">View Profile</a>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center py-5 bg-white rounded-4 shadow-sm">
                            <i class="bi bi-person-x fs-1 text-muted mb-2 d-block"></i>
                            <p class="text-muted m-0">No matching users found.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            
        </div>
    </div>

    <footer class="site-footer">
        <p class="m-0">© 2026 CheatSheet Hub. Learn Faster. Share Knowledge.</p>
    </footer>

    <!-- Bootstrap Bundle Core Module Script Dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <!-- ⚡ Dynamic Live Search Event Mapping Execution -->
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const ctx = "${pageContext.request.contextPath}";
            const searchInput = document.getElementById("globalSearchInput");
            const suggestBox = document.getElementById("globalSuggestBox");
            const suggestContent = document.getElementById("globalSuggestContent");

            searchInput.addEventListener("input", function () {
                const query = searchInput.value.trim();
                if (query === "") {
                    suggestBox.classList.add("d-none");
                    return;
                }

                fetch(ctx + '/search/live?query=' + encodeURIComponent(query))
                    .then(res => res.json())
                    .then(data => {
                        let html = "";
                        let hasCheatsheets = false;
                        let hasCategories = false;
                        let hasUsers = false;

                        let cheatsheetHtml = `<div class="p-2 small fw-bold text-primary"><i class="bi bi-file-earmark-text me-1"></i> Cheatsheets</div>`;
                        let categoryHtml = `<div class="p-2 small fw-bold text-success mt-2"><i class="bi bi-folder me-1"></i> Categories</div>`;
                        let userHtml = `<div class="p-2 small fw-bold text-warning mt-2"><i class="bi bi-person me-1"></i> Users</div>`;

                        data.forEach(item => {
                            if (item.type === 'cheatsheet') {
                                hasCheatsheets = true;
                                cheatsheetHtml += `<a href="` + ctx + `/cheatsheet/` + item.id + `" class="dropdown-item py-2 text-truncate rounded px-3">` + item.name + `</a>`;
                            } else if (item.type === 'category') {
                                hasCategories = true;
                                categoryHtml += `<a href="` + ctx + `/category/` + item.id + `" class="dropdown-item py-2 text-truncate rounded px-3">` + item.name + `</a>`;
                            } else if (item.type === 'user') {
                                hasUsers = true;
                                userHtml += `<a href="` + ctx + `/profile/` + item.id + `" class="dropdown-item py-2 text-truncate rounded px-3">` + item.name + `</a>`;
                            }
                        });

                        if (hasCheatsheets) html += cheatsheetHtml;
                        if (hasCategories) html += categoryHtml;
                        if (hasUsers) html += userHtml;

                        if (!hasCheatsheets && !hasCategories && !hasUsers) {
                            html = `<div class="p-3 text-center text-muted small">No immediate results match "` + query + `"</div>`;
                        }

                        suggestContent.innerHTML = html;
                        suggestBox.classList.remove("d-none");
                    })
                    .catch(err => {
                        console.error("Live Search Error Details:", err);
                    });
            });

            document.addEventListener("click", function (e) {
                if (!searchInput.contains(e.target) && !suggestBox.contains(e.target)) {
                    suggestBox.classList.add("d-none");
                }
            });
        });
    </script>
</body>
</html>