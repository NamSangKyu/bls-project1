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
<table border="1">
<thead>
<tr align="center">
<td>책제목</td>
<td>책저자</td>
<td>출판사</td>
<td>책분류</td>
<td>출간일</td>
<td>ISBN</td>
</tr>
</thead>
<c:forEach items="${requestScope.lvo.list}" var="hi">
<tbody>
<tr align="center">
<td><a href="book.do?command=getBookInfoIsbn&isbn=${hi.ISBN}">${hi.TITLE}</a></td>
<td>${hi.WRITER }</td>
<td>${hi.PUBLISHER}</td>
<td>${hi.SUBJECT}</td>
<td>${hi.OUTPUTDATE}</td>
<td>${hi.ISBN}</td>
</tr>
</tbody>
</c:forEach>
</table>
<!-- 이전글 -->
<c:if test="${requestScope.lvo.bean.previousPageGroup}">
<a href="book.do?command=newBook&pageNo=${requestScope.lvo.bean.startPageOfPageGroup-1}">
이전 << </a>
</c:if>

<c:forEach var="i" begin="${requestScope.lvo.bean.startPageOfPageGroup}" end="${requestScope.lvo.bean.endPageOfPageGroup}">
  <c:choose>
	 <c:when test="${requestScope.lvo.bean.nowPage!=i}">
	 <a href="book.do?command=newBook&pageNo=${i}">${i}</a>
	 </c:when>
	 <c:otherwise>
	${i}
	</c:otherwise>
	</c:choose>
</c:forEach>
 
<!-- 이후글 -->
<c:if test="${requestScope.lvo.bean.nextPageGroup}">
<a href="book.do?command=newBook&pageNo=${requestScope.lvo.bean.
	 endPageOfPageGroup+1}">이후 >></a>
</c:if> 
</body>
</html>