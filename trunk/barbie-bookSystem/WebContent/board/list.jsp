<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<link rel="stylesheet" href="${initParam.root }/css/board-table.css">  
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
	$(document).ready(function() {
		$("#selectPerPage").val("${requestScope.lvo.bean.numberOfContentPerPage}").attr("selected", "selected");

		$("#selectPerPage").change(function() {
			location.href="board.do?command=listPageChange&page=1&perPage="+$(this).val();
		});

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
		});
	});
</script>
<div><a href="board.do?command=list&page=1"><img src="${initParam.root}/img/ui/layout/freeboard.jpg"></a><br><br></div>
<div class="listPage">
	<c:set value="${requestScope.lvo }" var="lvo" />
	<div id="perPage">
		<select name="perPage" id="selectPerPage">
			<option value="4">4개씩</option>
			<option value="6">6개씩</option>
			<option value="8">8개씩</option>
			<option value="10" >10개씩</option>
		</select>
	</div>
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
					<td id="listTitle">
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
	<br>
	<%-- <form action="board.do" id="serchForm">
	<input type="hidden" name="command" value="serchBoard">
	<table id="serch">
		<tr>
			<td>
				<select name="serch">
					<option value="title">제목만</option>
					<option value="writer">글작성자</option>
					<option value="commentCont">덧글내용</option>
					<option value="commentWriter">덧글작성자</option>
				</select>
			</td>
			<td><input type="text" name="text" height="50"></td>
			<td><input type="image" src="${initParam.root}/img/ui/board/serch.jpg"></td>
		</tr>
	</table>
	</form> --%>
	</div>
</div>
