<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Category</title>

<style>
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Segoe UI',sans-serif;
}

body{
    min-height:100vh;
    background:linear-gradient(135deg,#d1fae5,#dcfce7,#ecfccb);
    display:flex;
    justify-content:center;
    align-items:center;
    padding:30px;
}

.card{
    width:100%;
    max-width:700px;
    background:white;
    padding:35px;
    border-radius:25px;
    box-shadow:0 20px 40px rgba(0,0,0,.1);
}

h2{
    text-align:center;
    color:#059669;
    margin-bottom:25px;
}

.form-group{
    margin-bottom:20px;
}

label{
    display:block;
    margin-bottom:8px;
    font-weight:600;
    color:#374151;
}

input,
select,
textarea{
    width:100%;
    padding:14px;
    border:2px solid #d1d5db;
    border-radius:12px;
    font-size:16px;
}

input:focus,
select:focus,
textarea:focus{
    outline:none;
    border-color:#10b981;
}

textarea{
    resize:none;
    height:120px;
}

.btn{
    width:100%;
    border:none;
    padding:15px;
    border-radius:12px;
    background:#10b981;
    color:white;
    font-size:17px;
    font-weight:bold;
    cursor:pointer;
}

.btn:hover{
    background:#059669;
}

.back{
    display:block;
    text-align:center;
    margin-top:15px;
    text-decoration:none;
    color:#2563eb;
    font-weight:bold;
}
</style>

</head>
<body>

<div class="card">

    <h2>✏️ Edit Category</h2>

    <form action="${pageContext.request.contextPath}/admin/category/update"
          method="post">

        <input type="hidden"
               name="id"
               value="${category.id}">

        <div class="form-group">
            <label>Category Name</label>

            <input type="text"
                   name="name"
                   value="${category.name}"
                   required>
        </div>

        <div class="form-group">

    <%--       
 <label>Parent Category</label>

<c:choose>

    <c:when test="${category.parent == null}">
        <select name="parentId" disabled>
            <option value="0" selected>No Parent Category</option>
        </select>

        <input type="hidden" name="parentId" value="0">
    </c:when>

    <c:otherwise>
        <select name="parentId">

            <option value="0">No Parent Category</option>

            <c:forEach items="${categories}" var="c">

                <c:if test="${c.parent == null && c.id != category.id}">
                    <option value="${c.id}"
                        <c:if test="${category.parent != null && category.parent.id == c.id}">
                            selected
                        </c:if>
                    >
                        ${c.name}
                    </option>
                </c:if>

            </c:forEach>

        </select>
    </c:otherwise>

</c:choose>
 
  --%>
 
 <label>Parent Category</label>

<c:if test="${category.parent == null}">

    <select disabled>
        <option selected>No Parent Category</option>
    </select>

    <input type="hidden" name="parentId" value="0"/>

</c:if>

<c:if test="${category.parent != null}">

    <select name="parentId">

        <c:forEach items="${categories}" var="c">

            <c:if test="${c.parent == null && c.id != category.id}">

                <option value="${c.id}"
                    <c:if test="${category.parent.id == c.id}">
                        selected
                    </c:if>
                >
                    ${c.name}
                </option>

            </c:if>

        </c:forEach>

    </select>

</c:if>
 
 
 
        </div>

        <div class="form-group">

            <label>Description</label>

            <textarea name="description">${category.description}</textarea>

        </div>

        <button type="submit" class="btn">
            Update Category
        </button>

    </form>

    <a class="back"
       href="${pageContext.request.contextPath}/admin/category-list">

        ← Back To List

    </a>

</div>

</body>
</html>