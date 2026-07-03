<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>DevNote - User Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root { 
            --bg-canvas: #f4fbfc; 
            --brand-green: #047857; 
            --brand-light: #d1fae5;
            --brand-blue: #2563eb;
            --brand-blue-light: #eff6ff;
            --text-dark: #1e293b; 
            --text-gray: #64748b; 
            --border-light: #e2e8f0; 
            --shadow-premium: 0 20px 25px -5px rgba(0, 0, 0, 0.02), 0 8px 10px -6px rgba(0, 0, 0, 0.02);
            --shadow-card: 0 4px 6px -1px rgba(0, 0, 0, 0.03), 0 2px 4px -1px rgba(0, 0, 0, 0.02);
        }
        body { font-family: 'Plus Jakarta Sans', sans-serif; background-color: var(--bg-canvas); margin: 0; color: var(--text-dark); }
        
        .page-container { display: flex; flex-direction: column; min-height: 100vh; }
        .page-wrapper { display: flex; padding: 28px; gap: 28px; align-items: flex-start; flex: 1; }
        
        .main-workspace { flex-grow: 1; min-width: 0; }
        .workspace-card { background-color: #ffffff; border-radius: 24px; padding: 32px; box-shadow: var(--shadow-premium); border: 1px solid rgba(226, 232, 240, 0.8); }
        .top-header-row { display: flex; justify-content: flex-end; align-items: center; margin-bottom: 20px; }
        
        .search-wrapper { max-width: 380px; width: 100%; }
        .search-input { border-radius: 12px 0 0 12px !important; border: 1px solid var(--border-light); padding: 11px 16px; font-size: 14px; background-color: #f8fafc; }
        .search-input:focus { border-color: var(--brand-blue); box-shadow: none; background-color: #ffffff; }
        .search-btn { border-radius: 0 12px 12px 0 !important; background-color: var(--brand-blue); border-color: var(--brand-blue); color: #ffffff; padding: 0 20px; transition: all 0.2s; }
        .search-btn:hover { background-color: #1d4ed8; border-color: #1d4ed8; color: #ffffff; }
        
        .blue-header-box { background: linear-gradient(135deg, #1e40af, #2563eb); color: #ffffff; padding: 28px 32px; border-radius: 20px; margin-bottom: 28px; box-shadow: 0 10px 20px -5px rgba(37, 99, 235, 0.2); }
        .table-title { font-weight: 800; font-size: 26px; color: #ffffff; margin-bottom: 6px; letter-spacing: -0.5px; }
        .table-subtitle { font-size: 14px; color: #bfdbfe; margin-bottom: 0; }
        
        .column-nav-tabs { display: flex; gap: 12px; margin-bottom: 24px; border-bottom: 2px solid var(--border-light); padding-bottom: 8px; }
        .nav-col-btn { background: none; border: none; font-size: 15px; font-weight: 800; text-transform: uppercase; letter-spacing: 0.5px; color: var(--text-gray); padding: 8px 20px; border-radius: 10px; display: flex; align-items: center; gap: 8px; transition: all 0.2s ease; cursor: pointer; }
        .nav-col-btn i { font-size: 14px; }
        
        .nav-col-btn.active.btn-admins-tab { background-color: #fee2e2; color: #ef4444; }
        .nav-col-btn.active.btn-users-tab { background-color: #d1fae5; color: #047857; }
        .nav-col-btn:not(.active):hover { background-color: #f1f5f9; color: var(--text-dark); }
        
        .role-content-pane { display: none; }
        .role-content-pane.active { display: block; }
        
        .account-list-container { display: flex; flex-direction: column; gap: 12px; }
        .account-card-link { text-decoration: none !important; color: inherit; display: block; }
        .account-card-link.search-disabled { display: none !important; }
        
        .account-horizontal-box { background-color: #ffffff; border: 1px solid var(--border-light); border-radius: 14px; padding: 14px 18px; display: flex; align-items: center; justify-content: space-between; transition: all 0.2s ease; box-shadow: var(--shadow-card); }
        .account-card-link:hover .account-horizontal-box { transform: translateY(-2px); border-color: var(--brand-blue); box-shadow: 0 6px 12px -3px rgba(0, 0, 0, 0.05); }
        
        .box-left-section { display: flex; align-items: center; gap: 24px; flex-grow: 1; min-width: 0; }
        .box-avatar { width: 44px; height: 44px; border-radius: 10px; object-fit: cover; border: 1px solid var(--border-light); flex-shrink: 0; }
        
        .box-details-grid { display: grid; grid-template-columns: 200px 260px 120px 120px; gap: 16px; align-items: center; flex-grow: 1; min-width: 0; }
        .box-name { font-weight: 700; font-size: 15px; color: var(--text-dark); white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
        .account-card-link:hover .box-name { color: var(--brand-blue); text-decoration: underline; }
        .box-email { font-size: 14px; color: var(--text-gray); white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
        
        .badge-wrapper { display: inline-block; }
        .role-badge { font-size: 11px; font-weight: 700; padding: 4px 10px; border-radius: 8px; display: inline-block; text-align: center; min-width: 85px; }
        .role-admin { background-color: #fee2e2; color: #ef4444; }
        .role-moderator { background-color: #fef3c7; color: #d97706; }
        .role-user { background-color: var(--brand-light); color: var(--brand-green); }
        
        .status-badge { font-size: 11px; font-weight: 600; padding: 4px 10px; border-radius: 8px; display: inline-flex; align-items: center; gap: 6px; min-width: 85px; justify-content: center; }
        .status-active { background-color: #ecfdf5; color: #10b981; }
        .status-inactive { background-color: #f1f5f9; color: #64748b; }
        .status-banned { background-color: #fff1f2; color: #f43f5e; }
        .status-badge::before { content: ''; width: 5px; height: 5px; border-radius: 50%; }
        .status-active::before { background-color: #10b981; }
        .status-inactive::before { background-color: #64748b; }
        .status-banned::before { background-color: #f43f5e; }
        
        .account-actions { display: flex; align-items: center; gap: 8px; }
        .btn-action { padding: 6px 12px; font-size: 12px; font-weight: 600; border-radius: 8px; display: inline-flex; align-items: center; gap: 4px; transition: all 0.2s ease; border: 1px solid transparent; }
        .btn-ban { background-color: #fff7ed; color: #ea580c; }
        .btn-ban:hover { background-color: #ffedd5; }
        .btn-unban { background-color: #f0fdf4; color: #16a34a; }
        .btn-unban:hover { background-color: #dcfce7; }
        .btn-delete { background-color: #fff1f2; color: #e11d48; padding: 6px 10px; }
        .btn-delete:hover { background-color: #ffe4e6; }
        
        .current-user-badge { font-size: 12px; font-weight: 700; color: var(--brand-blue); background-color: var(--brand-blue-light); padding: 6px 12px; border-radius: 8px; border: 1px dashed var(--brand-blue); display: inline-flex; align-items: center; gap: 6px; }
        
        .pagination { gap: 4px; margin-top: 28px; }
        .pagination .page-link { color: #475569; border: 1px solid var(--border-light); padding: 8px 14px; border-radius: 10px; font-weight: 600; font-size: 13px; background-color: #ffffff; text-decoration: none; }
        .pagination .page-item.active .page-link { background-color: var(--brand-blue); border-color: var(--brand-blue); color: #ffffff; }

        .site-footer { background:#111827; color:white; margin-top:60px; padding:40px 20px; }
        .footer-container { max-width:1200px; margin:auto; text-align:center; }
        .footer-container h3 { margin-bottom:10px; font-size:24px; }
        .footer-container p { color:#d1d5db; margin-bottom:8px; }
        .copyright { margin-top:15px; font-size:14px; color:#9ca3af; }
    </style>
</head>
<body>

    <div class="page-container">
        <header style="background:white; padding:20px 50px; display:flex; justify-content:space-between; align-items:center; box-shadow:0 2px 20px rgba(0,0,0,.05);">
            <h2 style="color:#2563eb; margin: 0;">CheatSheet Hub</h2>
            <nav style="display:flex; gap:25px;">
                <a href="${pageContext.request.contextPath}/" style="text-decoration:none; color:#334155; font-weight:600;">Home</a>
                <a href="${pageContext.request.contextPath}/admin/cheatsheet/create" style="text-decoration:none; color:#334155; font-weight:600;">Create Cheatsheet</a>
                <a href="${pageContext.request.contextPath}/admin/profile" style="text-decoration:none; color:#334155; font-weight:600;">Profile</a>
            </nav>
        </header>

        <div class="page-wrapper">
            <jsp:include page="/WEB-INF/views/sidebar.jsp" />
            
            <div class="main-workspace">
                <div class="workspace-card">
                    
                    <div class="top-header-row">
                        <div class="search-wrapper">
                            <div class="input-group">
                                <input type="text" id="userInputSearch" class="form-control search-input" placeholder="Search by name... (min 2 chars)" autocomplete="off">
                                <button class="btn search-btn" type="button" id="searchBtn">
                                    <i class="fa-solid fa-magnifying-glass"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                    
                    <div class="blue-header-box">
                        <div class="table-title">User Management</div>
                        <div class="table-subtitle">Manage system user accounts, roles, and status configurations.</div>
                    </div>
                    
                    <div class="column-nav-tabs">
                        <button class="nav-col-btn active btn-admins-tab" onclick="switchRoleTab('admins')">
                            <i class="fa-solid fa-user-shield"></i>ADMINISTRATOR
                        </button>
                        <button class="nav-col-btn btn-users-tab" onclick="switchRoleTab('users')">
                            <i class="fa-solid fa-users"></i>REGULAR USER
                        </button>
                    </div>
                    
                    <div class="role-content-pane active" id="paneAdmins">
                        <div class="account-list-container">
                            <c:forEach var="user" items="${users}">
                                <c:if test="${user.role eq 'ADMIN' || user.role eq 'MODERATOR'}">
                                    <a href="${pageContext.request.contextPath}/usermanagement/profile/${user.id}" class="account-card-link user-card-item" data-name="${user.name.toLowerCase()}">
                                        <div class="account-horizontal-box">
                                            <div class="box-left-section">
                                                <c:choose>
                                                    <c:when test="${not empty user.profileImg}">
                                                        <img src="${user.profileImg.startsWith('/') && !user.profileImg.startsWith(pageContext.request.contextPath) ? pageContext.request.contextPath : ''}${user.profileImg}" class="box-avatar"/>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img src="${pageContext.request.contextPath}/resources/images/default-avatar.png" class="box-avatar"/>
                                                    </c:otherwise>
                                                </c:choose>
                                                
                                                <div class="box-details-grid">
                                                    <div class="box-name"><c:out value="${user.name}"/></div>
                                                    <div class="box-email" title="${user.email}"><c:out value="${user.email}"/></div>
                                                    <div class="badge-wrapper">
                                                        <span class="role-badge ${user.role eq 'ADMIN' ? 'role-admin' : 'role-moderator'}">${user.role}</span>
                                                    </div>
                                                    <div class="badge-wrapper">
                                                        <span class="status-badge ${user.status eq 'ACTIVE' ? 'status-active' : (user.status eq 'INACTIVE' ? 'status-inactive' : 'status-banned')}">${user.status}</span>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <div class="account-actions" onclick="event.preventDefault();">
                                                <c:choose>
                                                    <c:when test="${user.id eq sessionScope.loginUser.id || user.id eq sessionScope.currentUser.id}">
                                                        <span class="current-user-badge"><i class="fa-solid fa-user-check"></i> You</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:choose>
                                                            <c:when test="${user.status ne 'BANNED'}">
                                                                <form action="${pageContext.request.contextPath}/usermanagement/ban/${user.id}" method="POST" onsubmit="return confirm('Are you sure you want to ban this admin?');">
                                                                    <button type="submit" class="btn btn-action btn-ban"><i class="fa-solid fa-ban"></i> Ban</button>
                                                                </form>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <form action="${pageContext.request.contextPath}/usermanagement/unban/${user.id}" method="POST">
                                                                    <button type="submit" class="btn btn-action btn-unban"><i class="fa-solid fa-circle-check"></i> Unban</button>
                                                                </form>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <form action="${pageContext.request.contextPath}/usermanagement/delete/${user.id}" method="POST" onsubmit="return confirm('Danger! Delete this account permanently?');">
                                                            <button type="submit" class="btn btn-action btn-delete" title="Delete Account"><i class="fa-solid fa-trash-can"></i></button>
                                                        </form>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </a>
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>
                    
                    <div class="role-content-pane" id="paneUsers">
                        <div class="account-list-container">
                            <c:forEach var="user" items="${users}">
                                <c:if test="${user.role ne 'ADMIN' && user.role ne 'MODERATOR'}">
                                    <a href="${pageContext.request.contextPath}/usermanagement/profile/${user.id}" class="account-card-link user-card-item" data-name="${user.name.toLowerCase()}">
                                        <div class="account-horizontal-box">
                                            <div class="box-left-section">
                                                <c:choose>
                                                    <c:when test="${not empty user.profileImg}">
                                                        <img src="${user.profileImg.startsWith('/') && !user.profileImg.startsWith(pageContext.request.contextPath) ? pageContext.request.contextPath : ''}${user.profileImg}" class="box-avatar"/>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img src="${pageContext.request.contextPath}/resources/images/default-avatar.png" class="box-avatar"/>
                                                    </c:otherwise>
                                                </c:choose>
                                                
                                                <div class="box-details-grid">
                                                    <div class="box-name"><c:out value="${user.name}"/></div>
                                                    <div class="box-email" title="${user.email}"><c:out value="${user.email}"/></div>
                                                    <div class="badge-wrapper">
                                                        <span class="role-badge role-user">USER</span>
                                                    </div>
                                                    <div class="badge-wrapper">
                                                        <span class="status-badge ${user.status eq 'ACTIVE' ? 'status-active' : (user.status eq 'INACTIVE' ? 'status-inactive' : 'status-banned')}">${user.status}</span>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <div class="account-actions" onclick="event.preventDefault();">
                                                <c:choose>
                                                    <c:when test="${user.id eq sessionScope.loginUser.id || user.id eq sessionScope.currentUser.id}">
                                                        <span class="current-user-badge"><i class="fa-solid fa-user-check"></i> You</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:choose>
                                                            <c:when test="${user.status ne 'BANNED'}">
                                                                <form action="${pageContext.request.contextPath}/usermanagement/ban/${user.id}" method="POST" onsubmit="return confirm('Are you sure you want to ban this user?');">
                                                                    <button type="submit" class="btn btn-action btn-ban"><i class="fa-solid fa-ban"></i> Ban</button>
                                                                </form>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <form action="${pageContext.request.contextPath}/usermanagement/unban/${user.id}" method="POST">
                                                                    <button type="submit" class="btn btn-action btn-unban"><i class="fa-solid fa-circle-check"></i> Unban</button>
                                                                </form>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <form action="${pageContext.request.contextPath}/usermanagement/delete/${user.id}" method="POST" onsubmit="return confirm('Danger! Delete this account permanently?');">
                                                            <button type="submit" class="btn btn-action btn-delete" title="Delete Account"><i class="fa-solid fa-trash-can"></i></button>
                                                        </form>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </a>
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>
                    
                    <c:if test="${totalPages >= 1}">
                        <nav class="d-flex justify-content-center">
                            <ul class="pagination">
                                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                    <a class="page-link" href="?page=${currentPage - 1}&size=10"><i class="fa-solid fa-chevron-left"></i></a>
                                </li>
                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                                        <c:choose>
                                            <c:when test="${currentPage == i}">
                                                <a class="page-link" href="javascript:void(0);">${i}</a>
                                            </c:when>
                                            <c:otherwise>
                                                <a class="page-link" href="?page=${i}&size=10">${i}</a>
                                            </c:otherwise>
                                        </c:choose>
                                    </li>
                                </c:forEach>
                                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                    <a class="page-link" href="?page=${currentPage + 1}&size=10"><i class="fa-solid fa-chevron-right"></i></a>
                                </li>
                            </ul>
                        </nav>
                    </c:if>
                    
                </div>
            </div>
        </div>

        <footer class="site-footer">
            <div class="footer-container">
                <h3>CheatSheet Hub</h3>
                <p>Learn Faster. Share Knowledge. Build Better.</p>
                <p class="copyright">© 2026 CheatSheet Hub. All Rights Reserved.</p>
            </div>
        </footer>
    </div>

    <script>
        function switchRoleTab(targetRole) {
            const btnAdmins = document.querySelector(".btn-admins-tab");
            const btnUsers = document.querySelector(".btn-users-tab");
            const paneAdmins = document.getElementById("paneAdmins");
            const paneUsers = document.getElementById("paneUsers");
            const searchInput = document.getElementById("userInputSearch");

            searchInput.value = "";
            const userCards = document.querySelectorAll(".user-card-item");
            userCards.forEach(card => card.classList.remove("search-disabled"));

            if (targetRole === 'admins') {
                btnAdmins.classList.add("active");
                btnUsers.classList.remove("active");
                paneAdmins.classList.add("active");
                paneUsers.classList.remove("active");
            } else {
                btnUsers.classList.add("active");
                btnAdmins.classList.remove("active");
                paneUsers.classList.add("active");
                paneAdmins.classList.remove("active");
            }
        }

        document.addEventListener("DOMContentLoaded", function() {
            const searchInput = document.getElementById("userInputSearch");

            function performFilter() {
                const query = searchInput.value.trim().toLowerCase();
                const activePaneCards = document.querySelectorAll(".role-content-pane.active .user-card-item");

                activePaneCards.forEach(card => {
                    const nameAttr = card.getAttribute("data-name") || "";
                    
                    if (query.length >= 2) {
                        if (nameAttr.includes(query)) {
                            card.classList.remove("search-disabled");
                        } else {
                            card.classList.add("search-disabled");
                        }
                    } else {
                        card.classList.remove("search-disabled");
                    }
                });
            }
            searchInput.addEventListener("input", performFilter);
        });
    </script>
</body>
</html>