<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css" rel="stylesheet">

<header class="bg-white px-4 py-3 d-flex justify-content-between align-items-center shadow-sm">
    <h2 class="m-0" style="color:#2563eb; font-weight: 700;">
        <a href="${pageContext.request.contextPath}/" class="text-decoration-none">
            CheatSheet Hub
        </a>
    </h2>
    <form action="${pageContext.request.contextPath}/search" method="GET" class="d-flex mx-4 position-relative" style="width: 45%; max-width: 600px;">
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
        <a href="${pageContext.request.contextPath}/" class="text-decoration-none text-secondary fw-semibold">
            Home
        </a>

        <c:choose>
            <c:when test="${not empty sessionScope.currentUser}">
                <div class="dropdown" id="notificationDropdownArea">
                    <button class="btn btn-link text-dark p-1 position-relative border-0 shadow-none dropdown-toggle text-decoration-none no-caret" 
                            type="button" 
                            data-bs-toggle="dropdown" 
                            aria-expanded="false">
                        <i class="bi bi-bell fs-5"></i>
                        <c:if test="${not empty unreadNotifications && fn:length(unreadNotifications) > 0}">
                            <span id="notiBadge" class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" style="font-size: 9px; padding: 0.35em 0.5em;">
                                ${fn:length(unreadNotifications)}
                            </span>
                        </c:if>
                    </button>
                    
<ul class="dropdown-menu dropdown-menu-end shadow border-0 py-2 mt-2"
    style="width: 320px; max-height: 400px; overflow-y: auto; z-index: 1100;">

    <!-- Header -->
    <li class="px-3 py-2 fw-bold text-dark border-bottom small d-flex justify-content-between align-items-center">
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

        <!-- ================= UNREAD ================= -->
        <c:if test="${not empty unreadNotifications}">

            <c:forEach var="noti" items="${unreadNotifications}">

                <li class="border-bottom list-unstyled bg-light">

                    <a class="dropdown-item p-3 text-wrap d-flex flex-column gap-1"
                       href="javascript:void(0);"
                       onclick="readNotification(${noti.id}, '${pageContext.request.contextPath}/cheatsheet/${noti.referenceId}')">

                        <div class="fw-bold text-dark small d-flex align-items-center gap-2">
                            <i class="bi bi-bell-fill text-primary"></i>
                            ${noti.title}
                        </div>

                        <div class="text-secondary"
                             style="font-size:12px;line-height:1.4;">
                            ${noti.message}
                        </div>

                    </a>

                </li>

            </c:forEach>

        </c:if>

        <!-- Empty -->
        <c:if test="${empty unreadNotifications && empty readNotificationsHistory}">
            <li class="text-center py-4 text-muted small list-unstyled">
                <i class="bi bi-bell-slash d-block fs-3 mb-2"></i>
                No notifications
            </li>
        </c:if>

        <!-- ================= HISTORY ================= -->

        <c:if test="${not empty readNotificationsHistory}">

            <li><hr class="dropdown-divider"></li>

            <li class="dropdown-header fw-bold text-secondary">
                Notification History
            </li>

            <c:forEach var="history" items="${readNotificationsHistory}">

                <li class="border-bottom list-unstyled">

                    <a class="dropdown-item p-3 text-wrap d-flex flex-column gap-1 text-muted"
                       href="${pageContext.request.contextPath}/cheatsheet/${history.referenceId}">

                        <div class="small d-flex align-items-center gap-2">
                            <i class="bi bi-check-circle text-success"></i>
                            ${history.title}
                        </div>

                        <div style="font-size:12px;">
                            ${history.message}
                        </div>

                    </a>

                </li>

            </c:forEach>

        </c:if>

    </div>

