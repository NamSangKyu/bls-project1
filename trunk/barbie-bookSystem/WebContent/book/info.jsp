<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script>
	$(document).ready(function() {
		$("a").click(function() {
			if( ${sessionScope.membervo !=null }){
				var state = $(this).attr("name");
				var bookNo=$(this).attr("id");
				$.ajax({
					type:"GET",//전송 타입 POST or GET
					url:"book.do", //Servlet 명
					data:"command="+state+"&bookNo="+bookNo+"&memberId=${sessionScope.membervo.memberId}",
					success:function(){ //callback 함수
						if(state=='bookReserve') {
							$("#state"+bookNo).html("예약중");
							$("#"+bookNo).attr({ name:"bookReserveCancel"});
							$("#"+bookNo).html("취소");
						} else {
							$("#state"+bookNo).html("대여가능");
							$("#"+bookNo).attr({name:"bookReserve"});
							$("#"+bookNo).html("예약");
						}
					}
				});			// ajax
			}else {
				alert("로그인 하셔야 이용할 수 있습니다.");
			}
		});

		var comment;
		   //onload() comment show
		$.ajax({
			type:"GET",//전송 타입 POST or GET
		    url:"book.do", //Servlet 명
		    dataType:"json", //Dispatcher로 부터 받는 데이터 타입
		    data:"command=getCommentList&isbn="+$("input[name=isbn]").val(),//Dispatcher로 보내는 데이터
		    success:function(data){ //callback 함수
		     	comment = "";
		    for(i=0;i<data.map.list.length;i++){
		    	comment += "<tr><td>"+data.map.list[i].writer+"</td><td>"+data.map.list[i].bookcomment+"</td></tr>";
		    }
		    comment+="<tr><td colspan=2>평점"+data.map.avgscore+"</td></tr>";
		    $("#commentTable").html(comment);

		    }//success
		});//ajax
		   //comment input -> comment show
		   $("#comment_input").click(function() {
		    var str = $("form[name=commentForm]").serialize();
		    $.ajax({
		     type:"GET",//전송 타입 POST or GET
		     url:"book.do", //Servlet 명
		     dataType:"json", //Dispatcher로 부터 받는 데이터 타입
		     data:str,//Dispatcher로 보내는 데이터
		     success:function(data){ //callback 함수
		      comment = "";
		      for(i=0;i<data.map.list.length;i++){
		       comment += "<tr><td>"+data.map.list[i].writer+"</td><td>"+data.map.list[i].bookcomment+"</td></tr>";
		      }
		      comment+="<tr><td colspan=2>평점"+data.map.avgscore+"</td></tr>";
		      $("#commentTable").html(comment);
		     }//success
		    });//ajax
		   });//comment_input click
	});
</script>

<style>
table tr,td {
	font-size: 10px;
	height: 15pt;
}
</style>
<center>
<table height="500" >
	<tr>
		<td>
			<form name="commentForm">
<input type="hidden" name="command" value="insertComment">
<input type="hidden" name="writer" value="${sessionScope.membervo.memberId }">
<input type="hidden" name="isbn" value="${requestScope.map.ISBN }">
<table border="1" width="450"  height="300">
<thead>
<tr>
<th>작성자</th>
<th>댓글</th>
</tr>
</thead>
<tbody id="commentTable">

</tbody>

<tfoot>
	<tr>
		<td colspan="2">
		평점 :
		<select name="score">
			<option value="1">☆</option>
			<option value="2">☆☆</option>
			<option value="3">☆☆☆</option>
			<option value="4">☆☆☆☆</option>
			<option value="5">☆☆☆☆☆</option>
		</select>
		<br>
		<textarea name="bookcomment" cols="60" rows="2"></textarea><br>
		<p align="right"><input type="button" id="comment_input"  value="서평 입력" ></p>
		</td>
	</tr>
</tfoot>
</table>
</form>
		</td>
		<td rowspan="2">
			<table border="1" height="500" width="350">
				<tr>
					<td width="15%" align="center">도서명</td>
					<td >${requestScope.map.TITLE }</td>
					<td rowspan="2" align="center" width="30%" height="30%"><img
						src="${initParam.root }/upload/${requestScope.map.IMG }"  width="100%" height="100%">
					</td>
				</tr>
				<tr align="center">
					<td>저자명</td>
					<td>${requestScope.map.WRITER }</td>
				</tr>

				<tr align="center">
					<td height="10">출판사</td>
					<td colspan="2">${requestScope.map.PUBLISHER }</td>
				</tr>

				<tr align="center">
					<td height="10">분류</td>
					<td colspan="2">${requestScope.map.SUBJECT }</td>
				</tr>

				<tr align="center">
					<td height="10">위치</td>
					<td colspan="2">${requestScope.map.LOC }</td>
				</tr>
				<tr >
					<td height="200" align="center">내용</td>
					<td colspan="2"><textarea rows="5" cols="37" readonly="readonly" >${requestScope.map.CONT }</textarea>
					</td>
				</tr>
			</table>
			</td>
		</tr>
		<tr>
			<td>
				<span class="resolve"> 도서현황
					<table border="1" width="450">
						<tr>
							<td>도서번호</td>
							<td>도서명</td>
							<td>출판사</td>
							<td>위치</td>
							<td>도서상태</td>
							<td>예약신청</td>
						</tr>
						<c:forEach items="${requestScope.list }" var="list">
							<tr>
								<td>${list.BOOKNO }</td>
								<td>${list.TITLE }</td>
								<td>${list.PUBLISHER }</td>
								<td>${list.LOC }</td>
								<td><span id="state${list.BOOKNO }">${list.BOOKSTATE }</span></td>
								<td>
									<c:choose>
										<c:when test="${list.BOOKSTATE == '대여가능' }">
											<a href="#" id="${list.BOOKNO }" name="bookReserve">예약</a>
										</c:when>
										<c:when test="${list.BOOKSTATE == '예약중' }">
											<a href="#" id="${list.BOOKNO }" name="bookReserveCancel">
												<c:if test="${list.IDSTATE =='ok' }">
													취소
												</c:if>
											</a>
										</c:when>
									</c:choose>
								</td>
							</tr>
						</c:forEach>
					</table>
			</span>
		</td>
	</tr>
</table>

</center>
<%-- <a href="book.do?command=updateSet&isbn=${requestScope.map.ISBN }"><input
	type="button" value="수정"></a> --%>
<center>
</center>












