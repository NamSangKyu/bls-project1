<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
    <link rel="stylesheet" href="${initParam.root}/css/book-table.css"> 
    <script src="http://code.jquery.com/jquery-latest.js"></script>
    <br><br>
<center>
<!-- 도서목록을 게시물로 보여주기 -->
<div class="listPage">
<table border="1" class="board_table" >
<thead>
<tr>
<!-- 글번호/도서명/출판사/저자명/ISBN -->
<th>글번호</th>
<th>도서명</th>
<th>출판사</th>
<th>저자명</th>
<th>분류</th>
<th>위치</th>
</tr>
</thead>
<tbody>

<c:forEach var="list" items="${requestScope.list.list }">
<tr>
<td>${list.NO }</td>
<td><a href="book.do?command=getBookInfoIsbn&isbn=${list.ISBN }">${list.TITLE }</a></td>
<td>${list.PUBLISHER }</td>
<td>${list.WRITER }</td>
<td>${list.SUBJECT }</td>
<td>${list.LOC }</td>
</tr>
</c:forEach>
</tbody>
</table>
</div>
<br><br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<!-- 페이징 처리 -->	
	<%-- 이전 페이지 그룹이 있으면 이미지 보여준다.
		   이미지 링크는 현 페이지 그룹 시작페이지 번호 -1 =>
		   이전 페이지 그룹의 마지막 페이지 번호로 한다. 
	 --%>
	<c:choose>
	<c:when test="${requestScope.flag==false}">
	 <c:if test="${requestScope.list.bean.previousPageGroup}">
	 <a href=
	 "board.do?command=list&nowPage=${requestScope.list.bean.
	 startPageOfPageGroup-1}"><<</a>
	 </c:if>
	 &nbsp;&nbsp;
	<%-- PagingBean 을 이용해서 현재 페이지에 해당되는 페이지그룹의
		   시작페이지~~마지막페이지까지 화면에 보여준다. 
		   이 때 현재 페이지를 제외한 나머지 페이지는 링크를 걸어
		   해당 페이지에 대한 게시물 리스트 조회가 가능하도록 한다. 
	 --%>	

	<c:forEach var="i" 
	begin="${requestScope.list.bean.startPageOfPageGroup}"
	 end="${requestScope.list.bean.endPageOfPageGroup}">
	 <c:choose>
	 <c:when test="${requestScope.list.bean.nowPage!=i}">
	 <a href="book.do?command=getBookList&nowPage=${i}">${i}</a>
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
	 <c:if test="${requestScope.list.bean.nextPageGroup}">
	 <a href=
	 "book.do?command=getBookList&nowPage=${requestScope.list.bean.
	 endPageOfPageGroup+1}">
	 >>
	 </a>
	 </c:if>
	 </c:when>
	 <c:otherwise>
		 <c:if test="${requestScope.list.bean.previousPageGroup}">
	 <a href=
	 "board.do?command=findbook&page=${requestScope.list.bean.
	 startPageOfPageGroup-1}&searchValue=${requestScope.serachValue}&serach=${requestScope.serach}"><<</a>
	 </c:if>
	 &nbsp;&nbsp;
	<%-- PagingBean 을 이용해서 현재 페이지에 해당되는 페이지그룹의
		   시작페이지~~마지막페이지까지 화면에 보여준다. 
		   이 때 현재 페이지를 제외한 나머지 페이지는 링크를 걸어
		   해당 페이지에 대한 게시물 리스트 조회가 가능하도록 한다. 
	 --%>	

	<c:forEach var="i" 
	begin="${requestScope.list.bean.startPageOfPageGroup}"
	 end="${requestScope.list.bean.endPageOfPageGroup}">
	 <c:choose>
	 <c:when test="${requestScope.list.bean.nowPage!=i}">
	 <a href="book.do?command=findBook&page=${i}&searchValue=${requestScope.serachValue}&serach=${requestScope.serach}">${i}</a>
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
	 <c:if test="${requestScope.list.bean.nextPageGroup}">
	 <a href=
	 "book.do?command=findBook&page=${requestScope.list.bean.endPageOfPageGroup+1}&searchValue=${requestScope.serachValue}&serach=${requestScope.serach}">
	 >>
	 </a>
	 </c:if>
		 	${requsetScope.flag }${requsetScope.search }${requsetScope.searchValue }
	 </c:otherwise>
	 </c:choose>
	 </center>
	 <form action="book.do" method="get">
	 <input type="hidden" name="command" value="findBook"> 
			<select name="serach">
				<option value="subject">분야</option>
				<option value="publisher">출판사</option>
				<option value="title">책제목</option>
				<option value="writer">저자</option>
			</select><input type="text" name="searchValue">
			<input type="submit" value="검색">	 
	 </form>	  