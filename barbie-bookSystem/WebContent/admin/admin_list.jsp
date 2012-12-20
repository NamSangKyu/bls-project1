<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script>
	$(document).ready(function() {
		$("a").click(function() {
			var state = $(this).attr("name");
			var bookNo=$(this).attr("id");
			var memberId=$("#memberId"+bookNo).val();
			if (memberId == "") {
				alert("회원 ID 를 입력하세요.");
				return false;
			}
			$.ajax({
				type:"POST",//전송 타입 POST or GET
				url:"book.do", //Servlet 명
				data:"command="+state+"&bookNo="+bookNo+"&memberId="+memberId,
				success:function(){ //callback 함수
					if(state=='bookRental') {
						$("#state"+bookNo).html("대여중");
						$("#"+bookNo).attr({
							name:"bookRentalCancle"
						});
						$("#"+bookNo).html("반납");
					} else {
						$("#state"+bookNo).html("대여가능");
						$("#"+bookNo).attr({
							name:"bookRental"
						});
						$("#"+bookNo).html("대여");
					}
				}
			});
		});
	});
</script>

<style>
table tr, td{
	text-align: center;
}
</style>

<center>
 <span class="resolve"> 도서현황
	<table border="1">
		<tr>
			<td>도서번호</td>
			<td>도서명</td>
			<td>출판사</td>
			<td>위치</td>
			<td>도서상태</td>
			<td></td>
		</tr>
		<c:forEach items="${requestScope.list }" var="list">
			<tr>
				<td>${list.BOOKNO }</td>
				<td>${list.TITLE }</td>
				<td>${list.PUBLISHER }</td>
				<td>${list.LOC }</td>
				<td><span id="state${list.BOOKNO }">${list.BOOKSTATE }</span></td>
				<td>
					<span id="href${list.BOOKNO }">
						<c:choose>
							<c:when test="${list.BOOKSTATE != '대여중' }">
								<input type="text" id="memberId${list.BOOKNO }" name="memeberId" size="6">
								<a href="#" id="${list.BOOKNO }" name="bookRental">대여</a>
							</c:when>
							<c:otherwise>
								<a href="#" id="${list.BOOKNO }" name="bookRentalCancle">반납</a>
							</c:otherwise>
						</c:choose>
					</span>
				</td>
			</tr>
		</c:forEach>
	</table>
</span>
</center>