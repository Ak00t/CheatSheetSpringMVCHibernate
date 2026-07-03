<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Cheatsheets</title>

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
    margin:40px auto;
}

h1{
    color:#2563eb;
    font-size:34px;
    font-weight:900;
    margin-bottom:10px;
}

.page-subtitle{
    color:#64748b;
    margin-bottom:28px;
}

/* Folder Cards Like Home Category Cards */
.folder-grid{
    display:grid;
    grid-template-columns:repeat(4,1fr);
    gap:24px;
    margin-bottom:35px;
}

.folder-card{
    position:relative;
    min-height:190px;
    padding:28px;
    border-radius:30px;
    background:#ffffff;
    border:1px solid #edf2f7;
    overflow:hidden;
    cursor:pointer;
    box-shadow:0 10px 35px rgba(15,23,42,.06);
    transition:.3s;
    display:flex;
    flex-direction:column;
    justify-content:space-between;
}

.folder-card:hover{
    transform:translateY(-8px);
    box-shadow:0 20px 50px rgba(15,23,42,.10);
}

.folder-card::before{
    content:'';
    position:absolute;
    width:210px;
    height:210px;
    right:-85px;
    bottom:-85px;
    border-radius:50%;
    opacity:.9;
    z-index:1;
}

.folder-card.published::before{
    background:radial-gradient(circle,#dbeafe,#ffffff);
}

.folder-card.draft::before{
    background:radial-gradient(circle,#fef3c7,#ffffff);
}

.folder-card.archived::before{
    background:radial-gradient(circle,#e2e8f0,#ffffff);
}

.folder-card.private::before{
    background:radial-gradient(circle,#fee2e2,#ffffff);
}

.folder-top{
    position:relative;
    z-index:2;
}

.folder-title{
    font-size:25px;
    font-weight:900;
    color:#2563eb;
}

.folder-card.draft .folder-title{
    color:#f59e0b;
}

.folder-card.archived .folder-title{
    color:#64748b;
}

.folder-card.private .folder-title{
    color:#dc2626;
}

.folder-count{
    position:relative;
    z-index:2;
    color:#475569;
    font-size:18px;
    font-weight:800;
}

.folder-hint{
    position:relative;
    z-index:2;
    color:#64748b;
    font-size:14px;
    margin-top:8px;
}

.folder-card.active{
    border-color:#2563eb;
    box-shadow:0 20px 50px rgba(37,99,235,.18);
}

.folder-card.active .folder-hint{
    color:#2563eb;
    font-weight:800;
}

.folder-content{
    display:none;
    margin-bottom:45px;
    animation:fadeDown .25s ease;
}

.folder-content.active{
    display:block;
}

@keyframes fadeDown{
    from{
        opacity:0;
        transform:translateY(-8px);
    }
    to{
        opacity:1;
        transform:translateY(0);
    }
}

.section-heading{
    margin:18px 0 20px;
    font-size:28px;
    font-weight:900;
    color:#1e293b;
}

/* Cheatsheet Cards */
.grid{
    display:flex;
    flex-wrap:wrap;
    justify-content:center;
    gap:24px;
    padding-bottom:18px;
}

.sheet-card{
    flex:0 0 380px;
    border-radius:28px;
    overflow:hidden;
    text-decoration:none;
    color:white !important;
    border:1px solid rgba(255,255,255,0.2);
    box-shadow:0 14px 35px rgba(0,0,0,.12);
    transition:.3s;
    padding:24px;
    display:flex;
    flex-direction:column;
    height:520px;
}

.sheet-card:hover{
    transform:translateY(-6px);
    box-shadow:0 20px 40px rgba(0,0,0,.2);
}

.sheet-cover{
    width:100%;
    height:180px;
    border:2px dashed rgba(255,255,255,0.4);
    border-radius:18px;
    display:flex;
    justify-content:center;
    align-items:center;
    color:white;
    font-size:22px;
    font-weight:800;
    overflow:hidden;
    background:rgba(0,0,0,0.05);
    flex-shrink:0;
}

.sheet-cover img{
    width:100%;
    height:100%;
    object-fit:cover;
}

.sheet-body{
    padding:12px 0 0 0;
    display:flex;
    flex-direction:column;
    flex-grow:1;
    overflow:hidden;
}

.category-badge{
    display:inline-block;
    padding:5px 15px;
    border-radius:999px;
    background:rgba(255,255,255,0.2);
    color:white;
    font-size:13px;
    font-weight:800;
    margin-bottom:12px;
    align-self:flex-start;
    text-transform:uppercase;
}

.sheet-title{
    font-size:24px;
    color:white;
    margin-bottom:8px;
    font-weight:800;
}

.sheet-description{
    color:rgba(255,255,255,0.9);
    line-height:1.6;
    max-height:80px;
    overflow:hidden;
    font-size:14px;
}

.see-btn{
    display:inline-block;
    margin-top:5px;
    color:white;
    text-decoration:underline;
    font-weight:800;
    cursor:pointer;
    font-size:14px;
}

.sheet-footer{
    margin-top:auto;
    padding-top:12px;
    border-top:1px solid rgba(255,255,255,0.2);
    color:rgba(255,255,255,0.8);
    font-size:13px;
    line-height:1.6;
}

.creator-link{
    color:white;
    text-decoration:none;
    font-weight:800;
}

.empty-box{
    background:white;
    border:2px dashed #cbd5e1;
    border-radius:26px;
    padding:30px;
    color:#64748b;
}


.folder-card.all::before{background:radial-gradient(circle,#ddd6fe,#ffffff);} 
.folder-card.all .folder-title{color:#7c3aed;}

@media(max-width:1100px){
    .folder-grid{
        grid-template-columns:repeat(2,1fr);
    }
}

@media(max-width:768px){
    .folder-grid{
        grid-template-columns:1fr;
    }

    .sheet-card{
        flex:0 0 100%;
    }
}

.folder-card.unlisted::before{
    background:
        radial-gradient(
            circle,
            #cffafe,
            #ffffff
        );
}

.folder-card.unlisted .folder-title{
    color:#0891b2;
}


</style>

<script>
function toggleFolder(id, card){

    const content = document.getElementById(id);

    if(!content){
        return;
    }

    const isOpen = content.classList.contains("active");

    document.querySelectorAll(".folder-content").forEach(function(item){
        item.classList.remove("active");
    });

    document.querySelectorAll(".folder-card").forEach(function(item){
        item.classList.remove("active");
        const hint = item.querySelector(".folder-hint");
        if(hint){
            hint.innerText = "Click to view cheatsheets";
        }
    });

    if(!isOpen){
        content.classList.add("active");
        card.classList.add("active");

        const hint = card.querySelector(".folder-hint");
        if(hint){
            hint.innerText = "Click to close";
        }

        content.scrollIntoView({
            behavior:"smooth",
            block:"start"
        });
    }
}
</script>
</head>

<body>

<jsp:include page="header.jsp"/>

<div class="container">

   
    <h1>
    👤 ${currentUser.name}'s Cheatsheets
</h1>
    
    
    <p class="page-subtitle">
        Choose a folder to view your cheatsheets by status and visibility.
    </p>

    <div class="folder-grid">

        
        <div class="folder-card all"
             onclick="toggleFolder('allFolder', this)">

            <div class="folder-top">
                <div class="folder-title">
                    📚 All Cheatsheets
                </div>
            </div>

            <div class="folder-count">
                ${totalCheatsheets} Cheatsheets
            </div>

        </div>

        <div class="folder-card published"
             onclick="toggleFolder('publishedFolder', this)">

            <div class="folder-top">
                <div class="folder-title">
                    📢 Published
                </div>

                <div class="folder-hint">
                    Click to view cheatsheets
                </div>
            </div>

            <div class="folder-count">
                ${publishedCheatsheets.size()} Cheatsheets
            </div>

        </div>

        <div class="folder-card draft"
             onclick="toggleFolder('draftFolder', this)">

            <div class="folder-top">
                <div class="folder-title">
                    📝 Draft
                </div>

                <div class="folder-hint">
                    Click to view cheatsheets
                </div>
            </div>

            <div class="folder-count">
                ${draftCheatsheets.size()} Cheatsheets
            </div>

        </div>

        <div class="folder-card archived"
             onclick="toggleFolder('archivedFolder', this)">

            <div class="folder-top">
                <div class="folder-title">
                    📦 Archived
                </div>

                <div class="folder-hint">
                    Click to view cheatsheets
                </div>
            </div>

            <div class="folder-count">
                ${archivedCheatsheets.size()} Cheatsheets
            </div>

        </div>

        <div class="folder-card private"
             onclick="toggleFolder('privateFolder', this)">

            <div class="folder-top">
                <div class="folder-title">
                    🔒 Private
                </div>

                <div class="folder-hint">
                    Click to view cheatsheets
                </div>
            </div>

            <div class="folder-count">
                ${privateCheatsheets.size()} Cheatsheets
            </div>

        </div>
        
        <div class="folder-card unlisted"
     onclick="toggleFolder('unlistedFolder', this)">

    <div class="folder-top">

        <div class="folder-title">
            🔗 Unlisted
        </div>

    </div>

    <div class="folder-count">
        ${unlistedCheatsheets.size()}
        Cheatsheets
    </div>

</div>
        
        
        

    </div>


    <h2 class="section-heading">📚 All Cheatsheets</h2>

<div id="allFolder" class="folder-content">
    <div class="grid">
        <c:forEach items="${publishedCheatsheets}" var="sheet">
            <div class="sheet-card" style="background-color:${not empty sheet.themeColor ? sheet.themeColor : '#2563eb'};">
                <a href="${pageContext.request.contextPath}/profile-cheatsheets/detail/${sheet.id}" style="text-decoration:none; color:inherit; display:flex; flex-direction:column; height:100%;">
                    <div class="sheet-cover">
                        <c:choose>
                            <c:when test="${not empty sheet.mediaList}">
                                <img src="${sheet.mediaList[0].mediaUrl}" alt="${sheet.title}">
                            </c:when>
                            <c:otherwise>No Cover</c:otherwise>
                        </c:choose>
                    </div>
                    <div class="sheet-body">
                        <div class="category-badge">${sheet.category.name}</div>
                        <h3 class="sheet-title">${sheet.title}</h3>
                        <p class="sheet-description">${sheet.description}</p>
                        <span class="see-btn">See More</span>
                        <div class="sheet-footer">Created By: <span class="creator-link">${sheet.user.name}</span></div>
                    </div>
                </a>
            </div>
        </c:forEach>
    </div>
</div>

    <h2 class="section-heading">📢 Published</h2>

<div id="publishedFolder" class="folder-content">

    <c:choose>
        <c:when test="${not empty publishedCheatsheets}">
            <div class="grid">

<c:forEach items="${publishedCheatsheets}" var="sheet">

    <div class="sheet-card"
         style="background-color:${not empty sheet.themeColor ? sheet.themeColor : '#2563eb'};">

        <a href="${pageContext.request.contextPath}/profile-cheatsheets/detail/${sheet.id}"
           style="text-decoration:none; color:inherit; display:flex; flex-direction:column; height:100%;">

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

    </div>

</c:forEach>

            </div>
        </c:when>

        <c:otherwise>
            <div class="empty-box">
                No published cheatsheets.
            </div>
        </c:otherwise>
    </c:choose>

</div>


    <h2 class="section-heading">📝 Draft</h2>

<div id="draftFolder" class="folder-content">

    <c:choose>
        <c:when test="${not empty draftCheatsheets}">
            <div class="grid">

<c:forEach items="${draftCheatsheets}" var="sheet">

    <div class="sheet-card"
         style="background-color:${not empty sheet.themeColor ? sheet.themeColor : '#2563eb'};">

        <a href="${pageContext.request.contextPath}/profile-cheatsheets/detail/${sheet.id}"
           style="text-decoration:none; color:inherit; display:flex; flex-direction:column; height:100%;">

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

    </div>

</c:forEach>

            </div>
        </c:when>

        <c:otherwise>
            <div class="empty-box">
                No drafts.
            </div>
        </c:otherwise>
    </c:choose>

</div>


    <h2 class="section-heading">📦 Archived</h2>

<div id="archivedFolder" class="folder-content">

    <c:choose>
        <c:when test="${not empty archivedCheatsheets}">
            <div class="grid">

<c:forEach items="${archivedCheatsheets}" var="sheet">

    <div class="sheet-card"
         style="background-color:${not empty sheet.themeColor ? sheet.themeColor : '#2563eb'};">

        <a href="${pageContext.request.contextPath}/profile-cheatsheets/detail/${sheet.id}"
           style="text-decoration:none; color:inherit; display:flex; flex-direction:column; height:100%;">

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

    </div>

</c:forEach>

            </div>
        </c:when>

        <c:otherwise>
            <div class="empty-box">
                No archived cheatsheets.
            </div>
        </c:otherwise>
    </c:choose>

</div>


    <h2 class="section-heading">🔒 Private</h2>

<div id="privateFolder" class="folder-content">

    <c:choose>
        <c:when test="${not empty privateCheatsheets}">
            <div class="grid">

<c:forEach items="${privateCheatsheets}" var="sheet">

    <div class="sheet-card"
         style="background-color:${not empty sheet.themeColor ? sheet.themeColor : '#2563eb'};">

        <a href="${pageContext.request.contextPath}/profile-cheatsheets/detail/${sheet.id}"
           style="text-decoration:none; color:inherit; display:flex; flex-direction:column; height:100%;">

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

    </div>

</c:forEach>

            </div>
        </c:when>

        <c:otherwise>
            <div class="empty-box">
                No private cheatsheets.
            </div>
        </c:otherwise>
    </c:choose>

</div>

<h2 class="section-heading">
    🔗 Unlisted
</h2>

<div id="unlistedFolder"
     class="folder-content">

    <c:choose>

        <c:when test="${not empty unlistedCheatsheets}">

            <div class="grid">

                <c:forEach items="${unlistedCheatsheets}"
                           var="sheet">

                    <!-- လက်ရှိ cheatsheet card block ကို
                         copy/paste လုပ်ပါ -->

                </c:forEach>

            </div>

        </c:when>

        <c:otherwise>

            <div class="empty-box">
                No unlisted cheatsheets.
            </div>

        </c:otherwise>

    </c:choose>

</div>



</div>

<jsp:include page="footer.jsp"/>

</body>
</html>