</ul>
                </div>

                <a href="${pageContext.request.contextPath}/admin/cheatsheet/create" class="text-decoration-none text-secondary fw-semibold">
                    Create Cheatsheet
                </a>
                <a href="#" class="text-decoration-none text-secondary fw-semibold">
                    Profile
                </a>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger btn-sm fw-bold px-3 rounded-2">
                    Logout
                </a>
            </c:when>
            <c:otherwise>
                <button type="button" class="btn btn-outline-primary btn-sm fw-bold px-3 rounded-2" data-bs-toggle="modal" data-bs-target="#loginModal">
                    Login
                </button>
                <button type="button" class="btn btn-primary btn-sm fw-bold px-3 rounded-2" data-bs-toggle="modal" data-bs-target="#registerModal">
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
/* Reduce placeholder visibility by making it 40% opaque */
.custom-placeholder::placeholder {
    opacity: 0.4;
}

/* For older webkit browsers */
.custom-placeholder::-webkit-input-placeholder {
    opacity: 0.4;
}

/* Ensure focus highlights look clean even with a split border-group */
.input-group:focus-within .form-control,
.input-group:focus-within .input-group-text {
    border-color: #86b7fe;
    box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25);
}
</style>

<!-- Login Modal -->
<div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow">
            <div class="modal-header bg-light">
                <h5 class="modal-title fw-bold text-dark" id="loginModalLabel"><i class="bi bi-box-arrow-in-right me-2"></i>Account Login</h5>
                <button type="button" class="btn-close shadow-none" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body p-4">
                <c:if test="${param.error == 'true'}">
                    <div class="alert alert-danger alert-dismissible fade show py-2 small" role="alert">
                        <i class="bi bi-exclamation-triangle-fill me-1"></i> Invalid email or password. Please try again.
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close" style="padding: 0.8rem 1rem; font-size: 10px;"></button>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/login" method="POST">
                    <div class="mb-3">
                        <label class="form-label small fw-bold text-secondary">Email Address</label>
                        <input type="email" name="email" class="form-control" required="required" placeholder="name@example.com" />
                    </div>
						<div class="mb-3">
						    <label class="form-label small fw-bold text-secondary">Password</label>
						    <div class="input-group">
						        <!-- Added a custom class 'custom-placeholder' here -->
						        <input type="password" id="loginPasswordInput" name="password" 
						               class="form-control border-end-0 custom-placeholder" 
						               required="required" placeholder="••••••••" />
						        
						        <!-- Toggle Icon Button -->
						        <button class="input-group-text bg-white border-start-0 text-muted" 
						                type="button" id="togglePasswordBtn" style="cursor: pointer;">
						            <i class="bi bi-eye" id="togglePasswordIcon"></i>
						        </button>
						    </div>
						</div>
                    
                    <div class="mb-4 d-flex justify-content-between align-items-center">
                        <div class="form-check m-0">
                            <input type="checkbox" class="form-check-input" id="rememberMeCheck" name="remember-me">
                            <label class="form-check-label small text-muted" for="rememberMeCheck">Remember me</label>
                        </div>
                        <div>
                            <a href="${pageContext.request.contextPath}/forgot-password" class="small text-decoration-none fw-semibold">Forgot Password?</a>
                        </div>
                    </div>
                    
                    <button type="submit" class="btn btn-primary w-100 fw-bold">Sign In</button>
                </form>
            </div>
            <div class="modal-footer bg-light justify-content-center border-0 py-3">
                <span class="small text-muted">New here? <a href="javascript:void(0);" data-bs-toggle="modal" data-bs-target="#registerModal" class="fw-bold text-decoration-none">Create an account</a></span>
            </div>
        </div>
    </div>
</div>

