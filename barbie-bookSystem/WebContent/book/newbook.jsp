<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="${initParam.root}/css/book-table.css"> 
<br><div class="font_style">신간 도서</div><br><br>
<div class="listPage">  
<table border="0">
<thead>
<tr align="center">
<th>책제목</th>
<th>책저자</th>
<th>출판사</th>
<th>책분류</th>
<th>출간일</th>
<th>ISBN</th>
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
</div>
<br>
<!-- 이전글 -->
<c:if test="${requestScope.lvo.bean.previousPageGroup}">
<a href="book.do?command=getNewBookList&pageNo=${requestScope.lvo.bean.startPageOfPageGroup-1}"> << </a>
</c:if>

<c:forEach var="i" begin="${requestScope.lvo.bean.startPageOfPageGroup}" end="${requestScope.lvo.bean.endPageOfPageGroup}">
  <c:choose>
	 <c:when test="${requestScope.lvo.bean.nowPage!=i}">
	 <a href="book.do?command=getNewBookList&pageNo=${i}">${i}</a>
	 </c:when>
	 <c:otherwise>
	${i}
	</c:otherwise>
	</c:choose>
</c:forEach>
 
<!-- 이후글 -->
<c:if test="${requestScope.lvo.bean.nextPageGroup}">
<a href="book.do?command=getNewBookList&pageNo=${requestScope.lvo.bean.endPageOfPageGroup+1}"> >> </a>
</c:if> 
