<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.advancedjava.model.Book" %>
<%
    Book book = (Book) request.getAttribute("book");
    if (book == null) {
        response.sendRedirect(request.getContextPath() + "/books");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Book</title>
<style>
body{margin:0;background:#f2f3f6;font-family:Segoe UI,Arial;color:#182235}
.top{height:62px;background:#fff;border-bottom:1px solid #e3e7ec;display:flex;align-items:center;padding:0 6%;font-weight:800;color:#316b5c;letter-spacing:1px}
.card{max-width:650px;margin:45px auto;background:#fff;border:1px solid #e3e7ec;border-radius:16px;padding:30px;box-shadow:0 5px 20px #1220330b}
h1{margin:0 0 6px;font-size:25px}.sub{color:#778196;font-size:13px;margin-bottom:25px}
.grid{display:grid;grid-template-columns:1fr 1fr;gap:16px}label{font-size:11px;font-weight:700;color:#586274}input,select{display:block;width:100%;margin-top:6px;padding:11px;border:1px solid #dfe4ea;border-radius:9px;box-sizing:border-box;font-size:13px}
.full{grid-column:1/-1}.actions{display:flex;gap:10px;margin-top:22px}.btn{border:1px solid #dfe4ea;background:#fff;border-radius:9px;padding:10px 16px;text-decoration:none;color:#303a4b;font-weight:700;font-size:12px}.save{background:#316b5c;color:#fff;border-color:#316b5c}
@media(max-width:600px){.grid{grid-template-columns:1fr}.full{grid-column:auto}.card{margin:20px 12px}}
</style>
</head>
<body>
<div class="top">LIBRARY MANAGEMENT</div>
<div class="card">
<h1>Edit Book</h1><div class="sub">Update the selected book record.</div>
<form action="<%=request.getContextPath()%>/books" method="post">
<input type="hidden" name="action" value="update"><input type="hidden" name="id" value="<%=book.getId()%>">
<div class="grid">
<label class="full">Book title<input name="title" required maxlength="150" value="<%=book.getTitle()%>"></label>
<label>Author<input name="author" required maxlength="100" value="<%=book.getAuthor()%>"></label>
<label>Category<input name="category" required maxlength="80" value="<%=book.getCategory()%>"></label>
<label>Status<select name="status"><option <%= "Available".equals(book.getStatus()) ? "selected" : "" %>>Available</option><option <%= "Issued".equals(book.getStatus()) ? "selected" : "" %>>Issued</option></select></label>
</div>
<div class="actions"><a class="btn" href="<%=request.getContextPath()%>/books">Cancel</a><button class="btn save" type="submit">Save Changes</button></div>
</form>
</div>
</body>
</html>
