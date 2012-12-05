<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<center>
		<table border="1">
			<tr align="center">
				<td colspan="6">게시물 보기</td>
			<tr align="center">
				<td>NO</td>
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
				<td colspan=6><textarea cols="100" rows="10" id="cont" name="cont" readonly="readonly">${requestScope.bvo.cont }</textarea></td>
			</tr>
		</table>
		<input type="button" value="목록">
		<input type="button" value="답글">
		<input type="button" value="수정">
		<input type="button" value="삭제">
	</center>
</body>
</html>