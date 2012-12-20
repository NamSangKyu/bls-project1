<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<style>
.listPage table {
        width: 800px;
        border-collapse: collapse;
        text-align: center;
        font-family: 'Trebuchet MS', malgun gothic,Arial, Helvetica, sans-serif;
        border-bottom: 2px solid #98bf21;
}

.listPage thead{
        font-size: 10pt;
        border-top: 1px solid #98bf21;
        border-bottom: 1px solid #98bf21;
        height: 30px;
}

.listTbody td {
        font-size: 10pt;
        border-top: 1px solid #98bf21;
        border-bottom: 1px solid #98bf21;
        height: 30px;
}

.listPage th{
        background-color:#98bf21;
        color:#ffffff;
        height: 25px;
}
.listPage tfoot td{
    	height: 40px;
}

.listHref:link{
		line-height: 5px;
		text-decoration: none;
		color: #708491;
}

.listHref:link.active, visited.active{
		padding-bottom: 6px;
		color: #cd1039; 
}

.listHref:hover{
		text-decoration: underline;
		padding-bottom: 6px;
		color: #cd1039; 
}

#title {
		text-align: left;
}
#page {
		font-family: 'Trebuchet MS', malgun gothic,Arial, Helvetica, sans-serif;
}
.arrow{
		font-size: 5px;
} 
.way{
		font-size: 15px;
}
#criteria1 {
		width: 80px;
}
#criteria2 {
		width: 400px;
}
#criteria3 {
		width: 100px;
}
#criteria4 {
		width: 120px;
}
#criteria5 {
		width: 50px;
}
#criteria6 {
		width: 50px;
}
</style>
<div class="listPage">
	<c:set value="${requestScope.lvo }" var="lvo" />
	<table>
		<thead>
			<tr>
				<th id="criteria1"></th><th id="criteria2">제목</th><th id="criteria3">작성자</th>
				<th id="criteria4">작성일</th><th id="criteria5">조회</th><th id="criteria6">첨부</th>
			</tr>
		</thead>
		<tbody class="listTbody">
			<c:forEach items="${lvo.list }" var="lvo">
				<tr align="center">
					<td><c:if test="${lvo.relevel == 0 }">${lvo.boardNo }</c:if></td>
					<td id="title">
						<c:if test="${lvo.relevel != 0 }">
							<c:forEach begin="1" end="${lvo.relevel }" step="1">
								&nbsp;&nbsp;
							</c:forEach>
							<img src="${initParam.root}/img/ui/board/reply.jpg">
						</c:if>
						<a href="board.do?command=showContent&boardNo=${lvo.boardNo }&page=${requestScope.lvo.bean.nowPage}" class="listHref">${lvo.title}</a>
					</td>
					<td>${lvo.memberId }</td><td>${lvo.boardDate }</td><td>${lvo.count }</td>
					<td>
						<c:if test="${lvo.newFileName != null }">
							<a href="board.do?command=fileDownload&newFileName=${lvo.newFileName}&orgFileName=${lvo.orgFileName}" class="listHref">
								<img src="${initParam.root}/img/ui/board/file.jpg">
							</a>
						</c:if>
					</td>
				</tr>
			</c:forEach>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="6" align="right">
					<c:if test="${sessionScope.membervo != null }">
						<a href="board.do?command=insertView" class="listHref"><img src="${initParam.root}/img/ui/board/write_btn.jpg"></a>
					</c:if>
				</td>
			</tr>
		</tfoot>
	</table>
	
	<br>
	<div id="page">
	<c:if test="${lvo.bean.previousPageGroup }">
		<a href="board.do?command=list&page=${lvo.bean.startPageOfPageGroup-1 }" class="listHref">
			<span class="arrow">◀</span><span class="way">이전</span>
		</a>
	</c:if>
	<c:forEach var="i" begin="${lvo.bean.startPageOfPageGroup}" end="${lvo.bean.endPageOfPageGroup}">
		<c:choose>
			<c:when test="${lvo.bean.nowPage != i}">
				<a href="board.do?command=list&page=${i}" class="listHref">${i}</a>
			</c:when>
			<c:otherwise>
				<u>${i}</u>
			</c:otherwise>
		</c:choose>
	</c:forEach>
	<c:if test="${lvo.bean.nextPageGroup}">
		<a href="board.do?command=list&page=${lvo.bean.endPageOfPageGroup+1 }" class="listHref">
			<span class="way">다음</span> <span class="arrow">▶</span>
		</a>
	</c:if>
	</div>
</div>
