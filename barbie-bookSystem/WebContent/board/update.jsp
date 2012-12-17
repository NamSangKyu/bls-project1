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
<center>
	<form action="${initParam.root}/board.do" method="post" id="updateForm"
		enctype="multipart/form-data">
		<input type="hidden" name="command" value="updateContent"> <input
			type="hidden" name="boardNo" value="${requestScope.bvo.boardNo }">
			<input type="hidden" name="page" value="${requestScope.page }">
			<input type="hidden" name="default1" value="${requestScope.bvo.orgFileName }">
			<input type="hidden" name="default2" value="${requestScope.bvo.newFileName }">
		<table border="1" width="600">
			<tr>
				<td>제목</td>
				<td><input type="text" id="title" name="title"
					value="${requestScope.bvo.title }"></td>
			</tr>
			<tr>
				<td>첨부파일</td>
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
				<td colspan=2><textarea cols="60" rows="10" id="cont"
						name="cont">${requestScope.bvo.cont }</textarea></td>
			</tr>
		</table>
		<img src="${initParam.root}/img/ui/board/confirm.gif" id="confirmImg">
	</form>
</center>