<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>DevNote - Admin Cheatsheet Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root { 
            --bg-canvas: #f4fbfc; 
            --brand-green: #047857; 
            --brand-blue: #2563eb;
            --text-dark: #1e293b; 
            --text-gray: #64748b; 
            --border-light: #e2e8f0; 
            --shadow-premium: 0 20px 25px -5px rgba(0, 0, 0, 0.02), 0 8px 10px -6px rgba(0, 0, 0, 0.02);
        }
        body { font-family: 'Plus Jakarta Sans', sans-serif; background-color: var(--bg-canvas); color: var(--text-dark); margin: 0; padding: 0; }
        
        /* Layout configuration */
        .page-container { display: flex; flex-direction: column; min-height: 100vh; }
        .content-body-wrapper { display: flex; padding: 28px; gap: 28px; flex: 1; }
        .main-workspace { flex-grow: 1; }
        
        .workspace-card { background-color: #ffffff; border-radius: 24px; padding: 32px; box-shadow: var(--shadow-premium); border: 1px solid rgba(226, 232, 240, 0.8); }
        .top-header-row { display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; }
        .filter-select { border-radius: 12px; border: 1px solid var(--border-light); padding: 10px 16px; font-size: 14px; background-color: #f8fafc; font-weight: 500; width: 180px; }
        .search-input { border-radius: 12px 0 0 12px !important; border: 1px solid var(--border-light); padding: 11px 16px; font-size: 14px; background-color: #f8fafc; }
        .search-btn { border-radius: 0 12px 12px 0 !important; background-color: var(--brand-blue); border-color: var(--brand-blue); color: #ffffff; }
        .blue-header-box { background: linear-gradient(135deg, #1e40af, #2563eb); color: #ffffff; padding: 24px 32px; border-radius: 20px; margin-bottom: 28px; }
        .cheatsheet-horizontal-box { background-color: #ffffff; border: 1px solid var(--border-light); border-radius: 16px; padding: 18px 24px; display: flex; align-items: center; justify-content: space-between; margin-bottom: 16px; transition: all 0.2s; }
        .cheatsheet-horizontal-box:hover { border-color: var(--brand-blue); transform: translateY(-2px); }
        .box-info-grid { display: grid; grid-template-columns: 240px 160px 200px 160px; gap: 20px; align-items: center; }
        .sheet-title { font-weight: 700; font-size: 16px; color: var(--text-dark); }
        .uploader-info { display: flex; align-items: center; gap: 8px; margin-top: 4px; }
        .uploader-avatar { width: 24px; height: 24px; border-radius: 50%; background-color: #e2e8f0; }
        .uploader-name { font-size: 13px; font-weight: 600; color: var(--text-gray); }
        .category-badge { font-size: 12px; font-weight: 700; padding: 6px 12px; border-radius: 8px; background-color: #f1f5f9; color: #475569; }
        .tag-pill { font-size: 11px; font-weight: 600; padding: 3px 8px; border-radius: 6px; background-color: #eff6ff; color: #3b82f6; border: 1px solid #bfdbfe; margin-right: 4px; }
        .upload-time { font-size: 13px; color: var(--text-gray); }
        .btn-action-view { background-color: #eff6ff; color: var(--brand-blue); padding: 8px 14px; font-size: 13px; font-weight: 600; border-radius: 10px; text-decoration: none; border: 1px solid #bfdbfe; }
        .btn-delete-sheet { background-color: #fff1f2; color: #e11d48; padding: 8px 12px; border-radius: 10px; border: none; }
        .hidden-by-filter { display: none !important; }

        /* Footer Style */
        .site-footer { background: #111827; color: white; margin-top: 60px; padding: 40px 20px; }
        .footer-container { max-width: 1200px; margin: auto; text-align: center; }
        .footer-container h3 { margin-bottom: 10px; font-size: 24px; }
        .footer-container p { color: #d1d5db; margin-bottom: 8px; }
        .copyright { margin-top: 15px; font-size: 14px; color: #9ca3af; }
    </style>
</head>
<body>

    <div class="page-container">
        <header style="background:white; padding:20px 50px; display:flex; justify-content:space-between; align-items:center; box-shadow:0 2px 20px rgba(0,0,0,.05);">
            <h2 style="color:#2563eb; margin:0;">CheatSheet Hub</h2>
            <nav style="display:flex; gap:25px;">
                <a href="${pageContext.request.contextPath}/" style="text-decoration:none; color:#334155; font-weight: 600;">Home</a>
                <a href="${pageContext.request.contextPath}/admin/cheatsheet/create" style="text-decoration:none; color:#334155; font-weight: 600;">Create Cheatsheet</a>
                <a href="${pageContext.request.contextPath}/admin/profile" style="text-decoration:none; color:#334155; font-weight: 600;">Profile</a>
            </nav>
        </header>

        <div class="content-body-wrapper">
            <jsp:include page="sidebar.jsp" />

            <div class="main-workspace">
                <div class="workspace-card">
                    <div class="top-header-row">
                        <div class="d-flex gap-2">
                            <select id="parentCategoryFilter" class="form-select filter-select" onchange="updateSubCategories()">
                                <option value="ALL">All Main Categories</option>
                                <c:forEach var="mainCat" items="${categories}">
                                    <c:if test="${empty mainCat.parent}">
                                        <option value="${mainCat.id}"><c:out value="${mainCat.name}"/></option>
                                    </c:if>
                                </c:forEach>
                            </select>

                            <select id="subCategoryFilter" class="form-select filter-select" onchange="handleCategoryChange()" disabled>
                                <option value="ALL">All Sub Categories</option>
                            </select>

                            <select id="tagFilter" class="form-select filter-select" onchange="filterCheatsheets()">
                                <option value="ALL" data-category="ALL">All Tags</option>
                                <c:forEach var="t" items="${tags}">
                                    <option value="${t.id}" data-category="${t.category.id}">#<c:out value="${t.name}"/></option>
                                </c:forEach>
                            </select>
                        </div>
                        <div style="width: 300px;">
                            <div class="input-group">
                                <input type="text" id="searchInput" class="form-control search-input" placeholder="Search sheet title..." oninput="filterCheatsheets()">
                                <button class="btn search-btn" type="button"><i class="fa-solid fa-magnifying-glass"></i></button>
                            </div>
                        </div>
                    </div>
                    
                    <div class="blue-header-box">
                        <h2 class="m-0 fw-bold">Admin Cheatsheet Repository</h2>
                        <p class="m-0 opacity-75 mt-1">Review and manage core developer technical submissions.</p>
                    </div>
                    
                    <div class="cheatsheet-list-container">
                        <c:forEach var="sheet" items="${adminCheatsheets}">
                            <div class="sheet-data-item" 
                                 data-title="${sheet.title.toLowerCase()}" 
                                 data-category="${sheet.category.id}" 
                                 data-tags="<c:forEach var='t' items='${sheet.tags}' varStatus='vs'>${t.id}${!vs.last ? ',' : ''}</c:forEach>">
                                 
                                <div class="cheatsheet-horizontal-box">
                                    <div class="box-info-grid">
                                        <div>
                                            <div class="sheet-title"><c:out value="${sheet.title}"/></div>
                                            <div class="uploader-info">
                                                <img src="${not empty sheet.user.profileImg ? sheet.user.profileImg : pageContext.request.contextPath.concat('/resources/images/default-avatar.png')}" class="uploader-avatar">
                                                <span class="uploader-name"><c:out value="${sheet.user.name}"/></span>
                                            </div>
                                        </div>
                                        <div>
                                            <span class="category-badge"><i class="fa-solid fa-folder-open me-1"></i> <c:out value="${sheet.category.name}"/></span>
                                        </div>
                                        <div>
                                            <c:forEach var="t" items="${sheet.tags}">
                                                <span class="tag-pill">#<c:out value="${t.name}"/></span>
                                            </c:forEach>
                                        </div>
                                        <div class="upload-time">
                                            <i class="fa-regular fa-clock me-1"></i>
                                            <fmt:parseDate value="${sheet.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both" />
                                            <fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd HH:mm"/>
                                        </div>
                                    </div>
                                    
                                    <div class="d-flex align-items-center gap-2">
                                        <a href="${pageContext.request.contextPath}/cheatsheets/view/${sheet.id}" class="btn-action-view"><i class="fa-regular fa-eye"></i> View</a>
                                        <form action="${pageContext.request.contextPath}/admin/cheatsheet/delete/${sheet.id}" method="POST" onsubmit="return confirm('Remove permanent?');" class="m-0">
                                            <button type="submit" class="btn-delete-sheet"><i class="fa-solid fa-trash-can"></i></button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>

        <footer class="site-footer">
            <div class="footer-container">
                <h3>CheatSheet Hub</h3>
                <p>Learn Faster. Share Knowledge. Build Better.</p>
                <p class="copyright">© 2026 CheatSheet Hub. All Rights Reserved.</p>
            </div>
        </footer>
    </div>

    <script>
        // ✅ JSTL က လာမယ့် categories list ကို JavaScript Array ပြောင်းလဲသိမ်းဆည်းခြင်း
        const allCategories = [
            <c:forEach var="cat" items="${categories}" varStatus="status">
                {
                    id: "${cat.id}",
                    name: "<c:out value='${cat.name}'/>",
                    parentId: "${not empty cat.parent ? cat.parent.id : ''}"
                }${not status.last ? ',' : ''}
            </c:forEach>
        ];

        // ✅ Parent Category ပြောင်းလိုက်ရင် Sub Category စာရင်းကို အလိုအလျောက် update လုပ်ပေးမည့် Function
        function updateSubCategories() {
            const parentSelect = document.getElementById("parentCategoryFilter");
            const subSelect = document.getElementById("subCategoryFilter");
            const selectedParentId = parentSelect.value;

            // လက်ရှိ sub-category options တွေကို အကုန်ရှင်းထုတ်ပြီး reset ချမယ်
            subSelect.innerHTML = '<option value="ALL">All Sub Categories</option>';

            if (selectedParentId === "ALL") {
                subSelect.disabled = true;
            } else {
                // ရွေးချယ်လိုက်တဲ့ Parent ID နဲ့ ကိုက်ညီတဲ့ Child Categories တွေကိုပဲ Filter စစ်ထုတ်မယ်
                const filteredSubs = allCategories.filter(cat => cat.parentId === selectedParentId);

                if (filteredSubs.length > 0) {
                    filteredSubs.forEach(sub => {
                        const option = document.createElement("option");
                        option.value = sub.id;
                        option.textContent = sub.name;
                        subSelect.appendChild(option);
                    });
                    subSelect.disabled = false;
                } else {
                    subSelect.disabled = true;
                }
            }
            
            // Sub Category အသစ်ပြောင်းလဲမှုအတွက် Tag filter တွေကိုပါ ချိန်ညှိရန် လှမ်းခေါ်ခြင်း
            handleCategoryChange();
        }

        // ✅ ရွေးချယ်ထားသော Category အလိုက် Tag mapping များကိုပါ စစ်ထုတ်ပေးမည့် Function
        function handleCategoryChange() {
            const parentCatId = document.getElementById("parentCategoryFilter").value;
            const subCatId = document.getElementById("subCategoryFilter").value;
            
            // Filter အတွက် သုံးမယ့် ဗဟို Category ID (Sub ရှိရင် SubID၊ မရှိရင် ParentID)
            const targetCatId = (subCatId !== "ALL") ? subCatId : parentCatId;

            const tagFilter = document.getElementById("tagFilter");
            const tagOptions = tagFilter.options;

            tagFilter.value = "ALL";

            for (let i = 0; i < tagOptions.length; i++) {
                const option = tagOptions[i];
                const associatedCatId = option.getAttribute("data-category");

                if (targetCatId === "ALL" || associatedCatId === "ALL" || associatedCatId === targetCatId) {
                    option.style.display = ""; 
                } else {
                    option.style.display = "none"; 
                }
            }

            // နောက်ဆုံးအဆင့် UI ကတ်များကို Filter ပတ်ရန် ခေါ်ခြင်း
            filterCheatsheets();
        }

        // ✅ UI ပေါ်ရှိ Cheatsheet Items များကို ရှာဖွေစစ်ထုတ်ပေးသော ဗဟို Function
        function filterCheatsheets() {
            const parentCatId = document.getElementById("parentCategoryFilter").value;
            const subCatId = document.getElementById("subCategoryFilter").value;
            const tagId = document.getElementById("tagFilter").value;
            const search = document.getElementById("searchInput").value.trim().toLowerCase();
            const items = document.querySelectorAll(".sheet-data-item");
            
            items.forEach(item => {
                const title = item.getAttribute("data-title") || "";
                const itemCatId = item.getAttribute("data-category") || "";
                const tagsRaw = item.getAttribute("data-tags") || "";
                const tagsArray = tagsRaw ? tagsRaw.split(",") : [];

                // ရှာဖွေမှု Logic အဆင့်ဆင့်စစ်ဆေးခြင်း
                const matchSearch = title.includes(search);
                
                // Category စစ်ထုတ်မှု- 
                // ၁။ Parent 'ALL' ဆို အကုန်ပြမယ်
                // ၂။ Sub ပါရွေးထားရင် Sub ID နဲ့ တိုက်စစ်မယ်
                // ၃။ Parent ပဲရွေးထားရင် အဆိုပါ Parent အောက်က child category items တွေရော၊ သူ့ကိုယ်ပိုင် items တွေရောပါ ပြသပေးမယ်
                let matchCategory = false;
                if (parentCatId === "ALL") {
                    matchCategory = true;
                } else if (subCatId !== "ALL") {
                    matchCategory = (itemCatId === subCatId);
                } else {
                    // Parent တစ်ခုတည်း ရွေးထားချိန်တွင် သက်ဆိုင်ရာ Child IDs များအုပ်စုကို ရှာခြင်း
                    const childIds = allCategories.filter(c => c.parentId === parentCatId).map(c => c.id);
                    matchCategory = (itemCatId === parentCatId || childIds.includes(itemCatId));
                }

                const matchTag = (tagId === "ALL" || tagsArray.includes(tagId));

                if (matchSearch && matchCategory && matchTag) {
                    item.classList.remove("hidden-by-filter");
                } else {
                    item.classList.add("hidden-by-filter");
                }
            });
        }

        window.onload = function() {
            // စဖွင့်ဖွင့်ချင်းမှာ Dropdown အခြေအနေမှန်အောင် setup ဆွဲပေးခြင်း
            updateSubCategories();
        };
    </script>
</body>
</html>