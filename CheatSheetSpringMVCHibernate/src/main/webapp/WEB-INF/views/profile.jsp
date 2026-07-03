<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>${user.name} - Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
    <style>
        body { background-color: #f8fafc; color: #334155; font-family: 'Segoe UI', system-ui, sans-serif; }
        
        /* 🌟 Top Premium Banner Layout */
        .profile-banner {
            background: linear-gradient(135deg, #1e3a8a 0%, #2563eb 100%);
            height: 140px;
            border-radius: 24px 24px 0 0;
        }

        /* Container & Grid Alignment */
        .profile-wrapper { max-width: 1100px; margin: -60px auto 50px auto; padding: 0 15px; }
        .info-sidebar { background: #ffffff; border-radius: 24px; box-shadow: 0 10px 25px rgba(15, 23, 42, 0.03); border: 1px solid #e2e8f0; padding: 30px; }
        .content-main { background: #ffffff; border-radius: 24px; box-shadow: 0 10px 25px rgba(15, 23, 42, 0.03); border: 1px solid #e2e8f0; padding: 35px; }
        
        /* Profile Image Ring */
        .profile-img-container { position: relative; margin-top: -30px; display: inline-block; }
        .profile-img { 
            width: 130px !important; height: 130px !important; 
            object-fit: cover; border-radius: 50%; 
            border: 5px solid #ffffff; box-shadow: 0 8px 20px rgba(0,0,0,0.1);
        }
        
        /* Modernized Form Elements */
        label { font-weight: 700; color: #475569; font-size: 0.85rem; text-transform: uppercase; letter-spacing: 0.5px; margin-bottom: 0.4rem; }
        .form-control { border-radius: 12px; border: 1px solid #cbd5e1; padding: 0.75rem 1rem; background-color: #f8fafc; font-weight: 500; color: #1e293b; transition: all 0.2s; }
        .form-control:focus { background-color: #ffffff; border-color: #2563eb; box-shadow: 0 0 0 4px rgba(37, 99, 235, 0.1); }
        .form-control[readonly] { background-color: #f1f5f9; border-color: #e2e8f0; cursor: not-allowed; }

        /* Modern Buttons Styling */
        .btn-save { background-color: #2563eb; color: white; border-radius: 12px; padding: 0.75rem 1.5rem; font-weight: 600; border: none; transition: 0.2s; }
        .btn-save:hover { background-color: #1d4ed8; transform: translateY(-1px); }
        .btn-follow { border-radius: 12px; padding: 0.6rem 1.5rem; font-weight: 600; transition: all 0.2s; }
        
        /* 🌟 Clean Horizontal Sliders Layout */
        .section-title { font-size: 1.15rem; font-weight: 800; color: #0f172a; margin-top: 2.5rem; margin-bottom: 1rem; display: flex; align-items: center; }
        .slider-wrapper { position: relative; display: flex; align-items: center; margin-bottom: 1.5rem; }
        
        .horizontal-slider {
            display: flex; gap: 16px; overflow-x: auto; scroll-behavior: smooth;
            padding: 8px 4px; width: 100%; -webkit-overflow-scrolling: touch;
        }
        .horizontal-slider::-webkit-scrollbar { display: none; }
        
        /* Clean White Cards inside Sliders */
        .slider-item-card {
            flex: 0 0 250px; background: #ffffff; border: 1px solid #e2e8f0;
            border-radius: 18px; padding: 20px; text-decoration: none !important; color: #1e293b;
            box-shadow: 0 4px 12px rgba(15, 23, 42, 0.02); transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1);
            display: flex; flex-direction: column; min-height: 160px;
        }
        .slider-item-card:hover { transform: translateY(-5px); box-shadow: 0 12px 24px rgba(15, 23, 42, 0.08); border-color: #cbd5e1; }
        .slider-item-card:active { filter: brightness(0.95); transform: scale(0.97); }
        
        /* Slider Floating Controls */
        .slider-arrow {
            position: absolute; width: 36px; height: 36px; background: #ffffff;
            border: 1px solid #e2e8f0; border-radius: 50%; display: flex; align-items: center;
            justify-content: center; z-index: 10; cursor: pointer; box-shadow: 0 4px 12px rgba(0,0,0,0.08);
            transition: 0.2s; color: #475569;
        }
        .slider-arrow:hover { background: #f8fafc; color: #2563eb; transform: scale(1.1); border-color: #cbd5e1; }
        .arrow-left { left: -18px; }
        .arrow-right { right: -18px; }
        
        .item-badge { display: inline-block; padding: 4px 12px; border-radius: 999px; font-size: 10px; font-weight: 800; background: #f1f5f9; color: #2563eb; text-transform: uppercase; margin-bottom: 12px; align-self: flex-start; }
    </style>
</head>
<body>

<jsp:include page="header.jsp"/>

<div class="container mt-4">
    <div class="profile-banner"></div>
</div>

<div class="container profile-wrapper">
    <c:set var="isOwner" value="${currentUser.id == user.id}" />
    
    <form action="${pageContext.request.contextPath}/profile/update" method="POST" enctype="multipart/form-data">
        <input type="hidden" name="id" value="${user.id}">

        <div class="row g-4">
            
            <div class="col-lg-4 text-center">
                <div class="info-sidebar h-100">
                    <div class="profile-img-container mb-3">
                        <img src="${pageContext.request.contextPath}/uploads/profiles/${user.profileImg}" class="profile-img" alt="Profile Photo">            
                    </div>
                    
                    <h4 class="fw-bold text-dark mb-1">${user.name}</h4>
                    <p class="text-muted small mb-4">@${user.email.split('@')[0]}</p>
                    
                    <c:if test="${isOwner}">
                        <div class="mb-4 text-start">
                            <label><i class="bi bi-camera-fill me-1"></i> Update Avatar</label>
                            <input type="file" name="profileImg" class="form-control form-control-sm">
                        </div>
                    </c:if>

                    <c:if test="${!isOwner && not empty currentUser}">
                        <button id="followBtn" type="button" onclick="toggleFollow(${user.id})"
                                class="btn btn-follow w-100 ${isFollowing ? 'btn-outline-danger' : 'btn-primary'} shadow-sm">
                            <i class="bi ${isFollowing ? 'bi-person-dash-fill' : 'bi-person-plus-fill'} me-1"></i>
                            ${isFollowing ? 'Unfollow' : 'Follow User'}
                        </button>
                    </c:if>
                </div>
            </div>

            <div class="col-lg-8">
                <div class="content-main">
                    
                    <h5 class="fw-bold text-dark mb-4 pb-2 border-bottom"><i class="bi bi-person-lines-fill me-2 text-muted"></i> Account Profiles</h5>
                    
                    <div class="mb-3">
                        <label>Display Name</label>
                        <input type="text" name="name" class="form-control" value="${user.name}" ${!isOwner ? 'readonly' : ''}>
                    </div>

                    <div class="mb-4">
                        <label>Biography</label>
                        <textarea name="bio" class="form-control" rows="3" ${!isOwner ? 'readonly' : ''} placeholder="Tell us about yourself...">${user.bio}</textarea>
                    </div>

                    <h4 class="section-title"><i class="bi bi-bookmark-heart-fill text-warning me-2"></i> Bookmarks Collection</h4>
                    <div class="slider-wrapper">
                        <button type="button" class="slider-arrow arrow-left" onclick="moveSlider('bookmarkSlider', -1)"><i class="bi bi-chevron-left"></i></button>
                        
                        <div class="horizontal-slider" id="bookmarkSlider">
                            <c:choose>
                                <c:when test="${not empty bookmarkedSheets}">
                                    <c:forEach items="${bookmarkedSheets}" var="sheet">
                                        <a href="${pageContext.request.contextPath}/cheatsheet/${sheet.id}" class="slider-item-card">
                                            <div class="item-badge">${sheet.category.name}</div>
                                            <h6 class="fw-bold text-truncate mb-1">${sheet.title}</h6>
                                            <p class="text-muted small text-truncate mb-3" style="font-size: 12px;">${sheet.description}</p>
                                            <div class="d-flex justify-content-between align-items-center small text-secondary border-top pt-2 mt-auto" style="font-size: 11px;">
                                                <span>👤 ${sheet.user.name}</span>
                                                <span>👁 ${sheet.viewCount}</span>
                                            </div>
                                        </a>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="text-muted small py-4 ps-2"><i class="bi bi-inbox me-1"></i> No bookmarks saved yet.</div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        
                        <button type="button" class="slider-arrow arrow-right" onclick="moveSlider('bookmarkSlider', 1)"><i class="bi bi-chevron-right"></i></button>
                    </div>

                    <h4 class="section-title"><i class="bi bi-folder-fill text-primary me-2"></i> Custom Collections</h4>
                    <div class="slider-wrapper">
                        <button type="button" class="slider-arrow arrow-left" onclick="moveSlider('collectionSlider', -1)"><i class="bi bi-chevron-left"></i></button>
                        
                        <div class="horizontal-slider" id="collectionSlider">
                            <c:choose>
                                <c:when test="${not empty collections}">
                                    <c:forEach items="${collections}" var="col">
                                        <a href="${pageContext.request.contextPath}/collection/view/${col.id}" class="slider-item-card">
                                            <div class="item-badge bg-info-subtle text-info"><i class="bi bi-shield-lock-fill me-1"></i> ${col.visibility}</div>
                                            <h6 class="fw-bold text-truncate mb-2">${col.name}</h6>
                                            <div class="d-flex justify-content-between align-items-center small text-secondary border-top pt-2 mt-auto" style="font-size: 11px;">
                                                <span>📁 Folder</span>
                                                <span class="fw-bold text-primary">${col.getItems().size()} Sheets</span>
                                            </div>
                                        </a>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="text-muted small py-4 ps-2"><i class="bi bi-folder-dash me-1"></i> No public collections available.</div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        
                        <button type="button" class="slider-arrow arrow-right" onclick="moveSlider('collectionSlider', 1)"><i class="bi bi-chevron-right"></i></button>
                    </div>

                    <h4 class="section-title"><i class="bi bi-share-fill text-success me-2"></i> Shared History</h4>
                    <div class="slider-wrapper">
                        <button type="button" class="slider-arrow arrow-left" onclick="moveSlider('shareSlider', -1)"><i class="bi bi-chevron-left"></i></button>
                        
                        <div class="horizontal-slider" id="shareSlider">
                            <c:choose>
                                <c:when test="${not empty sharedLogs}">
                                    <c:forEach items="${sharedLogs}" var="log">
                                        <a href="${pageContext.request.contextPath}/cheatsheet/${log.cheatsheet.id}" class="slider-item-card">
                                            <div class="item-badge bg-success-subtle text-success"><i class="bi bi-link-45deg me-1"></i> Shared Via ${log.platform}</div>
                                            <h6 class="fw-bold text-truncate mb-1">${log.cheatsheet.title}</h6>
                                            <p class="text-muted small text-truncate mb-3" style="font-size: 12px;">${log.cheatsheet.description}</p>
                                            <div class="d-flex justify-content-between align-items-center small text-secondary border-top pt-2 mt-auto" style="font-size: 11px;">
                                                <span>👤 ${log.cheatsheet.user.name}</span>
                                                <span>📅 ${log.createdAt.toString().split('T')[0]}</span>
                                            </div>
                                        </a>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="text-muted small py-4 ps-2"><i class="bi bi-share me-1"></i> No share history recorded yet.</div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        
                        <button type="button" class="slider-arrow arrow-right" onclick="moveSlider('shareSlider', 1)"><i class="bi bi-chevron-right"></i></button>
                    </div>
                    
                    <div class="d-flex gap-3 mt-5 pt-3 border-top justify-content-end">
                        <a href="${pageContext.request.contextPath}/" class="btn btn-outline-secondary px-4 rounded-3 fw-semibold">Back</a>
                        <c:if test="${isOwner}">
                            <button type="submit" class="btn btn-save px-4 rounded-3 shadow-sm">Save Changes</button>
                        </c:if>
                    </div>

                </div>
            </div>
            
        </div>
    </form>
</div>

<script>
function toggleFollow(followingId) {
    const btn = document.getElementById("followBtn");
    fetch('${pageContext.request.contextPath}/follow/toggle', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: 'followingId=' + followingId
    })
    .then(response => {
        if (!response.ok) return alert("System Sync Error");
        
        if (btn.innerText.trim().includes("Follow User") || btn.innerText.trim() === "Follow") {
            btn.innerHTML = '<i class="bi bi-person-dash-fill me-1"></i> Unfollow';
            btn.classList.remove("btn-primary");
            btn.classList.add("btn-outline-danger");
        } else {
            btn.innerHTML = '<i class="bi bi-person-plus-fill me-1"></i> Follow User';
            btn.classList.remove("btn-outline-danger");
            btn.classList.add("btn-primary");
        }
    })
    .catch(error => console.log(error));
}

function moveSlider(sliderId, direction) {
    const slider = document.getElementById(sliderId);
    if (slider) {
        const scrollAmount = 266; // ကတ်အကျယ် (250px) + Gap (16px) တွက်ချက်မှု
        slider.scrollLeft += (direction * scrollAmount);
    }
}
//💡 cheatsheet-detail.jsp ၏ အောက်ခြေ <script> ထဲက copyDeploymentLink ကို ဤသို့ ပြောင်းလဲပါ-
function copyDeploymentLink() {
    let inputEl = document.getElementById("deploymentLinkInput");
    inputEl.select();
    navigator.clipboard.writeText(inputEl.value);
    alert("Link copied to clipboard!");

    // 🚀 Database ထဲသို့ Share Log လှမ်းသိမ်းမည့် အပိုင်း
    const cheatsheetId = '${cheatsheet.id}';
    fetch('${pageContext.request.contextPath}/cheatsheet/share-log', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: 'cheatsheetId=' + cheatsheetId + '&platform=LINK'
    }).catch(err => console.error("Error logging share:", err));
}
</script>
</body>
</html>