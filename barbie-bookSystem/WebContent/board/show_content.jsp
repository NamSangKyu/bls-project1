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
		$("#list").click(function() {
			
		});
		$("#reply").click(function() {

		});
		$("#updateImg").click(function() {
			if(confirm("수정 하시겠습니까?"))
				location.href="board.do?command=updateView&boardNo=${requestScope.bvo.boardNo }";
		});
		$("#deleteImg").click(function() {
			if(confirm("삭제 하시겠습니까?"))
				location.href="board.do?command=delete&boardNo=${requestScope.bvo.boardNo }";
		});
	});
</script>
</head>
<body>
	<center>
		<table border="1" width="900">
			<tr align="center">
				<td colspan="6">게시물 보기</td>
			<tr align="center">
				<td>순번</td>
				<td>${requestScope.bvo.boardNo }</td>
				<td colspan="4">${requestScope.bvo.title }</td>
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
				<td colspan=6><textarea cols="124" rows="10" id="cont" name="cont" readonly="readonly">${requestScope.bvo.cont }</textarea></td>
			</tr>
		</table>
		<a href="board.do?command=list"><img src="${initParam.root}/img/ui/board/list_btn.jpg"></a>
		<a href="board.do?command=reply"><img src="${initParam.root}/img/ui/board/answer_btn.jpg"></a>
		<img src="${initParam.root}/img/ui/board/modify_btn.jpg" id="updateImg">
		<img src="${initParam.root}/img/ui/board/delete_btn.jpg" id="deleteImg">
	</center>
</body>
</html>