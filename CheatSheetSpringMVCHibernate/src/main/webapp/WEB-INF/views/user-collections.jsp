<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
        
        .playlist-card { 
            background-color: #ffffff; border-radius: 24px; overflow: hidden; 
            color: #1e293b !important; box-shadow: 0 10px 25px rgba(15, 23, 42, 0.03); 
            border: 1px solid #e2e8f0; padding: 26px; display: flex; flex-direction: column; 
            min-height: 220px; position: relative; 
            transition: transform 0.4s cubic-bezier(0.16, 1, 0.3, 1), box-shadow 0.4s cubic-bezier(0.16, 1, 0.3, 1); 
        }
        .playlist-card:hover { transform: translateY(-6px); box-shadow: 0 20px 35px rgba(15, 23, 42, 0.08); }
        
        /* Overlay Logic */
        .card-overlay { 
            position: absolute; bottom: 0; left: 0; width: 100%; height: 60%; 
            background: linear-gradient(to top, rgba(15, 23, 42, 0.4), rgba(15, 23, 42, 0)); 
            backdrop-filter: blur(2px); display: flex; align-items: center; justify-content: center; 
            gap: 10px; opacity: 0; transition: all 0.3s ease; pointer-events: none; z-index: 2; 
        }
        .playlist-card:hover .card-overlay { opacity: 1; pointer-events: auto; }
        
        .overlay-btn { transform: scale(0.8); transition: all 0.3s; border-radius: 12px; font-weight: 600; padding: 10px 14px; }
        .playlist-card:hover .overlay-btn { transform: scale(1); }
        
        .visibility-badge { display: inline-flex; align-items: center; gap: 6px; padding: 6px 14px; border-radius: 999px; font-size: 11px; font-weight: 800; text-transform: uppercase; }
        .badge-public { background: #e0f2fe; color: #2563eb; }
        .badge-private { background: #fee2e2; color: #ef4444; }
        .badge-unlisted { background: #f1f5f9; color: #64748b; }
        
        .playlist-title { font-size: 23px; font-weight: 900; margin-bottom: 10px; line-height: 1.35; color: #0f172a; margin-top: 5px; }
        .playlist-footer { margin-top: auto; padding-top: 14px; border-top: 1px solid #f1f5f9; font-size: 13px; color: #64748b; font-weight: 500; padding-bottom: 30px; }
        
        .pagination .page-link { color: #475569; border-radius: 10px; margin: 0 3px; border: 1px solid #e2e8f0; font-weight: 600; transition: all 0.2s; }
        .pagination .page-item.active .page-link { background-color: #2563eb; border-color: #2563eb; color: white; }
        
        .card-top-bar { position: relative; z-index: 10; pointer-events: auto; }
        .dropdown-menu { z-index: 1070 !important; }
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
                        
                        <div class="d-flex justify-content-between align-items-center card-top-bar mb-3" onclick="event.stopPropagation();">
                            <div class="visibility-badge ${playlist.visibility == 'PUBLIC' ? 'badge-public' : (playlist.visibility == 'PRIVATE' ? 'badge-private' : 'badge-unlisted')}">
                                <i class="bi ${playlist.visibility == 'PUBLIC' ? 'bi-globe' : (playlist.visibility == 'PRIVATE' ? 'bi-lock-fill' : 'bi-eye-slash-fill')}"></i> 
                                ${playlist.visibility}
                            </div>
                            
                            <div class="dropdown" onclick="event.stopPropagation();">
                                <button class="btn btn-sm btn-light border shadow-none rounded-pill px-3 fw-bold text-secondary d-flex align-items-center gap-1" 
                                        type="button" data-bs-toggle="dropdown" aria-expanded="false" style="font-size: 12px; height: 28px;">
                                    <i class="bi bi-pencil-square text-primary"></i> Privacy
                                </button>
                                <ul class="dropdown-menu dropdown-menu-end shadow border-0 p-2 mt-1" style="border-radius: 12px;">
                                    <li><button type="button" onclick="event.stopPropagation(); changeVisibility('${playlist.id}', 'PUBLIC')" class="dropdown-item small py-2 fw-semibold text-primary"><i class="bi bi-globe me-1"></i> Public</button></li>
                                    <li><button type="button" onclick="event.stopPropagation(); changeVisibility('${playlist.id}', 'PRIVATE')" class="dropdown-item py-2 fw-semibold text-danger"><i class="bi bi-lock-fill me-1"></i> Private</button></li>
                                    
                                </ul>
                            </div>
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
                            
                            <button type="button" onclick="confirmDeleteCollection('${playlist.id}', '${playlist.name}')" class="btn btn-danger overlay-btn" style="padding: 10px 14px;">
                                <i class="bi bi-trash3-fill"></i> Delete
                            </button>
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

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

function confirmDeleteCollection(id, name) {
    if (confirm("Yo! '" + name + "' Are you sure you want to delete this custom folder? All files and data contained within it will be permanently removed")) {
        fetch('${pageContext.request.contextPath}/collection/delete', {
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            body: 'collectionId=' + id
        })
        .then(res => res.text())
        .then(data => {
            if (data === "Success") {
                alert("Collection deleted successfully!");
                location.reload();
            } else if (data === "Forbidden") {
                alert("Access Denied! You do not own this collection.");
            } else {
                alert("Failed to delete collection context mapping.");
            }
        })
        .catch(() => alert("Network error synchronization failed."));
    }
}
</script>
</body>
</html>