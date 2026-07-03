<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Bookmarks Collection</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background-color: #f8fafc; font-family: 'Segoe UI', sans-serif; color: #1e293b; }
        .page-header { margin-top: 40px; margin-bottom: 30px; }
        
        /* 🌟 Modern Clean Grid Layout */
        .sheet-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 25px;
            margin-bottom: 35px;
        }
        
        /* 🌟 အဖြူရောင် Card ပုံစံအသစ် (Clean White Card) */
        .sheet-card {
            background-color: #ffffff;
            border-radius: 24px;
            overflow: hidden;
            text-decoration: none;
            color: #1e293b !important;
            box-shadow: 0 10px 25px rgba(15, 23, 42, 0.03);
            border: 1px solid #e2e8f0;
            padding: 26px;
            display: flex;
            flex-direction: column;
            min-height: 280px;
            position: relative;
            transition: transform 0.4s cubic-bezier(0.16, 1, 0.3, 1), 
                        box-shadow 0.4s cubic-bezier(0.16, 1, 0.3, 1);
            cursor: pointer;
        }
        
        .sheet-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 20px 35px rgba(15, 23, 42, 0.08);
        }

        /* 🌟 Card ကို Hover/ဖိလိုက်ရင် ပေါ်လာမည့် Overlay အမှောင်ချစနစ် */
        .card-overlay {
            position: absolute;
            top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(15, 23, 42, 0.4); /* ညင်သာစွာ မှောင်သွားစေရန် */
            backdrop-filter: blur(4px);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 15px;
            opacity: 0; /* သာမန်အချိန်မှာ ဖျောက်ထားမည် */
            transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1);
            pointer-events: none; /* သာမန်အချိန်မှာ နှိပ်လို့မရအောင် ပိတ်ထားမည် */
        }

        /* 🚀 Card ပေါ်ကို Mouse တင်လိုက်ရင် သို့မဟုတ် ဖိလိုက်ရင် Action Buttons များ လင်းပြီး ပေါ်လာစေရန် */
        .sheet-card:hover .card-overlay,
        .sheet-card:active .card-overlay {
            opacity: 1;
            pointer-events: auto; /* ပေါ်လာမှ ခလုတ်တွေကို နှိပ်ခွင့်ပြုမည် */
        }

        /* Overlay ထဲက ခလုတ်များ Animation */
        .overlay-btn {
            transform: scale(0.8);
            transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1);
            border-radius: 12px;
            font-weight: 600;
            padding: 10px 18px;
        }
        .sheet-card:hover .overlay-btn {
            transform: scale(1);
        }

        /* Category Badge Stylings */
        .category-badge {
            display: inline-block;
            padding: 6px 14px;
            border-radius: 999px;
            background: #f1f5f9;
            color: #2563eb;
            font-size: 11px;
            font-weight: 800;
            margin-bottom: 16px;
            align-self: flex-start;
            text-transform: uppercase;
        }
        
        .sheet-title { font-size: 23px; font-weight: 900; margin-bottom: 10px; line-height: 1.35; color: #0f172a; }
        .sheet-desc { font-size: 14px; color: #475569; line-height: 1.6; margin-bottom: 24px; display: -webkit-box; -webkit-line-clamp: 3; -webkit-box-orient: vertical; overflow: hidden; }
        .sheet-footer { margin-top: auto; padding-top: 14px; border-top: 1px solid #f1f5f9; font-size: 13px; color: #64748b; font-weight: 500; }
        
        /* Pagination Styling Customizations */
        .pagination .page-link {
            color: #475569;
            border-radius: 10px;
            margin: 0 3px;
            border: 1px solid #e2e8f0;
            font-weight: 600;
            transition: all 0.2s;
        }
        .pagination .page-item.active .page-link {
            background-color: #2563eb;
            border-color: #2563eb;
            color: white;
        }
        .pagination .page-link:hover {
            background-color: #f1f5f9;
            color: #2563eb;
        }
    </style>
</head>
<body>

<jsp:include page="header.jsp"/>

<div class="container">
    
    <div class="d-flex justify-content-between align-items-center page-header">
        <div>
            <h2 class="fw-bold m-0 text-dark">
                <i class="bi bi-bookmark-heart-fill text-warning me-2 animate-bounce"></i> Cheatsheet Bookmarks
            </h2>
            <p class="text-muted m-0 mt-1">Your personal white-card collection</p>
        </div>
        <a href="${pageContext.request.contextPath}/profile/${sessionScope.currentUser.id}" class="btn btn-outline-secondary btn-sm rounded-3 px-3 fw-semibold shadow-sm">
            <i class="bi bi-arrow-left"></i> Profile
        </a>
    </div>

    <c:choose>
        <c:when test="${not empty bookmarkedSheets}">
            <div class="sheet-grid">
                <c:forEach items="${bookmarkedSheets}" var="sheet">
                    
                    <div class="sheet-card">
                        
                        <div class="category-badge">${sheet.category.name}</div>
                        <h3 class="sheet-title">${sheet.title}</h3>
                        <p class="sheet-desc">${sheet.description}</p>
                        
                        <div class="sheet-footer d-flex justify-content-between align-items-center">
                            <span><i class="bi bi-person-fill me-1"></i> ${sheet.user.name}</span>
                            <span><i class="bi bi-eye-fill me-1"></i> ${sheet.viewCount} &nbsp;<i class="bi bi-heart-fill me-1"></i> ${sheet.likeCount}</span>
                        </div>

                        <div class="card-overlay">
                            <a href="${pageContext.request.contextPath}/cheatsheet/${sheet.id}" class="btn btn-light overlay-btn shadow-sm text-primary">
                                <i class="bi bi-eye-fill me-1"></i> View
                            </a>
                            
                            <form action="${pageContext.request.contextPath}/cheatsheet/bookmark" method="POST" onsubmit="return confirm('Remove this from your bookmarks?');" class="d-inline">
                                <input type="hidden" name="cheatsheetId" value="${sheet.id}" />
                                <button type="submit" class="btn btn-danger overlay-btn shadow-sm">
                                    <i class="bi bi-trash3-fill me-1"></i> Remove
                                </button>
                            </form>
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
                <i class="bi bi-bookmark-dash text-muted" style="font-size: 4rem;"></i>
                <h4 class="fw-bold mt-3 text-secondary">No Bookmarks Found</h4>
                <p class="text-muted">Explore cheat sheets and bookmark them to see them here.</p>
                <a href="${pageContext.request.contextPath}/" class="btn btn-primary btn-sm rounded-3 px-4 mt-2">Browse Home</a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

</body>
</html>