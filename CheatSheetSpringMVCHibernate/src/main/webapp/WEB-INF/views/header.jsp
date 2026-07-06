<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
                <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css"
                    rel="stylesheet">

                <style>
                    @media (min-width: 768px) {

                        /* 🌟 Hover လုပ်ထားစဉ် ပွင့်နေစေရန်နှင့် Gap ကြောင့် ပိတ်မသွားစေရန် Bridge Layer တည်ဆောက်ခြင်း */
                        .profile-hover-dropdown:hover .dropdown-menu {
                            display: block;
                            margin-top: 0;
                        }

                        /* 🌟 ဤအချက်က အဓိကပါ: Button နှင့် Menu ကြားက ကွက်လပ်ကို Invisible Layer ဖြင့် ပိတ်ဆို့ပေးထားသဖြင့် မောက်စ်ရွှေ့လျှင် လုံးဝမပျောက်တော့ပါ */
                        .profile-hover-dropdown .dropdown-menu::before {
                            content: "";
                            position: absolute;
                            top: -20px;
                            /* အပေါ်ဘက် ကွက်လပ်နေရာအလိုက် layer အား လှမ်းဆွဲဆန့်ထားခြင်း */
                            left: 0;
                            width: 100%;
                            height: 20px;
                            background: transparent;
                        }
                    }

                    /* 🌟 2-Column Grid Dropdown Layout စတိုင်လ် - ညာဘက်အစွန်းကို စနစ်တကျ ကပ်ပေးထားခြင်း */
                    .custom-grid-menu {
                        border-radius: 20px !important;
                        padding: 24px !important;
                        min-width: 480px !important;
                        border: 1px solid #e2e8f0 !important;
                        background: #ffffff !important;

                        /* 🌟 Menu ကြီး ညာဘက်အစွန်းကို ပုံစံကျကျ ကပ်နေစေရန် Positioning */
                        left: auto !important;
                        right: 0 !important;
                        transform: translateX(10px);
                        /* Screen အပြင်မထွက်အောင် ဘယ်ဘက်ကို နည်းနည်းပြန်တွန်းထားသည် */
                    }

                    .grid-menu-container {
                        display: grid;
                        grid-template-columns: 1fr 1fr;
                        gap: 20px;
                    }

                    .grid-column-side {
                        display: flex;
                        flex-direction: column;
                        gap: 6px;
                    }

                    .grid-column-divider {
                        border-right: 1px dashed #e2e8f0;
                        padding-right: 10px;
                    }

                    .custom-grid-menu .dropdown-item {
                        display: flex !important;
                        align-items: center !important;
                        gap: 12px !important;
                        padding: 10px 14px !important;
                        border-radius: 12px !important;
                        font-weight: 600 !important;
                        color: #475569 !important;
                        transition: all 0.2s ease !important;
                        font-size: 14px !important;
                    }

                    .custom-grid-menu .dropdown-item:hover {
                        background-color: #f1f5f9 !important;
                        color: #2563eb !important;
                    }

                    .custom-grid-menu .dropdown-item i {
                        font-size: 16px;
                    }
                </style>

                <header class="bg-white px-4 py-3 d-flex justify-content-between align-items-center shadow-sm">
                    <h2 class="m-0" style="color:#2563eb; font-weight: 700;">
                        <a href="${pageContext.request.contextPath}/" class="text-decoration-none">
                            CheatSheet Hub
                        </a>
                    </h2>
                    <form action="${pageContext.request.contextPath}/search" method="GET"
                        class="d-flex mx-4 position-relative" style="width: 45%; max-width: 600px;">
                        <div class="input-group">
                            <span class="input-group-text bg-light border-end-0 rounded-start-pill ps-3 text-muted">
                                <i class="bi bi-search"></i>
                            </span>
                            <input type="text" id="headerSearchInput" name="query" autocomplete="off"
                                class="form-control bg-light border-start-0 rounded-end-pill py-2 shadow-none"
                                placeholder="Search for cheatsheets, tags, or categories or users..."
                                value="<c:out value='${param.query}' />" required="required" />
                        </div>

                        <div id="searchSuggestBox" class="card shadow border position-absolute w-100 mt-2 d-none"
                            style="top: 100%; left: 0; z-index: 1050; max-height: 400px; overflow-y: auto; border-radius: 15px;">
                            <div id="suggestContent" class="p-2"></div>
                        </div>
                    </form>

                    <nav class="d-flex align-items-center gap-4">
                        <a href="${pageContext.request.contextPath}/"
                            class="text-decoration-none text-secondary fw-semibold">
                            Home
                        </a>

                        <c:choose>
                            <c:when test="${not empty sessionScope.currentUser}">
                                <div class="dropdown" id="notificationDropdownArea">
                                    <button
                                        class="btn btn-link text-dark p-1 position-relative border-0 shadow-none dropdown-toggle text-decoration-none no-caret"
                                        type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                        <i class="bi bi-bell fs-5"></i>
                                        <c:if
                                            test="${not empty unreadNotifications && fn:length(unreadNotifications) > 0}">
                                            <span id="notiBadge"
                                                class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger"
                                                style="font-size: 9px; padding: 0.35em 0.5em;">
                                                ${fn:length(unreadNotifications)}
                                            </span>
                                        </c:if>
                                    </button>

                                    <ul class="dropdown-menu dropdown-menu-end shadow border-0 py-2 mt-2"
                                        style="width: 320px; max-height: 400px; overflow-y: auto; z-index: 1100;">

                                        <li
                                            class="px-3 py-2 fw-bold text-dark border-bottom small d-flex justify-content-between align-items-center">
                                            <span>Notifications</span>

                                            <c:if test="${not empty unreadNotifications}">
                                                <button onclick="markAllAsRead()"
                                                    class="btn btn-link p-0 text-decoration-none text-primary fw-semibold"
                                                    style="font-size:11px;">
                                                    Mark all read
                                                </button>
                                            </c:if>
                                        </li>

