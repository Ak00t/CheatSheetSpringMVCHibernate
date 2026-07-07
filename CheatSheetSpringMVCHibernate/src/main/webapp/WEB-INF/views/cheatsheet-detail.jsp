<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>${cheatsheet.title} - Cheat Sheet</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
                <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css"
                    rel="stylesheet">
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

                <style>
                    body {
                        background: #f8fafc;
                        color: #334155;
                        font-family: 'Segoe UI', system-ui, sans-serif;
                    }

                    .breadcrumb a {
                        color: ${
                            cheatsheet.themeColor !=null ? cheatsheet.themeColor: '#2563eb'
                        }

                        ;
                        text-decoration: none;
                        font-weight: 600;
                    }

                    .title span {
                        color: ${
                            cheatsheet.themeColor !=null ? cheatsheet.themeColor: '#2563eb'
                        }

                        ;
                    }

                    .card-title-bar {
                        cursor: pointer;

                        border-top: 5px solid ${
                            cheatsheet.themeColor !=null ? cheatsheet.themeColor: '#2563eb'
                        }

                        ;
                        color: #0f172a;
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
                        background: rgba(0, 0, 0, 0.01);
                    }

                    .cell-key-left {
                        font-weight: 700;
                        color: #0f172a;
                        word-break: break-word;
                    }

                    .highlight-box {
                        background: #fffbeb;
                        border-left: 4px solid #f59e0b;
                    }

                    .interaction-card {
                        background: #ffffff;
                        border: 1px solid #e2e8f0;
                        border-radius: 16px;
                        box-shadow: 0 4px 20px rgba(15, 23, 42, 0.02);
                    }

                    .action-pill-btn {
                        background: #f8fafc;
                        border: 1px solid #e2e8f0;
                        padding: 8px 18px;
                        border-radius: 20px;
                        font-size: 0.9rem;
                        font-weight: 600;
                        color: #475569;
                        transition: all 0.2s ease;
                        display: inline-flex;
                        align-items: center;
                        gap: 6px;
                    }

                    .action-pill-btn:hover {
                        background: #f1f5f9;
                        color: #0f172a;
                        border-color: #cbd5e1;
                    }

                    /* 🌟 Facebook Style Reaction Popup System */
                    .fb-like-wrapper {
                        position: relative;
                        display: inline-block;
                    }

                    /* 🚀 အပေါ်ကနေ ကျော်တက်လာမည့် လှုပ်စိလှုပ်စိ Reaction Box */
                    .fb-reaction-popup {
                        position: absolute;
                        bottom: 50px;
                        /* ခလုတ်ရဲ့ အပေါ်နားမှာ ပေါ်ရန် */
                        left: 0;
                        background: #ffffff;
                        padding: 8px 12px;
                        border-radius: 30px;
                        box-shadow: 0 8px 30px rgba(0, 0, 0, 0.15);
                        border: 1px solid #e2e8f0;
                        display: flex;
                        align-items: center;
                        justify-content: center;

                        /* နဂိုအခြေအနေတွင် ပုန်းနေမည် */
                        visibility: hidden;
                        opacity: 0;
                        transform: translateY(10px) scale(0.8);
                        transition: all 0.25s cubic-bezier(0.175, 0.885, 0.32, 1.2);
                        z-index: 999;
                    }

                    /* 💡 Like Button ကို ဖိထားလျှင် (Active) သို့မဟုတ် Mouse တင်ထားလျှင် (Hover) Popup ထွက်လာမည် */
                    .fb-like-wrapper:hover .fb-reaction-popup,
                    .fb-like-wrapper:active .fb-reaction-popup {
                        visibility: visible;
                        opacity: 1;
                        transform: translateY(0) scale(1);
                    }

                    /* Popup ထဲက လက်မခလုတ်လေး သီးသန့် Style */
                    .fb-popup-thumb {
                        background: #f1f5f9;
                        border: none;
                        width: 42px;
                        height: 42px;
                        border-radius: 50%;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        color: #0284c7;
                        cursor: pointer;
                        transition: all 0.2s ease;
                    }

                    /* 🚀 Popup ထဲက လက်မလေးကို Mouse တင်ရင် (သို့မဟုတ် Popup ပွင့်ချိန်) လှုပ်စိလှုပ်စိ အဆက်မပြတ် ဖြစ်နေစေရန် */
                    .fb-like-wrapper:hover .fb-popup-thumb i {
                        animation: fbWobbleLoop 0.6s infinite ease-in-out;
                    }

                    .fb-popup-thumb:hover {
                        transform: scale(1.2) translateY(-4px);
                        background: #e0f2fe;
                    }

                    /* Like ပေးပြီးသား အပြာရောင် Highlight ပြောင်းလဲမှု */
                    .active-like {
                        background: #e0f2fe !important;
                        color: #0284c7 !important;
                        border-color: #bae6fd !important;
                    }

                    /* လှုပ်စိလှုပ်စိ ကခုန်စေမည့် Keyframes */
                    @keyframes fbWobbleLoop {
                        0% {
                            transform: rotate(0deg) scale(1.1);
                        }

                        20% {
                            transform: rotate(-15deg) scale(1.25);
                        }

                        40% {
                            transform: rotate(12deg) scale(1.25);
                        }

                        60% {
                            transform: rotate(-10deg) scale(1.25);
                        }

                        80% {
                            transform: rotate(8deg) scale(1.25);
                        }

                        100% {
                            transform: rotate(0deg) scale(1.1);
                        }
                    }

                    /* 🌟 Instant Star Rating UI Styling */
                    .star-rating-container {
                        display: inline-flex;
                        flex-direction: row-reverse;
                        /* Hover Effect မှန်ကန်စေရန် */
                        gap: 4px;
                    }

                    .star-rating-container i {
                        font-size: 1.25rem;
                        color: #cbd5e1;
                        cursor: pointer;
                        transition: color 0.15s ease, transform 0.1s ease;
                    }

                    .star-rating-container i:hover,
                    .star-rating-container i:hover~i {
                        color: #f59e0b;
                        /* ရွှေ့လိုက်ရင် ရွှေရောင်ပြောင်းမည် */
                        transform: scale(1.15);
                    }

                    .active-star {
                        color: #f59e0b !important;
                    }

                    .active-bookmark {
                        background: #fef9c3;
                        color: #d97706;
                        border-color: #fef08a;
                    }

                    .btn-report-pill {
                        color: #94a3b8;
                        background: transparent;
                        border: 1px solid transparent;
                    }

                    .btn-report-pill:hover {
                        background: #fff5f5;
                        color: #dc2626;
                        border-color: #fee2e2;
                    }

                    .star-rating-box {
                        display: inline-flex;
                        align-items: center;
                        gap: 6px;
                    }

                    .star-rating-container {
                        display: inline-flex;
                        gap: 4px;
                        /* 💡 row-reverse ကို လုံးဝ (လုံးဝ) မသုံးရပါ - ပုံမှန်အဝိုင်းအတိုင်း ဘယ်မှညာ သွားပါမည် */
                    }

                    .star-rating-container i {
                        font-size: 1.35rem;
                        color: #cbd5e1;
                        cursor: pointer;
                        transition: all 0.2s cubic-bezier(0.175, 0.885, 0.32, 1.275);
                    }

                    .star-rating-container i:hover,
                    .star-rating-container i.hovered {
                        color: #fbbf24 !important;
                        transform: scale(1.25) translateY(-2px);
                        text-shadow: 0 0 10px rgba(251, 191, 36, 0.4);
                    }

                    .active-star {
                        color: #f59e0b !important;
                        text-shadow: 0 0 8px rgba(245, 158, 11, 0.3);
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

                    <!-- Content Grid -->
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

                    <!-- 🌟 🛑 INTERACTION ACTION BAR SECTION (မင်းစိတ်ကြိုက် ပုံစံအသစ်) -->
                    <div class="card interaction-card border-0 p-3 mb-5">
                        <div class="d-flex flex-column flex-sm-row align-items-sm-center justify-content-between gap-3">

                            <!-- Left Side: Like, Instant Stars, Bookmark -->
                            <div class="d-flex flex-wrap align-items-center gap-3">

                                <div class="fb-like-wrapper">

                                    <div class="fb-reaction-popup">
                                        <form action="${pageContext.request.contextPath}/cheatsheet/like" method="POST"
                                            class="m-0">
                                            <input type="hidden" name="cheatsheetId" value="${cheatsheet.id}" />
                                            <button type="submit" class="fb-popup-thumb" title="Click to Like!">
                                                <i class="bi bi-hand-thumbs-up-fill fs-4"></i>
                                            </button>
                                        </form>
                                    </div>

                                    <button type="button" class="btn action-pill-btn ${isLiked ? 'active-like' : ''}"
                                        style="cursor: default;">
                                        <i
                                            class="bi ${isLiked ? 'bi-hand-thumbs-up-fill' : 'bi-hand-thumbs-up'} fs-5"></i>
                                        <span>${likeCount} Likes</span>
                                    </button>

                                </div>

                                <!-- 🔘 Instant Star Rating System (Submit ခလုတ်မလိုဘဲ တန်းပြောင်းလဲမည်) -->
                                <!-- 🔘 Instant Star Rating System (Advanced Dynamic Icons) -->
                                <div
                                    class="d-flex align-items-center gap-2 bg-light px-3 py-1.5 rounded-pill border star-rating-box">
                                    <span class="small fw-bold text-secondary font-monospace"
                                        id="avgRatingDisplay">${cheatsheet.ratingAvg}</span>

                                    <form id="instantRateForm"
                                        action="${pageContext.request.contextPath}/cheatsheet/rate" method="POST"
                                        class="m-0 d-inline">
                                        <input type="hidden" name="cheatsheetId" value="${cheatsheet.id}" />
                                        <input type="hidden" name="score" id="selectedStarScore" value="" />

                                        <!-- 💡 ကြယ်များကို ၁ မှ ၅ သို့ ဘယ်မှညာ အစဉ်အတိုင်း စီစဉ်ထားပါသည် -->
                                        <div class="star-rating-container" id="starContainer">
                                            <i class="bi bi-star-fill" data-score="1"
                                                onclick="submitInstantRating(1)"></i>
                                            <i class="bi bi-star-fill" data-score="2"
                                                onclick="submitInstantRating(2)"></i>
                                            <i class="bi bi-star-fill" data-score="3"
                                                onclick="submitInstantRating(3)"></i>
                                            <i class="bi bi-star-fill" data-score="4"
                                                onclick="submitInstantRating(4)"></i>
                                            <i class="bi bi-star-fill" data-score="5"
                                                onclick="submitInstantRating(5)"></i>
                                        </div>
                                    </form>
                                </div>

                                <!-- Bookmark Button Element -->
                                <form action="${pageContext.request.contextPath}/cheatsheet/bookmark" method="POST"
                                    class="m-0">
                                    <input type="hidden" name="cheatsheetId" value="${cheatsheet.id}" />
                                    <button type="submit"
                                        class="btn action-pill-btn ${isBookmarked ? 'active-bookmark' : ''}">
                                        <i class="bi ${isBookmarked ? 'bi-bookmark-fill' : 'bi-bookmark'}"></i>
                                        <span>${isBookmarked ? 'Saved' : 'Bookmark'}</span>
                                    </button>
                                </form>


                                <!-- PDF Download Button -->
                                <a href="${pageContext.request.contextPath}/cheatsheet/pdf/${cheatsheet.id}"
                                    target="_blank" class="btn action-pill-btn" style="
                                        background:${cheatsheet.themeColor != null ? cheatsheet.themeColor : '#2563eb'};
                                        color:white;
                                        border:none;
                                        font-weight:600;">
                                    <i class="bi bi-file-earmark-pdf-fill"></i>
                                    <span>Download PDF</span>
                                </a>

                            </div>

                            <div class="d-flex align-items-center gap-2 justify-content-end">
                                <button class="btn action-pill-btn bg-dark text-white border-dark"
                                    data-bs-toggle="modal" data-bs-target="#shareLinkModal">
                                    <i class="bi bi-share-fill"></i> Share Hub
                                </button>

                                <c:if
                                    test="${not empty sessionScope.currentUser and cheatsheet.user.id.toString() != sessionScope.currentUser.id.toString()}">
                                    <c:choose>
                                        <c:when test="${isAlreadyReported}">
                                            <button class="btn action-pill-btn" disabled
                                                style="opacity: 0.55; cursor: not-allowed; background: #fee2e2; color: #ef4444; border-color: #fca5a5;">
                                                <i class="bi bi-shield-fill-check"></i> Already Reported
                                            </button>
                                        </c:when>
                                        <c:otherwise>
                                            <button class="btn action-pill-btn btn-report-pill" data-bs-toggle="modal"
                                                data-bs-target="#reportModal">
                                                <i class="bi bi-flag-fill"></i> Report
                                            </button>
                                        </c:otherwise>
                                    </c:choose>
                                </c:if>
                            </div>
                        </div>
                    </div>

                    <!-- Discussion Comments Block Area -->
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
                                                            ${comment.relativeTime}</div>
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
                                                            <c:when
                                                                test="${cheatsheet.user.id == sessionScope.currentUser.id}">
                                                                <li>
                                                                    <form method="post"
                                                                        action="${pageContext.request.contextPath}/comment/delete"
                                                                        onsubmit="return confirm('Delete this comment from your cheatsheet?')">
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
                                                        <li id="translateOpt-${comment.id}">
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

                                            <!-- Comment text output & AJAX editing area wrapper -->
                                            <div class="text-secondary px-1 mb-2 fs-6" id="comment-text-${comment.id}">
                                                <c:out value="${comment.content}" />
                                            </div>

                                            <div class="d-flex gap-2">
                                                <button type="button"
                                                    class="btn btn-sm btn-link text-decoration-none text-muted p-0 fw-semibold small d-flex align-items-center gap-1"
                                                    onclick="toggleReplyForm(${comment.id})">
                                                    <i class="bi bi-reply-fill"></i> Reply
                                                </button>
                                            </div>


                                            <!-- Hidden dynamic inline edit element box container wrapper -->
                                            <div id="comment-edit-container-${comment.id}" class="d-none mt-2">
                                                <form method="post"
                                                    action="${pageContext.request.contextPath}/comment/edit">
                                                    <input type="hidden" name="commentId" value="${comment.id}" />
                                                    <input type="hidden" name="cheatsheetId" value="${cheatsheet.id}" />
                                                    <div class="mb-2">
                                                        <textarea class="form-control" name="content" rows="2"
                                                            required><c:out value="${comment.content}" /></textarea>
                                                    </div>
                                                    <div class="d-flex gap-2 justify-content-end">
                                                        <button type="button"
                                                            class="btn btn-light btn-sm fw-bold border"
                                                            onclick="toggleEditForm(${comment.id})">Cancel</button>
                                                        <button type="submit" class="btn btn-dark btn-sm fw-bold">Save
                                                            Changes</button>
                                                    </div>
                                                </form>
                                            </div>
                                            <div id="reply-form-${comment.id}"
                                                class="mt-3 p-3 bg-white border rounded-3" style="display:none;">
                                                <form method="post"
                                                    action="${pageContext.request.contextPath}/comment/post">
                                                    <input type="hidden" name="cheatsheetId" value="${cheatsheet.id}" />
                                                    <input type="hidden" name="parentCommentId" value="${comment.id}" />
                                                    <div class="mb-2">
                                                        <textarea class="form-control" placeholder="Write a reply..."
                                                            name="content" required></textarea>
                                                    </div>
                                                    <div class="d-flex gap-2 justify-content-end">
                                                        <button type="button" class="btn btn-sm btn-light border"
                                                            onclick="toggleReplyForm(${comment.id})">Cancel</button>
                                                        <button type="submit" class="btn btn-sm btn-dark">Post
                                                            Reply</button>
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

                <!-- Comment Dynamic Report Modal -->
                <div class="modal fade" id="commentReportModal" tabindex="-1" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered">
                        <form action="${pageContext.request.contextPath}/comment/report" method="POST"
                            class="modal-content">
                            <input type="hidden" name="commentId" id="reportCommentIdTarget" value="" />
                            <input type="hidden" name="cheatsheetId" value="${cheatsheet.id}" />
                            <div class="modal-header">
                                <h5 class="modal-title fw-bold text-danger"><i
                                        class="bi bi-exclamation-triangle-fill me-2"></i>Report Comment</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <p class="small text-muted">Please declare your assessment matrix parameters context
                                    category:</p>
                                <select name="reason" class="form-select mb-3" required>
                                    <option value="SPAM">Spam Content Matrix</option>
                                    <option value="ABUSE">Harassment or Abuse</option>
                                    <option value="INAPPROPRIATE">Inappropriate Tone/Language</option>
                                    <option value="COPYRIGHT">Copyright Violation</option>
                                </select>
                                <textarea name="description" class="form-control"
                                    placeholder="Optional meta descriptions context payload..." rows="3"></textarea>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-light fw-bold border"
                                    data-bs-dismiss="modal">Cancel</button>
                                <button type="submit" class="btn btn-danger fw-bold">Submit Assessment Report</button>
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

                <!-- Share Modal Hub -->
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

                                <!-- အကန့် ၁: SHARE CHEAT SHEET -->
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

                                <!-- အကန့် ၂: SHARE TO PROFILE -->
                                <div>
                                    <div class="d-flex align-items-center gap-2 mb-3">
                                        <span class="badge bg-success-subtle text-success rounded-circle p-2"><i
                                                class="bi bi-person-workspace fs-6"></i></span>
                                        <label class="small fw-extrabold text-dark m-0 tracking-wider">Share To My
                                            Profile (${sessionScope.currentUser.name})</label>
                                    </div>
                                    <button onclick="saveToMyProfileLogs()"
                                        class="btn btn-success w-100 py-2.5 rounded-3 fw-bold shadow-sm">
                                        <i class="bi bi-plus-circle-fill me-1"></i> Share to My Shared History
                                    </button>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>

                <!-- Report Modal Area -->
                <div class="modal fade" id="reportModal" tabindex="-1">
                    <div class="modal-dialog modal-dialog-centered">
                        <form action="${pageContext.request.contextPath}/report/submit" method="POST"
                            class="modal-content border-0" style="border-radius: 16px;">
                            <input type="hidden" name="targetId" value="${cheatsheet.id}" />
                            <div class="modal-header bg-light border-0">
                                <h5 class="modal-title fw-bold text-dark"><i
                                        class="bi bi-flag-fill text-danger me-2"></i> Report Content</h5>
                                <button type="button" class="btn-close shadow-none" data-bs-dismiss="modal"></button>
                            </div>
                            <div class="modal-body p-4">
                                <select name="reason" class="form-select mb-3 rounded-3 py-2" required>
                                    <option value="SPAM">Spam Content</option>
                                    <option value="ABUSE">Abuse or Harassment</option>
                                    <option value="COPYRIGHT">Copyright Violation</option>
                                    <option value="INAPPROPRIATE">Inappropriate Content</option>
                                </select>
                                <textarea name="description" class="form-control rounded-3" rows="3"
                                    placeholder="Optional details..."></textarea>
                            </div>
                            <div class="modal-footer border-0">
                                <button type="button" class="btn btn-light rounded-3 px-3"
                                    data-bs-dismiss="modal">Cancel</button>
                                <button type="submit" class="btn btn-danger rounded-3 px-4 fw-bold">Submit
                                    Report</button>
                            </div>
                        </form>
                    </div>
                </div>

                <script>


                    function toggleReplyForm(id) {
                        let el = document.getElementById('reply-form-' + id);
                        if (el) el.style.display = (el.style.display === 'none' || el.style.display === '') ? 'block' : 'none';
                    }

                    function toggleNestedReplies(id) {
                        let el = document.getElementById('nested-' + id);
                        if (el) el.style.display = (el.style.display === 'none' || el.style.display === '') ? 'block' : 'none';
                    }

                    // Toggle visibility of inline edit forms for comments
                    function toggleEditForm(commentId) {
                        const txtArea = document.getElementById("comment-text-" + commentId);
                        const editContainer = document.getElementById("comment-edit-container-" + commentId);
                        if (txtArea && editContainer) {
                            if (editContainer.classList.contains('d-none')) {
                                editContainer.classList.remove('d-none');
                                txtArea.classList.add('d-none');
                            } else {
                                editContainer.classList.add('d-none');
                                txtArea.classList.remove('d-none');
                            }
                        }
                    }

                    function submitInstantRating(scoreValue) {
                        document.getElementById("selectedStarScore").value = scoreValue;
                        document.getElementById("instantRateForm").submit(); // Form ကို တိုက်ရိုက် Submit လှမ်းလုပ်မည်
                    }

                    // Handle dynamic injection target parameter metrics payload for reporting comments
                    function triggerReportAction(commentId) {
                        const targetInput = document.getElementById("reportCommentIdTarget");
                        if (targetInput) {
                            targetInput.value = commentId;
                            const rModal = new bootstrap.Modal(document.getElementById('commentReportModal'));
                            rModal.show();
                        }
                    }

                    // Global memory cache to store text snapshots
                    const commentCache = {};

                    function translateComment(commentId, targetLang) {
                        let targetSpan = document.getElementById("comment-text-" + commentId);
                        if (!targetSpan) return;

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
                                document.getElementById('translateOpt-' + commentId)?.classList.add('d-none');
                                document.getElementById('originalOpt-' + commentId)?.classList.remove('d-none');
                            })
                            .catch(() => {
                                targetSpan.innerText = originalText;
                                alert("Could not fetch translation matrix body.");
                            });
                    }

                    function restoreOriginalComment(commentId) {
                        let targetSpan = document.getElementById("comment-text-" + commentId);
                        let originalText = commentCache[commentId];

                        if (targetSpan && originalText) {
                            targetSpan.innerText = originalText;
                            document.getElementById('originalOpt-' + commentId)?.classList.add('d-none');
                            document.getElementById('translateOpt-' + commentId)?.classList.remove('d-none');
                        }
                    }

                    function shareToSocialWeb(platformName, webPrefixUrl) {
                        const sheetUrl = document.getElementById("sheetLinkInput").value;
                        window.open(webPrefixUrl + encodeURIComponent(sheetUrl), '_blank', 'width=600,height=400');
                    }

                    function copySheetDirectLink() {
                        let inputEl = document.getElementById("sheetLinkInput");
                        inputEl.select();
                        navigator.clipboard.writeText(inputEl.value);
                        alert("Cheat Sheet link copied!");
                    }

                    function saveToMyProfileLogs() {
                        const cheatsheetId = '${cheatsheet.id}';

                        // URL-encoded string အစား FormData ကို သုံးပါ
                        let formData = new FormData();
                        formData.append("cheatsheetId", cheatsheetId);
                        formData.append("platform", "PROFILE");

                        fetch('${pageContext.request.contextPath}/cheatsheet/share-log', {
                            method: 'POST',
                            // ⚠️ Content-Type Header ကို လက်ရှိမှာ ဖြုတ်ထားရပါမယ် (FormData က အလိုအလျောက် ချိန်ပေးပါလိမ့်မယ်)
                            body: formData,
                            credentials: 'include' // 🔑 Browser Session Cookie ပါသွားစေရန် သေချာပေါက် ထည့်ရမည်
                        })
                            .then(res => res.text())
                            .then(data => {

                                if (data === "Logged Successfully") {
                                    alert("Successfully shared to your profile history!");
                                    const modalEl = document.getElementById('shareLinkModal');
                                    const modalInstance = bootstrap.Modal.getInstance(modalEl);
                                    if (modalInstance) modalInstance.hide();
                                } else {
                                    alert("Please login first!");
                                }
                            })            const cleanData = data.trim().replace(/^"|"$/g, '');
                            .catch (err => console.error("Database sync failed:", err));
                    }
                    // 💡 URL Parameters များကို ဖတ်ပြီး အခြေအနေအလိုက် Alert Box ပြပေးမည့်စနစ်
                    window.addEventListener('DOMContentLoaded', () => {
                        const urlParams = new URLSearchParams(window.location.search);

                        // ၁။ Report အောင်မြင်စွာ တင်ပြီးမြောက်သွားချိန်
                        if (urlParams.get('status') === 'reported') {
                            alert("🚨 Report Submitted Successfully!\nOur team will review this content shortly.");
                            // URL ထဲက Parameter ကို သန့်စင်ပေးခြင်း (နောက်တစ်ခါ Refresh နှိပ်ရင် Alert ထပ်မကျစေရန်)
                            window.history.replaceState({}, document.title, window.location.pathname);
                        }

                        // ၂။ Controller ကနေ တားဆီးလိုက်တဲ့ ကိုယ့်ဟာကိုယ် Report ထုမှုအခြေအနေ
                        if (urlParams.get('error') === 'self_report') {
                            alert("❌ Action Denied!\nYou cannot report your own cheat sheet.");
                            window.history.replaceState({}, document.title, window.location.pathname);
                        }
                    });

                    // 💡 Star Rating ခေတ်မီလှပစေမည့် Dynamic JavaScript Engine
                    document.addEventListener('DOMContentLoaded', () => {
                        // #starContainer အောက်က ကြယ် ၅ လုံးလုံးကို အစဉ်လိုက် ဆွဲယူခြင်း
                        const stars = document.querySelectorAll('#starContainer i');
                        const currentAvg = Math.floor(parseFloat('${cheatsheet.ratingAvg}') || 0);

                        // ၁။ စာမျက်နှာ စပွင့်ချိန်တွင် ရှိပြီးသား အမှတ်အတိုင်း ဘယ်ဘက်အစကနေ မီးလင်းပေးထားခြင်း
                        highlightStars(currentAvg, 'active-star');

                        // ၂။ Mouse တင်လိုက်သည့်အခါ ဘယ်ဘက်အစကနေ အစဉ်လိုက် လင်းစေမည့် Logic
                        stars.forEach(star => {
                            star.addEventListener('mouseenter', function () {
                                const currentScore = parseInt(this.getAttribute('data-score'));

                                // Hover လုပ်ထားသော ကြယ်အပါအဝင် ၎င်း၏ ရှေ့က ကြယ်များကိုသာ လင်းစေပြီး နောက်ကကောင်များကို မှိတ်ခြင်း
                                stars.forEach(s => {
                                    const sScore = parseInt(s.getAttribute('data-score'));
                                    if (sScore <= currentScore) {
                                        s.classList.add('hovered');
                                    } else {
                                        s.classList.remove('hovered');
                                    }
                                });
                            });
                        });

                        // ၃။ Mouse အပြင်ထွက်သွားလျှင် Hover အရောင်များကို ဖျက်ပြီး မူလအမှတ်အတိုင်း ပြန်ပြောင်းခြင်း
                        const container = document.getElementById('starContainer');
                        if (container) {
                            container.addEventListener('mouseleave', () => {
                                stars.forEach(s => s.classList.remove('hovered'));
                            });
                        }
                    });

                    // ဘယ်ဘက်အစကနေ သတ်မှတ်အမှတ်အထိ class တပ်ပေးမည့် အထောက်အကူပြု function
                    function highlightStars(score, className) {
                        const stars = document.querySelectorAll('#starContainer i');
                        stars.forEach(s => {
                            const sScore = parseInt(s.getAttribute('data-score'));
                            if (sScore <= score) {
                                s.classList.add(className);
                            } else {
                                s.classList.remove(className);
                            }
                        });
                    }

                    function submitInstantRating(scoreValue) {
                        document.getElementById("selectedStarScore").value = scoreValue;
                        // Form မတက်ခင် UI တွင် ချက်ချင်း အမှတ်ပြောင်းသွားစေရန် ဘယ်ကနေစပြီး အရောင်လင်းပေးခြင်း
                        highlightStars(scoreValue, 'active-star');
                        document.getElementById("instantRateForm").submit();
                    }
                    // URL Parameters Detection Block
                    window.addEventListener('DOMContentLoaded', () => {
                        const urlParams = new URLSearchParams(window.location.search);

                        if (urlParams.get('status') === 'reported') {
                            alert("🚨 Report Submitted Successfully!\nOur team will review this content shortly.");
                            window.history.replaceState({}, document.title, window.location.pathname);
                        }

                        if (urlParams.get('error') === 'self_report') {
                            alert("❌ Action Denied!\nYou cannot report your own cheat sheet.");
                            window.history.replaceState({}, document.title, window.location.pathname);
                        }

                        // 💡 🔑 ၂ ကြိမ်မြောက် အတင်းလာထုသူများအား Alert Box ဖြင့် ဖြတ်တားခြင်း
                        if (urlParams.get('error') === 'already_reported') {
                            alert("⚠️ Notice!\nYou have already submitted a report for this cheat sheet.");
                            window.history.replaceState({}, document.title, window.location.pathname);
                        }
                    });
                </script>
            </body>

            </html>