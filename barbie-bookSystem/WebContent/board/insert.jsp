<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#insertImg").click(function() {
			if ($("#title").val() == "") {
				alert("제목을 입력해주십시오");
				return;
			} else if ($("#content").val() == "") {
				alert("내용을 입력해주십시오");
				return;
			}
			$("#insertForm").submit();
		});
	});
</script>
</head>
<body>
	<center>
		<form action="board.do" method="post" id="insertForm">
			<input type="hidden" name="command" value="insert">
			<table border="1">
				<tr align="center">
					<td colspan="2">글쓰기</td>
				<tr align="center">
					<td>제목</td>
					<td><input type="text" id="title" name="title"></td>
				</tr>
				<tr align="center">
					<td>작성자</td>
					<td><input type="text" id="memberId" name="memberId"></td>
				</tr>
				<tr align="center">
					<td colspan=2><textarea cols="32" rows="10" id="cont" name="cont"></textarea></td>
				</tr>
				<tr align="center">
					<td colspan="2"><img src="../img/ui/confirm.gif" id="insertImg"></td>
				</tr>
			</table>
		</form>
	</center>
</body>
</html>