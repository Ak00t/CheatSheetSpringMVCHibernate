<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>${user.name} - Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
    <style>
        /* 🌟 Premium Futuristic Background */
        body { 
            background: radial-gradient(circle at top right, #f1f5f9 0%, #e2e8f0 100%);
            color: #334155; 
            font-family: 'Segoe UI', system-ui, sans-serif; 
            min-height: 100vh;
        }
        
        /* 🌟 Dynamic Cyber Banner */
        .profile-banner {
            background: linear-gradient(135deg, #0f172a 0%, #1e3a8a 50%, #2563eb 100%);
            height: 180px;
            border-radius: 30px;
            box-shadow: inset 0 0 40px rgba(0,0,0,0.2), 0 10px 30px rgba(37, 99, 235, 0.1);
            position: relative;
            overflow: hidden;
        }
        .profile-banner::before {
            content: ''; position: absolute; top: -50%; left: -50%; width: 200%; height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.05) 0%, transparent 70%);
            animation: rotateBg 20s linear infinite;
        }
        @keyframes rotateBg { 0% { transform: rotate(0deg); } 100% { transform: rotate(360deg); } }

        /* Container & Glassmorphism Alignments */
        .profile-wrapper { max-width: 1140px; margin: -70px auto 60px auto; padding: 0 20px; }
        
        /* Glass Effect Cards */
        .info-sidebar, .content-main { 
            background: rgba(255, 255, 255, 0.85); 
            backdrop-filter: blur(16px); 
            -webkit-backdrop-filter: blur(16px);
            border-radius: 28px; 
            box-shadow: 0 15px 35px rgba(15, 23, 42, 0.05), 0 5px 15px rgba(0, 0, 0, 0.02);
            border: 1px solid rgba(255, 255, 255, 0.6); 
            padding: 35px;
            transition: all 0.4s ease;
        }
        .info-sidebar:hover, .content-main:hover {
            box-shadow: 0 20px 40px rgba(37, 99, 235, 0.08);
            border-color: rgba(37, 99, 235, 0.2);
        }
        
        /* Premium Profile Avatar Frame */
        .profile-img-container { position: relative; margin-top: -15px; display: inline-block; }
        .profile-img { 
            width: 140px !important; height: 140px !important; 
            object-fit: cover; border-radius: 50%; 
            border: 6px solid #ffffff; 
            box-shadow: 0 10px 25px rgba(15, 23, 42, 0.15);
            transition: transform 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }
        .profile-img-container:hover .profile-img {
            transform: scale(1.05) rotate(3deg);
        }
        
        /* Modern Form Inputs & Glowing Fields */
        label { font-weight: 800; color: #475569; font-size: 0.8rem; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 0.5rem; display: flex; align-items: center; gap: 6px; }
        .form-control { 
            border-radius: 16px; border: 1px solid #cbd5e1; padding: 0.85rem 1.2rem; 
            background-color: rgba(248, 250, 252, 0.8); font-weight: 500; color: #1e293b; 
            transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1); 
        }
        .form-control:focus { 
            background-color: #ffffff; 
            border-color: #2563eb; 
            box-shadow: 0 0 0 5px rgba(37, 99, 235, 0.15);
            transform: translateY(-1px);
        }
        .form-control[readonly] { background-color: #f1f5f9; border-color: #e2e8f0; cursor: not-allowed; box-shadow: none; transform: none; }

        /* Custom File Input Stylings */
        .file-upload-wrapper {
            position: relative; overflow: hidden; display: inline-block; width: 100%;
        }
        .file-upload-btn {
            border: 2px dashed #cbd5e1; background: rgba(241, 245, 249, 0.5); padding: 12px;
            border-radius: 16px; text-align: center; cursor: pointer; display: block; font-weight: 600; color: #64748b; transition: 0.2s;
        }
        .file-upload-wrapper input[type=file] { position: absolute; left: 0; top: 0; opacity: 0; width: 100%; height: 100%; cursor: pointer; }
        .file-upload-wrapper:hover .file-upload-btn { border-color: #2563eb; color: #2563eb; background: rgba(37, 99, 235, 0.02); }

        /* Glow Action Buttons */
        .btn-save { 
            background: linear-gradient(135deg, #2563eb 0%, #1d4ed8 100%); 
            color: white; border-radius: 16px; padding: 0.85rem 2rem; font-weight: 700; border: none; 
            box-shadow: 0 8px 20px rgba(37, 99, 235, 0.3); transition: all 0.3s; 
        }
        .btn-save:hover { 
            background: linear-gradient(135deg, #1d4ed8 0%, #1e40af 100%); 
            box-shadow: 0 12px 25px rgba(37, 99, 235, 0.4); transform: translateY(-2px); 
        }
        .btn-save:active { transform: translateY(0); }
        
        .btn-follow { border-radius: 16px; padding: 0.75rem 1.5rem; font-weight: 700; transition: all 0.3s; box-shadow: 0 4px 12px rgba(0,0,0,0.05); }
        .btn-follow:hover { transform: translateY(-2px); box-shadow: 0 8px 20px rgba(0,0,0,0.1); }
        
        /* Clean Horizontal Sliders Layout */
        .section-title { font-size: 1.25rem; font-weight: 900; color: #0f172a; margin-top: 3rem; margin-bottom: 1.2rem; display: flex; align-items: center; }
        .slider-wrapper { position: relative; display: flex; align-items: center; margin-bottom: 1.5rem; }
        
        .horizontal-slider {
            display: flex; gap: 20px; overflow-x: auto; scroll-behavior: smooth;
            padding: 10px 5px; width: 100%; -webkit-overflow-scrolling: touch;
        }
        .horizontal-slider::-webkit-scrollbar { display: none; }
        
        /* Glow Accented White Cards inside Sliders */
        .slider-item-card {
            flex: 0 0 270px; background: #ffffff; border: 1px solid rgba(226, 232, 240, 0.8);
            border-radius: 22px; padding: 22px; text-decoration: none !important; color: #1e293b;
            box-shadow: 0 8px 20px rgba(15, 23, 42, 0.02); transition: all 0.4s cubic-bezier(0.16, 1, 0.3, 1);
            display: flex; flex-direction: column; min-height: 175px; position: relative;
        }
        .slider-item-card:hover { 
            transform: translateY(-6px) scale(1.02); 
            box-shadow: 0 15px 30px rgba(15, 23, 42, 0.08); 
            border-color: rgba(37, 99, 235, 0.15); 
        }
        
        /* Slider Floating Controls */
        .slider-arrow {
            position: absolute; width: 42px; height: 42px; background: #ffffff;
            border: 1px solid #e2e8f0; border-radius: 50%; display: flex; align-items: center;
            justify-content: center; z-index: 10; cursor: pointer; box-shadow: 0 6px 16px rgba(0,0,0,0.06);
            transition: all 0.2s ease; color: #475569;
        }
        .slider-arrow:hover { background: #0f172a; color: #ffffff; transform: scale(1.1); border-color: #0f172a; }
        .arrow-left { left: -21px; }
        .arrow-right { right: -21px; }
        
        .item-badge { 
            display: inline-flex; align-items: center; padding: 5px 14px; border-radius: 999px; 
            font-size: 10px; font-weight: 800; background: rgba(37, 99, 235, 0.08); color: #2563eb; 
            text-transform: uppercase; margin-bottom: 14px; align-self: flex-start; letter-spacing: 0.5px;
        }
        .badge-share { background: rgba(34, 197, 94, 0.1) !important; color: #16a34a !important; }
        
        
        
        /* Delete Button Styling for Slider Items */
.delete-log-btn {
    position: absolute;
    top: 12px;
    right: 12px;
    width: 28px;
    height: 28px;
    border-radius: 50%;
    background: rgba(239, 68, 68, 0.1);
    color: #ef4444;
    border: none;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 14px;
    transition: all 0.2s ease;
    z-index: 5;
}
.delete-log-btn:hover {
    background: #ef4444;
    color: #ffffff;
    transform: scale(1.1);
}
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
            
            <div class="col-lg-4">
                <div class="info-sidebar text-center h-100">
                    <div class="profile-img-container mb-3">
                        <img src="${pageContext.request.contextPath}/uploads/profiles/${user.profileImg}" class="profile-img" alt="Profile Photo">            
                    </div>
                    
                    <h4 class="fw-extrabold text-dark mb-1" style="font-weight: 900;">${user.name}</h4>
                    <p class="text-muted small mb-4" style="font-weight: 600;">@${user.email.split('@')[0]}</p>
                    
                    <c:if test="${isOwner}">
                        <div class="mb-4 text-start">
                            <label><i class="bi bi-cloud-arrow-up-fill text-primary"></i> Change Profile Picture</label>
                            <div class="file-upload-wrapper">
                                <span class="file-upload-btn"><i class="bi bi-folder2-open me-1"></i> Choose Avatar File</span>
                                <input type="file" name="profileImg">
                            </div>
                        </div>
                    </c:if>

                    <c:if test="${!isOwner && not empty currentUser}">
                        <button id="followBtn" type="button" onclick="toggleFollow(${user.id})"
                                class="btn btn-follow w-100 ${isFollowing ? 'btn-outline-danger' : 'btn-primary'} shadow-sm py-2.5">
                            <i class="bi ${isFollowing ? 'bi-person-dash-fill' : 'bi-person-plus-fill'} me-1"></i>
                            ${isFollowing ? 'Unfollow Account' : 'Follow Creator'}
                        </button>
                    </c:if>
                </div>
            </div>

            <div class="col-lg-8">
                <div class="content-main">
                    
                    <h5 class="fw-bold text-dark mb-4 pb-2 border-bottom d-flex align-items-center gap-2" style="font-weight: 800;">
                        <i class="bi bi-shield-lock-fill text-primary"></i> Personal Information
                    </h5>
                    
                    <div class="mb-3">
                        <label><i class="bi bi-person-fill text-secondary"></i> Display Name</label>
                        <input type="text" name="name" class="form-control" value="${user.name}" ${!isOwner ? 'readonly' : ''}>
                    </div>

                    <div class="mb-4">
                        <label><i class="bi bi-chat-right-quote-fill text-secondary"></i> Biography / Status</label>
                        <textarea name="bio" class="form-control" rows="3" ${!isOwner ? 'readonly' : ''} placeholder="Write a short summary about yourself...">${user.bio}</textarea>
                    </div>

                    <h4 class="section-title"><i class="bi bi-lightning-charge-fill text-warning me-2"></i> Shared Activities</h4>
                    <div class="slider-wrapper">
                        <button type="button" class="slider-arrow arrow-left" onclick="moveSlider('shareSlider', -1)"><i class="bi bi-chevron-left"></i></button>
                        
                        <div class="horizontal-slider" id="shareSlider">
    <c:choose>
        <c:when test="${not empty sharedLogs}">
            <c:forEach items="${sharedLogs}" var="log">
                <div class="position-relative" id="log-card-${log.id}">
                    
                    <c:if test="${isOwner}">
                        <button type="button" class="delete-log-btn" title="Delete from Profile" 
                                onclick="event.stopPropagation(); event.preventDefault(); deleteShareLog(${log.id});">
                            <i class="bi bi-trash3-fill"></i>
                        </button>
                    </c:if>

                    <a href="${pageContext.request.contextPath}/cheatsheet/${log.cheatsheet.id}" class="slider-item-card">
                        <div class="item-badge badge-share"><i class="bi bi-share-fill me-1"></i> Via ${log.platform}</div>
                        <h6 class="fw-bold text-truncate mb-1" style="color: #0f172a; font-weight: 800; max-width: 80%;">${log.cheatsheet.title}</h6>
                        <p class="text-muted small text-wrap mb-3" style="font-size: 12px; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; line-height: 1.4;">${log.cheatsheet.description}</p>
                        <div class="d-flex justify-content-between align-items-center small text-secondary border-top pt-2 mt-auto" style="font-size: 11px; font-weight: 600;">
                            <span>👤 ${log.cheatsheet.user.name}</span>
                            <span>🗓 ${log.createdAt.toString().split('T')[0]}</span>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <div class="text-muted small py-4 ps-2 w-100 text-center bg-light rounded-4 border border-dashed"><i class="bi bi-share me-1"></i> No shared logs recorded for this account.</div>
        </c:otherwise>
    </c:choose>
</div>
                        
                        <button type="button" class="slider-arrow arrow-right" onclick="moveSlider('shareSlider', 1)"><i class="bi bi-chevron-right"></i></button>
                    </div>
                    
                    <div class="d-flex gap-3 mt-5 pt-3 border-top justify-content-end">
                        <a href="${pageContext.request.contextPath}/" class="btn btn-outline-secondary px-4 rounded-4 fw-bold py-2.5">Back Home</a>
                        <c:if test="${isOwner}">
                            <button type="submit" class="btn btn-save px-4 rounded-4 py-2.5">Save Profiles</button>
                        </c:if>
                    </div>

                </div>
            </div>
            
        </div>
    </form>
</div>

<jsp:include page="footer.jsp" />

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
        
        if (btn.innerText.trim().includes("Follow Creator") || btn.innerText.trim() === "Follow") {
            btn.innerHTML = '<i class="bi bi-person-dash-fill me-1"></i> Unfollow Account';
            btn.classList.remove("btn-primary");
            btn.classList.add("btn-outline-danger");
        } else {
            btn.innerHTML = '<i class="bi bi-person-plus-fill me-1"></i> Follow Creator';
            btn.classList.remove("btn-outline-danger");
            btn.classList.add("btn-primary");
        }
    })
    .catch(error => console.log(error));
}

function moveSlider(sliderId, direction) {
    const slider = document.getElementById(sliderId);
    if (slider) {
        const scrollAmount = 290; // ကတ်အကျယ် (270px) + Gap (20px) တွက်ချက်မှုစနစ်
        slider.scrollLeft += (direction * scrollAmount);
    }
}
function deleteShareLog(logId) {
    if (!confirm("Are you sure you want to remove this shared history?")) return;

    let headers = {};
    const csrfTokenEl = document.querySelector("meta[name='_csrf']");
    const csrfHeaderEl = document.querySelector("meta[name='_csrf_header']");
    
    if (csrfTokenEl && csrfHeaderEl) {
        const csrfToken = csrfTokenEl.getAttribute("content");
        const csrfHeader = csrfHeaderEl.getAttribute("content");
        if (csrfToken && csrfHeader) {
            headers[csrfHeader] = csrfToken;
        }
    }

    let formData = new FormData();
    formData.append("logId", logId);

    fetch('${pageContext.request.contextPath}/profile/share-log/delete', {
        method: 'POST',
        headers: headers,
        body: formData,
        credentials: 'include'
    })
    .then(res => res.text())
    .then(data => {
        // 💡 စာသား အကြီးအသေး မရွေး လိုက်ဖက်အောင် အစ်ကို့စတိုင်အတိုင်း ပြောင်းလဲစစ်ဆေးခြင်း
        if (data.toLowerCase().includes("success")) {
            
            const cardElement = document.getElementById("log-card-" + logId);
            if (cardElement) {
                
                // ၁။ ချောမွေ့စွာ ပျောက်ကွယ်သွားမည့် Animation စတင်ခြင်း
                cardElement.style.transition = "all 0.4s cubic-bezier(0.16, 1, 0.3, 1)";
                cardElement.style.opacity = "0";
                cardElement.style.transform = "scale(0.7) translateY(20px)"; // အောက်ကို အိကျသွားမည့်ပုံစံ
                
                // ၂။ Slider flow မပျက်စေရန် Layout element များကိုပါ တပြိုင်နက် ကျုံ့ပစ်ခြင်း
                cardElement.style.width = "0px";
                cardElement.style.marginRight = "-20px";
                cardElement.style.overflow = "hidden";

                // ၃။ Animation Frame ပြီးဆုံးချိန်တွင် DOM ပေါ်မှ လုံးဝ ဖယ်ထုတ်ခြင်း
                setTimeout(() => {
                    cardElement.remove();
                    
                    // ၄။ Card တစ်ခုမှ မကျန်တော့လျှင် Empty state စာသား တန်းပြောင်းပေးခြင်း
                    const remainingCards = document.querySelectorAll("#shareSlider .position-relative");
                    if (remainingCards.length === 0) {
                        const sliderEl = document.getElementById("shareSlider");
                        if (sliderEl) {
                            sliderEl.innerHTML = '<div class="text-muted small py-4 ps-2 w-100 text-center bg-light rounded-4 border border-dashed"><i class="bi bi-share me-1"></i> No shared logs recorded for this account.</div>';
                        }
                    }
                }, 400);
            }
            
        } else {
           
            alert("Failed to delete: " + data); 
        }
    })
    .catch(err => {
        console.error(err);
        alert("Network error occurred.");
    });
}
</script>
</body>
</html>