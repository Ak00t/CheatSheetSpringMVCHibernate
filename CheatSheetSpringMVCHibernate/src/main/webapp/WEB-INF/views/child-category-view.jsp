<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${childCategory.name}</title>

<style>
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Segoe UI',sans-serif;
}

body{
    background:#f8fafc;
    color:#1e293b;
}

.container{
    width:95%;
    max-width:1400px;
    margin:auto;
}

.hero{
    margin:30px 0 25px;
    border-radius:28px;
    overflow:hidden;
    background:white;
    box-shadow:0 12px 35px rgba(15,23,42,.08);
}

.hero-top{
    padding:50px;
    background:linear-gradient(135deg,#2563eb,#10b981);
    color:white;
    display:flex;
    justify-content:space-between;
    align-items:center;
    gap:30px;
}

.hero h1{
    font-size:48px;
    margin-bottom:12px;
}

.hero p{
    font-size:17px;
    line-height:1.7;
}

.hero-stats{
    display:flex;
    gap:45px;
    text-align:center;
}

.hero-stats h2{
    font-size:34px;
}

.hero-stats span{
    font-size:15px;
}

.follow-bar{
    padding:22px 35px;
    display:flex;
    justify-content:space-between;
    align-items:center;
}

.follow-info small{
    color:#64748b;
    font-weight:700;
}

.follow-info h3{
    margin-top:6px;
    font-size:20px;
}

.follow-btn,
.following-btn{
    border:none;
    padding:13px 28px;
    border-radius:14px;
    color:white;
    font-weight:800;
    cursor:pointer;
    font-size:15px;
}

.follow-btn{
    background:#2563eb;
}

.following-btn{
    background:#ef4444;
}

.page-layout{
    display:grid;
    grid-template-columns:300px 1fr;
    gap:25px;
    align-items:start;
}

.sidebar-card,
.main-card{
    background:white;
    border-radius:20px;
    box-shadow:0 10px 30px rgba(15,23,42,.07);
    border:1px solid #e2e8f0;
}

.sidebar-card{
    padding:22px;
    margin-bottom:22px;
}

.sidebar-card h3{
    font-size:20px;
    margin-bottom:18px;
}

.tags{
    display:flex;
    flex-wrap:wrap;
    gap:12px;
}

.tag-card{
    padding:10px 16px;
    border-radius:999px;
    background:white;
    color:#2563eb;
    text-decoration:none;
    font-weight:800;
    border:1px solid #bfdbfe;
    box-shadow:0 6px 16px rgba(37,99,235,.08);
    font-size:14px;
}

.mini-card{
    display:flex;
    gap:12px;
    text-decoration:none;
    color:#1e293b;
    margin-bottom:16px;
    align-items:center;
}

.mini-img{
    width:70px;
    height:55px;
    border-radius:10px;
    overflow:hidden;
    background:#e2e8f0;
    flex-shrink:0;
}

.mini-img img{
    width:100%;
    height:100%;
    object-fit:cover;
}

.mini-title{
    font-size:14px;
    font-weight:800;
    line-height:1.4;
}

.mini-meta{
    margin-top:4px;
    font-size:12px;
    color:#64748b;
}

.main-card{
    padding:25px;
}

.main-head{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:25px;
}

.main-title{
    font-size:30px;
    font-weight:900;
}

.main-subtitle{
    color:#64748b;
    margin-top:6px;
}

.sheet-grid{
    display:grid;
    grid-template-columns:repeat(auto-fill,minmax(280px,1fr));
    gap:24px;
}

.sheet-card{
    border-radius:22px;
    overflow:hidden;
    text-decoration:none;
    color:white !important;
    box-shadow:0 12px 30px rgba(0,0,0,.13);
    transition:.3s;
    padding:20px;
    display:flex;
    flex-direction:column;
    min-height:470px;
}

.sheet-card:hover{
    transform:translateY(-6px);
    box-shadow:0 20px 40px rgba(0,0,0,.22);
}

.sheet-cover{
    width:100%;
    height:170px;
    border:2px dashed rgba(255,255,255,0.45);
    border-radius:18px;
    display:flex;
    justify-content:center;
    align-items:center;
    color:white;
    font-size:18px;
    font-weight:800;
    overflow:hidden;
    background:rgba(0,0,0,0.06);
    flex-shrink:0;
}

.sheet-cover img{
    width:100%;
    height:100%;
    object-fit:cover;
}

.sheet-body{
    padding-top:12px;
    display:flex;
    flex-direction:column;
    flex-grow:1;
    overflow:hidden;
}

.category-badge{
    display:inline-block;
    padding:6px 14px;
    border-radius:999px;
    background:rgba(255,255,255,0.25);
    color:white;
    font-size:12px;
    font-weight:800;
    margin-bottom:12px;
    align-self:flex-start;
}

.sheet-title{
    font-size:21px;
    color:white;
    margin-bottom:8px;
    font-weight:900;
    line-height:1.35;
}

.sheet-description{
    color:rgba(255,255,255,0.92);
    line-height:1.55;
    max-height:95px;
    overflow:hidden;
    font-size:15px;
}

.see-btn{
    display:inline-block;
    margin-top:6px;
    color:white;
    text-decoration:underline;
    font-weight:800;
    cursor:pointer;
}

.sheet-footer{
    margin-top:auto;
    padding-top:12px;
    border-top:1px solid rgba(255,255,255,0.25);
    color:rgba(255,255,255,0.9);
    font-size:13px;
    line-height:1.7;
}

.creator-link{
    color:white;
    text-decoration:none;
    font-weight:900;
}

.empty-box{
    background:white;
    border:2px dashed #cbd5e1;
    border-radius:20px;
    padding:25px;
    color:#64748b;
}

@media(max-width:900px){
    .page-layout{
        grid-template-columns:1fr;
    }

    .hero-top{
        flex-direction:column;
        align-items:flex-start;
    }

    .hero-stats{
        width:100%;
        justify-content:space-between;
    }
}

@media(max-width:768px){
    .hero-top{
        padding:30px;
    }

    .hero h1{
        font-size:36px;
    }

    .sheet-grid{
        grid-template-columns:1fr;
    }
}
</style>
</head>

<body>

<jsp:include page="header.jsp"/>

<div class="container">

    <section class="hero">

        <div class="hero-top">

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
                        <button type="submit" class="following-btn">
                            ✓ Following
                        </button>
                    </form>
                </c:when>

                <c:otherwise>
                    <form method="post"
                          action="${pageContext.request.contextPath}/category/follow/${childCategory.id}">
                        <button type="submit" class="follow-btn">
                            + Follow
                        </button>
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
                                <a href="${pageContext.request.contextPath}/tag/${tag.id}" class="tag-card">
                                    #${tag.name}
                                </a>
                            </c:forEach>
                        </div>
                    </c:when>

                    <c:otherwise>
                        <div class="empty-box">
                            No tags found.
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="sidebar-card">
                <h3>🔥 Popular Cheatsheets</h3>

                        <a href="${pageContext.request.contextPath}/cheatsheet/${sheet.id}"
                           class="sheet-card"
                           style="background-color: ${sheet.themeColor};">
<div class="sheet-cover">
    <c:choose>
        <c:when test="${not empty sheet.mediaList and not empty sheet.mediaList[0].mediaUrl}">
            <img src="${pageContext.request.contextPath}/uploads/cheatsheets/${sheet.mediaList[0].mediaUrl}" 
                 alt="${sheet.title}" />
        </c:when>
        <c:otherwise>
            <span style="color:white; font-size:12px;">No Image</span>
        </c:otherwise>
    </c:choose>
</div>






                            <div class="sheet-body">

                                <div class="category-badge">
                                    ${sheet.category.name}
                                </div>

                                <div>
                                    <div class="mini-title">${sheet.title}</div>
                                    <div class="mini-meta">👁 ${sheet.viewCount} views</div>
                                </div>

                            </a>
                        </c:forEach>
                    </c:when>

                                <span class="see-btn">
                                    See More
                                </span>
                       

                                <%-- <div class="sheet-footer">
                                    Created By: <span class="creator-link">${sheet.user.name}</span>
                                    <br>
                                    Created At: ${sheet.createdAt}
                                </div> --%>
                                
                       
                                
                               <div class="sheet-footer">
                               
                               
                               
                               
                               
                    <c:otherwise>
                        <div class="empty-box">
                            No popular cheatsheets.
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="sidebar-card">
                <h3>🆕 Recent Cheatsheets</h3>

                <c:choose>
                    <c:when test="${not empty recentCheatsheets}">
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

    🗓
    <%-- အရင်ရှိနေတဲ့ fmt:parseDate ကို ဖျက်ပြီး ဒါနဲ့ အစားထိုးပါ --%>
<c:set var="datePart" value="${fn:substring(sheet.createdAt, 0, 10)}" />
<c:set var="timePart" value="${fn:substring(sheet.createdAt, 11, 16)}" />

🗓 ${datePart} ${timePart}
            
            

                            </a>
                        </c:forEach>
                    </c:when>

                    <c:otherwise>
                        <div class="empty-box">
                            No recent cheatsheets.
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

        </aside>

        <main class="main-card">

            <div class="main-head">
                <div>
                    <div class="main-title">
                        📚 All Cheatsheets
                    </div>
                    <p class="main-subtitle">
                        Browse all public cheatsheets under ${childCategory.name}.
                    </p>
                </div>
            </div>

            <c:choose>
                <c:when test="${not empty cheatsheets}">
                    <div class="sheet-grid">

                        <c:forEach items="${cheatsheets}" var="sheet">

                            <a href="${pageContext.request.contextPath}/cheatsheet/${sheet.id}"
                               class="sheet-card"
                               style="background-color:${not empty sheet.themeColor ? sheet.themeColor : '#2563eb'};">

                                <div class="sheet-cover">
                                    <c:choose>
                                        <c:when test="${not empty sheet.mediaList}">
                                            <img src="${sheet.mediaList[0].mediaUrl}"
                                                 alt="${sheet.title}">
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

                                    <h3 class="sheet-title">
                                        ${sheet.title}
                                    </h3>

                                    <p class="sheet-description">
                                        ${sheet.description}
                                    </p>

                                    <span class="see-btn">
                                        See More
                                    </span>

                                    <div class="sheet-footer">
                                        Created By:
                                        <span class="creator-link">
                                            ${sheet.user.name}
                                        </span>

                                        <br>

                                        🗓
                                        <fmt:parseDate
                                                value="${sheet.createdAt}"
                                                pattern="yyyy-MM-dd'T'HH:mm:ss"
                                                var="createdDate"/>

                                        <fmt:formatDate
                                                value="${createdDate}"
                                                pattern="dd MMM yyyy"/>
                                    </div>

                                </div>
                            </a>

                        </c:forEach>

                    </div>
                </c:when>

                <c:otherwise>
                    <div class="empty-box">
                        No published cheatsheets found for this category.
                    </div>
                </c:otherwise>
            </c:choose>

        </main>

    </div>

</div>

<jsp:include page="footer.jsp"/>

<script>
document.querySelectorAll(".see-btn").forEach(function(btn){

    btn.addEventListener("click", function(e){
        e.preventDefault();
        e.stopPropagation();

        const desc = this.previousElementSibling;

        if(desc.style.maxHeight === "none"){
            desc.style.maxHeight = "95px";
            this.innerText = "See More";
        }else{
            desc.style.maxHeight = "none";
            this.innerText = "See Less";
        }
    });

});
.sheet-cover {
    width: 100%;
    height: 180px;
    background: rgba(0, 0, 0, 0.1);
    border-radius: 18px;
    display: flex;
    justify-content: center;
    align-items: center;
    overflow: hidden;
    flex-shrink: 0;
    margin-bottom: 10px; /* အောက်က စာသားနဲ့ ကပ်မနေအောင် */
}
function openModal() {
    const modal = document.getElementById('playlistModal');
    modal.style.display = "block";

    // Hibernate မှတစ်ဆင့် Data လှမ်းယူခြင်း
    fetch('${pageContext.request.contextPath}/collection/list')
        .then(response => response.json())
        .then(data => {
            const select = document.getElementById('playlistSelect');
            select.innerHTML = '<option>Select a playlist</option>';
            data.forEach(c => {
                select.innerHTML += `<option value="${c.id}">${c.name}</option>`;
            });
        });
}

function closeModal() {
    document.getElementById('playlistModal').style.display = "none";
}
</script>

</body>
</html>