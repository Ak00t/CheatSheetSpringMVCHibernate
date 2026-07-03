<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Collections</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background-color: #f8fafc; font-family: 'Segoe UI', sans-serif; color: #1e293b; }
        .page-header { margin-top: 40px; margin-bottom: 30px; }
        .playlist-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(320px, 1fr)); gap: 25px; margin-bottom: 35px; }
        .playlist-card { background-color: #ffffff; border-radius: 24px; overflow: hidden; text-decoration: none; color: #1e293b !important; box-shadow: 0 10px 25px rgba(15, 23, 42, 0.03); border: 1px solid #e2e8f0; padding: 26px; display: flex; flex-direction: column; min-height: 220px; position: relative; transition: transform 0.4s cubic-bezier(0.16, 1, 0.3, 1), box-shadow 0.4s cubic-bezier(0.16, 1, 0.3, 1); cursor: pointer; }
        .playlist-card:hover { transform: translateY(-6px); box-shadow: 0 20px 35px rgba(15, 23, 42, 0.08); }
        .card-overlay { position: absolute; top: 0; left: 0; width: 100%; height: 100%; background: rgba(15, 23, 42, 0.4); backdrop-filter: blur(4px); display: flex; align-items: center; justify-content: center; gap: 15px; opacity: 0; transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1); pointer-events: none; }
        .playlist-card:hover .card-overlay, .playlist-card:active .card-overlay { opacity: 1; pointer-events: auto; }
        .playlist-card:active { opacity: 0.85; filter: brightness(0.92); }
        .overlay-btn { transform: scale(0.8); transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1); border-radius: 12px; font-weight: 600; padding: 10px 18px; }
        .playlist-card:hover .overlay-btn { transform: scale(1); }
        .visibility-badge { display: inline-block; padding: 6px 14px; border-radius: 999px; font-size: 11px; font-weight: 800; margin-bottom: 16px; align-self: flex-start; text-transform: uppercase; }
        .badge-public { background: #e0f2fe; color: #2563eb; }
        .badge-private { background: #fee2e2; color: #ef4444; }
        .badge-unlisted { background: #f1f5f9; color: #64748b; }
        .playlist-title { font-size: 23px; font-weight: 900; margin-bottom: 10px; line-height: 1.35; color: #0f172a; }
        .playlist-footer { margin-top: auto; padding-top: 14px; border-top: 1px solid #f1f5f9; font-size: 13px; color: #64748b; font-weight: 500; }
        .pagination .page-link { color: #475569; border-radius: 10px; margin: 0 3px; border: 1px solid #e2e8f0; font-weight: 600; transition: all 0.2s; }
        .pagination .page-item.active .page-link { background-color: #2563eb; border-color: #2563eb; color: white; }
        .pagination .page-link:hover { background-color: #f1f5f9; color: #2563eb; }
    </style>
</head>
<body>

<jsp:include page="header.jsp"/>

<div class="container">
    
    <div class="d-flex justify-content-between align-items-center page-header">
        <div>
            <h2 class="fw-bold m-0 text-dark">
                <i class="bi bi-folder-fill text-warning me-2"></i> My Collections
            </h2>
            <p class="text-muted m-0 mt-1">Manage your custom folders and cheat sheet groups</p>
        </div>
        <a href="${pageContext.request.contextPath}/profile/${sessionScope.currentUser.id}" class="btn btn-outline-secondary btn-sm rounded-3 px-3 fw-semibold shadow-sm">
            <i class="bi bi-arrow-left"></i> Profile
        </a>
    </div>

    <c:choose>
        <c:when test="${not empty collections}">
            <div class="playlist-grid">
                <c:forEach items="${collections}" var="playlist">
                    
                    <div class="playlist-card">
                        <div class="visibility-badge ${playlist.visibility == 'PUBLIC' ? 'badge-public' : (playlist.visibility == 'PRIVATE' ? 'badge-private' : 'badge-unlisted')}">
                            <i class="bi ${playlist.visibility == 'PUBLIC' ? 'bi-globe' : (playlist.visibility == 'PRIVATE' ? 'bi-lock-fill' : 'bi-eye-slash-fill')}"></i> 
                            ${playlist.visibility}
                        </div>
                        
                        <h3 class="playlist-title">${playlist.name}</h3>
                        
                        <div class="playlist-footer d-flex justify-content-between align-items-center">
                            <span><i class="bi bi-folder-symlink-fill me-1 text-secondary"></i> Collection</span>
                            <span><i class="bi bi-file-earmark-code-fill text-primary"></i> ${playlist.items.size()} Sheets</span>
                        </div>

                        <div class="card-overlay">
                            <a href="${pageContext.request.contextPath}/collection/view/${playlist.id}" class="btn btn-light overlay-btn shadow-sm text-primary">
                                <i class="bi bi-folder2-open me-1"></i> Open
                            </a>
                            
                            <div class="dropdown d-inline-block">
                                <button class="btn btn-dark overlay-btn dropdown-toggle" data-bs-toggle="dropdown">
                                    <i class="bi bi-shield-lock-fill me-1"></i> Privacy
                                </button>
                                <ul class="dropdown-menu shadow border-0 p-2" style="border-radius: 10px;">
                                    <li><button onclick="changeVisibility('${playlist.id}', 'PUBLIC')" class="dropdown-item small py-2 fw-semibold text-primary"><i class="bi bi-globe me-1"></i> Public</button></li>
                                    <li><button onclick="changeVisibility('${playlist.id}', 'PRIVATE')" class="dropdown-item py-2 fw-semibold text-danger"><i class="bi bi-lock-fill me-1"></i> Private</button></li>
                                    <li><button onclick="changeVisibility('${playlist.id}', 'UNLISTED')" class="dropdown-item py-2 fw-semibold text-secondary"><i class="bi bi-eye-slash-fill me-1"></i> Unlisted</button></li>
                                </ul>
                            </div>
                        </div>
                    </div>

                </c:forEach>
            </div>

            <nav aria-label="Page navigation" class="d-flex justify-content-center my-5">
                <ul class="pagination shadow-sm p-1 bg-white rounded-3">
                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                        <a class="page-link py-2 px-3 d-flex align-items-center gap-1" href="?page=${currentPage - 1}">
                            <i class="bi bi-chevron-left"></i> Previous
                        </a>
                    </li>
                    <li class="page-item active">
                        <span class="page-link py-2 px-3">${not empty currentPage ? currentPage : 1}</span>
                    </li>
                    <li class="page-item ${hasMorePages == false ? 'disabled' : ''}">
                        <a class="page-link py-2 px-3 d-flex align-items-center gap-1" href="?page=${currentPage + 1}">
                            Next <i class="bi bi-chevron-right"></i>
                        </a>
                    </li>
                </ul>
            </nav>

        </c:when>
        <c:otherwise>
            <div class="text-center py-5 bg-white rounded-4 shadow-sm border my-4">
                <i class="bi bi-folder-plus text-muted" style="font-size: 4rem;"></i>
                <h4 class="fw-bold mt-3 text-secondary">No Collections Created</h4>
                <p class="text-muted">Start grouping cheat sheets into custom collections!</p>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script>
function changeVisibility(id, statusStr) {
    fetch('${pageContext.request.contextPath}/collection/update-visibility', {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: 'collectionId=' + id + '&visibility=' + statusStr
    })
    .then(res => {
        if(res.ok) {
            alert("Collection privacy preference updated successfully!");
            location.reload(); 
        } else {
            alert("Server returned an error.");
        }
    })
    .catch(() => alert("Error syncing visibility changes."));
}
</script>
</body>
</html>