<!-- Register Modal -->
<div class="modal fade" id="registerModal" tabindex="-1" aria-labelledby="registerModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow">
            <div class="modal-header bg-light">
                <h5 class="modal-title fw-bold text-dark" id="registerModalLabel"><i class="bi bi-person-plus-fill me-2"></i>Join Cheatsheet Hub</h5>
                <button type="button" class="btn-close shadow-none" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body p-4">
                <c:if test="${param.regError == 'true'}">
                    <div class="alert alert-danger alert-dismissible fade show py-2 small" role="alert">
                        ⚠️ <c:out value="${sessionScope.regErrorMessage}" />
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close" style="padding: 0.8rem 1rem; font-size: 10px;"></button>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/register" method="POST">
                    <div class="mb-3">
                        <label class="form-label small fw-bold text-secondary">Full Name</label>
                        <input type="text" name="name" class="form-control" placeholder="John Doe" required="required" value="<c:out value='${param.name}' />" />
                    </div>
                    <div class="mb-3">
                        <label class="form-label small fw-bold text-secondary">Email Address</label>
                        <input type="email" name="email" class="form-control" placeholder="john@example.com" required="required" value="<c:out value='${param.email}' />" />
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
        <input type="password" id="registerConfirmPasswordInput" name="confirmPassword" 
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
                <span class="small text-muted">Already registered? <a href="javascript:void(0);" data-bs-toggle="modal" data-bs-target="#loginModal" class="fw-bold text-decoration-none">Log in here</a></span>
            </div>
        </div>
    </div>
</div>

<!-- STEP 0 FIX: External Script Dependencies Added Here -->
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>

