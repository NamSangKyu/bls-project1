<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#list").click(function() {

		});
		$("#reply").click(function() {

		});
		$("#updateImg").click(function() {
			
		});
		$("#deleteImg").click(function() {
			if (confirm("삭제 하시겠습니까?"))
				location.href = "board.do?command=delete&boardNo=${requestScope.bvo.boardNo }&newFileName=${requestScope.bvo.newFileName }&page=${requestScope.page }";
		});
	});
</script>
<center>
	<c:set value="${requestScope.bvo }" var="bvo"/>
	<table width="600">
		<tr>
			<td>${bvo.title } | 자유게시판</td>
			<td align="right">${bvo.boardDate }</td>
		</tr>
		<tr>
			<td>${bvo.memberId }</td>
			<td align="right"><c:if
					test="${bvo.orgFileName!=null }">
					<img src="${initParam.root}/img/ui/board/file.jpg">
					<a href="board.do?command=fileDownload&newFileName=${bvo.newFileName}&orgFileName=${bvo.orgFileName}&page=${requestScope.page }">
						${bvo.orgFileName}</a>
				</c:if></td>
		</tr>
		<tr>
			<td colspan="2"><textarea cols="60" rows="10" id="cont"
					name="cont" readonly="readonly" disabled="disabled">${bvo.cont }</textarea></td>
		</tr>
		<tr>
			<td colspan="2">덧글 ? 개 | 조회수 ${bvo.count }</td>
		</tr>
		<tr>
			<td colspan="2">덧글 페이지</td>
		</tr>
	</table>
	<a href="board.do?command=insertView"><img src="${initParam.root}/img/ui/board/write_btn.jpg"></a>
	<a href="board.do?command=replyView&boardNo=${bvo.boardNo }&page=${requestScope.page }"><img src="${initParam.root}/img/ui/board/answer_btn.jpg"></a>
	<a href="board.do?command=updateView&boardNo=${bvo.boardNo }&page=${requestScope.page }"><img src="${initParam.root}/img/ui/board/modify_btn.jpg" id="updateImg"></a>
	<input type="image" src="${initParam.root}/img/ui/board/delete_btn.jpg" id="deleteImg">
	<a href="board.do?command=list&page=${requestScope.page }"><img src="${initParam.root}/img/ui/board/list_btn.jpg"></a>
	
	<br><br>
	
	
	
	
	
	
</center>