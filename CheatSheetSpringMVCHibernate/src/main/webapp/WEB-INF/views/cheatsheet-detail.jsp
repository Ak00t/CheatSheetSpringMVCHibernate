<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>${cheatsheet.title} - Cheat Sheet</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"
                    rel="stylesheet">
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

                <style>
                    body {
                        background: #f8f9fa;
                        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                    }

                    .breadcrumb a {
                        color: $ {
                            cheatsheet.themeColor !=null ? cheatsheet.themeColor: '#b51f55'
                        }

                        ;
                        text-decoration: none;
                        font-weight: 600;
                    }

                    .title span {
                        color: $ {
                            cheatsheet.themeColor !=null ? cheatsheet.themeColor: '#b51f55'
                        }

                        ;
                    }

                    .card-title-bar {
                        cursor: pointer;

                        border-top: 5px solid $ {
                            cheatsheet.themeColor !=null ? cheatsheet.themeColor: '#b51f55'
                        }

                        ;

                        color: $ {
                            cheatsheet.themeColor !=null ? cheatsheet.themeColor: '#222'
                        }

                        ;
                    }

                    .row-block {
                        display: grid;
                        grid-template-columns: 1.2fr 1fr 1fr;
                        align-items: center;
                        gap: 10px;
                        padding: 10px 12px;
                        border-radius: 4px;
                    }

                    .row-block:nth-child(odd) {
                        background: #ffffff;
                    }

                    .row-block:nth-child(even) {
                        background: rgba(0, 0, 0, 0.02);
                    }

                    .cell-key-left {
                        font-weight: 700;
                        color: #111;
                        word-break: break-word;
                    }

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
                        color: $ {
                            cheatsheet.themeColor !=null ? cheatsheet.themeColor: '#b51f55'
                        }

                        ;
                        transform: scale(1.08);
                    }

                    .dropdown-toggle::after {
                        display: none !important;
                    }

                    .bookmark-container {
                        display: inline-block;
                        transition: transform 0.2s ease;
                    }

                    .icon-wrapper {
                        display: flex;
                        align-items: center;
                        justify-content: center;
                    }

                    .text-wrapper {
                        font-size: 0.9rem;
                    }

                    .bookmark-container:hover {
                        transform: scale(1.05);
                    }
                </style>
            </head>

            <body>

                <jsp:include page="header.jsp" />

                <div class="container py-4">

                    <nav aria-label="breadcrumb" class="mb-3">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Home</a></li>
                            <li class="breadcrumb-item"><a
                                    href="${pageContext.request.contextPath}/child-category/${cheatsheet.category.id}">${cheatsheet.category.name}</a>
                            </li>
                            <li class="breadcrumb-item active">${cheatsheet.title}</li>
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
                                        data-bs-toggle="collapse" data-bs-target="#collapse-section-${section.id}"
                                        aria-expanded="true">
                                        <span>
                                            <c:out value="${section.title}" />
                                        </span>
                                        <i class="bi bi-chevron-down small text-muted"></i>
                                    </div>
                                    <div id="collapse-section-${section.id}" class="collapse show">
                                        <div class="card-body p-3">
                                            <c:forEach items="${section.rows}" var="row">
                                                <c:forEach items="${row.cells}" var="cell">
                                                    <div class="row-block mb-1">
                                                        <div class="cell-key-left small">
                                                            <c:out value="${row.rowTitle}" />
                                                        </div>
                                                        <div class="text-muted small">
                                                            <c:out
                                                                value="${not empty cell.cellKey ? cell.cellKey : ''}" />
                                                        </div>
                                                        <div class="text-muted small text-end">
                                                            <c:out value="${cell.cellValue}" />
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </c:forEach>

                                            <c:forEach items="${section.notes}" var="note">
                                                <div class="highlight-box p-3 mt-3 rounded">
                                                    <c:if test="${not empty note.noteTitle}">
                                                        <div class="fw-bold text-warning-emphasis mb-1">💡
                                                            <c:out value="${note.noteTitle}" />
                                                        </div>
                                                    </c:if>
                                                    <div class="small text-dark">
                                                        <c:out value="${note.noteContent}" />
                                                    </div>
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
                                <form action="${pageContext.request.contextPath}/cheatsheet/like" method="POST"
                                    style="display:inline;">
                                    <input type="hidden" name="cheatsheetId" value="${cheatsheet.id}" />
                                    <button type="submit" class="action-icon-btn d-flex align-items-center gap-2">
                                        <i class="bi ${isLiked ? 'bi-heart-fill text-danger' : 'bi-heart'} fs-5"></i>
                                        <span class="fw-medium">${likeCount}</span>
                                    </button>
                                </form>

                                <div class="dropdown">
                                    <button class="action-icon-btn d-flex align-items-center gap-2"
                                        data-bs-toggle="dropdown">
                                        <i class="bi bi-star-fill text-warning fs-5"></i>
                                        <span class="fw-medium">${cheatsheet.ratingAvg}</span>
                                    </button>
                                    <div class="dropdown-menu p-3 shadow border-0" style="width: 200px;">
                                        <form action="${pageContext.request.contextPath}/cheatsheet/rate" method="POST">
                                            <input type="hidden" name="cheatsheetId" value="${cheatsheet.id}" />
                                            <label class="small fw-bold mb-2">Rate this sheet:</label>
                                            <select name="score" class="form-select form-select-sm mb-2">
                                                <option value="5">5 - Excellent</option>
                                                <option value="4">4 - Very Good</option>
                                                <option value="3">3 - Average</option>
                                                <option value="2">2 - Poor</option>
                                                <option value="1">1 - Terrible</option>
                                            </select>
                                            <button type="submit" class="btn btn-dark btn-sm w-100">Submit
                                                Rating</button>
                                        </form>
                                    </div>
                                </div>
                            </div>

                            <div class="bookmark-container">
                                <form action="${pageContext.request.contextPath}/cheatsheet/bookmark" method="POST"
                                    style="display:inline;">
                                    <input type="hidden" name="cheatsheetId" value="${cheatsheet.id}" />
                                    <button type="submit" class="action-icon-btn d-flex align-items-center gap-2">
                                        <div class="icon-wrapper">
                                            <i
                                                class="bi ${isBookmarked ? 'bi-bookmark-fill text-warning' : 'bi-bookmark'} fs-5"></i>
                                        </div>
                                        <div class="text-wrapper">
                                            <span class="fw-medium">Bookmark</span>
                                        </div>
                                    </button>
                                </form>
                            </div>

                            <div class="d-flex gap-2">


                                <button
                                    class="btn btn-outline-secondary btn-sm d-flex align-items-center gap-2 rounded-2 px-3 fw-semibold"
                                    data-bs-toggle="modal" data-bs-target="#shareLinkModal">
                                    <i class="bi bi-share-fill"></i> Share Sheet
                                </button>

                                <button class="btn btn-outline-danger btn-sm d-flex align-items-center gap-2"
                                    data-bs-toggle="modal" data-bs-target="#reportModal">
                                    <i class="bi bi-flag-fill"></i> Report
                                </button>
                            </div>
                        </div>
                    </div>

                    <div class="card border-0 shadow-sm p-4 rounded-4 bg-white mb-5">
                        <h3 class="fw-bold mb-4"><i class="bi bi-chat-left-text-fill me-2 text-muted"></i> Discussion
                            Comments</h3>

                        <form class="mb-4" method="post" action="${pageContext.request.contextPath}/comment/post">
                            <input type="hidden" name="cheatsheetId" value="${cheatsheet.id}" />
                            <div class="mb-3">
                                <textarea class="form-control p-3 border rounded-3" style="min-height:95px;"
                                    name="content" placeholder="Share your perspective or ask a question..."
                                    required></textarea>
                            </div>
                            <button type="submit" class="btn btn-dark px-4 fw-bold rounded-2">Post Comment</button>
                        </form>

                        <div class="comment-stream-pipeline">
                            <c:choose>
                                <c:when test="${empty comments}">
                                    <div class="text-center py-4 text-muted">
                                        <p class="mb-0 fs-6">No discussions yet. Be the first to join the conversation!
                                        </p>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach items="${comments}" var="comment">
                                        <div
                                            class="card bg-light border-0 p-3 mb-3 rounded-3 position-relative shadow-sm">
                                            <div class="d-flex justify-content-between align-items-center mb-2">
                                                <div class="d-flex align-items-center gap-2">
                                                    <div class="bg-secondary-subtle rounded-circle d-flex align-items-center justify-content-center text-secondary fw-bold text-uppercase"
                                                        style="width:34px; height:34px; font-size:12px;">
                                                        ${comment.user.name.substring(0,2)}
                                                    </div>
                                                    <div>
                                                        <div class="fw-bold text-dark small">${comment.user.name}</div>
                                                        <div class="text-muted" style="font-size:11px;">
                                                            ${comment.createdAt}</div>
                                                    </div>
                                                </div>

                                                <div class="dropdown">
                                                    <button
                                                        class="btn btn-link p-1 text-secondary dropdown-toggle shadow-none"
                                                        type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                        <i class="bi bi-three-dots-vertical fs-5"></i>
                                                    </button>
                                                    <ul class="dropdown-menu dropdown-menu-end shadow border-0 py-2">
                                                        <c:choose>
                                                            <c:when
                                                                test="${comment.user.id == sessionScope.currentUser.id}">
                                                                <li>
                                                                    <a class="dropdown-item d-flex align-items-center gap-2 text-primary py-2"
                                                                        href="javascript:void(0);"
                                                                        onclick="toggleEditForm(${comment.id})">
                                                                        <i class="bi bi-pencil-square"></i> Edit Comment
                                                                    </a>
                                                                </li>
                                                                <li>
                                                                    <hr class="dropdown-divider my-1">
                                                                </li>
                                                                <li>
                                                                    <form method="post"
                                                                        action="${pageContext.request.contextPath}/comment/delete"
                                                                        onsubmit="return confirm('Delete this comment thread?')">
                                                                        <input type="hidden" name="commentId"
                                                                            value="${comment.id}" />
                                                                        <input type="hidden" name="cheatsheetId"
                                                                            value="${cheatsheet.id}" />
                                                                        <button type="submit"
                                                                            class="dropdown-item d-flex align-items-center gap-2 text-danger py-2">
                                                                            <i class="bi bi-trash3-fill"></i> Delete
                                                                            Comment
                                                                        </button>
                                                                    </form>
                                                                </li>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <li>
                                                                    <a class="dropdown-item d-flex align-items-center gap-2 text-warning py-2"
                                                                        href="javascript:void(0);"
                                                                        onclick="triggerReportAction(${comment.id})">
                                                                        <i class="bi bi-exclamation-triangle-fill"></i>
                                                                        Report Spam
                                                                    </a>
                                                                </li>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <li>
                                                            <hr class="dropdown-divider my-1">
                                                        </li>
                                                        <li>
                                                            <a class="dropdown-item d-flex align-items-center gap-2 text-success py-2"
                                                                href="javascript:void(0);"
                                                                onclick="translateComment(${comment.id}, 'my')">
                                                                <i class="bi bi-translate"></i> Translate to Burmese
                                                            </a>
                                                        </li>
                                                        <!-- See Original Option (Hidden initially) -->
                                                        <li id="originalOpt-${comment.id}" class="d-none">
                                                            <a class="dropdown-item d-flex align-items-center gap-2 text-secondary py-2"
                                                                href="javascript:void(0);"
                                                                onclick="restoreOriginalComment(${comment.id})">
                                                                <i class="bi bi-arrow-clockwise"></i> See Original
                                                            </a>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                            <div class="text-secondary px-1 mb-2 fs-6" id="comment-text-${comment.id}">
                                                <c:out value="${comment.content}" />
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>

                <!-- share -->
                <!-- 🌟 🛑 မင်းရဲ့ စည်းကမ်းချက်သတ်မှတ်ချက်အတိုင်း ကွက်တိပြင်ဆင်ထားသော Dual-Share Modal UI -->
                <div class="modal fade" id="shareLinkModal" tabindex="-1" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content border-0 shadow-lg" style="border-radius: 24px;">
                            <div class="modal-header bg-light border-0 py-3 px-4">
                                <h5 class="modal-title fw-bold text-dark"><i
                                        class="bi bi-share-fill me-2 text-primary"></i> Share Hub</h5>
                                <button type="button" class="btn-close shadow-none" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                            </div>
                            <div class="modal-body p-4">

                                <!-- ================== ⬆️ အကန့် ၁: SHARE CHEAT SHEET (ပြင်ပ Social Media သို့ ပို့မည့်နေရာ) ================== -->
                                <div class="mb-4">
                                    <div class="d-flex align-items-center gap-2 mb-3">
                                        <span class="badge bg-primary-subtle text-primary rounded-circle p-2"><i
                                                class="bi bi-file-earmark-code fs-6"></i></span>
                                        <label class="small fw-extrabold text-dark m-0 tracking-wider">Share This Cheat
                                            Sheet (Social Media)</label>
                                    </div>
                                    <div class="row g-2 mb-3">
                                        <div class="col-6">
                                            <button
                                                onclick="shareToSocialWeb('FACEBOOK', 'https://www.facebook.com/sharer/sharer.php?u=')"
                                                class="btn btn-sm btn-outline-primary w-100 py-2 rounded-3 fw-semibold"><i
                                                    class="bi bi-facebook me-1"></i> Facebook</button>
                                        </div>
                                        <div class="col-6">
                                            <button
                                                onclick="shareToSocialWeb('MESSENGER', 'fb-messenger://share/?link=')"
                                                class="btn btn-sm btn-outline-primary w-100 py-2 rounded-3 fw-semibold"
                                                style="color: #0084FF; border-color: #0084FF;"><i
                                                    class="bi bi-messenger me-1"></i> Messenger</button>
                                        </div>
                                        <div class="col-6">
                                            <button
                                                onclick="shareToSocialWeb('TELEGRAM', 'https://t.me/share/url?url=')"
                                                class="btn btn-sm btn-outline-info w-100 py-2 rounded-3 fw-semibold text-dark"><i
                                                    class="bi bi-telegram me-1 text-info"></i> Telegram</button>
                                        </div>
                                        <div class="col-6">
                                            <button onclick="shareToSocialWeb('VIBER', 'viber://forward?text=')"
                                                class="btn btn-sm btn-outline-purple w-100 py-2 rounded-3 fw-semibold"
                                                style="color: #7360f2; border-color: #7360f2;"><i
                                                    class="bi bi-chat-right-text-fill me-1"></i> Viber</button>
                                        </div>
                                    </div>
                                    <div class="input-group input-group-sm">
                                        <input type="text" class="form-control bg-light border-0 ps-3 font-monospace"
                                            style="font-size: 0.85rem;" id="sheetLinkInput"
                                            value="http://localhost:8080${pageContext.request.contextPath}/cheatsheet/${cheatsheet.id}"
                                            readonly>
                                        <button class="btn btn-dark fw-bold px-3" type="button"
                                            onclick="copySheetDirectLink()"><i class="bi bi-clipboard me-1"></i> Copy
                                            Link</button>
                                    </div>
                                </div>

                                <hr class="my-4" style="opacity: 0.1; border-style: dashed;">

                                <!-- ================== ⬇️ အကန့် ၂: SHARE TO PROFILE (ကိုယ်ပိုင် Profile ထဲသို့ ဒေတာလှမ်းသိမ်းမည့်နေရာ) ================== -->
                                <div>
                                    <div class="d-flex align-items-center gap-2 mb-3">
                                        <span class="badge bg-success-subtle text-success rounded-circle p-2"><i
                                                class="bi bi-person-workspace fs-6"></i></span>
                                        <label class="small fw-extrabold text-dark m-0 tracking-wider">Share To My
                                            Profile (${sessionScope.currentUser.name})</label>
                                    </div>

                                    <!-- 🚀 🛑 ဤခလုတ်ကို နှိပ်လိုက်လျှင် ကိုယ်ပိုင် Profile ထဲက Shared History ဆီသို့ ဒေတာ တိုက်ရိုက်ရောက်သွားပါမည် -->
                                    <button onclick="saveToMyProfileLogs()"
                                        class="btn btn-success w-100 py-2.5 rounded-3 fw-bold shadow-sm">
                                        <i class="bi bi-plus-circle-fill me-1"></i> Share to My Shared History
                                    </button>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>

                <div class="modal fade" id="reportModal" tabindex="-1">
                    <div class="modal-dialog">
                        <form action="${pageContext.request.contextPath}/report/submit" method="POST"
                            class="modal-content">
                            <input type="hidden" name="targetId" value="${cheatsheet.id}" />
                            <div class="modal-header">
                                <h5 class="modal-title">Report Content</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>
                            <div class="modal-body">
                                <select name="reason" class="form-select mb-3" required>
                                    <option value="SPAM">Spam</option>
                                    <option value="ABUSE">Abuse</option>
                                    <option value="COPYRIGHT">Copyright Violation</option>
                                    <option value="INAPPROPRIATE">Inappropriate Content</option>
                                </select>
                                <textarea name="description" class="form-control"
                                    placeholder="Optional details..."></textarea>
                            </div>
                            <div class="modal-footer">
                                <button type="submit" class="btn btn-danger">Submit Report</button>
                            </div>
                        </form>
                    </div>
                </div>

                <script>
                    let playlistModalObj = null;

                    // Modal Instance ဆောက်ပြီး ဖွင့်လှစ်ခြင်း
                    function openPlaylistModal() {
                        if (!playlistModalObj) {
                            playlistModalObj = new bootstrap.Modal(document.getElementById('bootstrapPlaylistModal'));
                        }
                        playlistModalObj.show();
                        loadPlaylists(); // Playlist Data တွေ လှမ်းဆွဲမယ်
                    }

                    // User ရဲ့ လက်ရှိ Playlist တွေကို Controller ကနေ လှမ်းယူပြီး Option ဖြည့်ခြင်း
                    function loadPlaylists() {
                        fetch('${pageContext.request.contextPath}/collection/list')
                            .then(res => res.json())
                            .then(data => {
                                const select = document.getElementById('playlistSelect');
                                select.innerHTML = '<option value="">-- Choose Playlist --</option>';
                                data.forEach(c => {
                                    select.innerHTML += `<option value="\${c.id}">\${c.name}</option>`;
                                });
                            })
                            .catch(err => console.error("Error loading playlists:", err));
                    }

                    // Playlist အသစ်ဆောက်ခြင်း
                    function createNewPlaylist() {
                        const nameInput = document.getElementById('newPlaylistName');
                        const name = nameInput.value.trim();
                        if (!name) return alert("Please enter a playlist name!");

                        fetch('${pageContext.request.contextPath}/collection/create', {
                            method: 'POST',
                            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                            body: 'name=' + encodeURIComponent(name)
                        })
                            .then(res => res.text())
                            .then(() => {
                                alert("Playlist Created!");
                                nameInput.value = ""; // Input fields ရှင်းမယ်
                                loadPlaylists(); // Dropdown list ကို update ပြန်လုပ်မယ်
                            })
                            .catch(() => alert("Error creating playlist"));
                    }

                    // ရွေးချယ်ထားတဲ့ Playlist ထဲကို Cheat Sheet သွားသိမ်းခြင်း
                    function saveToSelectedPlaylist() {
                        const collectionId = document.getElementById('playlistSelect').value;
                        const cheatsheetId = '${cheatsheet.id}';

                        if (!collectionId) return alert("Please select a playlist first!");

                        fetch('${pageContext.request.contextPath}/collection/add-to-playlist', {
                            method: 'POST',
                            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                            body: `collectionId=\${collectionId}&cheatsheetId=\${cheatsheetId}`
                        })
                            .then(res => res.text())
                            .then(data => {
                                if (data === "Item already added!") {
                                    alert("This cheat sheet is already in the selected playlist.");
                                } else {
                                    alert("Successfully added to your playlist!");
                                    if (playlistModalObj) playlistModalObj.hide();
                                }
                            })
                            .catch(() => alert("Error saving to playlist"));
                    }

                    function copyDeploymentLink() {
                        let inputEl = document.getElementById("deploymentLinkInput");
                        inputEl.select();
                        navigator.clipboard.writeText(inputEl.value);
                        alert("Link copied to clipboard!");
                    }
                    //💡 cheatsheet-detail.jsp ၏ အောက်ခြေ <script> ထဲက copyDeploymentLink ကို ဤသို့ ပြောင်းလဲပါ-
                    function copyDeploymentLink() {
                        let inputEl = document.getElementById("deploymentLinkInput");
                        inputEl.select();
                        navigator.clipboard.writeText(inputEl.value);
                        alert("Link copied to clipboard!");

                        // 🚀 Database ထဲသို့ Share Log လှမ်းသိမ်းမည့် အပိုင်း
                        const cheatsheetId = '${cheatsheet.id}';
                        fetch('${pageContext.request.contextPath}/cheatsheet/share-log', {
                            method: 'POST',
                            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                            body: 'cheatsheetId=' + cheatsheetId + '&platform=LINK'
                        }).catch(err => console.error("Error logging share:", err));
                    }
                    //Global memory cache to store text snapshots
                    const commentCache = {};

                    function translateComment(commentId, targetLang) {
                        let targetSpan = document.getElementById("comment-text-" + commentId);
                        if (!targetSpan) return;

                        // 1. Snapshot and cache the original text right off the screen if not already done
                        if (!commentCache[commentId]) {
                            commentCache[commentId] = targetSpan.innerText;
                        }

                        let originalText = commentCache[commentId];
                        targetSpan.innerText = "Translating text payload...";

                        let endpoint = '${pageContext.request.contextPath}/comment/translate?commentId=' + commentId + '&lang=' + targetLang;

                        fetch(endpoint)
                            .then(res => { if (!res.ok) throw new Error(); return res.text(); })
                            .then(txt => {
                                targetSpan.innerText = txt;

                                // 2. Translation succeeded! Swap the dropdown options visibility
                                document.getElementById('translateOpt-' + commentId)?.classList.add('d-none');
                                document.getElementById('originalOpt-' + commentId)?.classList.remove('d-none');
                            })
                            .catch(() => {
                                targetSpan.innerText = originalText;
                                alert("Could not fetch translation matrix body.");
                            });
                    }

                    // 3. New function to restore the text from memory instantly
                    function restoreOriginalComment(commentId) {
                        let targetSpan = document.getElementById("comment-text-" + commentId);
                        let originalText = commentCache[commentId];

                        if (targetSpan && originalText) {
                            targetSpan.innerText = originalText;

                            // Swap dropdown options visibility back to default states
                            document.getElementById('originalOpt-' + commentId)?.classList.add('d-none');
                            document.getElementById('translateOpt-' + commentId)?.classList.remove('d-none');
                        }
                        //၁။ ⬆️ အပေါ်အကန့်အတွက် - ပြင်ပ Social Media Window များ လှမ်းဖွင့်ပေးမည့် Function
                        function shareToSocialWeb(platformName, webPrefixUrl) {
                            const sheetUrl = document.getElementById("sheetLinkInput").value;
                            window.open(webPrefixUrl + encodeURIComponent(sheetUrl), '_blank', 'width=600,height=400');
                        }

                        // ရိုးရိုး Copy Link နှိပ်ရင် အလုပ်လုပ်မည့် Function
                        function copySheetDirectLink() {
                            let inputEl = document.getElementById("sheetLinkInput");
                            inputEl.select();
                            navigator.clipboard.writeText(inputEl.value);
                            alert("Cheat Sheet link copied!");
                        }

                        // ၂။ ⬇️ အောက်အကန့်အတွက် - မိမိ Profile (Shared History Slider) ထဲသို့ AJAX ဖြင့် တိုက်ရိုက်လှမ်းသိမ်းမည့် Function
                        function saveToMyProfileLogs() {
                            const cheatsheetId = '${cheatsheet.id}';

                            fetch('${pageContext.request.contextPath}/cheatsheet/share-log', {
                                method: 'POST',
                                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                                body: 'cheatsheetId=' + cheatsheetId + '&platform=PROFILE' // Platform အား 'PROFILE' ဟု သတ်မှတ်သည်
                            })
                                .then(res => res.text())
                                .then(data => {
                                    if (data === "Logged Successfully") {
                                        alert("Successfully shared to your profile history!");
                                        // မိုဒယ်အား ပိတ်ပေးခြင်း
                                        const modalEl = document.getElementById('shareLinkModal');
                                        const modalInstance = bootstrap.Modal.getInstance(modalEl);
                                        if (modalInstance) modalInstance.hide();
                                    } else {
                                        alert("Please login first!");
                                    }
                                })
                                .catch(err => console.error("Database sync failed:", err));
                        }
                </script>
            </body>

            </html>