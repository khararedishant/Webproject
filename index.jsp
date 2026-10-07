<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List,java.util.LinkedHashSet,java.util.Set,com.advancedjava.model.Book" %>
<%!
    private String esc(String s) {
        if (s == null) return "";
        return s.replace("&","&amp;").replace("<","&lt;").replace(">","&gt;")
                .replace("\"","&quot;").replace("'","&#39;");
    }
%>
<%
    List<Book> books = (List<Book>) request.getAttribute("books");
    String keyword = (String) request.getAttribute("keyword");
    if (keyword == null) keyword = "";
    int total = books == null ? 0 : books.size();
    int available = 0, issued = 0;
    Set<String> categories = new LinkedHashSet<String>();
    if (books != null) {
        for (Book b : books) {
            if ("Available".equalsIgnoreCase(b.getStatus())) available++;
            if ("Issued".equalsIgnoreCase(b.getStatus())) issued++;
            categories.add(b.getCategory());
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>Library Management Dashboard</title>
<style>
:root{--ink:#182235;--muted:#778196;--green:#316b5c;--dark:#255648;--line:#e3e7ec;--bg:#f2f3f6;--white:#fff}
*{box-sizing:border-box}body{margin:0;background:var(--bg);font-family:Segoe UI,Arial,sans-serif;color:var(--ink)}
.top{height:62px;background:#fff;border-bottom:1px solid var(--line);display:flex;justify-content:space-between;align-items:center;padding:0 max(20px,calc((100% - 1380px)/2))}
.brand{font-weight:800;letter-spacing:1.2px;color:var(--green);font-size:13px}.brand b{display:inline-grid;place-items:center;background:#e6f1ed;width:30px;height:30px;border-radius:9px;margin-right:8px}
.admin{font-size:12px;color:var(--muted)}
main{max-width:1380px;margin:24px auto;padding:0 24px 45px}
.hero,.panel,.stat{background:#fff;border:1px solid var(--line);border-radius:16px;box-shadow:0 3px 14px #12203308}
.hero{padding:28px 30px}.eyebrow{font-size:10px;color:#9aa2af;font-weight:700;letter-spacing:1.4px;margin:0 0 11px}h1{font-size:27px;margin:0 0 7px;letter-spacing:-.5px}.sub{color:var(--muted);font-size:13px}
.toolbar{display:flex;gap:9px;align-items:center;margin-top:21px;flex-wrap:wrap}.spacer{flex:1}
.btn,button{font:600 12px Segoe UI,Arial;border:1px solid var(--line);border-radius:9px;background:#fff;color:#303a4b;padding:10px 15px;text-decoration:none;cursor:pointer}.primary{background:var(--green);border-color:var(--green);color:#fff}.primary:hover{background:var(--dark)}
.stats{display:grid;grid-template-columns:repeat(4,1fr);gap:13px;margin:16px 0}.stat{padding:16px 18px;min-height:90px}.label{font-size:12px;font-weight:700;color:#465064}.value{font-size:25px;font-weight:800;margin-top:8px}.hint{font-size:10px;color:#929baa;margin-top:3px}
.panel{padding:20px 22px}.panelhead{display:flex;justify-content:space-between;align-items:flex-start;margin-bottom:17px}h2{font-size:21px;font-weight:500;margin:0 0 4px}.found{font-size:11px;color:#8992a1}
.controls{display:flex;gap:8px;align-items:center;flex-wrap:wrap;border-bottom:1px solid #edf0f3;padding-bottom:13px;margin-bottom:9px}.search{display:flex;gap:8px;margin-left:auto}.search input{width:270px;border:1px solid var(--line);border-radius:8px;padding:9px 11px;font-size:12px;outline:none}.search input:focus{border-color:#82aa9c}
.wrap{overflow-x:auto}table{width:100%;border-collapse:collapse;min-width:760px;font-size:12px}th{text-align:left;padding:12px 10px;background:#fbfcfd;color:#667084;border-bottom:1px solid var(--line);font-size:10px;text-transform:uppercase;letter-spacing:.4px}td{padding:13px 10px;border-bottom:1px solid #edf0f3}.title{font-weight:700}.muted{color:#5e6879}.tag{display:inline-block;background:#f0f4f2;color:#42695d;padding:5px 8px;border-radius:6px;font-size:10px}.status{font-size:10px;font-weight:700;padding:5px 8px;border-radius:20px}.available{background:#e1f3e9;color:#28714e}.issued{background:#fff0df;color:#a15c12}.actions{display:flex;gap:5px}.edit{background:#edf4f1;color:#316b5c}.delete{background:#fff0ef;color:#b43e39}.empty{text-align:center;padding:30px;color:#8992a1}.foot{font-size:10px;color:#9aa2af;margin-top:12px}
.add{margin-top:16px}.formgrid{display:grid;grid-template-columns:2fr 1.3fr 1fr 1fr auto;gap:11px;align-items:end;margin-top:15px}label{font-size:10px;font-weight:700;color:#586274}label input,label select{display:block;width:100%;margin-top:6px;padding:10px;border:1px solid var(--line);border-radius:8px;font-size:12px;background:#fff}
@media(max-width:850px){.stats{grid-template-columns:1fr 1fr}.formgrid{grid-template-columns:1fr 1fr}.addbtn{grid-column:1/-1}}@media(max-width:600px){main{padding:0 12px 30px}.stats{grid-template-columns:1fr}.hero{padding:22px 18px}.panel{padding:17px 14px}.search{margin-left:0;flex:1 1 100%}.search input{width:100%}.spacer{display:none}.formgrid{grid-template-columns:1fr}.addbtn{grid-column:auto}}
@media print{.top,.toolbar,.controls,.actions,.add,.foot{display:none!important}main{max-width:none;margin:0;padding:0}.hero,.panel,.stat{box-shadow:none}.stats{grid-template-columns:repeat(4,1fr)}}
</style>
</head>
<body>
<div class="top"><div class="brand"><b>▣</b>LIBRARY MANAGEMENT</div><div class="admin">Admin Dashboard</div></div>
<main>
<section class="hero">
<p class="eyebrow">LIBRARY MANAGEMENT</p><h1>Manage books and library records</h1><div class="sub">A simple dashboard for keeping your library collection organized.</div>
<div class="toolbar"><button onclick="exportCSV()">⇩ Export CSV</button><button onclick="window.print()">▣ Print</button><span class="spacer"></span><a class="btn primary" href="#add-book">＋ Add Book</a></div>
</section>

<section class="stats">
<div class="stat"><div class="label">Books shown</div><div class="hint">Current list / search results</div><div class="value"><%=total%></div></div>
<div class="stat"><div class="label">Available</div><div class="hint">Ready to issue</div><div class="value"><%=available%></div></div>
<div class="stat"><div class="label">Issued</div><div class="hint">Currently issued</div><div class="value"><%=issued%></div></div>
<div class="stat"><div class="label">Categories</div><div class="hint">Distinct categories</div><div class="value"><%=categories.size()%></div></div>
</section>

<section class="panel">
<div class="panelhead"><div><h2>All Books</h2><div class="found"><%=total%> book<%=total==1?"":"s"%> found</div></div></div>
<div class="controls">
<button onclick="document.getElementById('keyword').focus()">⚑ Filter</button>
<form class="search" action="<%=request.getContextPath()%>/books" method="get"><input id="keyword" name="keyword" value="<%=esc(keyword)%>" placeholder="⌕  Search title, author or category"><button type="submit">Search</button></form>
</div>
<div class="wrap"><table id="booksTable">
<thead><tr><th>ID</th><th>Book</th><th>Author</th><th>Category</th><th>Status</th><th>Actions</th></tr></thead>
<tbody>
<% if(books==null || books.isEmpty()){ %><tr><td colspan="6" class="empty">No books found. Add a book to get started.</td></tr>
<% } else { for(Book b:books){ %>
<tr><td><%=b.getId()%></td><td class="title"><%=esc(b.getTitle())%></td><td class="muted"><%=esc(b.getAuthor())%></td><td><span class="tag"><%=esc(b.getCategory())%></span></td>
<td><span class="status <%= "Available".equalsIgnoreCase(b.getStatus())?"available":"issued" %>"><%=esc(b.getStatus())%></span></td>
<td><div class="actions"><a class="btn edit" href="<%=request.getContextPath()%>/books?action=edit&id=<%=b.getId()%>">Edit</a>
<form action="<%=request.getContextPath()%>/books" method="post" onsubmit="return confirm('Delete this book?')"><input type="hidden" name="action" value="delete"><input type="hidden" name="id" value="<%=b.getId()%>"><button class="delete" type="submit">Delete</button></form></div></td></tr>
<% }} %>
</tbody></table></div>
<div class="foot">Book data is loaded from MySQL through Servlet and JDBC.</div>
</section>

<section class="panel add" id="add-book">
<h2>Add a Book</h2><div class="sub">Register a new book in the library database.</div>
<form class="formgrid" action="<%=request.getContextPath()%>/books" method="post">
<input type="hidden" name="action" value="add">
<label>Book title<input name="title" required maxlength="150" placeholder="e.g. Java Complete Reference"></label>
<label>Author<input name="author" required maxlength="100" placeholder="Author name"></label>
<label>Category<input name="category" required maxlength="80" placeholder="Programming"></label>
<label>Status<select name="status"><option>Available</option><option>Issued</option></select></label>
<button class="primary addbtn" type="submit">＋ Add Book</button>
</form>
</section>
</main>
<script>
function exportCSV(){
 const table=document.getElementById('booksTable');
 const rows=Array.from(table.querySelectorAll('tr')).map(r=>Array.from(r.querySelectorAll('th,td')).slice(0,5).map(c=>'"'+c.innerText.replace(/"/g,'""').trim()+'"').join(','));
 const blob=new Blob([rows.join('\r\n')],{type:'text/csv;charset=utf-8;'});
 const a=document.createElement('a');a.href=URL.createObjectURL(blob);a.download='library-books.csv';a.click();
}
</script>
</body>
</html>
