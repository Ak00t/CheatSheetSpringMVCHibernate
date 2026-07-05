<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>DevNote - User Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root { --bg-canvas: #f4fbfc; --brand-green: #047857; --brand-light: #d1fae5; --brand-blue: #2563eb; --brand-blue-light: #eff6ff; --text-dark: #1e293b; --text-gray: #64748b; --border-light: #e2e8f0; --shadow-premium: 0 20px 25px -5px rgba(0, 0, 0, 0.02), 0 8px 10px -6px rgba(0, 0, 0, 0.02); --shadow-card: 0 4px 6px -1px rgba(0, 0, 0, 0.03), 0 2px 4px -1px rgba(0, 0, 0, 0.02); }
        body { font-family: 'Plus Jakarta Sans', sans-serif; background-color: var(--bg-canvas); margin: 0; color: var(--text-dark); }
        .page-container { display: flex; flex-direction: column; min-height: 100vh; }
        .page-wrapper { display: flex; padding: 28px; gap: 28px; align-items: flex-start; flex: 1; }
        .main-workspace { flex-grow: 1; min-width: 0; }
        .workspace-card { background-color: #ffffff; border-radius: 24px; padding: 32px; box-shadow: var(--shadow-premium); border: 1px solid rgba(226, 232, 240, 0.8); }
        .top-header-row { display: flex; justify-content: flex-end; align-items: center; margin-bottom: 20px; }
        .search-wrapper { max-width: 380px; width: 100%; }
        .search-input { border-radius: 12px 0 0 12px !important; border: 1px solid var(--border-light); padding: 11px 16px; font-size: 14px; background-color: #f8fafc; }
        .search-btn { border-radius: 0 12px 12px 0 !important; background-color: var(--brand-blue); border-color: var(--brand-blue); color: #ffffff; padding: 0 20px; }
        .blue-header-box { background: linear-gradient(135deg, #1e40af, #2563eb); color: #ffffff; padding: 28px 32px; border-radius: 20px; margin-bottom: 28px; }
        .table-title { font-weight: 800; font-size: 26px; color: #ffffff; }
        .table-subtitle { font-size: 14px; color: #bfdbfe; }
        .column-nav-tabs { display: flex; gap: 12px; margin-bottom: 24px; border-bottom: 2px solid var(--border-light); padding-bottom: 8px; }
        .nav-col-btn { background: none; border: none; font-size: 15px; font-weight: 800; text-transform: uppercase; color: var(--text-gray); padding: 8px 20px; border-radius: 10px; cursor: pointer; }
        .nav-col-btn.active.btn-admins-tab { background-color: #fee2e2; color: #ef4444; }
        .nav-col-btn.active.btn-users-tab { background-color: #d1fae5; color: #047857; }
        .role-content-pane { display: none; }
        .role-content-pane.active { display: block; }
        .account-list-container { display: flex; flex-direction: column; gap: 12px; }
        .user-card-item { display: none; } /* Default hidden for pagination */
        .user-card-item.search-disabled { display: none !important; }
        .account-horizontal-box { background-color: #ffffff; border: 1px solid var(--border-light); border-radius: 14px; padding: 14px 18px; display: flex; align-items: center; justify-content: space-between; box-shadow: var(--shadow-card); }
        .box-left-section { display: flex; align-items: center; gap: 24px; flex-grow: 1; min-width: 0; }
        .box-avatar { width: 44px; height: 44px; border-radius: 10px; object-fit: cover; }
        .box-details-grid { display: grid; grid-template-columns: 200px 260px 120px 120px; gap: 16px; align-items: center; }
        .box-name { font-weight: 700; font-size: 15px; }
        .role-badge { font-size: 11px; font-weight: 700; padding: 4px 10px; border-radius: 8px; min-width: 85px; text-align: center; display: inline-block; }
        .role-admin { background-color: #fee2e2; color: #ef4444; }
        .role-moderator { background-color: #fef3c7; color: #d97706; }
        .role-user { background-color: var(--brand-light); color: var(--brand-green); }
        .status-badge { font-size: 11px; font-weight: 600; padding: 4px 10px; border-radius: 8px; min-width: 85px; text-align: center; display: inline-block; }
        .status-active { background-color: #ecfdf5; color: #10b981; }
        .status-inactive { background-color: #f1f5f9; color: #64748b; }
        .status-banned { background-color: #fff1f2; color: #f43f5e; }
        .account-actions { display: flex; align-items: center; gap: 8px; }
        .btn-action { padding: 6px 12px; font-size: 12px; font-weight: 600; border-radius: 8px; border: 1px solid transparent; cursor: pointer; }
        .btn-ban { background-color: #fff7ed; color: #ea580c; }
        .btn-unban { background-color: #f0fdf4; color: #16a34a; }
        .current-user-badge { font-size: 12px; color: var(--brand-blue); background-color: var(--brand-blue-light); padding: 6px 12px; border-radius: 8px; border: 1px dashed var(--brand-blue); }
        /* Pagination CSS */
        .pagination-container { display: flex; justify-content: center; gap: 8px; margin-top: 25px; padding-bottom: 20px; }
        .page-btn { padding: 6px 14px; border: 1px solid var(--border-light); border-radius: 8px; cursor: pointer; background: white; font-weight: 600; color: var(--text-gray); }
        .page-btn.active { background: var(--brand-blue); color: white; border-color: var(--brand-blue); }
    </style>
</head>
<body>
    <div class="page-container">
              <header style="background:white; padding:20px 50px; display:flex; justify-content:space-between; align-items:center; box-shadow:0 2px 20px rgba(0,0,0,.05);">
            <h2 style="color:#2563eb; margin: 0;">CheatSheet Hub</h2>
            <nav style="display:flex; gap:25px;">
         
                <a href="${pageContext.request.contextPath}/admin/profile" style="text-decoration:none; color:#334155; font-weight: 600;">Profile</a>
            </nav>
        </header>
        <div class="page-wrapper">
            <jsp:include page="/WEB-INF/views/sidebar.jsp" />
            <div class="main-workspace">
                <div class="workspace-card">
                    <div class="top-header-row">
                        <div class="search-wrapper">
                            <div class="input-group">
                                <input type="text" id="userInputSearch" class="form-control search-input" placeholder="Search...">
                                <button class="btn search-btn" type="button"><i class="fa-solid fa-magnifying-glass"></i></button>
                            </div>
                        </div>
                    </div>
                    <div class="blue-header-box">
                        <div class="table-title">User Management</div>
                        <div class="table-subtitle">Manage user accounts and statuses.</div>
                    </div>
                    <div class="column-nav-tabs">
                        <button class="nav-col-btn active btn-admins-tab" onclick="switchRoleTab('admins')">ADMINISTRATOR</button>
                        <button class="nav-col-btn btn-users-tab" onclick="switchRoleTab('users')">REGULAR USER</button>
                    </div>
                    
                    <div class="role-content-pane active" id="paneAdmins">
                        <div class="account-list-container">
                            <c:forEach var="user" items="${users}">
                                <c:if test="${user.role eq 'ADMIN' || user.role eq 'MODERATOR'}">
                                    <div class="user-card-item" data-name="${user.name.toLowerCase()}">
                                        <div class="account-horizontal-box">
                                            <div class="box-left-section">
                                                <c:choose>
                                                    <c:when test="${not empty user.profileImg}">
                                                        <c:set var="pathParts" value="${fn:split(user.profileImg, '/')}" />
                                                        <c:set var="fileName" value="${pathParts[fn:length(pathParts)-1]}" />
                                                        <c:url value="/app_uploads/profiles/${fileName}" var="imageUrl" />
                                                        <img src="${imageUrl}" class="box-avatar" onerror="this.onerror=null; this.src='https://ui-avatars.com/api/?name=${fn:replace(user.name, ' ', '+')}&background=random&color=fff';" />
                                                    </c:when>
                                                    <c:otherwise><img src="https://ui-avatars.com/api/?name=${fn:replace(user.name, ' ', '+')}&background=random&color=fff" class="box-avatar" /></c:otherwise>
                                                </c:choose>
                                                <div class="box-details-grid">
                                                    <div class="box-name"><c:out value="${user.name}"/></div>
                                                    <div class="box-email"><c:out value="${user.email}"/></div>
                                                    <span class="role-badge ${user.role eq 'ADMIN' ? 'role-admin' : 'role-moderator'}">${user.role}</span>
                                                    <span class="status-badge ${user.status eq 'ACTIVE' ? 'status-active' : (user.status eq 'INACTIVE' ? 'status-inactive' : 'status-banned')}">${user.status}</span>
                                                </div>
                                            </div>
                                            <div class="account-actions">
                                                <c:choose>
                                                    <c:when test="${user.id eq sessionScope.loginUser.id}"><span class="current-user-badge">You</span></c:when>
                                                    <c:otherwise>
                                                        <c:choose>
                                                            <c:when test="${user.status ne 'BANNED'}">
                                                                <form action="${pageContext.request.contextPath}/usermanagement/ban/${user.id}" method="POST" onsubmit="return confirm('Ban this user?');"><button type="submit" class="btn btn-action btn-ban"><i class="fa-solid fa-ban"></i> Ban</button></form>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <form action="${pageContext.request.contextPath}/usermanagement/unban/${user.id}" method="POST"><button type="submit" class="btn btn-action btn-unban"><i class="fa-solid fa-check"></i> Unban</button></form>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>
                    
                    <div class="role-content-pane" id="paneUsers">
                        <div class="account-list-container">
                            <c:forEach var="user" items="${users}">
                                <c:if test="${user.role ne 'ADMIN' && user.role ne 'MODERATOR'}">
                                    <div class="user-card-item" data-name="${user.name.toLowerCase()}">
                                        <div class="account-horizontal-box">
                                            <div class="box-left-section">
                                                <c:choose>
                                                    <c:when test="${not empty user.profileImg}">
                                                        <c:set var="imagePath" value="${user.profileImg}" />
                                                        <c:if test="${fn:startsWith(imagePath, '/')}"><c:set var="imagePath" value="${fn:substring(imagePath, 1, fn:length(imagePath))}" /></c:if>
                                                        <img src="${pageContext.request.contextPath}/uploads/profiles/${fn:replace(imagePath, ' ', '%20')}" class="box-avatar" onerror="this.onerror=null; this.src='https://ui-avatars.com/api/?name=${fn:replace(user.name, ' ', '+')}&background=random&color=fff';" />
                                                    </c:when>
                                                    <c:otherwise><img src="https://ui-avatars.com/api/?name=${fn:replace(user.name, ' ', '+')}&background=random&color=fff" class="box-avatar" /></c:otherwise>
                                                </c:choose>
                                                <div class="box-details-grid">
                                                    <div class="box-name"><c:out value="${user.name}"/></div>
                                                    <div class="box-email"><c:out value="${user.email}"/></div>
                                                    <span class="role-badge role-user">USER</span>
                                                    <span class="status-badge ${user.status eq 'ACTIVE' ? 'status-active' : (user.status eq 'INACTIVE' ? 'status-inactive' : 'status-banned')}">${user.status}</span>
                                                </div>
                                            </div>
                                            <div class="account-actions">
                                                <c:choose>
                                                    <c:when test="${user.status ne 'BANNED'}">
                                                        <form action="${pageContext.request.contextPath}/usermanagement/ban/${user.id}" method="POST" onsubmit="return confirm('Ban this user?');"><button type="submit" class="btn btn-action btn-ban"><i class="fa-solid fa-ban"></i> Ban</button></form>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <form action="${pageContext.request.contextPath}/usermanagement/unban/${user.id}" method="POST"><button type="submit" class="btn btn-action btn-unban"><i class="fa-solid fa-check"></i> Unban</button></form>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>
                    <!-- Pagination Container -->
                    <div id="paginationControls" class="pagination-container"></div>
                </div>
            </div>
        </div>
    </div>
    <script>
        const itemsPerPage = 10;
        let currentPage = 1;
        let currentRole = 'admins';

        function updatePagination() {
            const paneId = (currentRole === 'admins') ? 'paneAdmins' : 'paneUsers';
            const pane = document.getElementById(paneId);
            const allItems = Array.from(pane.querySelectorAll(".user-card-item")).filter(el => !el.classList.contains('search-disabled'));
            const totalPages = Math.ceil(allItems.length / itemsPerPage);

            pane.querySelectorAll(".user-card-item").forEach(item => item.style.display = 'none');
            const start = (currentPage - 1) * itemsPerPage;
            const end = start + itemsPerPage;
            allItems.slice(start, end).forEach(item => item.style.display = 'block');

            const container = document.getElementById("paginationControls");
            container.innerHTML = "";
            for (let i = 1; i <= totalPages; i++) {
                const btn = document.createElement("button");
                btn.innerText = i;
                btn.className = "page-btn" + (i === currentPage ? " active" : "");
                btn.onclick = () => { currentPage = i; updatePagination(); };
                container.appendChild(btn);
            }
        }

        function switchRoleTab(targetRole) {
            currentRole = targetRole;
            currentPage = 1;
            const btnAdmins = document.querySelector(".btn-admins-tab");
            const btnUsers = document.querySelector(".btn-users-tab");
            const paneAdmins = document.getElementById("paneAdmins");
            const paneUsers = document.getElementById("paneUsers");
            if (targetRole === 'admins') {
                btnAdmins.classList.add("active"); btnUsers.classList.remove("active");
                paneAdmins.classList.add("active"); paneUsers.classList.remove("active");
            } else {
                btnUsers.classList.add("active"); btnAdmins.classList.remove("active");
                paneUsers.classList.add("active"); paneAdmins.classList.remove("active");
            }
            updatePagination();
        }

        document.getElementById("userInputSearch").addEventListener("input", function() {
            const query = this.value.toLowerCase();
            document.querySelectorAll(".user-card-item").forEach(card => {
                const name = card.getAttribute("data-name");
                card.classList.toggle("search-disabled", query.length >= 2 && !name.includes(query));
            });
            currentPage = 1;
            updatePagination();
        });

        window.onload = () => updatePagination();
    </script>
</body>
</html>