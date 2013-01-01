<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
  <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
<script src="http://code.jquery.com/jquery-latest.js"></script>
<link rel="stylesheet" href="${initParam.root }/css/board-table.css">
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
		
/* 	<form action="board.do" method="post" id="commentForm">
		<input type="hidden" id="command" name="command" value="commentContent">
		<input type="hidden" id="commentNo" name="commentNo" value="">
		<input type="hidden" id="boardNo" name="boardNo" value="${bvo.boardNo }">
		<input type="hidden" id="memberId" name="memberId" value="${mvo.memberId }">
		<input type="hidden" name="page" value="${requestScope.page }">
		<input type="text" id="cont" name="cont" size="80">
		</form>	 */
		
		var state;
		var commentNo;
		$(".comment").click(function() {
			state = $(this).attr("name");
			commentNo = $(this).attr("id");
			$("#command").val(state);
			$("#commentNo").val(commentNo);
			
			if (state == 'commentDelete') {
				$("#commentForm").submit();
			} else {
				$("#contComment"+commentNo).html("<input type='text' name='cont' size='79' id=cont"+commentNo+" value="+$("#contComment"+commentNo).text()+">");
				$("#update"+commentNo).html("<input type= 'image' src=' ${initParam.root}/img/ui/board/comment.jpg' id='updateCommentBtn' name="+commentNo+">");
			}
		});
		
		$("#commentPage").on("click", "#updateCommentBtn", function() {
			$("#cont").val($("#cont"+commentNo).val());
			$("#commentForm").submit();
		});
	});
</script>
<center>
	<div id="page">
	<c:set value="${requestScope.bvo }" var="bvo"/>
	<c:set value="${sessionScope.membervo }" var="mvo" />
	<c:set value="${requestScope.cList }" var="cList" />
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
			<td colspan="2">&nbsp;<font color="#46649B"><b>덧글 ${cList.bean.totalContent } 개</b></font> | <b>조회수 ${bvo.count }</b></td>
		</tr>
		<tr>
			<td colspan="2">
			<div id="commentPage">
			<table>
				<c:forEach items="${cList.list }" var="comment">
					<tr>
						<td>&nbsp;<b>${comment.memberId }</b>&nbsp;&nbsp;${comment.commentDate }<br>&nbsp;<span id="contComment${comment.commentNo }">${comment.cont }</span></td>
						<td align="right" id="update${comment.commentNo }">
							<c:if test="${mvo.memberId == comment.memberId }">
								<b class="comment" id="${comment.commentNo }" name="commentUpdate"><font size='1'>수정</font></b> |
							</c:if>
							<c:if test="${mvo.memberId == 'java' || mvo.memberId == comment.memberId }">
								<b class="comment" id="${comment.commentNo }" name="commentDelete"><font size='1'>삭제&nbsp;</font></b>
							</c:if>
						</td>
					</tr>
				</c:forEach>
			<c:if test="${mvo != null }">
			<tr>
				<td align="center" colspan="2">
					<table id="commentAlign" border="0">
						<tr>
							<td colspan="2">
							<div id="page">
					<c:if test="${cList.bean.previousPageGroup }">
						<a href="board.do?command=showContent&boardNo=${bvo.boardNo }&page=${requestScope.page }&commentPage=${cList.bean.startPageOfPageGroup-1 }" class="listHref">
						<span class="arrow">◀</span><span class="way">이전</span>
						</a>
					</c:if>
					<c:forEach var="i" begin="${cList.bean.startPageOfPageGroup}" end="${cList.bean.endPageOfPageGroup}">
						<c:if test="${i != 0 }">
						<c:choose>
							<c:when test="${cList.bean.nowPage != i }">
								<a href="board.do?command=showContent&boardNo=${bvo.boardNo }&page=${requestScope.page }&commentPage=${i}" class="listHref">${i}</a>
							</c:when>
							<c:otherwise>
									<u>${i}</u>
							</c:otherwise>
						</c:choose>
						</c:if>
					</c:forEach>
					<c:if test="${cList.bean.nextPageGroup}">
						<a href="board.do?command=showContent&boardNo=${bvo.boardNo }&page=${requestScope.page }&commentPage=${cList.bean.endPageOfPageGroup+1 }" class="listHref">
						<span class="way">다음</span> <span class="arrow">▶</span>
						</a>
					</c:if>
					</div>
							</td>
						</tr>
					<tr>
						<td>
					<form action="board.do" method="post" id="commentForm">
						<input type="hidden" id="command" name="command" value="commentContent">
						<input type="hidden" id="commentNo" name="commentNo" value="1">
						<input type="hidden" id="boardNo" name="boardNo" value="${bvo.boardNo }">
						<input type="hidden" id="memberId" name="memberId" value="${mvo.memberId }">
						<input type="hidden" name="page" value="${requestScope.page }">
						<input type="text" id="cont" name="cont" size="80">
					</form>				
					</td>
					<td><input type="image" src="${initParam.root}/img/ui/board/comment.jpg" id="commentBtn"></td>
					</table>
				</td>
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