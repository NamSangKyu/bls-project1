<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
  <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#deleteImg").click(function() {
			if (confirm("삭제 하시겠습니까?"))
				location.href = "board.do?command=delete&boardNo=${requestScope.bvo.boardNo }&newFileName=${requestScope.bvo.newFileName }&page=${requestScope.page }";
		});
		
		$("#commentBtn").click(function() {
			if ($("#cont").val() == "") {
					alert("내용을 입력해주십시오");
					return;
			}
			$("#commentForm").submit();
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
.prenext{
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
}
#page {
	font-family: 'Trebuchet MS', malgun gothic,Arial, Helvetica, sans-serif;
}
#commentPage{
	background: #D2D2FF;
}
#prenext1 {
		width: 50px;
}
#prenext2 {
		width: 420px;
}
#prenext3 {
		width: 50px;
}
#prenext4 {
		width: 80px;
}
</style>
<center>
	<div id="page">
	<c:set value="${requestScope.bvo }" var="bvo"/>
	<c:set value="${sessionScope.membervo }" var="mvo" />
	<table>
		<tr>
			<td><b>&nbsp;${bvo.title }</b> | 자유게시판</td>
			<td align="right">${bvo.boardDate }&nbsp;</td>
		</tr>
		<tr>
			<td><b>&nbsp;${bvo.memberId }</b></td>
			<td align="right"><c:if
					test="${bvo.orgFileName!=null }">
					<img src="${initParam.root}/img/ui/board/file.jpg">
					<a href="board.do?command=fileDownload&newFileName=${bvo.newFileName}&orgFileName=${bvo.orgFileName}&page=${requestScope.page }">
						${bvo.orgFileName}&nbsp;</a>
				</c:if></td>
		</tr>
		<tr>
			<td colspan="2"><textarea cols="82" rows="12"
					name="cont" readonly="readonly" disabled="disabled">${bvo.cont }</textarea></td>
		</tr>
		<tr>
			<td colspan="2">&nbsp;<font color="#46649B"><b>덧글 ${fn:length(cList)} 개</b></font> | <b>조회수 ${bvo.count }</b></td>
		</tr>
		<tr>
			<td colspan="2">
			<div id="commentPage">
			<table>
					<c:forEach items="${requestScope.cList }" var="comment">
						<tr>
							<td>&nbsp;<b>${comment.memberId }</b>&nbsp;&nbsp;${comment.commentDate }<br>&nbsp;${comment.cont }</td>
							<td align="right">
								<c:if test="${mvo.memberId == comment.memberId }">
									<a href="#" class="listHref">수정</a>
								</c:if>
								<c:if test="${mvo.memberId == 'java' || mvo.memberId == comment.memberId }">
									<a href="#" class="listHref">삭제</a>
								</c:if>
							</td>
						</tr>
					</c:forEach>
				<c:if test="${mvo != null }">
				<tr>
					<td>
						<form action="board.do" method="post" id="commentForm">
							<input type="hidden" name="command" value="commentContent">
							<input type="hidden" name="boardNo" value="${bvo.boardNo }">
							<input type="hidden" name="memberId" value="${mvo.memberId }">
							<input type="hidden" name="page" value="${requestScope.page }">
							<input type="text" name="cont" size="80" id="cont">
						</form>				
					</td>
					<td><input type="image" src="${initParam.root}/img/ui/board/comment.jpg" id="commentBtn"></td>
				</tr>
				</c:if>
			</table>	
			</div>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="right">
			<c:if test="${mvo != null }">
				<a href="board.do?command=insertView"><img src="${initParam.root}/img/ui/board/write_btn.jpg"></a>
				<a href="board.do?command=replyView&boardNo=${bvo.boardNo }&page=${requestScope.page }"><img src="${initParam.root}/img/ui/board/answer_btn.jpg"></a>
				<c:if test="${mvo.memberId == bvo.memberId }">
					<a href="board.do?command=updateView&boardNo=${bvo.boardNo }&page=${requestScope.page }"><img src="${initParam.root}/img/ui/board/modify_btn.jpg" id="updateImg"></a>
				</c:if>
				<c:if test="${mvo.memberId == 'java' || mvo.memberId == bvo.memberId }">
					<input type="image" src="${initParam.root}/img/ui/board/delete_btn.jpg" id="deleteImg">
				</c:if>
			</c:if>
			<a href="board.do?command=list&page=${requestScope.page }"><img src="${initParam.root}/img/ui/board/list_btn.jpg"></a>
	</td>
	</table>
	<table>
		<c:if test="${bvo.relevel == 0 }">
			<tr>
				<td id="prenext1"><img src="${initParam.root}/img/ui/board/pre.jpg"></td>
				<td id="prenext2">
					<c:choose>
						<c:when test="${requestScope.nextpre.PRE_BOARDNO != 0 }">
							<a href="board.do?command=showContent&boardNo=${requestScope.nextpre.PRE_BOARDNO}&page=${requestScope.page }" class="prenext">${requestScope.nextpre.PRE_TITLE }</a>
						</c:when>
						<c:otherwise>
							${requestScope.nextpre.PRE_TITLE }
						</c:otherwise>
					</c:choose>
					</td>
				<td id="prenext3">${requestScope.nextpre.MEMBERID }</td>
				<td id="prenext4">${requestScope.nextpre.BOARDDATE }</td>
			</tr>
			<tr>
				<td id="prenext1"><img src="${initParam.root}/img/ui/board/next.jpg"></td>
				<td id="prenext2">
					<c:choose>
						<c:when test="${requestScope.nextpre.NEXT_BOARDNO != 0 }">
							<a href="board.do?command=showContent&boardNo=${requestScope.nextpre.NEXT_BOARDNO}&page=${requestScope.page }" class="prenext">${requestScope.nextpre.NEXT_TITLE }</a>
						</c:when>
						<c:otherwise>
							${requestScope.nextpre.NEXT_TITLE }
						</c:otherwise>
					</c:choose>	
				</td>
				<td id="prenext3">${requestScope.nextpre.MEMBERID }</td>
				<td id="prenext4">${requestScope.nextpre.BOARDDATE }</td>
			</tr>
		</c:if>
	</table>
	</div>
</center>