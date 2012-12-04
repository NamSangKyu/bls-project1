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
		$("#writeImg").click(function() {
			if($("#title").val()==""){
				alert("제목을 입력해주십시오");
				return;
			}else if($("#name").val()==""){
				alert("이름을 입력해주십시오");
				return;
			}else if($("#pass").val()==""){
				alert("비밀번호를 입력해주십시오");
				return;
			}else if($("#content").val()==""){
				alert("내용을 입력해주십시오");
				return;
			}
			writeForm.submit();
		});
	});
</script>
</head>
<body>
	<p>
		<!-- 진하게  -->
		<b>글쓰기</b>
	</p>
	<form action="" method="post" id="writeForm">
		<input type="hidden" name="command" value="write">
		<table width="300px">
			<tr>
				<td>제목</td>
				<td><input type="text" id="title" name="title"></td>
			</tr>
			<tr>
				<td>이름</td>
				<td><input type="text" id="name" name="memberId"></td>
			</tr>
			<tr>
				<td>패스워드</td>
				<td><input type="password" id="pass" name="pass"></td>
			</tr>
			<tr>
				<td colspan=2><textarea cols="32" rows="10" name="cont"
						id="content"></textarea></td>
			</tr>
			<tr>
			<!-- 그림파일은 일단 예제로 넣었습니다 -->
				<td colspan="2"><img src="../img/ui/confirm.gif" id="writeImg"></td>
			</tr>

		</table>

	</form>
</body>
</html>