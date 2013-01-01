<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  <br><br>
<center>

<a href="book.do?command=publisher">출판사 등록</a> &nbsp;
<a href="book.do?command=subject">분류 등록</a>&nbsp;
<a href="book.do?command=bookInsert">책등록</a>&nbsp;
<a href="book.do?command=getBookAllList">도서 삭제/수정</a><br><br>
<!-- 도서목록을 게시물로 보여주기 -->
<table border="1">
<thead>
<tr>
<!-- 도서번호/도서명/출판사/저자명/ISBN -->
<td>도서번호</td>
<td>도서명</td>
<td>출판사</td>
<td>저자명</td>
<td>분류</td>
<td>위치</td>
</tr>
</thead>
<tbody>

<c:forEach var="list" items="${requestScope.lvo.list }">
<tr>
<td>${list.BOOKNO }</td>
<td><a href="book.do?command=getBookInfoNo&no=${list.BOOKNO }">${list.TITLE }</a></td>
<td>${list.PUBLISHER }</td>
<td>${list.WRITER }</td>
<td>${list.SUBJECT }</td>
<td>${list.LOC }</td>
</tr>
</c:forEach>
</tbody>
</table>
<a href="book.do?command=bookInsert">책등록</a>
<br><br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<!-- 페이징 처리 -->	
	<%-- 이전 페이지 그룹이 있으면 이미지 보여준다.
		   이미지 링크는 현 페이지 그룹 시작페이지 번호 -1 =>
		   이전 페이지 그룹의 마지막 페이지 번호로 한다. 
	 --%>
	 <c:if test="${requestScope.lvo.bean.previousPageGroup}">
	 <a href=
	 "board.do?command=list&nowPage=${requestScope.lvo.bean.
	 startPageOfPageGroup-1}"><<</a>
	 </c:if>
	 &nbsp;&nbsp;
	<%-- PagingBean 을 이용해서 현재 페이지에 해당되는 페이지그룹의
		   시작페이지~~마지막페이지까지 화면에 보여준다. 
		   이 때 현재 페이지를 제외한 나머지 페이지는 링크를 걸어
		   해당 페이지에 대한 게시물 리스트 조회가 가능하도록 한다. 
	 --%>	

	<c:forEach var="i" 
	begin="${requestScope.lvo.bean.startPageOfPageGroup}"
	 end="${requestScope.lvo.bean.endPageOfPageGroup}">
	 <c:choose>
	 <c:when test="${requestScope.lvo.bean.nowPage!=i}">
	 <a href="book.do?command=getBookAllList&nowPage=${i}">${i}</a>
	 </c:when>
	 <c:otherwise>
	${i}
	</c:otherwise>
	</c:choose>
	</c:forEach>	 
	
	&nbsp;&nbsp;
	<%-- 다음 페이지 그룹이 있으면 화살표 이미지를 보여준다.
			이미지 링크는 현재 페이지 그룹의 마지막 번호 + 1 => 
			다음 그룹의 시작 페이지로 링크한다. 
			right_arrow_btn.gif
	 --%>
	 <c:if test="${requestScope.lvo.bean.nextPageGroup}">
	 <a href=
	 "book.do?command=getBookList&nowPage=${requestScope.lvo.bean.
	 endPageOfPageGroup+1}">
	 >>
	 </a>
	 </c:if>
	 </center>
	 