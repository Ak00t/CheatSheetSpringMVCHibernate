<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create Cheatsheet</title>

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
    background:linear-gradient(135deg,#059669,#22c55e);
    color:white;
    padding:28px 35px;
    border-radius:24px;
    margin-bottom:25px;
    box-shadow:0 15px 35px rgba(5,150,105,.25);
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
    color:#065f46;
    font-size:26px;
    margin-bottom:22px;
    border-left:6px solid #10b981;
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
    border:2px solid #bbf7d0;
    border-radius:14px;
    font-size:16px;
    background:#f8fffb;
}

input:focus,
select:focus,
textarea:focus{
    outline:none;
    border-color:#10b981;
    box-shadow:0 0 0 4px rgba(16,185,129,.15);
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
    border:2px dashed #bbf7d0;
    border-radius:16px;
    background:#f0fdf4;
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

.request-row{
    display:grid;
    grid-template-columns:1fr auto;
    gap:10px;
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

.builder-row .row-title-input{
    grid-column:1;
    text-align:left;
    font-weight:700;
    color:#111;
}

.builder-row .cell-key-input{
    grid-column:2;
    text-align:left;
    font-weight:400;
}

.builder-row .cell-value-input{
    grid-column:3;
    text-align:left;
    font-weight:400;
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
    background:#ecfdf5;
    color:#047857;
    border:2px solid #10b981;
}

.btn-request{
    background:#2563eb;
    color:white;
    border:2px solid #1d4ed8;
    white-space:nowrap;
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

.btn-save{
    width:100%;
    background:linear-gradient(135deg,#2563eb,#1d4ed8);
    color:white;
    margin-top:20px;
}

.preview-card{
    min-height:420px;
    border-radius:24px;
    padding:24px;
    color:white;
    background:#8b5cf6;
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

.pending-box{
    margin-top:20px;
    background:white;
    border-radius:18px;
    padding:18px;
}

.pending-box h3{
    color:#b91c1c;
    margin-bottom:12px;
}

.pending-box table{
    width:100%;
    border-collapse:collapse;
}

.pending-box th,
.pending-box td{
    padding:10px;
    border-bottom:1px solid #fecaca;
    text-align:left;
    color:#374151;
}

.remove-request{
    background:#fee2e2;
    color:#dc2626;
    border:none;
    padding:6px 10px;
    border-radius:8px;
    cursor:pointer;
    font-weight:700;
}

@media(max-width:900px){
    .grid,
    .row,
    .builder-row,
    .note-row,
    .request-row{
        grid-template-columns:1fr;
    }
}

.action-buttons{
    display:flex;
    gap:15px;
    margin-top:20px;
}

.btn-draft{
    flex:1;
    background:#f59e0b;
    color:white;
    border:none;
    padding:16px;
    border-radius:14px;
    font-size:16px;
    font-weight:700;
    cursor:pointer;
}

.btn-publish{
    flex:1;
    background:#2563eb;
    color:white;
    border:none;
    padding:16px;
    border-radius:14px;
    font-size:16px;
    font-weight:700;
    cursor:pointer;
}

.btn-draft:hover{
    opacity:.9;
}

.btn-publish:hover{
    opacity:.9;
}

</style>
</head>

<body>

<div class="container">

    <div class="header">
        <h1>Create Cheatsheet</h1>
        <p>Create cheatsheet with category, tags, color, cover photo and sections.</p>
    </div>

    <form action="${pageContext.request.contextPath}/admin/cheatsheet/save"
          method="post"
          enctype="multipart/form-data">
          
          <div class="grid">

            <div class="card">

                <h2 class="form-title">Cheatsheet Information</h2>

                <div class="row">

                    <div class="form-group">
                       
                        <label>Parent Category</label>

                        <select id="parentCategory" name="parentCategoryId">
                            <option value="">-- Select Parent --</option>

                            <c:forEach items="${categories}" var="c">
          
                               <c:if test="${c.parent == null}">
                                    <option value="${c.id}">
                                      
                                       ${c.name}
                                    </option>
                                </c:if>
                            </c:forEach>
  
                       </select>
                    </div>

                    <div class="form-group">
                        <label>Child Category</label>

                         <select id="childCategory" name="categoryId" required>
                            <option value="">-- Choose Parent First --</option>

                            <c:forEach items="${categories}" var="c">
                      
                               <c:if test="${c.parent != null}">
                                    <option value="${c.id}" data-parent="${c.parent.id}">
                                        ${c.name}
         
                                    </option>
                                </c:if>
                            </c:forEach>
             
                        </select>
                    </div>

                </div>

                <div class="form-group">
                    <label>Title</label>
                
                    <input type="text"
                           name="title"
                           id="titleInput"
                           placeholder="My Cheat Sheet"
            
                           required>
                </div>

                <div class="form-group">
                    <label>Description</label>
                    <textarea name="description"
           
                    placeholder="Write cheatsheet description"></textarea>
                </div>

                <div class="row">

                    <div class="form-group">
                        <label>Theme Color</label>

                        <div class="color-box">
                            <input type="color"
                                   name="themeColor"
           
                                   id="themeColor"
                                   value="#8b5cf6">

                            <span>Choose your custom color</span>
          
                       </div>
                    </div>

                    <div class="form-group">
                        <label>Cover Photo</label>
                    
                    <input type="file"
                               name="coverPhoto"
                               id="coverPhoto"
                               accept="image/*">
  
                   </div>

                </div>

                <div class="form-group">
                    <label>Tags Association Hub</label>

                    <div class="tag-box" id="tagBox">

     
                    <c:forEach items="${tags}" var="tag">
                            <label class="tag-item" data-category="${tag.category.id}">
                                <input type="checkbox"
                
                                       name="tagIds"
                                       value="${tag.id}">
                                #${tag.name}
      
                           </label>
                        </c:forEach>

                    </div>
                </div>

                <div class="form-group">
 
                    <label>Request Custom Tag</label>

                    <div class="request-row">
                        <input type="text"
                               id="requestedTag"
  
                               placeholder="e.g. django">

                        <button type="button"
                                class="btn btn-request"
                                onclick="addRequestedTag()">
          
                           + Request Tag
                        </button>
                    </div>

                    <div id="requestedTagHiddenBox"></div>
               
  </div>

                <h2 class="form-title">Cheatsheet Tree Data Layout Builder</h2>

                <div id="sectionContainer">

                    <div class="section-box" data-section-index="0">

                        <input type="hidden" name="sectionIndexes" value="0">

            
                         <div class="section-top">
                            <div class="form-group" style="flex:1;">
                                <label>Section Header Name</label>
                       
                                  <input type="text"
                                       name="sectionTitles"
                                       placeholder="Section Title">
           
                              </div>
                        </div>

                        <div class="rows-container">

                            <div class="builder-row">
     
                                    <input type="text"
                                       name="rowTitles_0"
                                       class="row-title-input"
                                       placeholder="Row Title">

                                <input type="text"
                                       name="cellKeys_0"
                                       class="cell-key-input"
                                       placeholder="Syntax / Code">

                                <input type="text"
                                       name="cellValues_0"
                                       class="cell-value-input"
                                       placeholder="Output / Rule">

                                <button type="button"
                                  
                                       class="btn remove-btn small-remove"
                                        onclick="removeItem(this)">
                                    -
                
                                 </button>
                            </div>

                        </div>

                        <div class="notes-container">

       
                             <div class="note-row">
                                <input type="text"
                                       name="noteTitles_0"
      
                                       placeholder="Note Title">

                                <textarea name="noteContents_0"
                                 
                                          placeholder="Add helpful note statement..."></textarea>

                                <button type="button"
                                        class="btn remove-btn small-remove"
             
                                        onclick="removeItem(this)">
                                    -
                                </button>
     
                        </div>

                        </div>

                        <div class="builder-actions">
                            
                        <button type="button"
                                    class="btn btn-add"
                                    onclick="addRow(this)">
                          
                               + Row
                            </button>

                            <button type="button"
                                    
                                    class="btn btn-add"
                                    onclick="addNote(this)">
                                + Note
                            </button>
  
                       </div>

                    </div>

                </div>

                <button type="button"
                        class="btn btn-add"
                        onclick="addSection()">
                    + Add Section
                </button>

                <div class="action-buttons">

                    <button type="submit"
                            name="action"
                            value="draft"
                            class="btn btn-draft">
                        Draft Cheatsheet
                    </button>

                    <button type="submit"
                            name="action"
                      
                            value="publish"
                            class="btn btn-publish">
                        Public Cheatsheet
                    </button>

                </div>


            </div>

            <div>

                <div class="preview-card" id="previewCard">

                    <div class="cover-preview" id="coverPreview">
   
                        Cover preview
                    </div>

                    <div class="preview-title" id="previewTitle">
                        My Cheat Sheet
          
                    </div>

                    <div class="preview-small" id="previewCategory">
                        Category: None
                    </div>

                    <div class="preview-small">
  
                        Section Layer
                    </div>

                    <div class="preview-small">
                        Selected tags will appear after choosing category
    
                    </div>

                </div>

                <div class="pending-box">
                    <h3>Requested Tag Queue</h3>

                    <table>
         
                        <thead>
                            <tr>
                                <th>Tag</th>
                         
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>

         
                        <tbody id="requestPreview">
                            <tr>
                                <td colspan="3">No pending tags in queue.</td>
                   
                            </tr>
                        </tbody>
                    </table>
                </div>

            </div>

        </div>

    </form>

</div>

<script>
const parentSelect = document.getElementById("parentCategory");
const childSelect = document.getElementById("childCategory");

// ပြင်ဆင်ချက် - ID ကိစ္စရပ်ကို ဖယ်ထုတ်ထားသဖြင့် Variable ညွှန်းဆိုမှု မလိုအပ်တော့ပါ

const tagItems = document.querySelectorAll(".tag-item");
const themeColor = document.getElementById("themeColor");
const previewCard = document.getElementById("previewCard");
const titleInput = document.getElementById("titleInput");
const previewTitle = document.getElementById("previewTitle");
const previewCategory = document.getElementById("previewCategory");
const coverPhoto = document.getElementById("coverPhoto");
const coverPreview = document.getElementById("coverPreview");
const requestedTag = document.getElementById("requestedTag");
const requestPreview = document.getElementById("requestPreview");
const requestedTagHiddenBox = document.getElementById("requestedTagHiddenBox");

let requestedTags = [];

function filterChildCategories() {

    const parentId = parentSelect.value;
    Array.from(childSelect.options).forEach(option => {

        if (option.value === "") {
            option.hidden = false;
            option.disabled = false;
            return;
        }

        const show = option.dataset.parent === parentId;

        option.hidden = !show;
        option.disabled = !show;
    });
    childSelect.value = "";
    filterTags();
}




function filterTags(){
    const categoryId = childSelect.value;
    
    // ပြင်ဆင်ချက် - hidden box ထဲကို data လှမ်းထည့်သည့် စာကြောင်းအား ဖယ်ရှားပြီးဖြစ်ပါသည်
    
    tagItems.forEach(item => {
        item.style.display =
            item.dataset.category === categoryId ? "flex" : "none";

        if(item.dataset.category !== categoryId){
            item.querySelector("input").checked = false;
        }
    });
    const selectedText =
        childSelect.options[childSelect.selectedIndex]?.text || "None";

    previewCategory.innerText = "Category: " + selectedText;
}

function addRequestedTag(){
    const value = requestedTag.value.trim();

    if(value === ""){
        alert("Please enter tag name.");
        return;
    }

    if(requestedTags.includes(value.toLowerCase())){
        alert("This tag is already requested.");
        return;
    }

    requestedTags.push(value.toLowerCase());
    requestedTag.value = "";
    renderRequestedTags();
}

function removeRequestedTag(index){
    requestedTags.splice(index, 1);
    renderRequestedTags();
}

function renderRequestedTags(){
    requestPreview.innerHTML = "";
    requestedTagHiddenBox.innerHTML = "";
    if(requestedTags.length === 0){
        requestPreview.innerHTML =
            '<tr><td colspan="3">No pending tags in queue.</td></tr>';
        return;
    }

    requestedTags.forEach((tag, index) => {
        requestPreview.innerHTML +=
            '<tr>' +
                '<td>#' + tag + '</td>' +
                '<td>Pending</td>' +
                '<td>' +
               
                    '<button type="button" class="remove-request" onclick="removeRequestedTag(' + index + ')">Remove</button>' +
                '</td>' +
            '</tr>';

        requestedTagHiddenBox.innerHTML +=
            '<input type="hidden" name="requestedTags" value="' + tag + '">';
    });
}

parentSelect.addEventListener("change", filterChildCategories);
childSelect.addEventListener("change", filterTags);

themeColor.addEventListener("input", function(){
    previewCard.style.background = this.value;
});
titleInput.addEventListener("input", function(){
    previewTitle.innerText =
        this.value.trim() === "" ? "My Cheat Sheet" : this.value;
});
coverPhoto.addEventListener("change", function(){
    const file = this.files[0];

    if(file){
        const reader = new FileReader();

        reader.onload = function(e){
            coverPreview.innerHTML =
                '<img src="' + e.target.result + '">';
        };

        reader.readAsDataURL(file);
    }
});
let sectionIndex = 1;

function removeItem(button){
    const target = button.closest(".builder-row, .note-row, .section-box");
    if(target){
        target.remove();
    }
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
                    '<input type="text" name="rowTitles_' + sectionIndex + '" class="row-title-input" placeholder="Row Title">' +
                    '<input type="text" name="cellKeys_' + sectionIndex + '" class="cell-key-input" placeholder="Syntax / Code">' +
                    '<input type="text" name="cellValues_' + sectionIndex + '" class="cell-value-input" placeholder="Output / Rule">' +
        
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
            '<input type="text" name="rowTitles_' + index + '" class="row-title-input" placeholder="Row Title">' +
            '<input type="text" name="cellKeys_' + index + '" class="cell-key-input" placeholder="Syntax / Code">' +
            '<input type="text" name="cellValues_' + index + '" class="cell-value-input" placeholder="Output / Rule">' +
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

filterChildCategories();
filterTags();
renderRequestedTags();
</script>

</body>
</html>