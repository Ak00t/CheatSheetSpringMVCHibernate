<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>${collection.name} - Sheets</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background-color: #f8fafc; font-family: 'Segoe UI', sans-serif; color: #1e293b; }
        .container { width: 95%; max-width: 1400px; margin: 40px auto; }
        .grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: 24px; padding-bottom: 18px; }
        
        .sheet-card { border-radius: 22px; overflow: hidden; text-decoration: none; color: white !important; box-shadow: 0 12px 30px rgba(0,0,0,.13); transition: .3s; padding: 20px; display: flex; flex-direction: column; min-height: 440px; cursor: pointer; }
        .sheet-card:hover { transform: translateY(-6px); box-shadow: 0 20px 40px rgba(0,0,0,.22); }
        .sheet-cover { width: 100%; height: 170px; border: 2px dashed rgba(255,255,255,0.45); border-radius: 18px; display: flex; justify-content: center; align-items: center; font-size: 18px; font-weight: 800; overflow: hidden; background: rgba(0,0,0,0.06); flex-shrink: 0; }
        .sheet-cover img { width: 100%; height: 100%; object-fit: cover; }
        .sheet-body { padding-top: 12px; display: flex; flex-direction: column; flex-grow: 1; overflow: hidden; }
        .category-badge { display: inline-block; padding: 6px 14px; border-radius: 999px; background: rgba(0,0,0,0.12); color: white; font-size: 12px; font-weight: 800; margin-bottom: 12px; align-self: flex-start; }
        .sheet-title { font-size: 21px; font-weight: 900; margin-bottom: 8px; line-height: 1.35; }
        .sheet-description { opacity: 0.9; line-height: 1.55; max-height: 95px; overflow: hidden; font-size: 15px; }
        .sheet-footer { margin-top: auto; padding-top: 12px; border-top: 1px solid rgba(0,0,0,0.1); opacity: 0.8; font-size: 13px; }
    </style>
</head>
<body>

<jsp:include page="header.jsp"/>

<div class="container">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="fw-bold text-dark m-0">📁 ${collection.name}</h2>
            <p class="text-muted m-0 mt-1">Saved cheat sheets inside this collection</p>
        </div>
        <a href="${pageContext.request.contextPath}/collection/manage" class="btn btn-outline-secondary btn-sm rounded-3 px-3 fw-semibold">
            <i class="bi bi-arrow-left"></i> Back to Collections
        </a>
    </div>

    <c:choose>
        <c:when test="${not empty sheetsInCollection}">
            <div class="grid">
                <c:forEach items="${sheetsInCollection}" var="sheet">
                    
                    <div class="sheet-card" 
                         style="background-color: ${not empty sheet.themeColor ? sheet.themeColor : '#2563eb'};"
                         onclick="location.href='${pageContext.request.contextPath}/profile-cheatsheets/detail/${sheet.id}'">
                        
                        <div class="sheet-cover">
                            <c:choose>
                                <c:when test="${not empty sheet.mediaList}">
                                    <c:choose>
                                        <c:when test="${fn:startsWith(sheet.mediaList[0].mediaUrl, 'http') || fn:startsWith(sheet.mediaList[0].mediaUrl, '/')}">
                                            <img src="${sheet.mediaList[0].mediaUrl}" alt="${sheet.title}">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="${pageContext.request.contextPath}/profile-cheatsheets/uploads/${sheet.mediaList[0].mediaUrl}" alt="${sheet.title}">
                                        </c:otherwise>
                                    </c:choose>
                                </c:when>
                                <c:otherwise>No Cover</c:otherwise>
                            </c:choose>
                        </div>

                        <div class="sheet-body">
                            <div class="category-badge">${sheet.category.name}</div>
                            <h3 class="sheet-title">${sheet.title}</h3>
                            <p class="sheet-description">${sheet.description}</p>

                            <div class="sheet-footer d-flex justify-content-between align-items-center">
                                <div>
                                    <span class="d-block" style="font-size: 11px; opacity: 0.7;">Created By:</span>
                                    <strong>${sheet.user.name}</strong>
                                </div>
                                <c:choose>
                                    <c:when test="${fn:contains(sheet.user.profileImg, '/') || fn:startsWith(sheet.user.profileImg, 'http')}">
                                        <img src="${sheet.user.profileImg}" style="width: 36px; height: 36px; border-radius: 50%; object-fit: cover; border: 2px solid white;" alt="creator">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/uploads/profiles/${not empty sheet.user.profileImg ? sheet.user.profileImg : 'default.png'}" style="width: 36px; height: 36px; border-radius: 50%; object-fit: cover; border: 2px solid white;" alt="creator">
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>

                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <div class="text-center py-5 bg-white rounded-4 border">
                <i class="bi bi-file-earmark-code text-muted" style="font-size: 3.5rem;"></i>
                <h5 class="fw-bold mt-3 text-secondary">This collection is empty</h5>
                <p class="text-muted">Start adding cheat sheets here to see them later!</p>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="footer.jsp"/>

<script>
// 💡 Fix 4: Card နောက်ခံအရောင်ပေါ်မူတည်ပြီး စာသားကို အလိုအလျောက် အနက် သို့မဟုတ် အဖြူ ပြောင်းပေးမည့် စနစ်အမှန်
function getContrastColor(hexColor) {
    if (!hexColor || hexColor === "null") { hexColor = "#2563eb"; }
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

document.addEventListener("DOMContentLoaded", function(){
    document.querySelectorAll(".sheet-card").forEach(function (card) {
        // inline background style သို့မဟုတ် data attribute ကနေ အရောင်ယူပြီး စာသားအရောင်ကို dynamic တွက်ချက်ခြင်း
        const bgHex = card.style.backgroundColor;
        if(bgHex.includes('#')) {
            card.style.setProperty("color", getContrastColor(bgHex), "important");
        }
    });
});
</script>
</body>
</html>