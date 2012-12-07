<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>관리자 책 등록 페이지</title>
</head>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
			
		$("#commit").click(function() {
			//alert("버튼클릭");
			var str = $("#insert").serialize();
			alert(str);
			$("form").submit();
			 /* $.ajax({
				type:"POST",
				url:"book.do",
				data:str,
				dataType:"json",
				success:function(data){
				}//success
		});//ajax */ 
		});//button click
	})
</script>
<body>
<form action="book.do" id="insert" name="insert" enctype="multipart/form-data" method="post">
<input type="hidden" name="command" value="insert"> 
<table>
<tr>
<td>책제목:</td>
<td><input type="text" name="title" size="70"></td>
</tr>
<tr>
<td>저자명:</td>
<td><input type="text" name="writer" size="70"></td>
</tr>
<tr>
<td>출판사:</td>
<td><input type="text" name="publisherNo" size="70"></td>
<!-- Ajax으로 출판사 받아와서 넣기  -->
</tr>
<tr>
<td>분류번호:</td>
<td><input type="text" name="subjectNo" size="70"></td> 
<!-- Ajax으로 분류번호 받아와서 넣기  -->
</tr>
<tr>
<td>ISBN:</td>
<td><input type="text" name="isbn" size="70"></td>
</tr>
<tr>
<td>서고위치:</td>
<td><input type="text" name="loc" size="70"></td>
</tr>
<tr>
<td>책사진:</td>
<td><input type="file" name="file" ></td>
</tr>

<tr>
<td>내용:</td>
<td><textarea rows="10" cols="70" name="cont"></textarea>
</td>
</tr>
</table>
</form>
<input type="button" id="commit" value="입력하기"> <input type="button" id="cancel" value="취소하기"> 
</body>
</html>