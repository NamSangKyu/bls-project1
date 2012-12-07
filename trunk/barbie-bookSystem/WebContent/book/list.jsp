<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 도서목록을 게시물로 보여주기 -->
<table border="1">
<thead>
<tr>
<!-- 글번호/도서명/출판사/저자명/ISBN -->
<td>글번호</td>
<td>도서명</td>
<td>출판사</td>
<td>저자명</td>
<td>분류</td>
<td>위치</td>
</tr>
</thead>
<tbody>
<c:forEach var="list" items="${requestScope.list }">
<tr>
<td>${list.NO }</td>
<td><a href="book.do?command=getBookInfoTitle&title=${list.TITLE }">${list.TITLE }</a></td>
<td>${list.PUBLISHER }</td>
<td>${list.WRITER }</td>
<td>${list.SUBJECT }</td>
<td>${list.LOC }</td>
</tr>
</c:forEach>
</tbody>
</table>
<a href="book.do?command=bookInsert">책등록</a>
</body>
</html>