<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

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

.folder-card.all::before{
    background:radial-gradient(circle,#ddd6fe,#ffffff);
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

.folder-card.unlisted::before{
    background:radial-gradient(circle,#cffafe,#ffffff);
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

.folder-card.all .folder-title{
    color:#7c3aed;
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

.folder-card.unlisted .folder-title{
    color:#0891b2;
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

/* Cheatsheet Cards - same as child-category-view card */
.grid{
    display:grid;
    grid-template-columns:repeat(auto-fill, minmax(280px, 1fr));
    gap:24px;
    padding-bottom:18px;
}

.sheet-card{
    border-radius:22px;
    overflow:hidden;
    text-decoration:none;
    color:var(--text-color, white) !important;
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
    color:var(--text-color, white);
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
    background:rgba(0,0,0,0.12);
    color:var(--text-color, white);
    font-size:12px;
    font-weight:800;
    margin-bottom:12px;
    align-self:flex-start;
}

.sheet-title{
    font-size:21px;
    color:var(--text-color, white);
    margin-bottom:8px;
    font-weight:900;
    line-height:1.35;
}

.sheet-description{
    color:var(--text-color, white);
    opacity:0.9;
    line-height:1.55;
    max-height:95px;
    overflow:hidden;
    font-size:15px;
}

.see-btn{
    display:inline-block;
    margin-top:6px;
    color:var(--text-color, white);
    text-decoration:underline;
    font-weight:800;
    cursor:pointer;
}

.sheet-footer{
    margin-top:auto;
    padding-top:12px;
    border-top:1px solid rgba(0,0,0,0.1);
    color:var(--text-color, white);
    opacity:0.8;
    font-size:13px;
    line-height:1.7;
}

.creator-link{
    color:var(--text-color, white);
    text-decoration:none;
    font-weight:900;
}

.empty-box{
    background:white;
    border:2px dashed #cbd5e1;
    border-radius:26px;
    padding:30px;
    color:#64748b;
}

@media(max-width:1100px){
    .folder-grid{
        grid-template-columns:repeat(2,1fr);
    }
}

@media(max-width:768px){
    .folder-grid{
        grid-template-columns:1fr;
    }

    .grid{
        grid-template-columns:1fr;
    }
}
</style>


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

        <div class="folder-card unlisted" onclick="toggleFolder('unlistedFolder', this)">
    <div class="folder-top">
        <div class="folder-title">
            👥 Followers Only
        </div>
    </div>
    <div class="folder-count">
        ${unlistedCheatsheets.size()} Cheatsheets
    </div>
</div>

    </div>


    <h2 class="section-heading">📚 All Cheatsheets</h2>

    <div id="allFolder" class="folder-content">
        <div class="grid">

            <c:forEach items="${allCheatsheets}" var="sheet">

                <div class="sheet-card auto-text-color"
                     data-color="${not empty sheet.themeColor ? sheet.themeColor : '#2563eb'}"
                     style="background-color:${not empty sheet.themeColor ? sheet.themeColor : '#2563eb'}; cursor:pointer; position:relative;">

                    <a href="${pageContext.request.contextPath}/profile-cheatsheets/detail/${sheet.id}"
                       style="text-decoration:none;
                              color:inherit;
                              display:flex;
                              flex-direction:column;
                              height:100%;">

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

                                <!-- <div style="
                                    font-size:24px;
                                    opacity:.8;
                                    font-weight:bold;">
                                    ⋮
                                </div> -->

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

                                    <span class="creator-link">
                                        ${sheet.user.name}
                                    </span>

                                    <div style="
                                        font-size:11px;
                                        opacity:.7;
                                        margin-top:4px;">

                                        <c:set var="datePart"
                                               value="${fn:substring(sheet.createdAt,0,10)}"/>

                                        <c:set var="timePart"
                                               value="${fn:substring(sheet.createdAt,11,16)}"/>

                                        🗓 ${datePart} ${timePart}
                                    </div>
                                </div>

                                <img src="${pageContext.request.contextPath}/uploads/profiles/${not empty sheet.user.profileImg ? sheet.user.profileImg : 'default.png'}"
                                     style="
                                        width:40px;
                                        height:40px;
                                        border-radius:50%;
                                        object-fit:cover;
                                        border:2px solid white;
                                        box-shadow:0 2px 6px rgba(0,0,0,.15);"
                                     alt="creator">

                            </div>

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

                        <div class="sheet-card auto-text-color"
                             data-color="${not empty sheet.themeColor ? sheet.themeColor : '#2563eb'}"
                             style="background-color:${not empty sheet.themeColor ? sheet.themeColor : '#2563eb'}; cursor:pointer; position:relative;">

                            <a href="${pageContext.request.contextPath}/profile-cheatsheets/detail/${sheet.id}"
                               style="text-decoration:none;
                                      color:inherit;
                                      display:flex;
                                      flex-direction:column;
                                      height:100%;">

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

                                        <div style="
                                            font-size:24px;
                                            opacity:.8;
                                            font-weight:bold;">
                                            ⋮
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

                                            <span class="creator-link">
                                                ${sheet.user.name}
                                            </span>

                                            <div style="
                                                font-size:11px;
                                                opacity:.7;
                                                margin-top:4px;">

                                                <c:set var="datePart"
                                                       value="${fn:substring(sheet.createdAt,0,10)}"/>

                                                <c:set var="timePart"
                                                       value="${fn:substring(sheet.createdAt,11,16)}"/>

                                                🗓 ${datePart} ${timePart}
                                            </div>
                                        </div>

                                        <img src="${pageContext.request.contextPath}/uploads/profiles/${not empty sheet.user.profileImg ? sheet.user.profileImg : 'default.png'}"
                                             style="
                                                width:40px;
                                                height:40px;
                                                border-radius:50%;
                                                object-fit:cover;
                                                border:2px solid white;
                                                box-shadow:0 2px 6px rgba(0,0,0,.15);"
                                             alt="creator">

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

                        <div class="sheet-card auto-text-color"
                             data-color="${not empty sheet.themeColor ? sheet.themeColor : '#2563eb'}"
                             style="background-color:${not empty sheet.themeColor ? sheet.themeColor : '#2563eb'}; cursor:pointer; position:relative;">

                            <a href="${pageContext.request.contextPath}/profile-cheatsheets/detail/${sheet.id}"
                               style="text-decoration:none;
                                      color:inherit;
                                      display:flex;
                                      flex-direction:column;
                                      height:100%;">

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

                                       <div class="dropdown d-inline-block" onclick="event.stopPropagation(); event.preventDefault();">
    <button class="btn p-1 text-reset border-0 shadow-none d-flex align-items-center justify-content-center" 
            type="button" 
            data-bs-toggle="dropdown" 
            aria-expanded="false" 
            style="color: var(--text-color, white) !important; opacity: 0.8; font-size: 24px; line-height: 1;">
        ⋮
    </button>
    <ul class="dropdown-menu dropdown-menu-end shadow border-0 py-2" style="border-radius: 10px; font-size: 14px; z-index: 1060;">
        <li>
            <a class="dropdown-item d-flex align-items-center gap-2 py-2 fw-semibold" href="javascript:void(0);" onclick="event.stopPropagation(); openPlaylistModal('${sheet.id}');">
                <i class="bi bi-plus-circle-fill text-primary"></i> Save to Playlist
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

                                            <span class="creator-link">
                                                ${sheet.user.name}
                                            </span>

                                            <div style="
                                                font-size:11px;
                                                opacity:.7;
                                                margin-top:4px;">

                                                <c:set var="datePart"
                                                       value="${fn:substring(sheet.createdAt,0,10)}"/>

                                                <c:set var="timePart"
                                                       value="${fn:substring(sheet.createdAt,11,16)}"/>

                                                🗓 ${datePart} ${timePart}
                                            </div>
                                        </div>

                                        <img src="${pageContext.request.contextPath}/uploads/profiles/${not empty sheet.user.profileImg ? sheet.user.profileImg : 'default.png'}"
                                             style="
                                                width:40px;
                                                height:40px;
                                                border-radius:50%;
                                                object-fit:cover;
                                                border:2px solid white;
                                                box-shadow:0 2px 6px rgba(0,0,0,.15);"
                                             alt="creator">

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

                        <div class="sheet-card auto-text-color"
                             data-color="${not empty sheet.themeColor ? sheet.themeColor : '#2563eb'}"
                             style="background-color:${not empty sheet.themeColor ? sheet.themeColor : '#2563eb'}; cursor:pointer; position:relative;">

                            <a href="${pageContext.request.contextPath}/profile-cheatsheets/detail/${sheet.id}"
                               style="text-decoration:none;
                                      color:inherit;
                                      display:flex;
                                      flex-direction:column;
                                      height:100%;">

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

                                        <div class="dropdown d-inline-block" onclick="event.stopPropagation(); event.preventDefault();">
    <button class="btn p-1 text-reset border-0 shadow-none d-flex align-items-center justify-content-center" 
            type="button" 
            data-bs-toggle="dropdown" 
            aria-expanded="false" 
            style="color: var(--text-color, white) !important; opacity: 0.8; font-size: 24px; line-height: 1;">
        ⋮
    </button>
    <ul class="dropdown-menu dropdown-menu-end shadow border-0 py-2" style="border-radius: 10px; font-size: 14px; z-index: 1060;">
        <li>
            <a class="dropdown-item d-flex align-items-center gap-2 py-2 fw-semibold" href="javascript:void(0);" onclick="event.stopPropagation(); openPlaylistModal('${sheet.id}');">
                <i class="bi bi-plus-circle-fill text-primary"></i> Save to Playlist
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

                                            <span class="creator-link">
                                                ${sheet.user.name}
                                            </span>

                                            <div style="
                                                font-size:11px;
                                                opacity:.7;
                                                margin-top:4px;">

                                                <c:set var="datePart"
                                                       value="${fn:substring(sheet.createdAt,0,10)}"/>

                                                <c:set var="timePart"
                                                       value="${fn:substring(sheet.createdAt,11,16)}"/>

                                                🗓 ${datePart} ${timePart}
                                            </div>
                                        </div>

                                        <img src="${pageContext.request.contextPath}/uploads/profiles/${not empty sheet.user.profileImg ? sheet.user.profileImg : 'default.png'}"
                                             style="
                                                width:40px;
                                                height:40px;
                                                border-radius:50%;
                                                object-fit:cover;
                                                border:2px solid white;
                                                box-shadow:0 2px 6px rgba(0,0,0,.15);"
                                             alt="creator">

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

                        <div class="sheet-card auto-text-color"
                             data-color="${not empty sheet.themeColor ? sheet.themeColor : '#2563eb'}"
                             style="background-color:${not empty sheet.themeColor ? sheet.themeColor : '#2563eb'}; cursor:pointer; position:relative;">

                            <a href="${pageContext.request.contextPath}/profile-cheatsheets/detail/${sheet.id}"
                               style="text-decoration:none;
                                      color:inherit;
                                      display:flex;
                                      flex-direction:column;
                                      height:100%;">

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

                                        <div class="dropdown d-inline-block" onclick="event.stopPropagation(); event.preventDefault();">
    <button class="btn p-1 text-reset border-0 shadow-none d-flex align-items-center justify-content-center" 
            type="button" 
            data-bs-toggle="dropdown" 
            aria-expanded="false" 
            style="color: var(--text-color, white) !important; opacity: 0.8; font-size: 24px; line-height: 1;">
        ⋮
    </button>
    <ul class="dropdown-menu dropdown-menu-end shadow border-0 py-2" style="border-radius: 10px; font-size: 14px; z-index: 1060;">
        <li>
            <a class="dropdown-item d-flex align-items-center gap-2 py-2 fw-semibold" href="javascript:void(0);" onclick="event.stopPropagation(); openPlaylistModal('${sheet.id}');">
                <i class="bi bi-plus-circle-fill text-primary"></i> Save to Playlist
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

                                            <span class="creator-link">
                                                ${sheet.user.name}
                                            </span>

                                            <div style="
                                                font-size:11px;
                                                opacity:.7;
                                                margin-top:4px;">

                                                <c:set var="datePart"
                                                       value="${fn:substring(sheet.createdAt,0,10)}"/>

                                                <c:set var="timePart"
                                                       value="${fn:substring(sheet.createdAt,11,16)}"/>

                                                🗓 ${datePart} ${timePart}
                                            </div>
                                        </div>

                                        <img src="${pageContext.request.contextPath}/uploads/profiles/${not empty sheet.user.profileImg ? sheet.user.profileImg : 'default.png'}"
                                             style="
                                                width:40px;
                                                height:40px;
                                                border-radius:50%;
                                                object-fit:cover;
                                                border:2px solid white;
                                                box-shadow:0 2px 6px rgba(0,0,0,.15);"
                                             alt="creator">

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
    👥 Followers Only
</h2>
    <div id="unlistedFolder"
         class="folder-content">

        <c:choose>

            <c:when test="${not empty unlistedCheatsheets}">

                <div class="grid">

                    <c:forEach items="${unlistedCheatsheets}" var="sheet">

                        <div class="sheet-card auto-text-color"
                             data-color="${not empty sheet.themeColor ? sheet.themeColor : '#2563eb'}"
                             style="background-color:${not empty sheet.themeColor ? sheet.themeColor : '#2563eb'}; cursor:pointer; position:relative;">

                            <a href="${pageContext.request.contextPath}/profile-cheatsheets/detail/${sheet.id}"
                               style="text-decoration:none;
                                      color:inherit;
                                      display:flex;
                                      flex-direction:column;
                                      height:100%;">

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

                                        <div class="dropdown" onclick="event.stopPropagation(); event.preventDefault();">
    <button class="btn p-0 text-reset border-0 shadow-none" type="button" data-bs-toggle="dropdown" aria-expanded="false" style="color: var(--text-color, white) !important; opacity: 0.8; font-size: 24px; line-height: 1;">
        ⋮
    </button>
    <ul class="dropdown-menu dropdown-menu-end shadow border-0 py-2" style="border-radius: 10px; font-size: 14px;">
        <li>
            <a class="dropdown-item d-flex align-items-center gap-2 py-2 fw-semibold" href="javascript:void(0);" onclick="event.stopPropagation(); openPlaylistModal('${sheet.id}');">
                <i class="bi bi-plus-circle-fill text-primary"></i> Save to Playlist
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

                                            <span class="creator-link">
                                                ${sheet.user.name}
                                            </span>

                                            <div style="
                                                font-size:11px;
                                                opacity:.7;
                                                margin-top:4px;">

                                                <c:set var="datePart"
                                                       value="${fn:substring(sheet.createdAt,0,10)}"/>

                                                <c:set var="timePart"
                                                       value="${fn:substring(sheet.createdAt,11,16)}"/>

                                                🗓 ${datePart} ${timePart}
                                            </div>
                                        </div>

                                        <img src="${pageContext.request.contextPath}/uploads/profiles/${not empty sheet.user.profileImg ? sheet.user.profileImg : 'default.png'}"
                                             style="
                                                width:40px;
                                                height:40px;
                                                border-radius:50%;
                                                object-fit:cover;
                                                border:2px solid white;
                                                box-shadow:0 2px 6px rgba(0,0,0,.15);"
                                             alt="creator">

                                    </div>

                                </div>

                            </a>

                        </div>

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

<div class="modal fade" id="bootstrapPlaylistModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" style="max-width: 420px;">
        <div class="modal-content border-0 p-2" style="border-radius: 24px; box-shadow: 0 10px 40px rgba(0,0,0,0.12);">
            <div class="modal-header border-0 pb-0 pt-3 px-4">
                <h5 class="modal-title fw-bold text-dark" style="font-size: 22px;">Save to playlist</h5>
                <button type="button" class="btn-close shadow-none" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body px-4 pb-4 pt-3">
                <div class="mb-3">
                    <label class="form-label text-secondary fw-semibold small mb-1" style="font-size: 13px;">Choose Playlist</label>
                    <select id="playlistSelect" class="form-select py-2 rounded-3 text-secondary" style="border-color: #cbd5e1; font-size: 14px;">
                        <option value="">-- Choose Playlist --</option>
                    </select>
                </div>
                <button onclick="saveToSelectedPlaylist()" class="btn btn-primary w-100 py-2 fw-bold mb-4 rounded-3 shadow-sm" style="background-color: #2563eb; border: none; font-size: 15px;">
                    Save to Selected
                </button>
                <hr class="my-3" style="opacity: 0.1;">
                <div class="mb-3">
                    <label class="form-label text-secondary fw-semibold small mb-1" style="font-size: 13px;">Create New Playlist</label>
                    <input id="newPlaylistName" class="form-control py-2 rounded-3" style="border-color: #cbd5e1; font-size: 14px;" placeholder="Choose a title">
                </div>
                <div class="mb-3">
                    <label class="form-label text-secondary fw-semibold small mb-1" style="font-size: 13px;">Visibility</label>
                    <select id="newPlaylistVisibility" class="form-select py-2 rounded-3 text-dark" style="border-color: #cbd5e1; font-size: 14px;">
                        <option value="PRIVATE">Private</option>
                        <option value="PUBLIC">Public</option>
                    </select>
                </div>
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <label class="form-label text-dark fw-semibold small m-0" style="font-size: 14px;">Collaborate</label>
                    <div class="form-check form-switch p-0 m-0 d-flex align-items-center">
                        <input class="form-check-input m-0" type="checkbox" role="switch" id="collaborateToggle" style="width: 2.5em; height: 1.25em; cursor: pointer;">
                    </div>
                </div>
                <button onclick="createNewPlaylist()" class="btn btn-dark w-100 py-2 fw-bold rounded-3" style="background-color: #1e293b; border: none; font-size: 15px;">
                    Create
                </button>
            </div>
        </div>
    </div>
</div>


<jsp:include page="footer.jsp"/>




<script>


let selectedCheatsheetIdForPlaylist = null;
let playlistModalObj = null;

function openPlaylistModal(cheatsheetId) {
    selectedCheatsheetIdForPlaylist = cheatsheetId;
    const modalEl = document.getElementById('bootstrapPlaylistModal');
    if (!playlistModalObj) {
        playlistModalObj = new bootstrap.Modal(modalEl);
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
                let option = document.createElement("option");
                option.value = c.id;
                option.text = c.name;
                select.appendChild(option);
            });
        })
        .catch(err => console.error("Error loading playlists:", err));
}

function createNewPlaylist() {
    const nameInput = document.getElementById('newPlaylistName');
    const visibilitySelect = document.getElementById('newPlaylistVisibility');
    const name = nameInput.value.trim();
    const visibility = visibilitySelect.value;

    if (!name) return alert("Please type a playlist name!");

    fetch('${pageContext.request.contextPath}/collection/create', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: 'name=' + encodeURIComponent(name) + '&visibility=' + encodeURIComponent(visibility)
    })
    .then(res => res.text())
    .then(() => {
        nameInput.value = "";
        loadPlaylists();
    })
    .catch(err => alert("Failed to create playlist."));
}

function saveToSelectedPlaylist() {
    const collectionId = document.getElementById('playlistSelect').value;
    const cheatsheetId = selectedCheatsheetIdForPlaylist;

    if (!collectionId) return alert("Please select a playlist first!");
    if (!cheatsheetId) return alert("Cheat sheet context error!");

    fetch('${pageContext.request.contextPath}/collection/add-to-playlist', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: 'collectionId=' + encodeURIComponent(collectionId) + '&cheatsheetId=' + encodeURIComponent(cheatsheetId)
    })
    .then(res => res.text())
    .then(data => {
        if (data === "Item already added!") {
            alert("This cheat sheet is already inside this playlist.");
        } else {
            alert("Successfully added to your playlist!");
            if (playlistModalObj) playlistModalObj.hide();
        }
    })
    .catch(() => alert("Error saving to playlist"));
}
document.addEventListener("DOMContentLoaded", function(){
    applyDynamicTextColors();

    document.querySelectorAll(".see-btn").forEach(function (btn) {
        btn.addEventListener("click", function (e) {
            e.preventDefault(); e.stopPropagation();
            const desc = this.previousElementSibling;
            if (desc.style.maxHeight === "none") {
                desc.style.maxHeight = "95px"; this.innerText = "See More";
            } else {
                desc.style.maxHeight = "none"; this.innerText = "See Less";
            }
        });
    });

    // 🚀 🛑 [ဤလိုင်းသစ်ကို တိုးမြှင့်ထည့်သွင်းပေးပါဦးဗျာ]
    // Dropdown Button ကို နှိပ်လိုက်တဲ့အခါ အပေါ်က <a> tag ရဲ့ Detail Page လင့်ခ်ဆီ အလုပ်လှမ်းမလုပ်အောင် လုံးဝ ညှပ်ပိတ်တားဆီးခြင်း
    document.querySelectorAll('.dropdown, .dropdown button, .dropdown-menu').forEach(function(element) {
        element.addEventListener('click', function(e) {
            e.preventDefault();
            e.stopPropagation();
        });
    });
});
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

document.addEventListener("DOMContentLoaded", function(){
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
</script>
</body>
</html>
