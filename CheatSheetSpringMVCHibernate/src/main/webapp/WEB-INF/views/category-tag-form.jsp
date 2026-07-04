<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Category & Tag Management</title>

<style>
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Segoe UI', Arial, sans-serif;
}

body{
    min-height:100vh;
    background:linear-gradient(135deg,#d1fae5,#bbf7d0,#e0f2fe);
    padding:40px;
    color:#1f2937;
}

.container{
    max-width:1250px;
    margin:auto;
}

.header{
    background:linear-gradient(135deg,#059669,#22c55e);
    color:white;
    padding:35px 45px;
    border-radius:28px;
    margin-bottom:35px;
    box-shadow:0 18px 40px rgba(5,150,105,.35);
}

.header h1{
    font-size:42px;
    margin-bottom:10px;
}

.header p{
    font-size:18px;
    opacity:.95;
}

.grid{
    display:grid;
    grid-template-columns:1fr 1fr;
    gap:32px;
}

.card{
    background:linear-gradient(180deg,#f0fdf4,#ffffff);
    border-radius:28px;
    padding:35px;
    box-shadow:0 18px 40px rgba(15,118,110,.18);
    border:2px solid rgba(34,197,94,.25);
}

.card h2{
    font-size:30px;
    color:#065f46;
    margin-bottom:28px;
    border-left:7px solid #22c55e;
    padding-left:16px;
}

label{
    display:block;
    margin-bottom:10px;
    font-size:17px;
    font-weight:700;
    color:#064e3b;
}

input,
select,
textarea{
    width:100%;
    padding:16px 18px;
    border:2px solid #bbf7d0;
    border-radius:16px;
    margin-bottom:24px;
    background:#ffffff;
    font-size:17px;
    color:#111827;
    transition:.25s;
}

input::placeholder,
textarea::placeholder{
    color:#94a3b8;
}

input:focus,
select:focus,
textarea:focus{
    outline:none;
    border-color:#10b981;
    box-shadow:0 0 0 5px rgba(16,185,129,.18);
}

textarea{
    resize:vertical;
    min-height:130px;
}

.btn-category,
.btn-tag{
    width:100%;
    border:none;
    padding:18px;
    border-radius:18px;
    color:white;
    font-size:18px;
    font-weight:800;
    cursor:pointer;
    transition:.25s;
}

.btn-category{
    background:linear-gradient(135deg,#2563eb,#1d4ed8);
    box-shadow:0 12px 24px rgba(37,99,235,.25);
}

.btn-category:hover{
    transform:translateY(-2px);
    box-shadow:0 16px 30px rgba(37,99,235,.35);
}

.btn-tag{
    background:linear-gradient(135deg,#10b981,#059669);
    box-shadow:0 12px 24px rgba(16,185,129,.25);
}

.btn-tag:hover{
    transform:translateY(-2px);
    box-shadow:0 16px 30px rgba(16,185,129,.35);
}


/* Custom category tree dropdown for tag create */
.category-tree-wrapper{
    position:relative;
    margin-bottom:24px;
}

.category-tree-selected{
    width:100%;
    padding:16px 18px;
    border:2px solid #bbf7d0;
    border-radius:16px;
    background:#ffffff;
    font-size:17px;
    color:#111827;
    cursor:pointer;
    display:flex;
    align-items:center;
    justify-content:space-between;
    min-height:58px;
}

.category-tree-selected:focus{
    outline:none;
    border-color:#10b981;
    box-shadow:0 0 0 5px rgba(16,185,129,.18);
}

.category-tree-arrow{
    font-size:14px;
    color:#059669;
    transition:.2s;
}

.category-tree-wrapper.open .category-tree-arrow{
    transform:rotate(180deg);
}

.category-tree-menu{
    display:none;
    position:absolute;
    left:0;
    right:0;
    top:66px;
    z-index:50;
    max-height:330px;
    overflow-y:auto;
    padding:12px;
    border-radius:18px;
    background:linear-gradient(180deg,#1f2937,#064e3b);
    border:2px solid rgba(187,247,208,.9);
    box-shadow:0 20px 40px rgba(15,23,42,.35);
}

.category-tree-wrapper.open .category-tree-menu{
    display:block;
}

.parent-node{
    margin-bottom:6px;
}

.parent-toggle{
    width:100%;
    border:none;
    background:transparent;
    color:#f9fafb;
    padding:10px 8px;
    border-radius:12px;
    text-align:left;
    font-size:17px;
    font-weight:800;
    cursor:pointer;
    display:flex;
    align-items:center;
    gap:8px;
}

.parent-toggle:hover{
    background:rgba(255,255,255,.10);
}

.folder-icon{
    width:24px;
    display:inline-block;
}

.child-list{
    display:none;
    padding-left:34px;
    margin:3px 0 8px;
}

.parent-node.expanded .child-list{
    display:block;
}

.child-option{
    width:100%;
    border:none;
    background:transparent;
    color:#ffffff;
    padding:9px 10px;
    border-radius:10px;
    text-align:left;
    font-size:16px;
    font-weight:700;
    cursor:pointer;
}

.child-option:hover,
.child-option.active{
    background:rgba(34,197,94,.30);
}

.no-child{
    color:#cbd5e1;
    font-size:14px;
    padding:8px 10px;
}

.tag-category-error{
    display:none;
    margin:-14px 0 18px;
    color:#dc2626;
    font-weight:700;
    font-size:14px;
}

@media(max-width:900px){
    body{
        padding:20px;
    }

    .grid{
        grid-template-columns:1fr;
    }

    .header h1{
        font-size:32px;
    }
}
</style>
</head>

<body>

<div class="container">

    <div class="header">
        <h1>Category & Tag Management</h1>
        <p>Create and manage categories and tags for your cheatsheets</p>
    </div>

    <div class="grid">

        <div class="card">
            <h2>Create Category</h2>

            <form action="${pageContext.request.contextPath}/admin/category/save" method="post">


               
                
                <label>Parent Category</label>

<select name="parentId">

    <option value="0">No Parent Category</option>

    <c:forEach items="${categories}" var="c">

        <c:if test="${c.parent == null}">
            <option value="${c.id}">
                ${c.name}
            </option>
        </c:if>

    </c:forEach>

</select>
                
               

                <label>Category Name</label>
                <input type="text"
                       id="categoryName"
                       name="name"
                       required
                       placeholder="Java Language"
                       onkeyup="generateSlug('categoryName','categorySlug')">

                <label>Slug</label>
                <input type="text"
                       id="categorySlug"
                       name="slug"
                       required
                       placeholder="java-language">

                <label>Description</label>
                <textarea name="description"
                          placeholder="Category description"></textarea>

                <button type="submit" class="btn-category">
                    Save Category
                </button>

            </form>
        </div>

        <div class="card">
            <h2>Create Tag</h2>

            <form action="${pageContext.request.contextPath}/admin/tag/save" method="post">

               <%--  <label>Select Category</label>
                <select name="categoryId" required>
                    <option value="">Select Category</option>
                    

                    <c:forEach items="${categories}" var="c">
                        <option value="${c.id}">${c.name}</option>
                    </c:forEach>
                    
                    
                    
                </select> --%>
                
                <label>Select Category</label>

                <div class="category-tree-wrapper" id="tagCategoryTree">
                    <button type="button" class="category-tree-selected" onclick="toggleCategoryTree()">
                        <span id="selectedCategoryText">Select Category</span>
                        <span class="category-tree-arrow">▼</span>
                    </button>

                    <div class="category-tree-menu">
                        <c:forEach items="${categories}" var="parent">
                            <c:if test="${parent.parent == null}">

                                <c:set var="hasChild" value="false"/>
                                <c:forEach items="${categories}" var="checkChild">
                                    <c:if test="${checkChild.parent != null && checkChild.parent.id == parent.id}">
                                        <c:set var="hasChild" value="true"/>
                                    </c:if>
                                </c:forEach>

                                <div class="parent-node">
                                    <button type="button" class="parent-toggle" onclick="toggleParentNode(this)">
                                        <span class="folder-icon">📁</span>
                                        <span>${parent.name}</span>
                                    </button>

                                    <div class="child-list">
                                        <c:choose>
                                            <c:when test="${hasChild}">
                                                <c:forEach items="${categories}" var="child">
                                                    <c:if test="${child.parent != null && child.parent.id == parent.id}">
                                                        <button type="button"
                                                                class="child-option"
                                                                onclick="selectChildCategory('${child.id}','${parent.name} / ${child.name}', this)">
                                                            ↳ ${child.name}
                                                        </button>
                                                    </c:if>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="no-child">No child category</div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>

                            </c:if>
                        </c:forEach>
                    </div>
                </div>

                <input type="hidden" id="tagCategoryId" name="categoryId" required>
                <div class="tag-category-error" id="tagCategoryError">Please select child category.</div>

                <label>Tag Name</label>
                <input type="text"
                       id="tagName"
                       name="name"
                       required
                       placeholder="Spring Boot"
                       onkeyup="generateSlug('tagName','tagSlug')">

                <label>Slug</label>
                <input type="text"
                       id="tagSlug"
                       name="slug"
                       required
                       placeholder="spring-boot">

                <button type="submit" class="btn-tag">
                    Save Tag
                </button>

            </form>
        </div>

    </div>

</div>

<script>
function generateSlug(inputId, slugId){
    let value = document.getElementById(inputId).value;

    let slug = value.toLowerCase()
                    .trim()
                    .replace(/[^a-z0-9\s-]/g,'')
                    .replace(/\s+/g,'-')
                    .replace(/-+/g,'-');

    document.getElementById(slugId).value = slug;
}

function toggleCategoryTree(){
    document.getElementById('tagCategoryTree').classList.toggle('open');
}

function toggleParentNode(button){
    const parentNode = button.closest('.parent-node');
    parentNode.classList.toggle('expanded');

    const icon = parentNode.querySelector('.folder-icon');
    icon.textContent = parentNode.classList.contains('expanded') ? '📂' : '📁';
}

function selectChildCategory(id, text, button){
    document.getElementById('tagCategoryId').value = id;
    document.getElementById('selectedCategoryText').textContent = text;
    document.getElementById('tagCategoryError').style.display = 'none';

    document.querySelectorAll('.child-option').forEach(function(item){
        item.classList.remove('active');
    });
    button.classList.add('active');

    document.getElementById('tagCategoryTree').classList.remove('open');
}

document.addEventListener('click', function(e){
    const tree = document.getElementById('tagCategoryTree');
    if(tree && !tree.contains(e.target)){
        tree.classList.remove('open');
    }
});

document.querySelector('.btn-tag').closest('form').addEventListener('submit', function(e){
    if(!document.getElementById('tagCategoryId').value){
        e.preventDefault();
        document.getElementById('tagCategoryError').style.display = 'block';
        document.getElementById('tagCategoryTree').classList.add('open');
    }
});
</script>

</body>
</html>