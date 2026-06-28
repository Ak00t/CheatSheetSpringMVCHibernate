<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
  <%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${cheatsheet.title} - Cheat Sheet</title>
    
   
    <style>
        body {
            background: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .breadcrumb a {
            color: ${cheatsheet.themeColor != null ? cheatsheet.themeColor : '#b51f55'};
            text-decoration: none;
            font-weight: 600;
        }
        .title span {
            color: ${cheatsheet.themeColor != null ? cheatsheet.themeColor : '#b51f55'};
        }
        .card-title-bar {
            cursor: pointer;
            border-top: 5px solid ${cheatsheet.themeColor != null ? cheatsheet.themeColor : '#b51f55'};
            color: ${cheatsheet.themeColor != null ? cheatsheet.themeColor : '#222'};
        }
        .row-block {
            display: grid;
            grid-template-columns: 1.2fr 1fr 1fr;
            align-items: center;
            gap: 10px;
            padding: 10px 12px;
            border-radius: 4px;
        }
        .row-block:nth-child(odd) { background: #ffffff; }
        .row-block:nth-child(even) { background: rgba(0,0,0,0.02); }
        .cell-key-left { font-weight: 700; color: #111; word-break: break-word; }
        .highlight-box {
            background: #fff8df;
            border-left: 4px solid #f0b429;
        }
        .action-icon-btn {
            background: none;
            border: none;
            color: #6c757d;
            transition: all 0.2s;
        }
        .action-icon-btn:hover {
            color: ${cheatsheet.themeColor != null ? cheatsheet.themeColor : '#b51f55'};
            transform: scale(1.08);
        }
        .dropdown-toggle::after { display: none !important; }
    </style>
</head>
<body>

<jsp:include page="header.jsp"/>

<div class="container py-4">

    <nav aria-label="breadcrumb" class="mb-3">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Home</a></li>
            <li class="breadcrumb-item"><a href="#">${cheatsheet.category.name}</a></li>
            <li class="breadcrumb-item active" aria-current="page">${cheatsheet.title} Sheets</li>
        </ol>
    </nav>

    <div class="mb-4">
        <h1 class="fw-bold title mb-2">
            ${cheatsheet.title} Cheat Sheet <span>by ${cheatsheet.user.name}</span>
        </h1>
        <p class="text-muted max-width-auto mb-3">${cheatsheet.description}</p>
    </div>

    <div class="row g-4 mb-5">
        <c:forEach items="${cheatsheet.sections}" var="section">
            <div class="col-12 col-md-6 col-lg-4">
                <div class="card shadow-sm h-100 border-0 overflow-hidden" style="border-radius: 12px;">
                    <div class="card-header card-title-bar bg-white d-flex justify-content-between align-items-center py-3 px-3 fs-5 fw-bold"
                         data-bs-toggle="collapse" data-bs-target="#collapse-section-${section.id}" aria-expanded="true">
                        <span><c:out value="${section.title}"/></span>
                        <i class="bi bi-chevron-down small text-muted"></i>
                    </div>
                    <div id="collapse-section-${section.id}" class="collapse show">
                        <div class="card-body p-3">
                            <c:forEach items="${section.rows}" var="row">
                                <c:forEach items="${row.cells}" var="cell">
                                    <div class="row-block mb-1">
                                        <div class="cell-key-left small"><c:out value="${row.rowTitle}"/></div>
                                        <div class="text-muted small"><c:out value="${not empty cell.cellKey ? cell.cellKey : ''}"/></div>
                                        <div class="text-muted small text-end"><c:out value="${cell.cellValue}"/></div>
                                    </div>
                                </c:forEach>
                            </c:forEach>

                            <c:forEach items="${section.notes}" var="note">
                                <div class="highlight-box p-3 mt-3 rounded">
                                    <c:if test="${not empty note.noteTitle}">
                                        <div class="fw-bold text-warning-emphasis mb-1">💡 <c:out value="${note.noteTitle}"/></div>
                                    </c:if>
                                    <div class="small text-dark"><c:out value="${note.noteContent}"/></div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <div class="card shadow-sm border-0 rounded-3 p-3 mb-5 bg-white">
        <div class="d-flex flex-wrap align-items-center justify-content-between gap-3">
            <div class="d-flex align-items-center gap-4">
                <div class="text-secondary d-flex align-items-center gap-2">
                    <i class="bi bi-eye-fill fs-5 text-muted"></i>
                    <span class="fw-medium">${not empty cheatsheet.viewCount ? cheatsheet.viewCount : 0} Views</span>
                </div>
                <button class="action-icon-btn d-flex align-items-center gap-2" onclick="toggleLike(${cheatsheet.id})">
                    <i class="bi bi-heart fs-5 text-danger" id="likeBtnIcon"></i>
                    <span class="fw-medium text-dark" id="likeCounterText">${not empty cheatsheet.likeCount ? cheatsheet.likeCount : 0}</span>
                </button>
                <button class="action-icon-btn d-flex align-items-center gap-2" onclick="toggleBookmark(${cheatsheet.id})">
                    <i class="bi bi-bookmark fs-5 text-warning" id="bookmarkBtnIcon"></i>
                    <span class="fw-medium text-dark">Bookmark</span>
                </button>
            </div>
            <div>
                <button class="btn btn-outline-secondary btn-sm d-flex align-items-center gap-2 rounded-2 px-3 fw-semibold" data-bs-toggle="modal" data-bs-target="#shareLinkModal">
                    <i class="bi bi-share-fill"></i> Share Sheet
                </button>
            </div>
        </div>
    </div>

    <div class="card border-0 shadow-sm p-4 rounded-4 bg-white mb-5">
        <h3 class="fw-bold mb-4"><i class="bi bi-chat-left-text-fill me-2 text-muted"></i> Discussion Comments</h3>

        <form class="mb-4" method="post" action="${pageContext.request.contextPath}/comment/post">
            <input type="hidden" name="cheatsheetId" value="${cheatsheet.id}" />
            <div class="mb-3">
                <textarea class="form-control p-3 border rounded-3" style="min-height:95px;" name="content" placeholder="Share your perspective or ask a question..." required></textarea>
            </div>
            <button type="submit" class="btn btn-dark px-4 fw-bold rounded-2">Post Comment</button>
        </form>

        <div class="comment-stream-pipeline">
            <c:choose>
                <c:when test="${empty comments}">
                    <div class="text-center py-4 text-muted">
                        <p class="mb-0 fs-6">No discussions yet. Be the first to join the conversation!</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${comments}" var="comment">
                        <div class="card bg-light border-0 p-3 mb-3 rounded-3 position-relative shadow-sm">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <div class="d-flex align-items-center gap-2">
                                    <div class="bg-secondary-subtle rounded-circle d-flex align-items-center justify-content-center text-secondary fw-bold text-uppercase" style="width:34px; height:34px; font-size:12px;">
                                        ${comment.user.name.substring(0,2)}
                                    </div>
                                    <div>
                                        <div class="fw-bold text-dark small">${comment.user.name}</div>
                                        <div class="text-muted" style="font-size:11px;">${comment.createdAt}</div>
                                    </div>
                                </div>

                                <div class="dropdown">
                                    <button class="btn btn-link p-1 text-secondary dropdown-toggle shadow-none" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                        <i class="bi bi-three-dots-vertical fs-5"></i>
                                    </button>
                                    <ul class="dropdown-menu dropdown-menu-end shadow border-0 py-2">
                                        <c:choose>
                                            <c:when test="${comment.user.id == sessionScope.currentUser.id}">
                                                <li>
                                                    <a class="dropdown-item d-flex align-items-center gap-2 text-primary py-2" href="javascript:void(0);" onclick="toggleEditForm(${comment.id})">
                                                        <i class="bi bi-pencil-square"></i> Edit Comment
                                                    </a>
                                                </li>
                                                <li><hr class="dropdown-divider my-1"></li>
                                                <li>
                                                    <form method="post" action="${pageContext.request.contextPath}/comment/delete" onsubmit="return confirm('Delete this comment thread?')">
                                                        <input type="hidden" name="commentId" value="${comment.id}" />
                                                        <input type="hidden" name="cheatsheetId" value="${cheatsheet.id}" />
                                                        <button type="submit" class="dropdown-item d-flex align-items-center gap-2 text-danger py-2">
                                                            <i class="bi bi-trash3-fill"></i> Delete Comment
                                                        </button>
                                                    </form>
                                                </li>
                                            </c:when>
                                            <c:otherwise>
                                                <li>
                                                    <a class="dropdown-item d-flex align-items-center gap-2 text-warning py-2" href="javascript:void(0);" onclick="triggerReportAction(${comment.id})">
                                                        <i class="bi bi-exclamation-triangle-fill"></i> Report Spam
                                                    </a>
                                                </li>
                                            </c:otherwise>
                                        </c:choose>
                                        <li><hr class="dropdown-divider my-1"></li>
                                        <li>
                                            <a class="dropdown-item d-flex align-items-center gap-2 text-success py-2" href="javascript:void(0);" onclick="translateComment(${comment.id}, 'my')">
                                                <i class="bi bi-translate"></i> Translate to Burmese
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>

                            <div class="text-secondary px-1 mb-2 fs-6" id="comment-text-${comment.id}">
                                <c:out value="${comment.content}" />
                            </div>

                            <div class="d-flex gap-2">
                                <button type="button" class="btn btn-sm btn-link text-decoration-none text-muted p-0 fw-semibold small d-flex align-items-center gap-1" onclick="toggleReplyForm(${comment.id})">
                                    <i class="bi bi-reply-fill"></i> Reply
                                </button>
                            </div>

                            <div id="edit-form-${comment.id}" class="mt-3 p-3 bg-white border rounded-3" style="display:none;">
                                <form method="post" action="${pageContext.request.contextPath}/comment/edit">
                                    <input type="hidden" name="commentId" value="${comment.id}" />
                                    <input type="hidden" name="cheatsheetId" value="${cheatsheet.id}" />
                                    <div class="mb-2">
                                        <textarea class="form-control" name="content" required>${comment.content}</textarea>
                                    </div>
                                    <div class="d-flex gap-2 justify-content-end">
                                        <button type="button" class="btn btn-sm btn-light border" onclick="toggleEditForm(${comment.id})">Cancel</button>
                                        <button type="submit" class="btn btn-sm btn-primary">Update</button>
                                    </div>
                                </form>
                            </div>

                            <div id="reply-form-${comment.id}" class="mt-3 p-3 bg-white border rounded-3" style="display:none;">
                                <form method="post" action="${pageContext.request.contextPath}/comment/post">
                                    <input type="hidden" name="cheatsheetId" value="${cheatsheet.id}" />
                                    <input type="hidden" name="parentCommentId" value="${comment.id}" />
                                    <div class="mb-2">
                                        <textarea class="form-control" placeholder="Write a reply..." name="content" required></textarea>
                                    </div>
                                    <div class="d-flex gap-2 justify-content-end">
                                        <button type="button" class="btn btn-sm btn-light border" onclick="toggleReplyForm(${comment.id})">Cancel</button>
                                        <button type="submit" class="btn btn-sm btn-dark">Post Reply</button>
                                    </div>
                                </form>
                            </div>

                            <div class="mt-2">
                                <c:forEach items="${comment.replies}" var="reply">
                                    <c:set var="node" value="${reply}" scope="request" />
                                    <jsp:include page="comment-node.jsp" />
                                </c:forEach>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<div class="modal fade" id="shareLinkModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content border-0 shadow">
      <div class="modal-header bg-light">
        <h5 class="modal-title fw-bold text-dark"><i class="bi bi-share-fill me-2"></i> Share Sheet Hyperlink</h5>
        <button type="button" class="btn-close shadow-none" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body p-4">
        <div class="input-group">
          <input type="text" class="form-control bg-light" id="deploymentLinkInput" value="http://localhost:8080${pageContext.request.contextPath}/cheatsheet/${cheatsheet.id}" readonly>
          <button class="btn btn-dark fw-bold" type="button" onclick="copyDeploymentLink()">Copy Path</button>
        </div>
      </div>
    </div>
  </div>
</div>
<jsp:include page="footer.jsp"/>

<script>
function toggleReplyForm(id) {
    let el = document.getElementById('reply-form-' + id);
    if(el) el.style.display = (el.style.display === 'none' || el.style.display === '') ? 'block' : 'none';
}
function toggleEditForm(id) {
    let el = document.getElementById('edit-form-' + id);
    if(el) el.style.display = (el.style.display === 'none' || el.style.display === '') ? 'block' : 'none';
}
function toggleNestedReplies(id) {
    let el = document.getElementById('nested-' + id);
    if(el) el.style.display = (el.style.display === 'none' || el.style.display === '') ? 'block' : 'none';
}
function toggleLike(id) {
    let icon = document.getElementById('likeBtnIcon');
    icon.classList.toggle('bi-heart');
    icon.classList.toggle('bi-heart-fill');
}
var bmk = false;
function toggleBookmark(id) {
    let icon = document.getElementById('bookmarkBtnIcon');
    bmk = !bmk;
    icon.className = bmk ? "bi bi-bookmark-fill fs-5 text-warning" : "bi bi-bookmark fs-5 text-warning";
}
function copyDeploymentLink() {
    let inputEl = document.getElementById("deploymentLinkInput");
    inputEl.select();
    navigator.clipboard.writeText(inputEl.value);
    alert("Copied configuration pathway link directly to clipboard paste stack!");
}
function triggerReportAction(id) {
    if(confirm("Submit a content flags violation ticket for thread instance evaluation?")) {
        alert("Report captured for safety analysis validation.");
    }
}
function translateComment(commentId, targetLang) {
    let targetSpan = document.getElementById("comment-text-" + commentId);
    let originalText = targetSpan.innerText;
    targetSpan.innerText = "Translating text payload...";
    
    let endpoint = '${pageContext.request.contextPath}/comment/translate?commentId=' + commentId + '&lang=' + targetLang;
    
    fetch(endpoint)
        .then(res => { if(!res.ok) throw new Error(); return res.text(); })
        .then(txt => { targetSpan.innerText = txt; })
        .catch(() => { targetSpan.innerText = originalText; alert("Could not fetch translation matrix body."); });
}
</script>
</body>
</html>