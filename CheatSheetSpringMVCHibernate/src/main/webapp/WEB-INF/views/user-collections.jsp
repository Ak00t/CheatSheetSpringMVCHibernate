<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Collections</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
    
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
            <p class="text-muted m-0 mt-1"></p>
        </div>
        <a href="${pageContext.request.contextPath}/profile/${sessionScope.currentUser.id}" class="btn btn-outline-secondary btn-sm rounded-3 px-3 fw-semibold shadow-sm">
            <i class="bi bi-arrow-left"></i> Profile
        </a>
    </div>

    <c:choose>
        <c:when test="${not empty collections}">
            <div class="playlist-grid">
                <c:forEach items="${collections}" var="playlist">
                    
                    <div class="playlist-card" id="card-${playlist.id}">
                        
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
                        
                        <h3 class="playlist-title" style="cursor: pointer;" ondblclick="openEditModal('${playlist.id}', '${playlist.name}')">
                            ${playlist.name}
                        </h3>
                        
                        <div class="playlist-footer d-flex justify-content-between align-items-center">
                            <span><i class="bi bi-folder-symlink-fill me-1 text-secondary"></i> Collection</span>
                            <span><i class="bi bi-file-earmark-code-fill text-primary"></i> ${playlist.items.size()} Sheets</span>
                        </div>

                        <div class="card-overlay">
                            <a href="${pageContext.request.contextPath}/collection/view/${playlist.id}" class="btn btn-light overlay-btn shadow-sm text-primary">
                                <i class="bi bi-folder2-open me-1"></i> Open
                            </a>
                            <button type="button" onclick="event.stopPropagation(); openEditModal('${playlist.id}', '${fn:escapeXml(playlist.name)}')" class="btn btn-warning overlay-btn text-dark">
        <i class="bi bi-pencil-square me-1"></i> Rename
    </button>
                            <button type="button" onclick="confirmDeleteCollection('${playlist.id}', '${playlist.name}')" class="btn btn-danger overlay-btn" style="padding: 10px 14px;">
                                <i class="bi bi-trash3-fill"></i> Delete
                            </button>
                        </div>
                    </div>

                </c:forEach>
            </div>
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

<div class="modal fade" id="editCollectionModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" style="max-width: 380px;">
        <div class="modal-content border-0" style="border-radius: 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.15);">
            <div class="modal-header border-0 pb-0 pt-4 px-4">
                <h5 class="modal-title fw-bold text-dark"><i class="bi bi-pencil-square text-success me-2"></i>Rename Folder</h5>
                <button type="button" class="btn-close shadow-none" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body p-4">
                <input type="hidden" id="editCollectionId">
                <div class="mb-4">
                    <label class="form-label small fw-bold text-secondary">Collection Name</label>
                    <input type="text" id="editCollectionName" class="form-control py-2" style="border-radius: 10px;" required>
                </div>
                <button type="button" onclick="submitRenameCollection()" class="btn btn-primary w-100 fw-bold py-2 rounded-3" style="background-color: #2563eb; border: none;">
                    Save Changes
                </button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
let editModalInstance = null;

//💡 Context Path နဲ့ CSRF ကို JSP က မရိပ်မိအောင် String ရိုးရိုးပဲ ယူထားပါတယ်
const contextPath = "${pageContext.request.contextPath}";
const csrfToken = document.querySelector("meta[name='_csrf']")?.getAttribute("content");
const csrfHeader = document.querySelector("meta[name='_csrf_header']")?.getAttribute("content");

function openEditModal(id, currentName) {
 document.getElementById('editCollectionId').value = id;
 document.getElementById('editCollectionName').value = currentName;
 const modalEl = document.getElementById('editCollectionModal');
 if (!editModalInstance) {
     editModalInstance = new bootstrap.Modal(modalEl);
 }
 editModalInstance.show();
}

//🌟 [RENAME SCRIPT FIX]: UI တန်းပြောင်းပြီး Backtick error ရှင်းထားပါတယ်
function submitRenameCollection() {
 const id = document.getElementById('editCollectionId').value;
 const name = document.getElementById('editCollectionName').value.trim();
 
 if (!name) return alert("Collection name cannot be empty!");

 const headers = { 'Content-Type': 'application/x-www-form-urlencoded' };
 if (csrfHeader && csrfToken) headers[csrfHeader] = csrfToken;

 // 💡 Backtick နေရာမှာ ရိုးရိုး String concatenation (+) ပြောင်းလဲလိုက်ပါတယ်
 fetch(contextPath + '/collection/update-name', {
     method: 'POST',
     headers: headers,
     body: 'collectionId=' + id + '&name=' + encodeURIComponent(name)
 })
 .then(res => res.text())
 .then(data => {
     if (data.toLowerCase().includes("success")) {
         // Modal ပိတ်မယ်
         if (editModalInstance) {
             editModalInstance.hide();
         } else {
             const modalEl = document.getElementById('editCollectionModal');
             const modal = bootstrap.Modal.getInstance(modalEl);
             if (modal) modal.hide();
         }

         // UI ချက်ချင်းပြောင်းမယ်
         const cardElement = document.getElementById('card-' + id);
         if (cardElement) {
             const titleElement = cardElement.querySelector('.playlist-title');
             if (titleElement) {
                 titleElement.textContent = name;
                 titleElement.setAttribute('ondblclick', "openEditModal('" + id + "', '" + name.replace(/'/g, "\\'") + "')");
             }
         }

         const backdrop = document.querySelector('.modal-backdrop');
         if (backdrop) backdrop.remove();
         document.body.style.overflow = 'auto';

     } else {
         alert("Server Alert: " + data);
     }
 })
 .catch(() => alert("Network synchronization failed."));
}

//🌟 [VISIBILITY SCRIPT FIX]
function changeVisibility(id, statusStr) {
 const headers = { 'Content-Type': 'application/x-www-form-urlencoded' };
 if (csrfHeader && csrfToken) headers[csrfHeader] = csrfToken;

 fetch(contextPath + '/collection/update-visibility', {
     method: 'POST',
     headers: headers,
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
    if (confirm("Yo! '" + name + "' Are you sure you want to delete this custom folder?")) {
        
        const headers = { 'Content-Type': 'application/x-www-form-urlencoded' };
        if (csrfHeader && csrfToken) headers[csrfHeader] = csrfToken;

        fetch('${pageContext.request.contextPath}/collection/delete', {
            method: 'POST',
            headers: headers,
            body: 'collectionId=' + id 
        })
        .then(res => res.text())
        .then(data => {
           
            if (data.toLowerCase().includes("success")) {
                
                const cardElement = document.getElementById('card-' + id);
                if (cardElement) {
                    
                    cardElement.style.transition = "all 0.4s cubic-bezier(0.16, 1, 0.3, 1)";
                    cardElement.style.opacity = "0";
                    cardElement.style.transform = "scale(0.8) translateY(20px)";
                    
                    setTimeout(() => {
                        cardElement.remove();
                        
                        
                        const remainingCards = document.querySelectorAll('.playlist-card');
                        if (remainingCards.length === 0) {
                            location.reload(); 
                        }
                    }, 400); 
                }
                
            } else {
                alert("Failed to delete: " + data);
            }
        })
        .catch((err) => {
            console.error(err);
            alert("Network error occurred.");
        });
    }
}
</script>
</body>
</html>