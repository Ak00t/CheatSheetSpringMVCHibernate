<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
    /* Component Layout & Tree Variables */
    .tree-card {
        background: #ffffff;
        border-radius: 20px;
        padding: 36px;
        box-shadow: var(--shadow-card);
        border: 1px solid var(--border-color);
    }
    .tree-card h2 {
        font-size: 20px;
        margin-bottom: 24px;
        border-left: 5px solid var(--brand-primary);
        padding-left: 14px;
        font-weight: 800;
        color: var(--text-main);
    }
    .tree-wrapper details {
        margin-bottom: 12px;
    }
    .tree-wrapper summary {
        cursor: pointer;
        list-style: none;
        padding: 14px 18px;
        border-radius: 12px;
        background: #ecfdf5;
        border: 1px solid #bbf7d0;
        font-size: 18px;
        font-weight: 700;
        color: #065f46;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .tree-wrapper summary::-webkit-details-marker {
        display: none;
    }
    .tree-wrapper summary::before {
        content: "▶";
        margin-right: 10px;
        color: #059669;
        font-size: 14px;
    }
    .tree-wrapper details[open] > summary::before {
        content: "▼";
    }
    .tree-child-box {
        margin-left: 28px;
        margin-top: 8px;
    }
    .tree-row {
        padding: 10px 16px;
        margin: 6px 0;
        border-radius: 10px;
        background: #f8fafc;
        border: 1px solid #e5e7eb;
        display: flex;
        justify-content: space-between;
        align-items: center;
        font-size: 15px;
    }
    .tree-wrapper .child-summary {
        background: #eff6ff;
        color: #1e40af;
        border: 1px solid #bfdbfe;
    }
    .tree-wrapper .child-summary::before {
        color: #2563eb;
    }
    .tree-actions a {
        text-decoration: none;
        padding: 6px 12px;
        border-radius: 8px;
        font-size: 13px;
        margin-left: 4px;
        font-weight: 700;
        display: inline-block;
    }
    .tree-actions .edit {
        background: #dbeafe;
        color: #1d4ed8;
    }
    .tree-actions .edit:hover {
        background: #bfdbfe;
    }
    .tree-actions .delete {
        background: #fee2e2;
        color: #dc2626;
    }
    .tree-actions .delete:hover {
        background: #fecaca;
    }
</style>

<div class="tree-card">
    <h2><i class="fa-solid fa-folder-tree me-2"></i>Unified Taxonomy Directory</h2>
    <p class="text-muted small mb-4">Hierarchical tree view showing Root Categories, Sub-Categories, and their associated Functional Tags.</p>

    <div class="tree-wrapper">
        <c:forEach items="${categories}" var="parent">
            <c:if test="${parent.parent == null}">
                <details>
                    <summary>
                        <span>📁 ${parent.name}</span>
                        <span class="tree-actions">
                            <a class="edit" href="${pageContext.request.contextPath}/admin/category/edit/${parent.id}">Edit</a>
                            <a class="delete" href="${pageContext.request.contextPath}/admin/category/delete/${parent.id}" onclick="return confirm('Delete this category?');">Delete</a>
                        </span>
                    </summary>
                    
                    <div class="tree-child-box">
                        <c:forEach items="${tags}" var="tag">
                            <c:if test="${tag.category.id == parent.id}">
                                <div class="tree-row">
                                    <span>🏷 ${tag.name}</span>
                                    <span class="tree-actions">
                                        <a class="edit" href="${pageContext.request.contextPath}/admin/tag/edit/${tag.id}">Edit</a>
                                        <a class="delete" href="${pageContext.request.contextPath}/admin/tag/delete/${tag.id}" onclick="return confirm('Delete this tag?');">Delete</a>
                                    </span>
                                </div>
                            </c:if>
                        </c:forEach>

                        <c:forEach items="${categories}" var="child">
                            <c:if test="${child.parent != null && child.parent.id == parent.id}">
                                <details>
                                    <summary class="child-summary">
                                        <span>📂 ${child.name}</span>
                                        <span class="tree-actions">
                                            <a class="edit" href="${pageContext.request.contextPath}/admin/category/edit/${child.id}">Edit</a>
                                            <a class="delete" href="${pageContext.request.contextPath}/admin/category/delete/${child.id}" onclick="return confirm('Delete this category?');">Delete</a>
                                        </span>
                                    </summary>
                                    
                                    <div class="tree-child-box">
                                        <c:forEach items="${tags}" var="tag">
                                            <c:if test="${tag.category.id == child.id}">
                                                <div class="tree-row">
                                                    <span>🏷 ${tag.name}</span>
                                                    <span class="tree-actions">
                                                        <a class="edit" href="${pageContext.request.contextPath}/admin/tag/edit/${tag.id}">Edit</a>
                                                        <a class="delete" href="${pageContext.request.contextPath}/admin/tag/delete/${tag.id}" onclick="return confirm('Delete this tag?');">Delete</a>
                                                    </span>
                                                </div>
                                            </c:if>
                                        </c:forEach>
                                    </div>
                                </details>
                            </c:if>
                        </c:forEach>
                    </div>
                </details>
            </c:if>
        </c:forEach>
    </div>
</div>