<div id="notiList">
    <!-- ================= UNREAD NOTIFICATIONS ================= -->
    <c:if test="${not empty unreadNotifications}">
        <c:forEach var="noti" items="${unreadNotifications}">
            <li class="border-bottom list-unstyled bg-light">
                <!-- 1. Determine target link destination based on type matching -->
                <c:choose>
                    <c:when test="${noti.type eq 'FOLLOW'}">
                        <c:set var="targetLink" value="${pageContext.request.contextPath}/profile/${noti.referenceId}" />
                    </c:when>
                    <c:otherwise>
                        <c:set var="targetLink" value="${pageContext.request.contextPath}/cheatsheet/${noti.referenceId}" />
                    </c:otherwise>
                </c:choose>

                <!-- 2. Pass dynamic destination directly into JS onclick trigger handler -->
                <a class="dropdown-item p-3 text-wrap d-flex flex-column gap-1"
                    href="javascript:void(0);"
                    onclick="readNotification(${noti.id}, '${targetLink}')">
                    <div class="fw-bold text-dark small d-flex align-items-center gap-2">
                        <i class="bi bi-bell-fill text-primary"></i>
                        ${noti.title}
                    </div>
                    <div class="text-secondary" style="font-size:12px;line-height:1.4;">
                        ${noti.message}
                    </div>
                </a>
            </li>
        </c:forEach>
    </c:if>

    <!-- ================= EMPTY STATE PROMPT ================= -->
    <c:if test="${empty unreadNotifications && empty readNotificationsHistory}">
        <li class="text-center py-4 text-muted small list-unstyled">
            <i class="bi bi-bell-slash d-block fs-3 mb-2"></i>
            No notifications
        </li>
    </c:if>

    <!-- ================= HISTORICAL NOTIFICATIONS ================= -->
    <c:if test="${not empty readNotificationsHistory}">
        <li>
            <hr class="dropdown-divider">
        </li>
        <li class="dropdown-header fw-bold text-secondary">Notification History</li>
        
        <c:forEach var="history" items="${readNotificationsHistory}">
            <li class="border-bottom list-unstyled">
                <!-- 3. Handle same type validation checks for historical links -->
                <c:choose>
                    <c:when test="${history.type eq 'FOLLOW'}">
                        <c:set var="historyLink" value="${pageContext.request.contextPath}/profile/${history.referenceId}" />
                    </c:when>
                    <c:otherwise>
                        <c:set var="historyLink" value="${pageContext.request.contextPath}/cheatsheet/${history.referenceId}" />
                    </c:otherwise>
                </c:choose>

                <a class="dropdown-item p-3 text-wrap d-flex flex-column gap-1 text-muted"
                    href="${historyLink}">
                    <div class="small d-flex align-items-center gap-2">
                        <i class="bi bi-check-circle text-success"></i>
                        ${history.title}
                    </div>
                    <div style="font-size:12px;">${history.message}</div>
                </a>
            </li>
        </c:forEach>
    </c:if>
