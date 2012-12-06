<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#confirmImg").click(function() {
			if(confirm("수정 하시겠습니까?")) {
				if ($("#title").val() == "") {
					alert("제목을 입력해주십시오");
					return;
				} else if ($("#cont").val() == "") {
					alert("내용을 입력해주십시오");
					return;
				}
				$("#updateForm").submit();
			}
		});
	});
</script>
</head>
<body>
	<center>
		<form action="${initParam.root}/board.do" method="post" id="updateForm">
			<input type="hidden" name="command" value="updateContent">
			<input type="hidden" name="boardNo" value="${requestScope.bvo.boardNo }">
			<table border="1" width="900">
				<tr align="center">
					<td colspan="6">게시물 수정</td>
				<tr align="center">
					<td>NO</td>
					<td>${requestScope.bvo.boardNo }</td>
					<td colspan="4"><input type="text" id="title" name="title" value="${requestScope.bvo.title }"></td>
				</tr>
				<tr align="center">
					<td>작성자</td>
					<td>${requestScope.bvo.memberId }</td>
					<td>등록일</td>
					<td>${requestScope.bvo.boardDate }</td>
					<td>조회수</td>
					<td>${requestScope.bvo.count }</td>
				</tr>
				<tr align="center">
					<td colspan=6><textarea cols="124" rows="10" id="cont" name="cont">${requestScope.bvo.cont }</textarea></td>
				</tr>
			</table>
			<img src="${initParam.root}/img/ui/board/confirm.gif" id="confirmImg">
		</form>
	</center>
</body>
</html>