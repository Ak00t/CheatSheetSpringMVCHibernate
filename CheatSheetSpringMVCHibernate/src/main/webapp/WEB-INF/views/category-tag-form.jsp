<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Enterprise Admin - Taxonomy Control Panel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg-canvas: #f8fafc;       
            --brand-primary: #2563eb;     
            --brand-gradient: linear-gradient(135deg, #1e40af, #2563eb);
            --text-main: #0f172a;
            --text-muted: #64748b;
            --border-color: #e2e8f0;
            --shadow-card: 0 4px 12px -1px rgba(0, 0, 0, 0.03), 0 2px 4px -1px rgba(0, 0, 0, 0.02);
            --input-border: #cbd5e1;
        }
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: var(--bg-canvas);
            color: var(--text-main);
            margin: 0;
            padding: 0;
        }
        .page-container {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        .content-body-wrapper {
            display: flex;
            padding: 32px;
            gap: 32px;
            flex: 1;
            align-items: flex-start;
        }
        .main-workspace {
            flex-grow: 1;
            min-width: 0;
        }
        .workspace-banner {
            background: var(--brand-gradient); 
            border-radius: 20px;
            padding: 36px 48px; 
            color: #ffffff;
            margin-bottom: 24px;
            box-shadow: 0 10px 25px -5px rgba(37, 99, 235, 0.2);
        }
        .banner-title {
            font-weight: 800;
            font-size: 32px; 
            margin-bottom: 8px;
            letter-spacing: -0.5px;
        }
        .banner-subtitle {
            font-size: 15px; 
            opacity: 0.9;
            margin: 0;
        }

        /* Web Tab Controls Custom Styles */
        .taxonomy-tabs-nav {
            display: flex;
            background-color: #e2e8f0;
            padding: 6px;
            border-radius: 14px;
            gap: 6px;
            margin-bottom: 32px;
            border: none;
            max-width: 600px;
            list-style: none;
        }
        .taxonomy-tabs-nav .nav-link {
            flex: 1;
            border: none !important;
            padding: 14px 20px;
            font-size: 14px;
            font-weight: 700;
            color: var(--text-muted);
            border-radius: 10px;
            background: transparent;
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            width: 100%;
        }
        .taxonomy-tabs-nav .nav-link.active {
            background-color: #ffffff !important;
            color: var(--brand-primary) !important;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
        }

        /* Tab Content Custom Toggles */
        .custom-tab-panel {
            display: none;
        }
        .custom-tab-panel.active-panel {
            display: block;
        }

        .panel-card {
            background-color: #ffffff;
            border-radius: 20px;
            padding: 36px;
            box-shadow: var(--shadow-card);
            border: 1px solid var(--border-color);
            margin-bottom: 32px;
            height: auto;
        }
        .panel-card h2 {
            font-size: 20px;
            margin-bottom: 24px;
            border-left: 5px solid var(--brand-primary);
            padding-left: 14px;
            font-weight: 800;
            color: var(--text-main);
        }
        .field-wrapper { margin-bottom: 16px; }
        label { display: block; margin-bottom: 8px; font-size: 14px; font-weight: 700; color: #334155; }
        input, select, textarea { width: 100%; padding: 12px 16px; border: 1px solid var(--input-border); border-radius: 10px; font-size: 15px; color: var(--text-main); }
        input:focus, select:focus, textarea:focus { outline: none; border-color: var(--brand-primary); box-shadow: 0 0 0 4px rgba(37, 99, 235, 0.12); }
        textarea { resize: vertical; min-height: 100px; }
        .action-submit-btn { width: 100%; border: none; padding: 14px; border-radius: 10px; color: white; font-size: 15px; font-weight: 700; cursor: pointer; transition: all 0.2s ease; }
        .btn-primary-gradient { background: var(--brand-gradient); }
        .btn-emerald-gradient { background: linear-gradient(135deg, #10b981, #059669); }
        
        /* Dropdown Tree Custom Styles */
        .dropdown-tree-container { position: relative; }
        .dropdown-trigger-field { width: 100%; padding: 12px 16px; border: 1px solid var(--input-border); border-radius: 10px; background: #ffffff; font-size: 15px; cursor: pointer; display: flex; align-items: center; justify-content: space-between; min-height: 48px; font-weight: 500; }
        .dropdown-tree-popover { display: none; position: absolute; left: 0; right: 0; top: 54px; z-index: 50; max-height: 260px; overflow-y: auto; padding: 10px; border-radius: 12px; background: #1e293b; border: 1px solid #334155; box-shadow: 0 12px 25px rgba(0, 0, 0, 0.15); }
        .dropdown-tree-container.open .dropdown-tree-popover { display: block; }
        .popover-parent-item { margin-bottom: 6px; }
        .popover-node-toggle { width: 100%; border: none; background: transparent; color: #f8fafc; padding: 10px; border-radius: 8px; text-align: left; font-size: 14px; font-weight: 600; pointer-events: auto; cursor: pointer; display: flex; align-items: center; gap: 8px; }
        .popover-node-toggle:hover { background: rgba(255, 255, 255, 0.08); }
        .icon-folder { width: 20px; display: inline-block; }
        .popover-child-group { display: none; padding-left: 24px; margin: 4px 0; }
        .popover-parent-item.expanded .popover-child-group { display: block; }
        .popover-child-option { width: 100%; border: none; background: transparent; color: #cbd5e1; padding: 8px; border-radius: 6px; text-align: left; font-size: 13px; cursor: pointer; }
        .popover-child-option:hover, .popover-child-option.active { background: rgba(34, 197, 94, 0.2); color: #ffffff; }
        .popover-empty-notice { color: #94a3b8; font-size: 12px; padding: 6px 8px; }
    </style>
</head>
<body>
    <c:if test="${not empty errorMessage}">
        <script>
            document.addEventListener("DOMContentLoaded", function() {
                alert("${errorMessage}");
            });
        </script>
    </c:if>

    <div class="page-container">
        <jsp:include page="/WEB-INF/views/header.jsp" />
        
        <div class="content-body-wrapper">
            <jsp:include page="/WEB-INF/views/sidebar.jsp" />
            
            <div class="main-workspace">
                <div class="workspace-banner">
                    <div>
                        <h1 class="banner-title">Taxonomy Structure Repository</h1>
                        <p class="banner-subtitle">Configure enterprise application schemas, structured hierarchical categories, and specialized developer tags.</p>
                    </div>
                </div>

                <ul class="nav taxonomy-tabs-nav" id="taxonomyPanelTab">
                    <li class="nav-item" style="flex: 1;">
                        <button class="nav-link active" id="btn-properties" type="button">
                            <i class="fa-solid fa-sliders"></i> Taxonomy Management Panel
                        </button>
                    </li>
                    <li class="nav-item" style="flex: 1;">
                        <button class="nav-link" id="btn-directory" type="button">
                            <i class="fa-solid fa-folder-tree"></i> Unified Taxonomy Directory
                        </button>
                    </li>
                </ul>

                <div id="taxonomyTabContent">
                    
                    <div class="custom-tab-panel active-panel" id="panel-properties">
                        <div class="row g-4">
                            <div class="col-lg-6">
                                <div class="panel-card">
                                    <h2>Category Properties</h2>
                                    <form id="categoryForm" action="${pageContext.request.contextPath}/admin/category/save" method="post">
                                        <div class="field-wrapper">
                                            <label>Parent Context Hierarchy</label>
                                            <select name="parent.id">
                                                <option value="0">No Parent Category (Root Node)</option>
                                                <c:forEach items="${categories}" var="categoryUnit">
                                                    <c:if test="${categoryUnit.parent == null}">
                                                        <option value="${categoryUnit.id}">${categoryUnit.name}</option>
                                                    </c:if>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="field-wrapper">
                                            <label>Category Name</label>
                                            <input type="text" id="categoryName" name="name" value="${category.name}" required placeholder="e.g., Java Language" onkeyup="generateDataSlug('categoryName','categorySlug')">
                                        </div>
                                        <div class="field-wrapper">
                                            <label>URL Slug Identifier</label>
                                            <input type="text" id="categorySlug" name="slug" value="${category.slug}" required placeholder="e.g., java-language">
                                        </div>
                                        <div class="field-wrapper">
                                            <label>Resource Description</label>
                                            <textarea name="description" placeholder="Provide description details...">${category.description}</textarea>
                                        </div>
                                        <button type="submit" class="action-submit-btn btn-primary-gradient">Commit New Category</button>
                                    </form>
                                </div>
                            </div>

                            <div class="col-lg-6">
                                <div class="panel-card">
                                    <h2 style="border-left-color: #10b981;">Tag Properties</h2>
                                    <form id="tagForm" action="${pageContext.request.contextPath}/admin/tag/save" method="post">
                                        <div class="field-wrapper">
                                            <label>Target Scope Category Mapping</label>
                                            <div class="dropdown-tree-container" id="tagCategoryTree">
                                                <button type="button" class="dropdown-trigger-field" onclick="toggleContextPopover()">
                                                    <span id="selectedCategoryText">
                                                        <c:choose>
                                                            <c:when test="${not empty tag.category}">${tag.category.name}</c:when>
                                                            <c:otherwise>Map to Context Target</c:otherwise>
                                                        </c:choose>
                                                    </span>
                                                    <span class="dropdown-trigger-arrow">▼</span>
                                                </button>
                                                <div class="dropdown-tree-popover">
                                                    <c:forEach items="${categories}" var="parent">
                                                        <c:if test="${parent.parent == null}">
                                                            <c:set var="hasChild" value="false"/>
                                                            <c:forEach items="${categories}" var="checkChild">
                                                                <c:if test="${checkChild.parent != null && checkChild.parent.id == parent.id}">
                                                                    <c:set var="hasChild" value="true"/>
                                                                </c:if>
                                                            </c:forEach>
                                                            <div class="popover-parent-item">
                                                                <button type="button" class="popover-node-toggle" onclick="togglePopoverNode(this); event.stopPropagation();">
                                                                    <span class="icon-folder">📁</span><span>${parent.name}</span>
                                                                </button>
                                                                <div class="popover-child-group">
                                                                    <c:choose>
                                                                        <c:when test="${hasChild}">
                                                                            <c:forEach items="${categories}" var="child">
                                                                                <c:if test="${child.parent != null && child.parent.id == parent.id}">
                                                                                    <button type="button" class="popover-child-option ${tag.category.id == child.id ? 'active' : ''}" onclick="bindSelectedCategory('${child.id}','${parent.name} / ${child.name}', this); event.stopPropagation();">
                                                                                        ↳ ${child.name}
                                                                                    </button>
                                                                                </c:if>
                                                                            </c:forEach>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <div class="popover-empty-notice">No nested nodes available</div>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </div>
                                                            </div>
                                                        </c:if>
                                                    </c:forEach>
                                                </div>
                                            </div>
                                            <input type="hidden" id="tagCategoryId" name="categoryId" value="${tag.category.id}" required>
                                        </div>
                                        <div class="field-wrapper">
                                            <label>Tag Name</label>
                                            <input type="text" id="tagName" name="name" value="${tag.name}" required placeholder="e.g., Spring Boot" onkeyup="generateDataSlug('tagName','tagSlug')">
                                        </div>
                                        <div class="field-wrapper">
                                            <label>URL Slug Identifier</label>
                                            <input type="text" id="tagSlug" name="slug" value="${tag.slug}" required placeholder="e.g., spring-boot">
                                        </div>
                                        <button type="submit" class="action-submit-btn btn-emerald-gradient">Commit New Tag</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="custom-tab-panel" id="panel-directory">
                        <div class="row">
                            <div class="col-12">
                                <jsp:include page="/WEB-INF/views/category-list.jsp" />
                            </div>
                        </div>
                    </div>
                    
                </div>
            </div>
        </div>
        <jsp:include page="/WEB-INF/views/footer.jsp" />
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            const btnProperties = document.getElementById('btn-properties');
            const btnDirectory = document.getElementById('btn-directory');
            const panelProperties = document.getElementById('panel-properties');
            const panelDirectory = document.getElementById('panel-directory');

            // 1. Manage Properties Button Trigger Listener
            btnProperties.addEventListener('click', function() {
                // Adjust Active Tab Header State
                btnProperties.classList.add('active');
                btnDirectory.classList.remove('active');
                
                // Adjust Content Layout Sheet Toggles
                panelProperties.classList.add('active-panel');
                panelDirectory.classList.remove('active-panel');
            });

            // 2. Unified Taxonomy Directory Button Trigger Listener
            btnDirectory.addEventListener('click', function() {
                // Adjust Active Tab Header State
                btnDirectory.classList.add('active');
                btnProperties.classList.remove('active');
                
                // Adjust Content Layout Sheet Toggles
                panelDirectory.classList.add('active-panel');
                panelProperties.classList.remove('active-panel');
            });
        });

        function generateDataSlug(originId, targetSlugId){
            let rawData = document.getElementById(originId).value;
            let formattedSlug = rawData.toLowerCase().trim()
                                    .replace(/[^a-z0-9\s-]/g,'')
                                    .replace(/\s+/g,'-')
                                    .replace(/-+/g,'-');
            document.getElementById(targetSlugId).value = formattedSlug;
        }

        function toggleContextPopover(){ 
            document.getElementById('tagCategoryTree').classList.toggle('open'); 
        }

        function togglePopoverNode(element){
            const nodeInstance = element.closest('.popover-parent-item');
            nodeInstance.classList.toggle('expanded');
            
            const folderIcon = nodeInstance.querySelector('.icon-folder');
            if(folderIcon) {
                folderIcon.textContent = nodeInstance.classList.contains('expanded') ? '📂' : '📁';
            }
        }

        function bindSelectedCategory(extractedId, templateText, buttonInstance){
            document.getElementById('tagCategoryId').value = extractedId;
            document.getElementById('selectedCategoryText').textContent = templateText;
            document.querySelectorAll('.popover-child-option').forEach(node => node.classList.remove('active'));
            buttonInstance.classList.add('active');
            document.getElementById('tagCategoryTree').classList.remove('open');
        }

        document.addEventListener('click', function(event){
            const contextTree = document.getElementById('tagCategoryTree');
            if(contextTree && !contextTree.contains(event.target)) {
                contextTree.classList.remove('open');
            }
        });
    </script>
</body>
</html>