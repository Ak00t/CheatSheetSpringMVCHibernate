<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="selectedCategoryId" value=""/>
<c:if test="${tag.category != null}">
    <c:set var="selectedCategoryId" value="${tag.category.id}"/>
</c:if>
<c:set var="selectedCategoryText" value="Select child category"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Tag</title>

<style>
*{margin:0;padding:0;box-sizing:border-box;font-family:'Segoe UI',Arial,sans-serif;}
body{
    min-height:100vh;
    background:linear-gradient(135deg,#eef2ff,#ecfdf5);
    display:flex;
    justify-content:center;
    align-items:center;
    padding:30px;
    color:#1f2937;
}
.card{
    width:100%;
    max-width:760px;
    background:#fff7ed;
    padding:36px;
    border-radius:24px;
    box-shadow:0 18px 40px rgba(0,0,0,.12);
}
h2{
    text-align:center;
    color:#2563eb;
    margin-bottom:26px;
    font-size:28px;
    font-weight:800;
}
.form-group{margin-bottom:22px;}
label{
    display:block;
    margin-bottom:9px;
    font-weight:800;
    color:#374151;
}
input{
    width:100%;
    padding:15px 18px;
    border:2px solid #d1d5db;
    border-radius:14px;
    background:#fff;
    font-size:16px;
    color:#111827;
}
input:focus{
    outline:none;
    border-color:#2563eb;
    box-shadow:0 0 0 4px rgba(37,99,235,.15);
}
.btn{
    width:100%;
    border:none;
    padding:16px;
    border-radius:14px;
    background:#2563eb;
    color:#fff;
    font-size:17px;
    font-weight:800;
    cursor:pointer;
}
.btn:hover{background:#1d4ed8;}
.back{
    display:block;
    text-align:center;
    margin-top:16px;
    text-decoration:none;
    color:#2563eb;
    font-weight:800;
}
.category-tree-wrapper{position:relative;width:100%;}
.category-tree-selected{
    width:100%;
    padding:15px 18px;
    border:2px solid #d1d5db;
    border-radius:14px;
    background:#fff;
    font-size:16px;
    text-align:left;
    display:flex;
    justify-content:space-between;
    align-items:center;
    cursor:pointer;
    color:#111827;
}
.category-tree-wrapper.open .category-tree-selected{
    border-color:#2563eb;
    box-shadow:0 0 0 4px rgba(37,99,235,.15);
}
.category-tree-menu{
    display:none;
    position:absolute;
    left:0;
    right:0;
    top:58px;
    max-height:360px;
    overflow-y:auto;
    background:#263238;
    color:#fff;
    border-radius:14px;
    padding:10px;
    z-index:999;
    box-shadow:0 18px 35px rgba(0,0,0,.28);
}
.category-tree-wrapper.open .category-tree-menu{display:block;}
.parent-node{margin-bottom:4px;}
.parent-toggle{
    width:100%;
    border:none;
    background:transparent;
    color:#f9fafb;
    padding:10px 12px;
    border-radius:10px;
    text-align:left;
    font-size:16px;
    font-weight:800;
    cursor:pointer;
    display:flex;
    align-items:center;
    gap:8px;
}
.parent-toggle:hover{background:#374151;}
.parent-arrow{margin-left:auto;transition:.2s;}
.parent-node.expanded .parent-arrow{transform:rotate(90deg);}
.child-list{display:none;padding-left:28px;}
.parent-node.expanded .child-list{display:block;}
.child-option{
    width:100%;
    border:none;
    background:transparent;
    color:#e5e7eb;
    padding:9px 12px;
    border-radius:9px;
    text-align:left;
    font-size:15px;
    font-weight:700;
    cursor:pointer;
}
.child-option:hover,
.child-option.active{
    background:#2563eb;
    color:#fff;
}
.no-child{
    padding:8px 12px;
    color:#9ca3af;
    font-size:14px;
    font-style:italic;
}
.error{
    display:none;
    color:#dc2626;
    font-weight:700;
    font-size:14px;
    margin-top:8px;
}
</style>
</head>
<body>

<div class="card">
    <h2>🏷️ Edit Tag</h2>

    <form id="tagEditForm" action="${pageContext.request.contextPath}/admin/tag/update" method="post">
        <input type="hidden" name="id" value="${tag.id}">

        <div class="form-group">
            <label>Tag Name</label>
            <input type="text" name="name" value="${tag.name}" required>
        </div>

        <div class="form-group">
            <label>Category</label>

            <div class="category-tree-wrapper" id="tagCategoryTree">
                <button type="button" class="category-tree-selected" id="treeOpenBtn">
                    <span id="selectedCategoryText">${selectedCategoryText}</span>
                    <span>▼</span>
                </button>

                <div class="category-tree-menu">
                    <c:forEach items="${categories}" var="parent">
                        <c:if test="${parent.parent == null}">

                            <div class="parent-node">
                                <button type="button" class="parent-toggle">
                                    <span class="folder-icon">📁</span>
                                    <span>${parent.name}</span>
                                    <span class="parent-arrow">▶</span>
                                </button>

                                <div class="child-list">
                                    <c:set var="hasChild" value="false"/>

                                    <c:forEach items="${categories}" var="child">
                                        <c:if test="${child.parent != null && child.parent.id == parent.id}">
                                            <c:set var="hasChild" value="true"/>

                                            <button type="button"
                                                    class="child-option <c:if test='${tag.category != null && tag.category.id == child.id}'>active</c:if>"
                                                    data-id="${child.id}"
                                                    data-text="${parent.name} / ${child.name}">
                                                └ ${child.name}
                                            </button>
                                        </c:if>
                                    </c:forEach>

                                    <c:if test="${hasChild == false}">
                                        <div class="no-child">No child category</div>
                                    </c:if>
                                </div>
                            </div>

                        </c:if>
                    </c:forEach>
                </div>
            </div>

            <input type="hidden" id="tagCategoryId" name="categoryId" value="${selectedCategoryId}" required>
            <div class="error" id="categoryError">Please select child category.</div>
        </div>

        <button type="submit" class="btn">Update Tag</button>
    </form>

    <a class="back" href="${pageContext.request.contextPath}/admin/category-list">← Back</a>
</div>

<script>
document.getElementById('treeOpenBtn').addEventListener('click', function(){
    document.getElementById('tagCategoryTree').classList.toggle('open');
});

/* Edit mode: bind previous selected category id without using tag.category.parent in JSP */
const activeChild = document.querySelector('.child-option.active');
if(activeChild){
    document.getElementById('selectedCategoryText').textContent = activeChild.dataset.text;
    document.getElementById('tagCategoryId').value = activeChild.dataset.id;

    const parentNode = activeChild.closest('.parent-node');
    if(parentNode){
        parentNode.classList.add('expanded');
        const icon = parentNode.querySelector('.folder-icon');
        if(icon){ icon.textContent = '📂'; }
    }
}

document.querySelectorAll('.parent-toggle').forEach(function(button){
    button.addEventListener('click', function(){
        const parentNode = button.closest('.parent-node');
        parentNode.classList.toggle('expanded');
        const icon = parentNode.querySelector('.folder-icon');
        icon.textContent = parentNode.classList.contains('expanded') ? '📂' : '📁';
    });
});

document.querySelectorAll('.child-option').forEach(function(button){
    button.addEventListener('click', function(){
        document.getElementById('tagCategoryId').value = button.dataset.id;
        document.getElementById('selectedCategoryText').textContent = button.dataset.text;
        document.getElementById('categoryError').style.display = 'none';

        document.querySelectorAll('.child-option').forEach(function(item){
            item.classList.remove('active');
        });
        button.classList.add('active');

        document.getElementById('tagCategoryTree').classList.remove('open');
    });
});

document.addEventListener('click', function(e){
    const tree = document.getElementById('tagCategoryTree');
    if(tree && !tree.contains(e.target)){
        tree.classList.remove('open');
    }
});

document.getElementById('tagEditForm').addEventListener('submit', function(e){
    if(!document.getElementById('tagCategoryId').value){
        e.preventDefault();
        document.getElementById('categoryError').style.display = 'block';
        document.getElementById('tagCategoryTree').classList.add('open');
    }
});
</script>

</body>
</html>
