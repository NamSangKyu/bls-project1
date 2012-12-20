<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="http://code.jquery.com/jquery-latest.js"></script>
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
<style>
table {
        width: 600px;
        border-collapse: collapse;
        font-family: 'Trebuchet MS', malgun gothic,Arial, Helvetica, sans-serif;
        border-bottom: 2px solid #98bf21;
    }
    thead, tbody td{
        font-size: 10pt;
        border-top: 1px solid #98bf21;
        border-bottom: 1px solid #98bf21;
        height: 30px;
    }
    th{
        background-color:#98bf21;
        color:#ffffff;
        height: 25px;
    }
    tfoot td{
    	height: 40px;
    }
#title {
	text-align: left;
}
#page {
	font-family: 'Trebuchet MS', malgun gothic,Arial, Helvetica, sans-serif;
}
</style>
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
				<td><input type="text" id="title" name="title" value="${bvo.title }" size="50"></td>
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