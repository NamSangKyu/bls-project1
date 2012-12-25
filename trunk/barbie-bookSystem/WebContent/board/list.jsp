<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
	$(document).ready(function() {
		$("#adminCheck").click(function() {
			if($(this).attr('checked') == 'checked') {
				$("input[name=boardList]").attr('checked', 'checked');
				$("#adminText").html("전체해제");
			} else {
				$("input[name=boardList]").attr('checked', !'checked');
				$("#adminText").html("전체선택");
			}
		});
		
		$("#deleteImg").click(function() {
			var bListlen = $("input[name=boardList]:checkbox:checked").length;
			if (bListlen == 0){
				alert("삭제할 게시물을 선택해 주세요");
				return;
			}
			$("#adminCheckForm").submit();
			/* var bLChecked = $("input[name=boardList]:checkbox:checked");
			$.each(bLChecked, function(index, data) {
				alert($(this).attr('value') + $(this).attr('id'));
				location.href = "board.do?command=delete&boardNo="+$(this).attr('value')+"&newFileName="+$(this).attr('id')+"&page=${requestScope.page }";
			}); */
		});
	});
</script>
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
    	font-size: 10pt;
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
		padding-left: 15px;
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
#criteria0 {
		width: 30px;
}
#criteria1 {
		width: 30px;
}
#criteria2 {
		width: 420px;
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
<div><a href="board.do?command=list&page=1"><img src="${initParam.root}/img/ui/layout/freeboard.jpg"></a><br><br></div>
<div class="listPage">
	<c:set value="${requestScope.lvo }" var="lvo" />
	<table>
		<thead>
			<tr>
				<th id="criteria0">
				</th>
				<th id=criteria1></th><th id="criteria2">제목</th><th id="criteria3">작성자</th>
				<th id="criteria4">작성일</th><th id="criteria5">조회</th><th id="criteria6">첨부</th>
			</tr>
		</thead>
		<tbody class="listTbody">
			<form action="board.do" method="post" id="adminCheckForm">
			<input type="hidden" name="command" value="adminDelete">
			<input type="hidden" name="page" value="${requestScope.lvo.bean.nowPage}">
			<c:forEach items="${lvo.list }" var="lvo">
				<tr align="center">
					<td>
						<c:if test="${sessionScope.membervo.memberId == 'java' }">
							<input type="checkbox" name="boardList" id="${lvo.newFileName }" value="${lvo.boardNo }">
							<input type="hidden" name="${lvo.boardNo }" value="${lvo.newFileName}">
						</c:if>
					</td>
					<td><c:if test="${lvo.relevel == 0 }">${lvo.boardNo }</c:if></td>
					<td id="title">
						<c:if test="${lvo.relevel != 0 }">
							<c:forEach begin="1" end="${lvo.relevel }" step="1">
								&nbsp;&nbsp;
							</c:forEach>
							<img src="${initParam.root}/img/ui/board/reply.jpg">
						</c:if>
						<a href="board.do?command=showContent&boardNo=${lvo.boardNo }&page=${requestScope.lvo.bean.nowPage}" class="listHref">${lvo.title}</a>
						<c:if test="${lvo.commentCount != 0 }">
							<b>[${lvo.commentCount}]</b>
						</c:if>
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
			</form>
		</tbody>
		<tfoot>
			<tr>
				<td>
					<c:if test="${sessionScope.membervo.memberId == 'java' }">
						<input type="checkbox" name="adminCheck" id="adminCheck">
					</c:if>
				</td>
				<td colspan="2" align="left">
					<c:if test="${sessionScope.membervo.memberId == 'java' }">
						<span id="adminText">전체선택</span>
					</c:if>
				</td>
				<td colspan="4" align="right">
					<c:if test="${sessionScope.membervo.memberId == 'java' }">
						<input type="image" src="${initParam.root}/img/ui/board/delete_btn.jpg" id="deleteImg">
					</c:if>
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
