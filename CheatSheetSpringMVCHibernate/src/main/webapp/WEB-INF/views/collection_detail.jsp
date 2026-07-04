<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>${collection.name}</title>
    </head>
<body>
    <jsp:include page="header.jsp"/>

    <div class="container">
        <section class="hero">
            <h1>${collection.name}</h1>
            <p>Visibility: ${collection.visibility}</p>
        </section>

        <section class="section">
            <h2 class="section-title">Saved Cheatsheets</h2>
            <div class="sheet-scroll" style="display: flex; gap: 20px; flex-wrap: wrap;">
                <c:choose>
                    <c:when test="${not empty items}">
                        <c:forEach items="${items}" var="item">
                            <div class="sheet-card" style="background-color: ${item.cheatsheet.themeColor};">
                                <h3>${item.cheatsheet.title}</h3>
                                <p>${item.cheatsheet.description}</p>
                                <a href="${pageContext.request.contextPath}/cheatsheet/${item.cheatsheet.id}">View Details</a>
                                
                                <button onclick="removeFromCollection(${collection.id}, ${item.cheatsheet.id})">Remove</button>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <p>No cheatsheets in this collection yet.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>
    </div>

    <script>
    function removeFromCollection(colId, sheetId) {
        if(confirm("Are you sure?")) {
            fetch('${pageContext.request.contextPath}/collection/toggle?collectionId=' + colId + '&cheatsheetId=' + sheetId, {
                method: 'POST'
            }).then(() => location.reload());
        }
    }
    </script>
</body>
</html>