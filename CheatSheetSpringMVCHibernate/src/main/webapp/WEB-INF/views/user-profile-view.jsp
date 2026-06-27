<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${targetUser.name}'s Profile - CheatSheet Hub</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-slate-50 font-sans antialiased text-slate-800">

    <div class="flex min-h-screen">
        <jsp:include page="/WEB-INF/views/sidebar.jsp" />

        <main class="flex-1 p-8">
           <jsp:include page="/WEB-INF/views/header.jsp" />
           
            <section class="bg-white rounded-2xl border border-slate-200 overflow-hidden shadow-sm mb-8">
                <div class="h-40 bg-blue-600 relative"></div>
                <div class="px-8 pb-8 relative flex flex-col md:flex-row md:items-end justify-between -mt-16 md:space-x-6">
                    <div class="flex flex-col md:flex-row items-center md:items-end space-y-4 md:space-y-0 md:space-x-6">
                        <div class="w-32 h-32 rounded-2xl bg-slate-200 border-4 border-white shadow-md overflow-hidden flex items-center justify-center text-slate-400 bg-white">
                            <i class="fa-solid fa-user text-5xl"></i>
                        </div>
                        <div class="text-center md:text-left pt-2">
                            <h1 class="text-2xl font-bold text-slate-900 flex items-center justify-center md:justify-start gap-2">
                                <c:out value="${targetUser.name}"/>
                                <span class="text-xs px-2.5 py-0.5 font-semibold rounded-full bg-slate-100 text-slate-600 border border-slate-200 uppercase">
                                    <c:out value="${targetUser.role}"/>
                                </span>
                            </h1>
                            <p class="text-slate-500 text-sm mt-0.5"><c:out value="${targetUser.email}"/></p>
                        </div>
                    </div>
                    
                    <div class="flex items-center justify-center space-x-3 mt-6 md:mt-0">
                        <c:choose>
                            <c:when test="${targetUser.status == 'BANNED'}">
                                <form action="${pageContext.request.contextPath}/usermanagement/unban/${targetUser.id}" method="POST" onsubmit="return confirm('Are you sure you want to unban this user?');">
                                    <button type="submit" class="px-5 py-2 rounded-xl text-sm font-medium bg-emerald-600 hover:bg-emerald-700 text-white shadow-sm transition">
                                        <i class="fa-solid fa-circle-check mr-2"></i>Unban User
                                    </button>
                                </form>
                            </c:when>
                            <c:otherwise>
                                <form action="${pageContext.request.contextPath}/usermanagement/ban/${targetUser.id}" method="POST" onsubmit="return confirm('Are you sure you want to ban this user?');">
                                    <button type="submit" class="px-5 py-2 rounded-xl text-sm font-medium border border-amber-200 bg-amber-50 text-amber-700 hover:bg-amber-100 shadow-sm transition">
                                        <i class="fa-solid fa-ban mr-2"></i>Ban User
                                    </button>
                                </form>
                            </c:otherwise>
                        </c:choose>
                        
                        <form action="${pageContext.request.contextPath}/usermanagement/delete/${targetUser.id}" method="POST" onsubmit="return confirm('Warning! Permanent deletion cannot be undone. Proceed?');">
                            <button type="submit" class="px-5 py-2 rounded-xl text-sm font-medium bg-red-600 hover:bg-red-700 text-white shadow-sm transition">
                                <i class="fa-solid fa-trash-can mr-2"></i>Delete Account
                            </button>
                        </form>
                    </div>
                </div>
            </section>

            <section class="bg-white rounded-2xl border border-slate-200 p-8 shadow-sm">
                <h2 class="text-lg font-bold text-slate-900 mb-6 flex items-center gap-2">
                    <i class="fa-solid fa-layer-group text-blue-600"></i> Published Submissions
                </h2>

                <c:choose>
                    <c:when test="${empty userCheatsheets}">
                        <div class="text-center py-12 border-2 border-dashed border-slate-200 rounded-xl">
                            <i class="fa-solid fa-folder-open text-slate-300 text-4xl mb-3"></i>
                            <p class="text-slate-500 text-sm">This user hasn't uploaded any technical cheatsheets yet.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <c:forEach var="sheet" items="${userCheatsheets}">
                                <div class="p-5 rounded-xl border border-slate-200 hover:border-blue-300 hover:shadow-md transition bg-slate-50 flex justify-between items-start">
                                    <div>
                                        <h3 class="font-semibold text-slate-800 text-base mb-1 hover:text-blue-600">
                                            <a href="${pageContext.request.contextPath}/cheatsheet/view/${sheet.id}"><c:out value="${sheet.title}"/></a>
                                        </h3>
                                        <p class="text-slate-500 text-xs line-clamp-2 mb-3"><c:out value="${sheet.description}"/></p>
                                        <div class="flex flex-wrap gap-1.5">
                                            <span class="text-[11px] px-2 py-0.5 rounded-md bg-blue-100 text-blue-700 font-medium">
                                                <c:out value="${sheet.category.name}"/>
                                            </span>
                                        </div>
                                    </div>
                                    <span class="text-[10px] text-slate-400 font-medium whitespace-nowrap ml-4">
                                        <c:out value="${sheet.createdAt}"/>
                                    </span>
                                </div>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </section>

             
        </main>
    </div>

</body>
</html>