<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#confirmImg").click(function() {
			if (confirm("수정 하시겠습니까?")) {
					if ($("#title").val() == "") {
						alert("제목을 입력해주십시오");
						return;
					} else if ($("#cont").val() == "") {
						alert("내용을 입력해주십시오");
						return;
					}
					$("#updateForm").submit();
			}
		});
		
		$("#cancelFile").click(function() {
			$.ajax({
				type : "POST",
				url : "board.do",
				data : "command=deleteFile&newFileName=${requestScope.bvo.newFileName}",
				success : function() { // data 변수로 json 입력된다.			
					$("#fileView").html("<input type='file' name='uploadFile'>");
				} // success
			}); //ajax 
			return false;
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
#replyPage{
	background: #D2D2FF;
}
#replySize1 {
		width: 120px;
}
#replySize2 {
		width: 50px;
}
#replySize3 {
		width: 430px;
}
</style>


<div><a href="board.do?command=list&page=1"><img src="${initParam.root}/img/ui/layout/freeboard.jpg"></a><br><br></div>
<center>
<div id="page">
	<form action="${initParam.root}/board.do" method="post" id="updateForm"
		enctype="multipart/form-data">
		<input type="hidden" name="command" value="updateContent"> <input
			type="hidden" name="boardNo" value="${requestScope.bvo.boardNo }">
			<input type="hidden" name="page" value="${requestScope.page }">
			<input type="hidden" name="default1" value="${requestScope.bvo.orgFileName }">
			<input type="hidden" name="default2" value="${requestScope.bvo.newFileName }">
		<table>
			<tr>
				<td>&nbsp;제목</td>
				<td><input type="text" id="title" name="title"
					value="${requestScope.bvo.title }" size="50"></td>
			</tr>
			<tr>
				<td>&nbsp;첨부파일</td>
				<td><span id="fileView"><c:choose>
						<c:when test="${requestScope.bvo.orgFileName!=null }">
							 <font size="2"> <a
									href="board.do?command=fileDownload&newFileName=${requestScope.bvo.newFileName}&orgFileName=${requestScope.bvo.orgFileName}">
										${requestScope.bvo.orgFileName}</a></font> <input type="image"
								src="${initParam.root}/img/ui/board/cancel.jpg" id="cancelFile">
						</c:when>
						<c:otherwise>
							<input type="file" name="uploadFile">
						</c:otherwise>
					</c:choose></span></td>
			</tr>
			<tr>
				<td colspan=2><textarea cols="82" rows="12" id="cont"
						name="cont">${requestScope.bvo.cont }</textarea></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<img src="${initParam.root}/img/ui/board/confirm.gif" id="confirmImg">
				</td>
			</tr>
		</table>
	</form>
	</div>
</center>
