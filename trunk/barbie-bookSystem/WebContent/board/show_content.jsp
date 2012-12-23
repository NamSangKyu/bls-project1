<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#deleteImg").click(function() {
			if (confirm("삭제 하시겠습니까?"))
				location.href = "board.do?command=delete&boardNo=${requestScope.bvo.boardNo }&newFileName=${requestScope.bvo.newFileName }&page=${requestScope.page }";
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
		width: 100px;
}
#replySize2 {
		width: 50px;
}
#replySize3 {
		width: 450px;
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
			<td colspan="2"><textarea cols="82" rows="12" id="cont"
					name="cont" readonly="readonly" disabled="disabled">${bvo.cont }</textarea></td>
		</tr>
		<tr>
			<td colspan="2">&nbsp;<font color="#46649B"><b>덧글 ? 개</b></font> | <b>조회수 ${bvo.count }</b></td>
		</tr>
		<tr>
		
			<td colspan="2">
			<div id="replyPage">&nbsp;덧글 페이지<br>
			<table>
				<tr>
					<td id="replySize1"><b>&nbsp;ex) memberId</b></td><td id="replySize2">sysdate</td><td id="replySize3">->reply</td>
				</tr>
				<tr>
					<td colspan="3">&nbsp;cont</td>
				</tr>
			</table>
			<br>
			<table>
				<tr>
					<td><textarea cols="70" rows="3" id="cont" name="cont" readonly="readonly"></textarea></td>
					<td><input type="button" value="덧글입력"></td>
				</tr>
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
		<tr>
			<td id="prenext1"><img src="${initParam.root}/img/ui/board/pre.jpg"></td>
			<td id="prenext2"><a href="board.do?command=showContent&boardNo=${requestScope.nextpre.PRE_BOARDNO}&page=${requestScope.page }" class="prenext">${requestScope.nextpre.PRE_TITLE }</a></td>
			<td id="prenext3">${requestScope.nextpre.MEMBERID }</td>
			<td id="prenext4">${requestScope.nextpre.BOARDDATE }</td>
		</tr>
		<tr>
			<td id="prenext1"><img src="${initParam.root}/img/ui/board/next.jpg"></td>
			<td id="prenext2"><a href="board.do?command=showContent&boardNo=${requestScope.nextpre.NEXT_BOARDNO}&page=${requestScope.page }" class="prenext">${requestScope.nextpre.NEXT_TITLE }</a></td>
			<td id="prenext3">${requestScope.nextpre.MEMBERID }</td>
			<td id="prenext4">${requestScope.nextpre.BOARDDATE }</td>
		</tr>
	</table>
	</div>
</center>