<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script>
	$(document).ready(function() {
		$("a").click(function() {
			var state = $(this).attr("name");
			var bookNo=$(this).attr("id");
			$.ajax({
				type:"GET",//전송 타입 POST or GET
				url:"book.do", //Servlet 명
				data:"command="+state+"&bookNo="+bookNo,
				success:function(){ //callback 함수
					if(state=='bookResolve') {
						$("#state"+bookNo).html("예약중");
						$("#"+bookNo).attr({
							name:"bookResolveCancle"
						});
						$("#"+bookNo).html("취소");
					} else {
						$("#state"+bookNo).html("대여가능");
						$("#"+bookNo).attr({
							name:"bookResolve"
						});
						$("#"+bookNo).html("예약");
					}
				}
			});	
		});
	});
</script>

<style>
table tr,td {
	font-size: 10px;
	height: 15pt;
}
</style>
<center>
	<table border="1">
		<tr height="40">
			<td>도서명</td>
			<td width="350">${requestScope.map.TITLE }</td>
			<td rowspan="5" align="center"><img
				src="${initParam.root }/upload/${requestScope.map.IMG }" width="150"
				height="200"></td>
		</tr>

		<tr height="40">
			<td>저자명</td>
			<td>${requestScope.map.WRITER }</td>
		</tr>

		<tr height="40">
			<td>출판사</td>
			<td>${requestScope.map.PUBLISHER }</td>
		</tr>

		<tr height="40">
			<td>분류</td>
			<td>${requestScope.map.SUBJECT }</td>
		</tr>

		<tr height="40">
			<td>위치</td>
			<td>${requestScope.map.LOC }</td>
		</tr>


		<tr>
			<td>내용</td>
			<td colspan="2"><textarea rows="2" cols="5" readonly="readonly">${requestScope.map.CONT }</textarea>
			</td>

		</tr>
		<tr>
			<td>답글</td>
			<td colspan="2">
				<table>
					<tfoot>
						<tr>
							<td>평점 : <select>
									<option value="1">☆</option>
									<option value="2">☆☆</option>
									<option value="3">☆☆☆</option>
									<option value="4">☆☆☆☆</option>
									<option value="5">☆☆☆☆☆</option>
							</select> <br> <textarea name="contents" cols="60" rows="2"></textarea>
								<input type="button" id="comment_input" value="서평 입력">
							</td>
						</tr>
					</tfoot>
				</table>
			</td>
		</tr>
	</table>
</center>
<a href="book.do?command=updateSet&isbn=${requestScope.map.ISBN }"><input
	type="button" value="수정"></a>

<center>
<span class="resolve"> 도서현황
	<table border="1"> 
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
							<a href="#" id="${list.BOOKNO }" name="bookResolve">예약</a>
						</c:when>
						<c:when test="${list.BOOKSTATE == '예약중' }">
							<a href="#" id="${list.BOOKNO }" name="bookResolveCancle">취소</a>
						</c:when>
					</c:choose>
				</td>
			</tr>
		</c:forEach>
	</table>
</span>
</center>












