<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Cheatsheet - ${cheatsheet.title}</title>

<style>
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Segoe UI', Arial, sans-serif;
}

body{
    min-height:100vh;
    background:linear-gradient(135deg,#f0fdf4,#dcfce7,#f8fafc);
    padding:30px;
    color:#1f2937;
}

.container{
    max-width:1300px;
    margin:auto;
}

.header{
    background:linear-gradient(135deg,#0284c7,#0ea5e9);
    color:white;
    padding:28px 35px;
    border-radius:24px;
    margin-bottom:25px;
    box-shadow:0 15px 35px rgba(14,165,233,.25);
}

.header h1{
    font-size:36px;
    margin-bottom:8px;
}

.grid{
    display:grid;
    grid-template-columns:1.4fr .9fr;
    gap:25px;
}

.card{
    background:white;
    border-radius:24px;
    padding:28px;
    box-shadow:0 15px 35px rgba(0,0,0,.08);
}

.form-title{
    color:#0369a1;
    font-size:26px;
    margin-bottom:22px;
    border-left:6px solid #0ea5e9;
    padding-left:14px;
}

.form-group{
    margin-bottom:18px;
}

label{
    display:block;
    margin-bottom:8px;
    font-weight:700;
    color:#374151;
}

input,
select,
textarea{
    width:100%;
    padding:14px 16px;
    border:2px solid #bae6fd;
    border-radius:14px;
    font-size:16px;
    background:#f0f9ff;
}

input:focus,
select:focus,
textarea:focus{
    outline:none;
    border-color:#0ea5e9;
    box-shadow:0 0 0 4px rgba(14,165,233,.15);
}

select:disabled {
    background: #e2e8f0 !important;
    border-color: #cbd5e1 !important;
    color: #64748b !important;
    cursor: not-allowed;
}

.tag-box.disabled-box {
    background: #e2e8f0 !important;
    border-color: #cbd5e1 !important;
    cursor: not-allowed;
}
.tag-item input:disabled {
    cursor: not-allowed;
}

textarea{
    resize:vertical;
    min-height:90px;
}

.row{
    display:grid;
    grid-template-columns:1fr 1fr;
    gap:18px;
}

.color-box{
    display:flex;
    align-items:center;
    gap:15px;
}

input[type="color"]{
    width:70px;
    height:50px;
    padding:4px;
    cursor:pointer;
}

.tag-box{
    display:grid;
    grid-template-columns:repeat(2,1fr);
    gap:10px;
    padding:15px;
    border:2px dashed #bae6fd;
    border-radius:16px;
    background:#f0f9ff;
}

.tag-item{
    display:flex;
    align-items:center;
    gap:8px;
    font-weight:600;
}

.tag-item input{
    width:auto;
}

.section-box{
    border:2px dashed #d1d5db;
    padding:18px;
    border-radius:18px;
    background:#f9fafb;
    margin-bottom:18px;
}

.section-top{
    display:flex;
    justify-content:space-between;
    align-items:flex-start;
    gap:12px;
}

.builder-row{
    display:grid;
    grid-template-columns:1.2fr 1fr 1fr auto;
    gap:12px;
    margin-bottom:12px;
    align-items:start;
}

/* Row Title ကို အမြဲ ပထမဆုံး/ဘယ်ဘက်မှာပြရန် */
.builder-row .row-title-input{
    grid-column:1;
    text-align:left;
    font-weight:700;
}

.builder-row .cell-key-input{
    grid-column:2;
    text-align:left;
}

.builder-row .cell-value-input{
    grid-column:3;
    text-align:left;
}

.builder-row .small-remove{
    grid-column:4;
}

.note-row{
    display:grid;
    grid-template-columns:1fr 2fr auto;
    gap:12px;
    margin-bottom:12px;
}

.builder-actions{
    display:flex;
    gap:10px;
    margin-top:12px;
}

.btn{
    border:none;
    padding:14px 18px;
    border-radius:14px;
    font-size:16px;
    font-weight:800;
    cursor:pointer;
}

.btn-add{
    background:#e0f2fe;
    color:#0369a1;
    border:2px solid #0ea5e9;
}

.remove-btn{
    background:#fee2e2;
    color:#dc2626;
    border:2px solid #fecaca;
}

.small-remove{
    padding:10px 14px;
    border-radius:12px;
    font-weight:800;
    cursor:pointer;
}

.preview-card{
    min-height:420px;
    border-radius:24px;
    padding:24px;
    color:white;
    box-shadow:0 15px 35px rgba(0,0,0,.15);
}

.cover-preview{
    height:170px;
    border:2px dashed rgba(255,255,255,.55);
    border-radius:18px;
    display:flex;
    justify-content:center;
    align-items:center;
    margin-bottom:18px;
    overflow:hidden;
    background: rgba(0, 0, 0, 0.2);
}

.cover-preview img{
    width:100%;
    height:100%;
    object-fit:cover;
}

.preview-title{
    font-size:28px;
    font-weight:800;
    margin-bottom:8px;
}

.preview-small{
    opacity:.9;
    margin-bottom:16px;
}

.action-buttons{
    display:flex;
    gap:15px;
    margin-top:20px;
}

.btn-update{
    width:100%;
    background:#0ea5e9;
    color:white;
    border:none;
    padding:16px;
    border-radius:14px;
    font-size:16px;
    font-weight:700;
    cursor:pointer;
}
.btn-update:hover{ opacity:.9; }

@media(max-width:900px){
    .grid, .row, .builder-row, .note-row { grid-template-columns:1fr; }
}
</style>
</head>

<body>

<div class="container">

    <div class="header">
        <h1>Edit Cheatsheet</h1>
        <p>Modify your existing cheatsheet structure, layout details and configuration trees.</p>
    </div>

    <form action="${pageContext.request.contextPath}/profile-cheatsheets/update"
          method="post"
          enctype="multipart/form-data">
          
          <input type="hidden" name="id" value="${cheatsheet.id}">
          
          <input type="hidden" name="parentCategoryId" value="${cheatsheet.category.parent.id}">
          <input type="hidden" name="categoryId" value="${cheatsheet.category.id}">

          <c:forEach items="${cheatsheet.tags}" var="t">
              <input type="hidden" name="tagIds" value="${t.id}">
          </c:forEach>

          <div class="grid">

            <div class="card">
                <h2 class="form-title">Basic Information Hub</h2>

                <div class="row">
                    <div class="form-group">
                        <label>Parent Category</label>
                        <select id="parentCategory" disabled>
                            <c:forEach items="${categories}" var="c">
                                <c:if test="${c.parent == null}">
                                    <option value="${c.id}" ${c.id == cheatsheet.category.parent.id ? 'selected' : ''}>
                                        ${c.name}
                                    </option>
                                </c:if>
                            </c:forEach>
                       </select>
                    </div>

                    <div class="form-group">
                        <label>Child Category</label>
                         <select id="childCategory" disabled>
                            <c:forEach items="${categories}" var="c">
                                <c:if test="${c.parent != null}">
                                     <option value="${c.id}" data-parent="${c.parent.id}" ${c.id == cheatsheet.category.id ? 'selected' : ''}>
                                        ${c.name}
                                     </option>
                                </c:if>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label>Title</label>
                    <input type="text" name="title" id="titleInput" value="${cheatsheet.title}" required>
                </div>

                <div class="form-group">
                    <label>Description</label>
                    <textarea name="description">${cheatsheet.description}</textarea>
                </div>

                <div class="row">
                    <div class="form-group">
                        <label>Theme Color</label>
                        <div class="color-box">
                            <input type="color" name="themeColor" id="themeColor" value="${cheatsheet.themeColor}">
                            <span>Adjust layout theme branding</span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label>Update Cover Photo</label>
                        <input type="file" name="coverPhoto" id="coverPhoto" accept="image/*">
                    </div>
                </div>

                <div class="row">
                    <div class="form-group">
                        <label>Publish Status</label>
                        <select name="publishStatus">
                            <option value="DRAFT" ${cheatsheet.publishStatus == 'DRAFT' ? 'selected' : ''}>DRAFT</option>
                            <option value="PUBLISHED" ${cheatsheet.publishStatus == 'PUBLISHED' ? 'selected' : ''}>PUBLISHED</option>
                            <option value="ARCHIVED" ${cheatsheet.publishStatus == 'ARCHIVED' ? 'selected' : ''}>ARCHIVED</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>Visibility</label>
                        <select name="visibility">
                            <option value="PUBLIC" ${cheatsheet.visibility == 'PUBLIC' ? 'selected' : ''}>PUBLIC</option>
                            <option value="PRIVATE" ${cheatsheet.visibility == 'PRIVATE' ? 'selected' : ''}>PRIVATE</option>
                            <option value="UNLISTED" ${cheatsheet.visibility == 'UNLISTED' ? 'selected' : ''}>UNLISTED</option>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label>Tags Association Hub</label>
                    <div class="tag-box disabled-box" id="tagBox">
                        <c:forEach items="${tags}" var="tag">
                            <label class="tag-item" data-category="${tag.category.id}">
                                <c:set var="isMatch" value="false" />
                                <c:forEach items="${cheatsheet.tags}" var="t">
                                    <c:if test="${t.id == tag.id}"><c:set var="isMatch" value="true" /></c:if>
                                </c:forEach>
                                <input type="checkbox" disabled ${isMatch ? 'checked' : ''}>
                                #${tag.name}
                            </label>
                        </c:forEach>
                    </div>
                </div>

                <h2 class="form-title">Cheatsheet Tree Data Layout Builder</h2>
                <div id="sectionContainer">
                    <c:forEach items="${cheatsheet.sections}" var="section" varStatus="secStatus">
                        <div class="section-box" data-section-index="${secStatus.index}">
                            <input type="hidden" name="sectionIndexes" value="${secStatus.index}">
                            
                            <div class="section-top">
                                <div class="form-group" style="flex:1;">
                                    <label>Section Header Name</label>
                                    <input type="text" name="sectionTitles" value="${section.title}" placeholder="Section Title">
                                </div>
                                <button type="button" class="btn remove-btn small-remove" onclick="removeItem(this)">- Section</button>
                            </div>

                            <div class="rows-container">
                                <c:forEach items="${section.rows}" var="row">
                                    <c:forEach items="${row.cells}" var="cell">
                                        <div class="builder-row">
                                            <input type="text" class="row-title-input" name="rowTitles_${secStatus.index}" value="${row.rowTitle}" placeholder="Row Title">
                                            <input type="text" class="cell-key-input" name="cellKeys_${secStatus.index}" value="${cell.cellKey}" placeholder="Syntax / Code">
                                            <input type="text" class="cell-value-input" name="cellValues_${secStatus.index}" value="${cell.cellValue}" placeholder="Output / Rule">
                                            <button type="button" class="btn remove-btn small-remove" onclick="removeItem(this)">-</button>
                                        </div>
                                    </c:forEach>
                                </c:forEach>
                            </div>

                            <div class="notes-container">
                                <c:forEach items="${section.notes}" var="note">
                                    <div class="note-row">
                                        <input type="text" name="noteTitles_${secStatus.index}" value="${note.noteTitle}" placeholder="Note Title">
                                        <textarea name="noteContents_${secStatus.index}" placeholder="Add helpful note statement...">${note.noteContent}</textarea>
                                        <button type="button" class="btn remove-btn small-remove" onclick="removeItem(this)">-</button>
                                    </div>
                                </c:forEach>
                            </div>

                            <div class="builder-actions">
                                <button type="button" class="btn btn-add" onclick="addRow(this)">+ Row</button>
                                <button type="button" class="btn btn-add" onclick="addNote(this)">+ Note</button>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <button type="button" class="btn btn-add" onclick="addSection()">+ Add Section</button>

                <div class="action-buttons">
                    <button type="submit" class="btn btn-update">
                        💾 Save & Update Changes
                    </button>
                </div>
            </div>

            <div>
                <div class="preview-card" id="previewCard" style="background: ${not empty cheatsheet.themeColor ? cheatsheet.themeColor : '#0ea5e9'};">
                  
                    <div class="cover-preview" id="coverPreview">
                        <c:choose>
                            <c:when test="${not empty cheatsheet.mediaList}">
                            
                            
                             <img src="${cheatsheet.mediaList[0].mediaUrl}"
                 alt="Cover">
                             
                             
                            </c:when>
                            <c:otherwise>Cover preview</c:otherwise>
                        </c:choose>
                    </div>
                    
                    
                    <div class="preview-title" id="previewTitle">${cheatsheet.title}</div>
                    <div class="preview-small" id="previewCategory">Category: ${cheatsheet.category.name}</div>
                    <div class="preview-small">Interactive Builder Mode active. All layers syncing properly.</div>
                </div>
            </div>

          </div>
    </form>
</div>

<script>
const childCategory = document.getElementById("childCategory");
const tagItems = document.querySelectorAll(".tag-item");
const themeColor = document.getElementById("themeColor");
const previewCard = document.getElementById("previewCard");
const titleInput = document.getElementById("titleInput");
const previewTitle = document.getElementById("previewTitle");
const coverPhoto = document.getElementById("coverPhoto");
const coverPreview = document.getElementById("coverPreview");

let sectionIndex = ${not empty cheatsheet.sections ? cheatsheet.sections.size() : 1};

function filterTagsOnLoad(){
    const categoryId = childCategory.value;
    tagItems.forEach(item => {
        item.style.display = item.dataset.category === categoryId ? "flex" : "none";
    });
}

themeColor.addEventListener("input", function(){ previewCard.style.background = this.value; });
titleInput.addEventListener("input", function(){ previewTitle.innerText = this.value.trim() === "" ? "My Cheat Sheet" : this.value; });

coverPhoto.addEventListener("change", function(){
    const file = this.files[0];
    if(file){
        const reader = new FileReader();
        reader.onload = function(e){ coverPreview.innerHTML = '<img src="' + e.target.result + '">'; };
        reader.readAsDataURL(file);
    }
});

function removeItem(button){
    const target = button.closest(".builder-row, .note-row, .section-box");
    if(target) target.remove();
}

function addSection(){
    const container = document.getElementById("sectionContainer");
    const html =
        '<div class="section-box" data-section-index="' + sectionIndex + '">' +
            '<input type="hidden" name="sectionIndexes" value="' + sectionIndex + '">' +
            '<div class="section-top">' +
                '<div class="form-group" style="flex:1;">' +
                    '<label>Section Header Name</label>' +
                    '<input type="text" name="sectionTitles" placeholder="Section Title">' +
                '</div>' +
                '<button type="button" class="btn remove-btn small-remove" onclick="removeItem(this)">- Section</button>' +
            '</div>' +
            '<div class="rows-container">' +
                '<div class="builder-row">' +
                    '<input type="text" class="row-title-input" name="rowTitles_' + sectionIndex + '" placeholder="Row Title">' +
                    '<input type="text" class="cell-key-input" name="cellKeys_' + sectionIndex + '" placeholder="Syntax / Code">' +
                    '<input type="text" class="cell-value-input" name="cellValues_' + sectionIndex + '" placeholder="Output / Rule">' +
                    '<button type="button" class="btn remove-btn small-remove" onclick="removeItem(this)">-</button>' +
                '</div>' +
            '</div>' +
            '<div class="notes-container">' +
                '<div class="note-row">' +
                    '<input type="text" name="noteTitles_' + sectionIndex + '" placeholder="Note Title">' +
                    '<textarea name="noteContents_' + sectionIndex + '" placeholder="Add helpful note statement..."></textarea>' +
                    '<button type="button" class="btn remove-btn small-remove" onclick="removeItem(this)">-</button>' +
                '</div>' +
            '</div>' +
            '<div class="builder-actions">' +
                '<button type="button" class="btn btn-add" onclick="addRow(this)">+ Row</button>' +
                '<button type="button" class="btn btn-add" onclick="addNote(this)">+ Note</button>' +
            '</div>' +
        '</div>';
    container.insertAdjacentHTML("beforeend", html);
    sectionIndex++;
}

function addRow(button){
    const sectionBox = button.closest(".section-box");
    const index = sectionBox.dataset.sectionIndex;
    const rowsContainer = sectionBox.querySelector(".rows-container");
    const html =
        '<div class="builder-row">' +
            '<input type="text" class="row-title-input" name="rowTitles_' + index + '" placeholder="Row Title">' +
            '<input type="text" class="cell-key-input" name="cellKeys_' + index + '" placeholder="Syntax / Code">' +
            '<input type="text" class="cell-value-input" name="cellValues_' + index + '" placeholder="Output / Rule">' +
            '<button type="button" class="btn remove-btn small-remove" onclick="removeItem(this)">-</button>' +
        '</div>';
    rowsContainer.insertAdjacentHTML("beforeend", html);
}

function addNote(button){
    const sectionBox = button.closest(".section-box");
    const index = sectionBox.dataset.sectionIndex;
    const notesContainer = sectionBox.querySelector(".notes-container");
    const html =
        '<div class="note-row">' +
            '<input type="text" name="noteTitles_' + index + '" placeholder="Note Title">' +
            '<textarea name="noteContents_' + index + '" placeholder="Add helpful note statement..."></textarea>' +
            '<button type="button" class="btn remove-btn small-remove" onclick="removeItem(this)">-</button>' +
        '</div>';
    notesContainer.insertAdjacentHTML("beforeend", html);
}

filterTagsOnLoad();
</script>

</body>
</html>