<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
$(document).ready(function(){
	$.ajax({
		type:"POST",
		url:"book.do",
		data:"command=getSubject",
		dataType:"json",
		success:function(data){
		var subject="<option value=''>---선택---</option value>";
		for(i=0; i<data.list.length; i++){
		subject+="<option value="+data.list[i]+">"+data.list[i]+"</option>";
		}
		$("#subject").html(subject);
		
	}//success
});//ajax
	$("#subject").change(function() {
		var bookList;
		var subject=$(this).val(); 
		$.ajax({
		 type:"POST",
		 url:"book.do",
		 data:"command=recommandBook&subject="+subject,
		 dataType:"json",
		success:function(data){ 
		 bookList="";
		 for(i=0; i<data.list.length; i++){
		bookList+="<tr><td>"+data.list[i].TITLE+"</td><td>"+data.list[i].WRITER+"</td><td>"+data.list[i].AVERAGE+"</td><td>"+data.list[i].C_ISBN+"</td><td>"+data.list[i].SUBJECT+"</td></tr>";	 
		 }
		$("#tableBook").html(bookList);
		}//callback함
	});//ajax()함수
	});//click

}) //ready

</script>
</head>
<body>
<select id="subject">
<option value="">--분야선택---</option>
</select>

<table border="1">
<thead>
<tr>
<td>책제목</td>
<td>글쓴이</td>
<td>평점</td>
<td>ISBN</td>
<td>분류</td>
</tr>
</thead>

<tbody id="tableBook">
<c:forEach items="${requestScope.list}" var="list">
<tr>
<td><a href="book.do?command=getBookInfoIsbn&isbn=${list.C_ISBN}">${list.TITLE}</a></td>
<td>${list.WRITER}</td>
<td>${list.AVERAGE}</td>
<td>${list.C_ISBN}</td>
<td>${list.SUBJECT}</td>
</tr>
</c:forEach>
</tbody>

</table>
</body>
</html>