</div>
                                    </ul>
                                </div>

                                <a href="${pageContext.request.contextPath}/cheatsheet/create"
                                    class="text-decoration-none text-secondary fw-semibold">
                                    Create Cheatsheet
                                </a>

                                <div class="dropdown d-inline-block profile-hover-dropdown">
                                    <a href="${pageContext.request.contextPath}/profile/${sessionScope.currentUser.id}"
                                        class="text-decoration-none text-secondary fw-semibold dropdown-toggle d-flex align-items-center gap-2"
                                        id="profileDropdown" data-bs-toggle="dropdown" aria-expanded="false">

                                        <c:choose>
                                            <c:when test="${not empty sessionScope.currentUser.profileImg}">
                                                <img src="${pageContext.request.contextPath}/uploads/profiles/${sessionScope.currentUser.profileImg}"
                                                    alt="User Profile"
                                                    style="width: 28px; height: 28px; border-radius: 50%; object-fit: cover; border: 1.5px solid #2563eb;" />
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${pageContext.request.contextPath}/uploads/profiles/default.png"
                                                    alt="Default Profile"
                                                    style="width: 28px; height: 28px; border-radius: 50%; object-fit: cover; border: 1.5px solid #64748b;" />
                                            </c:otherwise>
                                        </c:choose>

                                        <span
                                            class="ms-1 text-dark small fw-bold">${sessionScope.currentUser.name}</span>
                                    </a>

                                    <!-- 💡 ဤနေရာတွင် dropdown-menu-end အစား dropdown-menu-start သို့ပြောင်းလဲပြီး style positioning ကို ညှိလိုက်ပါသည် -->
                                    <div class="dropdown-menu dropdown-menu-start shadow border-0 custom-grid-menu mt-2"
                                        style="left: auto !important; right: 0 !important; transform: translateX(10px);">
                                        <div class="grid-menu-container">

                                            <!-- ဘယ်ဘက်ခြမ်း Column (Profile & Socials) -->
                                            <div class="grid-column-side grid-column-divider">
                                                <h6 class="dropdown-header px-2 fw-bold text-primary mb-1"></h6>
                                                <a class="dropdown-item"
                                                    href="${pageContext.request.contextPath}/profile/${sessionScope.currentUser.id}">
                                                    <i class="bi bi-person-circle text-primary"></i> My Profile
                                                </a>
                                                <a class="dropdown-item"
                                                    href="${pageContext.request.contextPath}/follow/followers-view">
                                                    <i class="bi bi-people-fill text-info"></i> My Followers
                                                </a>
                                                <a class="dropdown-item"
                                                    href="${pageContext.request.contextPath}/follow/following-view">
                                                    <i class="bi bi-person-heart text-danger"></i> Following Users
                                                </a>
                                                <a class="dropdown-item"
                                                    href="${pageContext.request.contextPath}/category/followed-list">
                                                    <i class="bi bi-grid-fill text-warning"></i> Followed Categories
                                                </a>
                                                <div class="mt-auto pt-2 border-top border-light">
                                                    <a class="dropdown-item text-danger fw-bold"
                                                        href="${pageContext.request.contextPath}/logout">
                                                        <i class="bi bi-box-arrow-right text-danger"></i> Log out
                                                    </a>
                                                </div>
                                            </div>

                                            <!-- ညာဘက်ခြမ်း Column (Collections & Hubs) -->
                                            <div class="grid-column-side">
                                                <h6 class="dropdown-header px-2 fw-bold text-success mb-1"></h6>
                                                <a class="dropdown-item"
                                                    href="${pageContext.request.contextPath}/profile/bookmarks">
                                                    <i class="bi bi-bookmark-heart-fill text-warning"></i> Bookmarks
                                                </a>
                                                <a class="dropdown-item"
                                                    href="${pageContext.request.contextPath}/collection/manage">
                                                    <i class="bi bi-folder-fill text-success"></i> My Collection
                                                </a>
                                                <a class="dropdown-item"
                                                    href="${pageContext.request.contextPath}/profile-cheatsheets">
                                                    <i class="bi bi-file-earmark-spreadsheet-fill text-primary"></i> My
                                                    Cheatsheets
                                                </a>
                                            </div>

                                        </div>
                                    </div>
                                </div>

                            </c:when>
                            <c:otherwise>
                                <button type="button" class="btn btn-outline-primary btn-sm fw-bold px-3 rounded-2"
                                    data-bs-toggle="modal" data-bs-target="#loginModal">
                                    Login
                                </button>
                                <button type="button" class="btn btn-primary btn-sm fw-bold px-3 rounded-2"
                                    data-bs-toggle="modal" data-bs-target="#registerModal">
                                    Register
                                </button>
                            </c:otherwise>
                        </c:choose>
                    </nav>
                </header>

                <style>
                    .dropdown-toggle.no-caret::after {
                        display: none !important;
                    }

                    .custom-placeholder::placeholder {
                        opacity: 0.4;
                    }

                    .custom-placeholder::-webkit-input-placeholder {
                        opacity: 0.4;
                    }

                    .input-group:focus-within .form-control,
                    .input-group:focus-within .input-group-text {
                        border-color: #86b7fe;
                        box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25);
                    }
                </style>

                <div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel"
                    aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content border-0 shadow">
                            <div class="modal-header bg-light">
                                <h5 class="modal-title fw-bold text-dark" id="loginModalLabel"><i
                                        class="bi bi-box-arrow-in-right me-2"></i>Account Login</h5>
                                <button type="button" class="btn-close shadow-none" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                            </div>
                            <div class="modal-body p-4">
                                <c:if test="${param.error == 'true'}">
                                    <div class="alert alert-danger alert-dismissible fade show py-2 small" role="alert">
                                        <i class="bi bi-exclamation-triangle-fill me-1"></i> User not found or account is unavailable
                                        <button type="button" class="btn-close" data-bs-dismiss="alert"
                                            aria-label="Close" style="padding: 0.8rem 1rem; font-size: 10px;"></button>
                                    </div>
                                </c:if>

                                <form action="${pageContext.request.contextPath}/login" method="POST">
                                    <div class="mb-3">
                                        <label class="form-label small fw-bold text-secondary">Email Address</label>
                                        <input type="email" name="email" class="form-control" required="required"
                                            placeholder="name@example.com" />
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label small fw-bold text-secondary">Password</label>
                                        <div class="input-group">
                                            <input type="password" id="loginPasswordInput" name="password"
                                                class="form-control border-end-0 custom-placeholder" required="required"
                                                placeholder="••••••••" />
                                            <button class="input-group-text bg-white border-start-0 text-muted"
                                                type="button" id="togglePasswordBtn" style="cursor: pointer;">
                                                <i class="bi bi-eye" id="togglePasswordIcon"></i>
                                            </button>
                                        </div>
                                    </div>

                                    <div class="mb-4 d-flex justify-content-between align-items-center">
                                        <div class="form-check m-0">
                                            <input type="checkbox" class="form-check-input" id="rememberMeCheck"
                                                name="remember-me">
                                            <label class="form-check-label small text-muted"
                                                for="rememberMeCheck">Remember me</label>
                                        </div>
                                        <div>
                                            <a href="${pageContext.request.contextPath}/forgot-password"
                                                class="small text-decoration-none fw-semibold">Forgot Password?</a>
                                        </div>
                                    </div>

                                    <button type="submit" class="btn btn-primary w-100 fw-bold">Sign In</button>
                                </form>
                            </div>
                            <div class="modal-footer bg-light justify-content-center border-0 py-3">
                                <span class="small text-muted">New here? <a href="javascript:void(0);"
                                        data-bs-toggle="modal" data-bs-target="#registerModal"
                                        class="fw-bold text-decoration-none">Create an account</a></span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="modal fade" id="registerModal" tabindex="-1" aria-labelledby="registerModalLabel"
                    aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content border-0 shadow">
                            <div class="modal-header bg-light">
                                <h5 class="modal-title fw-bold text-dark" id="registerModalLabel"><i
                                        class="bi bi-person-plus-fill me-2"></i>Join Cheatsheet Hub</h5>
                                <button type="button" class="btn-close shadow-none" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                            </div>
                            <div class="modal-body p-4">
                                <c:if test="${param.regError == 'true'}">
                                    <div class="alert alert-danger alert-dismissible fade show py-2 small" role="alert">
                                        ⚠️
                                        <c:out value="${sessionScope.regErrorMessage}" />
                                        <button type="button" class="btn-close" data-bs-dismiss="alert"
                                            aria-label="Close" style="padding: 0.8rem 1rem; font-size: 10px;"></button>
                                    </div>
                                </c:if>

                                <form action="${pageContext.request.contextPath}/register" method="POST">
                                    <div class="mb-3">
                                        <label class="form-label small fw-bold text-secondary">Full Name</label>
                                        <input type="text" name="name" class="form-control" placeholder="John Doe"
                                            required="required" value="<c:out value='${param.name}' />" />
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label small fw-bold text-secondary">Email Address</label>
                                        <input type="email" name="email" class="form-control"
                                            placeholder="john@example.com" required="required"
                                            value="<c:out value='${param.email}' />" />
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label small fw-bold text-secondary">Password</label>
                                        <div class="input-group">
                                            <input type="password" id="registerPasswordInput" name="password"
                                                class="form-control border-end-0 custom-placeholder"
                                                placeholder="Create password" required="required" />
                                            <button class="input-group-text bg-white border-start-0 text-muted"
                                                type="button" id="toggleRegPasswordBtn" style="cursor: pointer;">
                                                <i class="bi bi-eye" id="toggleRegPasswordIcon"></i>
                                            </button>
                                        </div>
                                    </div>

                                    <div class="mb-4">
                                        <label class="form-label small fw-bold text-secondary">Confirm Password</label>
                                        <div class="input-group">
                                            <input type="password" id="registerConfirmPasswordInput"
                                                name="confirmPassword"
                                                class="form-control border-end-0 custom-placeholder"
                                                placeholder="Repeat password" required="required" />
                                            <button class="input-group-text bg-white border-start-0 text-muted"
                                                type="button" id="toggleRegConfirmPasswordBtn" style="cursor: pointer;">
                                                <i class="bi bi-eye" id="toggleRegConfirmPasswordIcon"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <button type="submit" class="btn btn-success w-100 fw-bold">Create Account</button>
                                </form>
                            </div>
                            <div class="modal-footer bg-light justify-content-center border-0 py-3">
                                <span class="small text-muted">Already registered? <a href="javascript:void(0);"
                                        data-bs-toggle="modal" data-bs-target="#loginModal"
                                        class="fw-bold text-decoration-none">Log in here</a></span>
                            </div>
                        </div>
                    </div>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
                <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>

                <script>
                    function loadFollowSystemFeed(type) {
                        const ctx = "${pageContext.request.contextPath}";
                        const container = document.getElementById('followersContainer') || document.getElementById('followContainer');
                        const feedArea = document.getElementById('followersFeedArea') || document.getElementById('followFeedArea');
                        const heading = feedArea ? feedArea.querySelector('.section-heading') : null;

                        if (!container) return;
                        if (heading) heading.innerText = (type === 'followers') ? "👥 My Followers" : "🤝 Following Users";

                        const endpoint = (type === 'followers') ? '/follow/my-followers' : '/follow/my-following';

                        fetch(ctx + endpoint)
                            .then(res => res.json())
                            .then(users => {
                                container.innerHTML = "";
                                if (feedArea) feedArea.classList.remove('d-none');

                                if (users.length === 0) {
                                    container.innerHTML = `<div class="empty-box text-center w-100 py-5">No \${type} found yet.</div>`;
                                    return;
                                }

                                users.forEach(user => {
                                    const uId = user.id;
                                    const uName = user.name;
                                    const uEmail = user.email;
                                    const profileImg = user.profileImg ? user.profileImg : 'default.png';

                                    const userCard = `
                    <div class="card p-4 border-0 shadow-sm text-center align-items-center" style="border-radius: 24px; background: white; min-height: 220px;">
                        <img src="\${ctx}/uploads/profiles/\${profileImg}" style="width: 80px; height: 80px; border-radius: 50%; object-fit: cover; border: 3px solid #f1f5f9; box-shadow: 0 4px 12px rgba(0,0,0,0.06);" alt="user">
                        <h4 class="mt-3 fw-bold text-dark mb-1" style="font-size: 18px;">\${uName}</h4>
                        <p class="text-secondary small mb-3">\${uEmail}</p>
                        <a href="\${ctx}/profile/\${uId}" class="btn btn-primary btn-sm fw-bold px-4 rounded-pill" style="background-color: #2563eb; border:none; font-size: 13px;">View Profile</a>
                    </div>`;
                                    container.insertAdjacentHTML('beforeend', userCard);
                                });
                            })
                            .catch(err => console.error("Error loading feed:", err));
                    }

                    document.addEventListener("DOMContentLoaded", function () {
                        const passwordInput = document.getElementById("loginPasswordInput");
                        const togglePasswordBtn = document.getElementById("togglePasswordBtn");
                        const togglePasswordIcon = document.getElementById("togglePasswordIcon");

                        if (togglePasswordBtn && passwordInput) {
                            togglePasswordBtn.addEventListener("click", function () {
                                if (passwordInput.type === "password") {
                                    passwordInput.type = "text";
                                    togglePasswordIcon.classList.remove("bi-eye");
                                    togglePasswordIcon.classList.add("bi-eye-slash");
                                } else {
                                    passwordInput.type = "password";
                                    togglePasswordIcon.classList.remove("bi-eye-slash");
                                    togglePasswordIcon.classList.add("bi-eye");
                                }
                            });
                        }

                        function setupPasswordToggle(buttonId, inputId, iconId) {
                            const btn = document.getElementById(buttonId);
                            const input = document.getElementById(inputId);
                            const icon = document.getElementById(iconId);

                            if (btn && input && icon) {
                                btn.addEventListener("click", function () {
                                    if (input.type === "password") {
                                        input.type = "text";
                                        icon.classList.replace("bi-eye", "bi-eye-slash");
                                    } else {
                                        input.type = "password";
                                        icon.classList.replace("bi-eye-slash", "bi-eye");
                                    }
                                });
                            }
                        }

                        setupPasswordToggle("toggleRegPasswordBtn", "registerPasswordInput", "toggleRegPasswordIcon");
                        setupPasswordToggle("toggleRegConfirmPasswordBtn", "registerConfirmPasswordInput", "toggleRegConfirmPasswordIcon");

                        const urlParams = new URLSearchParams(window.location.search);
                        const ctx = "${pageContext.request.contextPath}";

                        function clearUrlParams() {
                            const cleanUrl = window.location.origin + window.location.pathname;
                            window.history.replaceState({ path: cleanUrl }, '', cleanUrl);
                        }

                        if (urlParams.get('error') === 'true') {
                            const loginEl = document.getElementById('loginModal');
                            if (loginEl) { bootstrap.Modal.getOrCreateInstance(loginEl).show(); clearUrlParams(); }
                        }
                        if (urlParams.get('regError') === 'true') {
                            const regEl = document.getElementById('registerModal');
                            if (regEl) { bootstrap.Modal.getOrCreateInstance(regEl).show(); clearUrlParams(); }
                        }
                        if (urlParams.get('login') === 'true') {
                            const loginEl = document.getElementById('loginModal');
                            if (loginEl) { bootstrap.Modal.getOrCreateInstance(loginEl).show(); clearUrlParams(); }
                        }
                        if (urlParams.get('unauthorized') === 'true') {
                            const loginEl = document.getElementById('loginModal');
                            if (loginEl) {
                                bootstrap.Modal.getOrCreateInstance(loginEl).show();
                                const modalBody = loginEl.querySelector('.modal-body');
                                if (modalBody && !document.getElementById('authErrorAlert')) {
                                    const alertDiv = document.createElement('div');
                                    alertDiv.id = 'authErrorAlert';
                                    alertDiv.className = 'alert alert-danger alert-dismissible fade show py-2 small';
                                    alertDiv.innerHTML = '🔒 Please sign in first to access that area.<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close" style="padding: 0.8rem 1rem; font-size: 10px;"></button>';
                                    modalBody.insertBefore(alertDiv, modalBody.firstChild);
                                }
                                clearUrlParams();
                            }
                        }

                        if (urlParams.get('regSuccess') === 'true') {
                            const loginEl = document.getElementById('loginModal');
                            if (loginEl) {
                                bootstrap.Modal.getOrCreateInstance(loginEl).show();
                                const modalBody = loginEl.querySelector('.modal-body');
                                if (modalBody && !document.getElementById('regSuccessAlert')) {
                                    const alertDiv = document.createElement('div');
                                    alertDiv.id = 'regSuccessAlert';
                                    alertDiv.className = 'alert alert-success alert-dismissible fade show py-2 small';
                                    alertDiv.innerHTML = '🎉 Account created successfully! Please sign in below.<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close" style="padding: 0.8rem 1rem; font-size: 10px;"></button>';
                                    modalBody.insertBefore(alertDiv, modalBody.firstChild);
                                }
                                clearUrlParams();
                            }
                        }

                        setTimeout(function () {
                            document.querySelectorAll('.alert-dismissible').forEach(function (alert) {
                                bootstrap.Alert.getOrCreateInstance(alert).close();
                            });
                        }, 4000);

                        const searchInput = document.getElementById("headerSearchInput");
                        const suggestBox = document.getElementById("searchSuggestBox");
                        const suggestContent = document.getElementById("suggestContent");

                        searchInput.addEventListener("focus", function () {
                            if (searchInput.value.trim() === "") {
                                fetch(ctx + '/search/history')
                                    .then(res => res.json())
                                    .then(data => {
                                        if (!data || data.length === 0) { suggestBox.classList.add("d-none"); return; }
                                        let html = `<div class="p-2 small fw-bold text-muted border-bottom mb-1"><i class="bi bi-clock-history me-1"></i> Recent Searches</div>`;
                                        let hasItems = false;
                                        data.forEach(item => {
                                            let keyword = (typeof item === 'object' && item !== null) ? item.keyword : item;
                                            if (keyword && keyword.trim() !== "") {
                                                hasItems = true;
                                                html += `<a href="` + ctx + `/search?query=` + encodeURIComponent(keyword.trim()) + `" class="dropdown-item py-2 text-truncate rounded px-3"><i class="bi bi-arrow-left-right me-2 text-muted small"></i>` + keyword.trim() + `</a>`;
                                            }
                                        });
                                        if (hasItems) { suggestContent.innerHTML = html; suggestBox.classList.remove("d-none"); }
                                        else { suggestBox.classList.add("d-none"); }
                                    }).catch(err => suggestBox.classList.add("d-none"));
                            }
                        });

                        searchInput.addEventListener("input", function () {
                            const query = searchInput.value.trim();
                            if (query === "") { searchInput.dispatchEvent(new Event("focus")); return; }

                            fetch(ctx + '/search/live?query=' + encodeURIComponent(query))
                                .then(res => res.json())
                                .then(data => {
                                    let html = "";
                                    let hasCheatsheets = false, hasCategories = false, hasUsers = false;
                                    let cheatsheetHtml = `<div class="p-2 small fw-bold text-primary"><i class="bi bi-file-earmark-text me-1"></i> Cheatsheets</div>`;
                                    let categoryHtml = `<div class="p-2 small fw-bold text-success mt-2"><i class="bi bi-folder me-1"></i> Categories</div>`;
                                    let userHtml = `<div class="p-2 small fw-bold text-warning mt-2"><i class="bi bi-person me-1"></i> Users</div>`;

                                    data.forEach(item => {
                                        if (item.type === 'cheatsheet') { hasCheatsheets = true; cheatsheetHtml += `<a href="` + ctx + `/cheatsheet/` + item.id + `" class="dropdown-item py-2 text-truncate rounded px-3">` + item.name + `</a>`; }
                                        else if (item.type === 'category') { hasCategories = true; categoryHtml += `<a href="` + ctx + `/category/` + item.id + `" class="dropdown-item py-2 text-truncate rounded px-3">` + item.name + `</a>`; }
                                        else if (item.type === 'user') { hasUsers = true; userHtml += `<a href="` + ctx + `/profile/` + item.id + `" class="dropdown-item py-2 text-truncate rounded px-3">` + item.name + `</a>`; }
                                    });

                                    if (hasCheatsheets) html += cheatsheetHtml;
                                    if (hasCategories) html += categoryHtml;
                                    if (hasUsers) html += userHtml;
                                    if (!hasCheatsheets && !hasCategories && !hasUsers) html = `<div class="p-3 text-center text-muted small">No immediate results match "` + query + `"</div>`;

                                    suggestContent.innerHTML = html; suggestBox.classList.remove("d-none");
                                });
                        });

                        document.addEventListener("click", function (e) {
                            if (!searchInput.contains(e.target) && !suggestBox.contains(e.target)) { suggestBox.classList.add("d-none"); }
                        });

                        const socket = new SockJS(ctx + '/ws-notifications');
                        const stompClient = Stomp.over(socket);
                        stompClient.connect({}, function (frame) {
                            stompClient.subscribe('/topic/notifications-' + '${sessionScope.currentUser.id}', function (response) {
                                appendNewLiveNotification(JSON.parse(response.body));
                            });
                        });

                        document.querySelectorAll('button[data-bs-toggle="dropdown"], a.dropdown-toggle').forEach(function (element) {
                            element.addEventListener('click', function (e) {
                                e.stopPropagation();
                            });
                        });
                    });

                    function appendNewLiveNotification(data) {
                        const badge = document.getElementById('notiBadge');
                        const notiList = document.getElementById('notiList');
                        if (badge) { badge.innerText = (parseInt(badge.innerText.trim()) || 0) + 1; }
                        else {
                            const dropdownBtn = document.querySelector("#notificationDropdownArea button");
                            if (dropdownBtn) dropdownBtn.insertAdjacentHTML('beforeend', `<span id="notiBadge" class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" style="font-size: 9px; padding: 0.35em 0.5em;">1</span>`);
                        }
                        if (notiList) {
                            if (notiList.querySelector('.text-center')) notiList.innerHTML = '';
                            notiList.insertAdjacentHTML('afterbegin', `<li class="border-bottom list-unstyled"><a class="dropdown-item p-3 text-wrap d-flex flex-column gap-1" href="javascript:void(0);"><div class="fw-bold text-dark small d-flex align-items-center gap-1"><i class="bi bi-chat-left-text-fill text-primary small"></i> \${data.title}</div><div class="text-secondary" style="font-size: 12px; line-height:1.4;">\${data.message}</div></a></li>`);
                        }
                    }

                    function readNotification(id, url) {
                        fetch('${pageContext.request.contextPath}/notification/read?id=' + id, { method: 'POST' }).then(res => { if (res.ok) window.location.href = url; });
                    }

                    function markAllAsRead() {
                        fetch('${pageContext.request.contextPath}/notification/read-all', { method: 'POST' }).then(res => {
                            if (res.ok) {
                                if (document.getElementById('notiBadge')) document.getElementById('notiBadge').remove();
                                if (document.getElementById('notiList')) document.getElementById('notiList').innerHTML = `<li class="text-center py-4 text-muted small list-unstyled"><i class="bi bi-bell-slash d-block fs-3 mb-1 text-secondary"></i>No new notifications</li>`;
                            }
                        });
                    }
                </script>
                </body>

                </html>