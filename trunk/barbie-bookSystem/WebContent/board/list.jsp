<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<center>
		<table border="1" width="900">
			<tr align="center">
				<td>순번</td><td>제목</td><td>작성자</td>
				<td>등록일</td><td>조회수</td><td>첨부</td>
			</tr>
			<c:forEach items="${requestScope.lvo }" var="lvo">
				<tr align="center">
					<td>${lvo.boardNo }</td>
					<td><a href="board.do?command=showContent&boardNo=${lvo.boardNo }">${lvo.title }</a></td>
					<td>${lvo.memberId }</td><td>${lvo.boardDate }</td><td>${lvo.count }</td><td>-</td>
				</tr>
			</c:forEach>
		</table>
		<a href="board.do?command=insertView"><img src="${initParam.root}/img/ui/board/write_btn.jpg"></a>
	</center>
</body>
</html>