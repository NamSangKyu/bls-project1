<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>    
<link rel="stylesheet" href="css/book-table.css"> 

<link rel="stylesheet" href="/resources/demos/style.css" />

<br><div class="font_style">${sessionScope.membervo.memberId}회원님 추천 도서</div><br><br>

<div id="listPage">
<table border="0" class="board_table">
<thead>
<tr>
<th>책제목</th>
<th>글쓴이</th>
<th>평점</th>
<th>ISBN</th>
<th>분류</th>
</tr>
</thead>

<tbody>
<!-- 역사 -->
<c:choose>
<c:when test="${empty requestScope.subject.subject1}">
<tr align="center">
<td colspan="5">${sessionScope.membervo.subject1}에 해당하는 추천도서가 없습니다</td>

</tr>
</c:when>
<c:otherwise>
<c:forEach items="${requestScope.subject.subject1}" var="list">
<tr align="center">
<td><a href="book.do?command=getBookInfoIsbn&isbn=${list.C_ISBN}">${list.TITLE}</a></td>
<td>${list.WRITER}</td>
<td>${list.AVERAGE}</td>
<td>${list.C_ISBN}</td>
<td>${list.SUBJECT}</td>
</tr>
</c:forEach>
</c:otherwise>
</c:choose>
</tbody>

<!-- subject2개째  -->
<tbody>
<!-- 역사 -->
<c:choose>
<c:when test="${empty requestScope.subject.subject2}">
<tr>
<td colspan="5">${sessionScope.membervo.subject2}에 해당하는 추천도서가 없습니다</td>
</tr>
</c:when>
<c:otherwise>
<c:forEach items="${requestScope.subject.subject2}" var="list">
<tr align="center">
<td><a href="book.do?command=getBookInfoIsbn&isbn=${list.C_ISBN}">${list.TITLE}</a></td>
<td>${list.WRITER}</td>
<td>${list.AVERAGE}</td>
<td>${list.C_ISBN}</td>
<td>${list.SUBJECT}</td>
</tr>
</c:forEach>
</c:otherwise>
</c:choose>
</tbody>

<!-- 3개째 -->

<tbody>
<!-- 역사 -->
<c:choose>
<c:when test="${empty requestScope.subject.subject3}">
<tr>
<td colspan="5">${sessionScope.membervo.subject3}에 해당하는 추천도서가 없습니다</td>
</tr>
</c:when>
<c:otherwise>
<c:forEach items="${requestScope.subject.subject3}" var="list">
<tr align="center">
<td><a href="book.do?command=getBookInfoIsbn&isbn=${list.C_ISBN}">${list.TITLE}</a></td>
<td>${list.WRITER}</td>
<td>${list.AVERAGE}</td>
<td>${list.C_ISBN}</td>
<td>${list.SUBJECT}</td>
</tr>
</c:forEach>
</c:otherwise>
</c:choose>
</tbody>
</table>
</div>