<script>
document.addEventListener("DOMContentLoaded", function() {
	
	// --- SHOW/HIDE PASSWORD TOGGLE ---
    const passwordInput = document.getElementById("loginPasswordInput");
    const togglePasswordBtn = document.getElementById("togglePasswordBtn");
    const togglePasswordIcon = document.getElementById("togglePasswordIcon");

    if (togglePasswordBtn && passwordInput) {
        togglePasswordBtn.addEventListener("click", function() {
            // Check current type and flip it
            if (passwordInput.type === "password") {
                passwordInput.type = "text";
                // Swap icon to 'eye-slash'
                togglePasswordIcon.classList.remove("bi-eye");
                togglePasswordIcon.classList.add("bi-eye-slash");
            } else {
                passwordInput.type = "password";
                // Swap icon back to normal 'eye'
                togglePasswordIcon.classList.remove("bi-eye-slash");
                togglePasswordIcon.classList.add("bi-eye");
            }
        });
    }
 // --- REGISTRATION PASSWORD TOGGLES ---
    function setupPasswordToggle(buttonId, inputId, iconId) {
        const btn = document.getElementById(buttonId);
        const input = document.getElementById(inputId);
        const icon = document.getElementById(iconId);

        if (btn && input && icon) {
            btn.addEventListener("click", function() {
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

    // Initialize toggles for both registration fields
    setupPasswordToggle("toggleRegPasswordBtn", "registerPasswordInput", "toggleRegPasswordIcon");
    setupPasswordToggle("toggleRegConfirmPasswordBtn", "registerConfirmPasswordInput", "toggleRegConfirmPasswordIcon");
	
    const urlParams = new URLSearchParams(window.location.search);
    const ctx = "${pageContext.request.contextPath}";
    
    function clearUrlParams() {
        const cleanUrl = window.location.protocol + "//" + window.location.host + window.location.pathname;
        window.history.replaceState({ path: cleanUrl }, '', cleanUrl);
    }
    
    // --- STABLE MODAL ROUTING MECHANICS ---
    if (urlParams.get('error') === 'true') {
        const loginEl = document.getElementById('loginModal');
        if (loginEl) {
            bootstrap.Modal.getOrCreateInstance(loginEl).show();
            clearUrlParams();
        }
    }

    if (urlParams.get('regError') === 'true') {
        const regEl = document.getElementById('registerModal');
        if (regEl) {
            bootstrap.Modal.getOrCreateInstance(regEl).show();
            clearUrlParams();
        }
    }
    if (urlParams.get('login') === 'true') {
		const loginEl = document.getElementById('loginModal');
		if (loginEl) {
			bootstrap.Modal.getOrCreateInstance(loginEl).show();
			clearUrlParams();
		}
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
                alertDiv.innerHTML = '🔒 Please sign in first to access that area.' +
                                      '<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close" style="padding: 0.8rem 1rem; font-size: 10px;"></button>';
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
                alertDiv.innerHTML = '🎉 Account created successfully! Please sign in below.' +
                                      '<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close" style="padding: 0.8rem 1rem; font-size: 10px;"></button>';
                modalBody.insertBefore(alertDiv, modalBody.firstChild);
            }
            clearUrlParams();
        }
    }

    // --- AUTOMATIC ALERTS TIMEOUT FADE ---
    setTimeout(function() {
        const activeAlerts = document.querySelectorAll('.alert-dismissible');
        activeAlerts.forEach(function(alert) {
            const bsAlert = bootstrap.Alert.getOrCreateInstance(alert);
            bsAlert.close();
        });
    }, 4000);

    // --- SEARCH INFRASTRUCTURE ---
    const searchInput = document.getElementById("headerSearchInput");
    const suggestBox = document.getElementById("searchSuggestBox");
    const suggestContent = document.getElementById("suggestContent");

    searchInput.addEventListener("focus", function() {
        if (searchInput.value.trim() === "") {
            fetch(ctx + '/search/history')
                .then(res => res.json())
                .then(data => {
                    if (!data || data.length === 0) {
                        suggestBox.classList.add("d-none");
                        return;
                    }
                    
                    let html = `<div class="p-2 small fw-bold text-muted border-bottom mb-1"><i class="bi bi-clock-history me-1"></i> Recent Searches</div>`;
                    let hasItems = false;
                    
                    data.forEach(item => {
                        let keyword = "";
                        if (typeof item === 'object' && item !== null) {
                            keyword = item.keyword || ""; 
                        } else {
                            keyword = item; 
                        }
                        
                        if (keyword && keyword.trim() !== "") {
                            hasItems = true;
                            html += `<a href="` + ctx + `/search?query=` + encodeURIComponent(keyword.trim()) + `" class="dropdown-item py-2 text-truncate rounded px-3"><i class="bi bi-arrow-left-right me-2 text-muted small"></i>` + keyword.trim() + `</a>`;
                        }
                    });
                    
                    if (hasItems) {
                        suggestContent.innerHTML = html;
                        suggestBox.classList.remove("d-none");
                    } else {
                        suggestBox.classList.add("d-none");
                    }
                })
                .catch(err => {
                    console.error("Failed to fetch search history:", err);
                    suggestBox.classList.add("d-none");
                });
        }
    });

    searchInput.addEventListener("input", function() {
        const query = searchInput.value.trim();
        if (query === "") {
            searchInput.dispatchEvent(new Event("focus")); 
            return;
        }

        fetch(ctx + '/search/live?query=' + encodeURIComponent(query))
            .then(res => res.json())
            .then(data => {
                let html = "";
                let hasCheatsheets = false;
                let hasCategories = false;
                let hasUsers = false;

                let cheatsheetHtml = `<div class="p-2 small fw-bold text-primary"><i class="bi bi-file-earmark-text me-1"></i> Cheatsheets</div>`;
                let categoryHtml = `<div class="p-2 small fw-bold text-success mt-2"><i class="bi bi-folder me-1"></i> Categories</div>`;
                let userHtml = `<div class="p-2 small fw-bold text-warning mt-2"><i class="bi bi-person me-1"></i> Users</div>`;

                data.forEach(item => {
                    if (item.type === 'cheatsheet') {
                        hasCheatsheets = true;
                        cheatsheetHtml += `<a href="` + ctx + `/cheatsheet/` + item.id + `" class="dropdown-item py-2 text-truncate rounded px-3">` + item.name + `</a>`;
                    } else if (item.type === 'category') {
                        hasCategories = true;
                        categoryHtml += `<a href="` + ctx + `/category/` + item.id + `" class="dropdown-item py-2 text-truncate rounded px-3">` + item.name + `</a>`;
                    } else if(item.type === 'user') {
                        hasUsers = true;
                        userHtml += `<a href="` + ctx + `/user/` + item.id + `" class="dropdown-item py-2 text-truncate rounded px-3">` + item.name + `</a>`;
                    }
                });

                if (hasCheatsheets) html += cheatsheetHtml;
                if (hasCategories) html += categoryHtml;
                if (hasUsers) html += userHtml;

                if (!hasCheatsheets && !hasCategories && !hasUsers) {
                    html = `<div class="p-3 text-center text-muted small">No immediate results match "` + query + `"</div>`;
                }

                suggestContent.innerHTML = html;
                suggestBox.classList.remove("d-none");
            })
            .catch(err => {
                console.error("Live Search Error Details:", err);
            });
    });

    document.addEventListener("click", function(e) {
        if (!searchInput.contains(e.target) && !suggestBox.contains(e.target)) {
            suggestBox.classList.add("d-none");
        }
    });

 // --- REAL-TIME WEBSOCKET LISTENER ---
    const socket = new SockJS(ctx + '/ws-notifications');
    const stompClient = Stomp.over(socket);

    stompClient.connect({}, function (frame) {
        console.log('Connected to WebSocket server successfully!');
        
        // Dynamically append the logged-in user's ID to match your backend destination precisely
        stompClient.subscribe('/topic/notifications-' + '${sessionScope.currentUser.id}', function (response) {
            const notiData = JSON.parse(response.body);
            appendNewLiveNotification(notiData);
        });
    }, function(error) {
        console.error('WebSocket broker connection failure:', error);
    });
});

// --- INDEPENDENT GLOBAL SCOPE FUNCTIONS ---

function appendNewLiveNotification(data) {
    const badge = document.getElementById('notiBadge');
    const notiList = document.getElementById('notiList');
    
    if (badge) {
        let currentCount = parseInt(badge.innerText.trim()) || 0;
        badge.innerText = currentCount + 1;
    } else {
        const dropdownBtn = document.querySelector("#notificationDropdownArea button");
        if(dropdownBtn) {
            dropdownBtn.insertAdjacentHTML('beforeend', 
                `<span id="notiBadge" class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" style="font-size: 9px; padding: 0.35em 0.5em;">1</span>`
            );
        }
    }
    
    if (notiList) {
        const emptyPlaceholder = notiList.querySelector('.text-center');
        if (emptyPlaceholder) {
            notiList.innerHTML = ''; 
        }
        
        const newNotiHtml = `
            <li class="border-bottom list-unstyled">
                <a class="dropdown-item p-3 text-wrap d-flex flex-column gap-1" href="javascript:void(0);">
                    <div class="fw-bold text-dark small d-flex align-items-center gap-1">
                        <i class="bi bi-chat-left-text-fill text-primary small"></i> \${data.title}
                    </div>
                    <div class="text-secondary tracking-normal line-clamp-2" style="font-size: 12px; line-height:1.4;">
                        \${data.message}
                    </div>
                </a>
            </li>`;
            
        notiList.insertAdjacentHTML('afterbegin', newNotiHtml);
    }
}

function readNotification(notificationId, redirectUrl) {
    fetch('${pageContext.request.contextPath}/notification/read?id=' + notificationId, {
        method: 'POST'
    }).then(response => {
        if (response.ok) {
            window.location.href = redirectUrl;
        }
    }).catch(err => console.error("Notification clearance failed:", err));
}

function markAllAsRead() {
    fetch('${pageContext.request.contextPath}/notification/read-all', { method: 'POST' })
    .then(res => {
        if (res.ok) {
            document.getElementById('notiBadge')?.remove();
            const notiList = document.getElementById('notiList');
            if (notiList) {
                notiList.innerHTML = `<li class="text-center py-4 text-muted small list-unstyled"><i class="bi bi-bell-slash d-block fs-3 mb-1 text-secondary"></i>No new notifications</li>`;
            }
        }
    });
}
</script>