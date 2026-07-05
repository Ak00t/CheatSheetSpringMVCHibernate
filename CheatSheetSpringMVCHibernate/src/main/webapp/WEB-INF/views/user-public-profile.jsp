<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${publicUser.name} - Profile Hub</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body { background: #f8fafc; color: #1e293b; font-family: 'Segoe UI', sans-serif; }
        .profile-header-card {
            background: linear-gradient(135deg, #1e293b, #334155);
            color: white;
            border-radius: 32px;
            padding: 40px;
            box-shadow: 0 20px 40px rgba(15, 23, 42, 0.08);
        }
        .follow-stats {
            display: flex;
            gap: 20px;
            margin-top: 8px;
        }
        .stat-item {
            font-size: 14px;
            opacity: 0.85;
        }
        .stat-num {
            font-weight: 800;
            font-size: 16px;
            color: #38bdf8;
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
            min-height: 400px;
            cursor: pointer;
            position: relative;
        }
        .sheet-card:hover { transform: translateY(-6px); box-shadow: 0 20px 40px rgba(0, 0, 0, .22); }
        .sheet-cover {
            width: 100%; height: 150px;
            border: 2px dashed rgba(255, 255, 255, 0.45);
            border-radius: 18px;
            display: flex; justify-content: center; align-items: center;
            background: rgba(0, 0, 0, 0.06); flex-shrink: 0; overflow: hidden;
        }
        .sheet-cover img { width: 100%; height: 100%; object-fit: cover; }
        .category-badge {
            display: inline-block; padding: 6px 14px; border-radius: 999px;
            background: rgba(0, 0, 0, 0.12); font-size: 12px; font-weight: 800;
            margin-bottom: 12px; align-self: flex-start;
        }
        .sheet-title { font-size: 20px; font-weight: 900; margin-bottom: 8px; }
        .sheet-description { opacity: 0.9; line-height: 1.55; max-height: 85px; overflow: hidden; font-size: 14px; }
        
        /* 🌟 [ဒီဇိုင်းဆန်းသစ်မှုအပိုင်း] Premium Glass-Folder Collection Card Layout */
        .playlist-card { 
            background: linear-gradient(145deg, #ffffff, #f1f5f9);
            border-radius: 24px; 
            text-decoration: none; 
            color: #1e293b !important; 
            box-shadow: 0 10px 30px rgba(15, 23, 42, 0.04); 
            border: 1px solid rgba(226, 232, 240, 0.8); 
            padding: 28px; 
            display: flex; 
            flex-direction: column; 
            min-height: 220px; 
            cursor: pointer; 
            position: relative;
            overflow: hidden;
            transition: all 0.4s cubic-bezier(0.16, 1, 0.3, 1);
        }
        /* နောက်ခံ Folder မျဉ်းကွေးရိပ်လှလှလေး ထည့်သွင်းခြင်း */
        .playlist-card::before {
            content: '';
            position: absolute;
            top: -20px; right: -20px;
            width: 100px; height: 100px;
            background: radial-gradient(circle, rgba(37, 99, 235, 0.06), transparent 70%);
            border-radius: 50%;
            transition: transform 0.5s;
        }
        .playlist-card:hover { 
            transform: translateY(-8px) scale(1.02); 
            box-shadow: 0 20px 40px rgba(15, 23, 42, 0.09);
            border-color: rgba(37, 99, 235, 0.25);
        }
        .playlist-card:hover::before {
            transform: scale(1.5);
        }
        .playlist-icon-box {
            width: 44px; height: 44px;
            border-radius: 12px;
            background: #eff6ff;
            color: #2563eb;
            display: flex; align-items: center; justify-content: center;
            font-size: 20px; margin-bottom: 16px;
            transition: all 0.3s;
        }
        .playlist-card:hover .playlist-icon-box {
            background: #2563eb;
            color: #ffffff;
        }
        .playlist-title { font-size: 24px; font-weight: 900; margin-bottom: 8px; color: #0f172a; line-height: 1.3; }
        .playlist-footer { 
            margin-top: auto; 
            padding-top: 14px; 
            border-top: 1px dashed #e2e8f0; 
            font-size: 13px; 
            color: #64748b; 
            font-weight: 600; 
        }
        
        .empty-box { background: white; border: 2px dashed #cbd5e1; color: #64748b; padding: 40px; border-radius: 20px; text-align: center; }
    </style>
</head>
<body>

    <jsp:include page="header.jsp" />

    <div class="container my-5">
        
        <!-- Profile Header Block -->
        <div class="profile-header-card mb-5 d-flex flex-column flex-md-row align-items-center gap-4">
            <img src="${pageContext.request.contextPath}/uploads/profiles/${not empty publicUser.profileImg ? publicUser.profileImg : 'default.png'}" 
                 style="width: 110px; height: 110px; object-fit: cover; border-radius: 50%; border: 4px solid rgba(255,255,255,0.2);" alt="avatar">
            
            <div class="flex-grow-1 text-center text-md-start">
                <h1 class="fw-bold m-0">${publicUser.name}</h1>
                <p class="text-white-50 small mb-2">${publicUser.email}</p>
                
                <div class="follow-stats mb-3 justify-content-center justify-content-md-start">
                    <div class="stat-item">
                        <span class="stat-num">${not empty followersCount ? followersCount : 0}</span> Followers
                    </div>
                    <div class="stat-item">
                        <span class="stat-num">${not empty followingCount ? followingCount : 0}</span> Following
                    </div>
                </div>

                <span class="badge bg-success py-2 px-3 rounded-pill">
                    <i class="bi bi-people-fill me-1"></i> Hub Dashboard
                </span>
            </div>

            <div>
                <c:choose>
                    <c:when test="${isFollowing}">
                        <button onclick="togglePublicFollow('${publicUser.id}')" id="publicFollowBtn" class="btn btn-secondary fw-bold px-4 rounded-pill py-2.5">
                            <i class="bi bi-person-check-fill me-1"></i> Following
                        </button>
                    </c:when>
                    <c:otherwise>
                        <button onclick="togglePublicFollow('${publicUser.id}')" id="publicFollowBtn" class="btn btn-primary fw-bold px-4 rounded-pill py-2.5">
                            <i class="bi bi-person-plus-fill me-1"></i> Follow User
                        </button>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Section 1: Followers Only Cheatsheets -->
        <h2 class="fw-black mb-4" style="font-weight: 900; font-size: 28px;">👥 Followers Only Cheatsheets</h2>
        
        <c:choose>
            <c:when test="${not empty followersOnlySheets}">
                <div class="sheet-grid mb-5">
                    <c:forEach items="${followersOnlySheets}" var="sheet">
                        <div class="sheet-card auto-text-color"
                             data-color="${not empty sheet.themeColor ? sheet.themeColor : '#2563eb'}"
                             style="background-color:${not empty sheet.themeColor ? sheet.themeColor : '#2563eb'};"
                             onclick="location.href='${pageContext.request.contextPath}/cheatsheet/${sheet.id}'">

                            <div class="sheet-cover">
                                <c:choose>
                                    <c:when test="${not empty sheet.mediaList}">
                                        <img src="${sheet.mediaList[0].mediaUrl.contains('/') ? sheet.mediaList[0].mediaUrl : pageContext.request.contextPath.concat('/cheatsheet/uploads/').concat(sheet.mediaList[0].mediaUrl)}" alt="${sheet.title}">
                                    </c:when>
                                    <c:otherwise>No Cover</c:otherwise>
                                </c:choose>
                            </div>

                            <div class="sheet-body pt-3 d-flex flex-column flex-grow-1">
                                <div class="d-flex align-items-center gap-2 mb-2 flex-wrap">
                                    <div class="category-badge m-0">${sheet.category.name}</div>
                                    <span class="badge bg-warning text-dark border-0 fw-bold d-inline-flex align-items-center gap-1" 
                                          style="font-size: 11px; padding: 5px 10px; border-radius: 999px; height: 26px;">
                                        <i class="bi bi-people-fill"></i> Followers Only
                                    </span>
                                </div>

                                <h3 class="sheet-title text-wrap">${sheet.title}</h3>
                                <p class="sheet-description text-wrap">${sheet.description}</p>
                                
                                <div class="mt-auto pt-3 border-top border-dark border-opacity-10 small font-monospace opacity-75">
                                    🗓 ${fn:substring(sheet.createdAt, 0, 10)}
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-box text-center py-4 mb-5">
                    <i class="bi bi-lock-fill fs-2 d-block mb-2 text-muted"></i>
                    "No 'Followers Only' content available. Please follow this user to view these documents"!
                </div>
            </c:otherwise>
        </c:choose>

        <hr class="my-5" style="opacity: 0.1;">

        <!-- Section 2: Public Cheatsheets -->
        <h2 class="fw-black mb-4" style="font-weight: 900; font-size: 28px;">📑 Public Cheatsheets</h2>

        <c:choose>
            <c:when test="${not empty purePublicSheets}">
                <div class="sheet-grid mb-5">
                    <c:forEach items="${purePublicSheets}" var="sheet">
                        <div class="sheet-card auto-text-color"
                             data-color="${not empty sheet.themeColor ? sheet.themeColor : '#0ea5e9'}"
                             style="background-color:${not empty sheet.themeColor ? sheet.themeColor : '#0ea5e9'};"
                             onclick="location.href='${pageContext.request.contextPath}/cheatsheet/${sheet.id}'">

                            <div class="sheet-cover">
                                <c:choose>
                                    <c:when test="${not empty sheet.mediaList}">
                                        <img src="${sheet.mediaList[0].mediaUrl.contains('/') ? sheet.mediaList[0].mediaUrl : pageContext.request.contextPath.concat('/cheatsheet/uploads/').concat(sheet.mediaList[0].mediaUrl)}" alt="${sheet.title}">
                                    </c:when>
                                    <c:otherwise>No Cover</c:otherwise>
                                </c:choose>
                            </div>

                            <div class="sheet-body pt-3 d-flex flex-column flex-grow-1">
                                <div class="category-badge">${sheet.category.name}</div>
                                <h3 class="sheet-title text-wrap">${sheet.title}</h3>
                                <p class="sheet-description text-wrap">${sheet.description}</p>
                                
                                <div class="mt-auto pt-3 border-top border-dark border-opacity-10 small font-monospace opacity-75">
                                    🗓 ${fn:substring(sheet.createdAt, 0, 10)}
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-box text-center py-4 mb-5">
                    <i class="bi bi-folder-x fs-2 d-block mb-2 text-muted"></i>
                    This user hasn't published any public cheatsheets yet.
                </div>
            </c:otherwise>
        </c:choose>

        <hr class="my-5" style="opacity: 0.1;">

        <!-- 🌟 Section 3: Public Collections (Folders အသွင်ဆန်းသစ်ထားသော Slider ပုံစံ) -->
        <h2 class="fw-black mb-4" style="font-weight: 900; font-size: 28px;">📂 Public Collections (Folders)</h2>

        <c:choose>
            <c:when test="${not empty publicPlaylists}">
                <div id="followersSheetsCarousel" class="carousel slide" data-bs-ride="false">
                    <div class="carousel-inner">
                        
                        <c:forEach items="${publicPlaylists}" var="playlist" varStatus="status">
                            <c:if test="${status.index % 3 == 0}">
                                <div class="carousel-item ${status.first ? 'active' : ''}">
                                    <div class="row g-4 px-5">
                            </c:if>

                            <div class="col-md-4">
                                <div class="playlist-card" onclick="location.href='${pageContext.request.contextPath}/collection/view/${playlist.id}'">
                                    
                                    <!-- Dynamic Icon Box -->
                                    <div class="playlist-icon-box shadow-sm">
                                        <i class="bi bi-folder2-open"></i>
                                    </div>
                                    
                                    <h3 class="playlist-title text-truncate">${playlist.name}</h3>
                                    
                                    <div class="playlist-footer d-flex justify-content-between align-items-center">
                                        <span class="small fw-bold text-primary"><i class="bi bi-globe me-1"></i> ${playlist.visibility}</span>
                                        <span class="badge bg-light text-dark border fw-bold px-2.5 py-1.5 rounded-pill"><i class="bi bi-file-earmark-code-fill text-secondary me-1"></i> ${playlist.items.size()} Sheets</span>
                                    </div>
                                </div>
                            </div>

                            <c:if test="${status.index % 3 == 2 || status.last}">
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>

                    </div>

                    <button class="carousel-control-prev" type="button" data-bs-target="#followersSheetsCarousel" data-bs-slide="prev" style="width: 5%;">
                        <span class="carousel-control-prev-icon bg-dark rounded-circle p-2" aria-hidden="true"></span>
                        <span class="visually-hidden">Previous</span>
                    </button>
                    <button class="carousel-control-next" type="button" data-bs-target="#followersSheetsCarousel" data-bs-slide="next" style="width: 5%;">
                        <span class="carousel-control-next-icon bg-dark rounded-circle p-2" aria-hidden="true"></span>
                        <span class="visually-hidden">Next</span>
                    </button>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-box text-center py-4">
                    <i class="bi bi-folder-minus fs-2 d-block mb-2 text-muted"></i>
                    This user hasn't created any public custom folders yet.
                </div>
            </c:otherwise>
        </c:choose>

    </div>

    <jsp:include page="footer.jsp" />

    <script>
        // --- Dynamic High-Contrast Card Text Renderer ---
        function getContrastColor(hexColor) {
            if (!hexColor || hexColor === "null") hexColor = "#2563eb";
            hexColor = hexColor.replace("#", "");
            if (hexColor.length === 3) hexColor = hexColor[0]+hexColor[0]+hexColor[1]+hexColor[1]+hexColor[2]+hexColor[2];
            const r = parseInt(hexColor.substr(0, 2), 16);
            const g = parseInt(hexColor.substr(2, 2), 16);
            const b = parseInt(hexColor.substr(4, 2), 16);
            return (((r * 299) + (g * 587) + (b * 114)) / 1000) >= 128 ? "#1e293b" : "#ffffff";
        }

        document.addEventListener("DOMContentLoaded", function () {
            document.querySelectorAll(".auto-text-color").forEach(function (card) {
                card.style.setProperty("--text-color", getContrastColor(card.getAttribute("data-color")));
            });
        });

        function togglePublicFollow(followingId) {
            const ctx = "${pageContext.request.contextPath}";
            const params = new URLSearchParams();
            params.append('followingId', followingId);

            fetch(ctx + '/follow/toggle', { 
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: params
            })
            .then(res => {
                if (res.ok) {
                    location.reload(); 
                } else if (res.status === 401) {
                    alert("Action unauthorized. Please log in first.");
                    window.location.href = ctx + "/login"; 
                } else { 
                    alert("Something went wrong. Please try again."); 
                }
            })
            .catch(err => {
                console.error("Error:", err);
                alert("Network error occurred.");
            });
        }
    </script>
</body>
</html>