<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<link rel="stylesheet" href="${initParam.root }/css/board-table.css">
<script type="text/javascript">
	$(document).ready(function() {
		$("#insertImg").click(function() {
			if ($("#title").val() == "") {
				alert("제목을 입력해주십시오");
				return;
			} else if ($("#cont").val() == "") {
				alert("내용을 입력해주십시오");
				return;
			}
			$(	"#replyForm").submit();
		});	
	});
</script>
<div><a href="board.do?command=list&page=1"><img src="${initParam.root}/img/ui/layout/freeboard.jpg"></a><br><br></div>
<center>
<div id="page">
	<c:set value="${requestScope.bvo }" var="bvo"/>
	<form action="${initParam.root}/board.do" method="post" id="replyForm" enctype="multipart/form-data">
		<input type="hidden" name="command" value="replyContent">
		<input type="hidden" name="ref" value="${bvo.ref }">
		<input type="hidden" name="restep" value="${bvo.restep }">
		<input type="hidden" name="relevel" value="${bvo.relevel }">
		<input type="hidden" name="page" value="${requestScope.page }">
		<input type="hidden" name="memberId" value="${sessionScope.membervo.memberId }">
		<table>
			<tr>
				<td>&nbsp;제목</td>
				<td><input type="text" id="title" name="title" value="Re : ${bvo.title }" size="50"></td>
			</tr>
			<tr>
				<td>&nbsp;첨부파일</td>
				<td><input type="file" name="uploadFile"></td>
			</tr>
			<tr>
				<td colspan=2><textarea cols="82" rows="12" id="cont"
						name="cont"></textarea></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><img
					src="${initParam.root}/img/ui/board/confirm.gif" id="insertImg"></td>
			</tr>
		</table>
	</form>
	</div>
</center>