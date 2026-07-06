<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head> 
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DevNote - User Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
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
        .page-wrapper { display: flex; padding: 24px; gap: 24px; align-items: flex-start; flex: 1; }
        .main-workspace { flex-grow: 1; min-width: 0; }
        .workspace-card { background-color: #ffffff; border-radius: 24px; padding: 32px; box-shadow: var(--shadow-premium); border: 1px solid rgba(226, 232, 240, 0.8); }
        
        .top-header-row { display: flex; justify-content: flex-end; align-items: center; margin-bottom: 20px; }
        .search-wrapper { max-width: 380px; width: 100%; }
        .search-input { border-radius: 12px 0 0 12px !important; border: 1px solid var(--border-light); padding: 11px 16px; font-size: 14px; background-color: #f8fafc; }
        .search-btn { border-radius: 0 12px 12px 0 !important; background-color: var(--brand-blue); border-color: var(--brand-blue); color: #ffffff; padding: 0 20px; }
        
        .blue-header-box { background: linear-gradient(135deg, #1e40af, #2563eb); color: #ffffff; padding: 28px 32px; border-radius: 20px; margin-bottom: 28px; }
        .table-title { font-weight: 800; font-size: 26px; color: #ffffff; }
        .table-subtitle { font-size: 14px; color: #bfdbfe; }
        
        .account-list-container { display: flex; flex-direction: column; gap: 12px; }
        .user-card-item { display: block; }
        .user-card-item.search-disabled { display: none !important; }
        
        .account-horizontal-box { background-color: #ffffff; border: 1px solid var(--border-light); border-radius: 14px; padding: 14px 18px; display: flex; align-items: center; justify-content: space-between; box-shadow: var(--shadow-card); }
        .box-left-section { display: flex; align-items: center; gap: 24px; flex-grow: 1; min-width: 0; }
        
        /* Premium Avatar Placeholder Styles */
        .box-avatar { width: 44px; height: 44px; border-radius: 10px; object-fit: cover; border: 1px solid var(--border-light); }
        .box-avatar-text { width: 44px; height: 44px; border-radius: 10px; background: linear-gradient(135deg, #3b82f6, #1d4ed8); color: #ffffff; display: flex; align-items: center; justify-content: center; font-weight: 700; font-size: 16px; border: 1px solid var(--border-light); text-transform: uppercase; }
        
        .box-details-grid { display: grid; grid-template-columns: 200px 260px 120px 120px; gap: 16px; align-items: center; }
        .box-name { font-weight: 700; font-size: 15px; }
        .box-email { color: var(--text-gray); font-size: 14px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
        
        .role-badge { font-size: 11px; font-weight: 700; padding: 4px 10px; border-radius: 8px; min-width: 85px; text-align: center; display: inline-block; }
        .role-user { background-color: var(--brand-light); color: var(--brand-green); }
        
        .status-badge { font-size: 11px; font-weight: 600; padding: 4px 10px; border-radius: 8px; min-width: 85px; text-align: center; display: inline-block; }
        .status-active { background-color: #ecfdf5; color: #10b981; }
        .status-inactive { background-color: #f1f5f9; color: #64748b; }
        .status-banned { background-color: #fff1f2; color: #f43f5e; }
        
        .account-actions { display: flex; align-items: center; gap: 8px; }
        .btn-action { padding: 7px 14px; font-size: 13px; font-weight: 700; border-radius: 8px; border: none; cursor: pointer; display: inline-flex; align-items: center; gap: 6px; transition: all 0.2s; }
        .btn-ban { background-color: #fff1f2; color: #e11d48; border: 1px solid #ffe4e6; }
        .btn-ban:hover { background-color: #ffe4e6; }
        .btn-unban { background-color: #f0fdf4; color: #16a34a; border: 1px solid #dcfce7; }
        .btn-unban:hover { background-color: #dcfce7; }
        
        .pagination-container { display: flex; justify-content: center; gap: 8px; margin-top: 25px; padding-bottom: 20px; }
        .page-btn { padding: 6px 14px; border: 1px solid var(--border-light); border-radius: 8px; cursor: pointer; background: white; font-weight: 600; color: var(--text-gray); }
        .page-btn.active { background: var(--brand-blue); color: white; border-color: var(--brand-blue); }
    </style>
</head>
<body>
    <div class="page-container">
        <!-- Header -->
        <header style="background:white; padding:20px 50px; display:flex; justify-content:space-between; align-items:center; box-shadow:0 2px 20px rgba(0,0,0,.05);">
            <h2 style="color:#2563eb; margin: 0;">CheatSheet Hub</h2>
            <nav style="display:flex; align-items:center; gap:25px;">
                <a href="${pageContext.request.contextPath}/admin/profile" style="text-decoration:none; color:#334155; font-weight: 600;">Profile</a>
            </nav>
        </header>

        <div class="page-wrapper">
            <!-- Sidebar -->
            <jsp:include page="/WEB-INF/views/sidebar.jsp" />

            <!-- Main Workspace -->
            <div class="main-workspace">
                <div class="workspace-card">
                    <div class="top-header-row">
                        <div class="search-wrapper">
                            <div class="input-group">
                                <input type="text" id="userInputSearch" class="form-control search-input" placeholder="Search regular users...">
                                <button class="btn search-btn" type="button"><i class="fa-solid fa-magnifying-glass"></i></button>
                            </div>
                        </div>
                    </div>
                    
                    <div class="blue-header-box">
                        <div class="table-title">User Management</div>
                        <div class="table-subtitle">Manage system regular user accounts, tracking activities, and restriction criteria rules.</div>
                    </div>
                    
                    <!-- Regular Users List -->
                    <div class="role-content-pane active" id="paneUsers">
                        <div class="account-list-container">
                            <c:forEach var="user" items="${users}">
                                <c:if test="${user.role ne 'ADMIN' && user.role ne 'MODERATOR'}">
                                    <div class="user-card-item" data-name="${user.name.toLowerCase()}">
                                        <div class="account-horizontal-box">
                                            <div class="box-left-section">
                                                
                                                <!-- Fixed Image Route mapping from spring xml settings -->
                                                <c:choose>
                                                    <c:when test="${not empty user.profileImg}">
                                                        <c:choose>
                                                            <c:when test="${fn:startsWith(user.profileImg, 'http')}">
                                                                <img src="${user.profileImg}" class="box-avatar" alt="Profile" />
                                                            </c:when>
                                                            <c:otherwise>
                                                                <!-- Spring XML configuration mapping အရ /uploads/profiles/ သို့ ပြောင်းလဲပြင်ဆင်ထားပါသည် -->
                                                                <img src="${pageContext.request.contextPath}/uploads/profiles/${user.profileImg}" 
                                                                     onerror="this.style.display='none'; document.getElementById('text-avatar-${user.id}').style.display='flex';"
                                                                     class="box-avatar" alt="Profile" />
                                                                <div id="text-avatar-${user.id}" class="box-avatar-text" style="display:none;">
                                                                    <c:out value="${fn:substring(user.name, 0, 1)}"/>
                                                                </div>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="box-avatar-text">
                                                            <c:out value="${fn:substring(user.name, 0, 1)}"/>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                                
                                                <div class="box-details-grid">
                                                    <div class="box-name"><c:out value="${user.name}"/></div>
                                                    <div class="box-email"><c:out value="${user.email}"/></div>
                                                    <span class="role-badge role-user">USER</span>
                                                    <span class="status-badge ${user.status eq 'ACTIVE' ? 'status-active' : (user.status eq 'INACTIVE' ? 'status-inactive' : 'status-banned')}">${user.status}</span>
                                                </div>
                                            </div>
                                            
                                            <!-- Action Controller Forms -->
                                            <div class="account-actions">
                                                <c:choose>
                                                    <c:when test="${user.status eq 'BANNED'}">
                                                        <form action="${pageContext.request.contextPath}/usermanagement/unban/${user.id}" method="POST" style="margin: 0;">
                                                            <button type="submit" class="btn-action btn-unban">
                                                                <i class="fa-solid fa-unlock"></i> Unban
                                                            </button>
                                                        </form>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <form action="${pageContext.request.contextPath}/usermanagement/ban/${user.id}" method="POST" style="margin: 0;">
                                                            <button type="submit" class="btn-action btn-ban">
                                                                <i class="fa-solid fa-ban"></i> Ban User
                                                            </button>
                                                        </form>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>
                    
                    <div id="paginationControls" class="pagination-container"></div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        const itemsPerPage = 10;
        let currentPage = 1;

        function updatePagination() {
            const pane = document.getElementById('paneUsers');
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