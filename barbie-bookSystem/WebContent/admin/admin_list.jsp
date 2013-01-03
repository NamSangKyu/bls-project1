<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="${initParam.root }/css/board-table.css" />
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script>
	$(document).ready(function() {
		$(".but").click(function() {
			var state = $(this).attr("name");
			var bookNo=$(this).attr("id");
			var memberId="";
			memberId=$("#memberId"+bookNo).val();
			if (memberId == "" && state=="bookRental") {
					alert("회원 ID 를 입력하세요.");
					return false;
			}
			$("#memberId"+bookNo).val("");
			$.ajax({
				type:"get",					//전송 타입 POST or GET
				url:"book.do", 				//Servlet 명
				data:"command="+state+"&bookNo="+bookNo+"&memberId="+memberId+"&bookState="+$("#state"+bookNo).text(),
				success:function(data){ 	//callback 함수
					if(data.isReserve){
						if(state=='bookRental'){
							$("#state"+bookNo).html("대여중");
							$("#"+bookNo).attr({name:"bookRentalCancel"});
							$("#"+bookNo).html("반납");
							$("#span"+bookNo).attr({style:"visibility:hidden"});			// 속성을 숨김
							$("#term").html("0");
						} else {
							$("#state"+bookNo).html("대여가능");
							$("#"+bookNo).attr({name:"bookRental"});
							$("#"+bookNo).html("대여");
							$("#span"+bookNo).attr({style:"visibility:visible"});			// 속성을 보여줌
							$("#term").html("");
						}
					}else
						alert("ID 값이 잘못 입력하셨습니다. ");
				}// function
			});// ajax
		});// click
	});// ready
</script>
<!-- 		자주 사용할 데이터 이름 지어줌	 -->
<c:set var="bean" value="${requestScope.listvo.bean }"></c:set>
<c:set var="list" value="${requestScope.listvo.list }"></c:set>

 <span class="resolve" > 도서현황
 <c:choose>
 	<c:when test="${sessionScope.membervo.memberId=='java' }">
	<table>
		<thead align="center">
		<tr>
			<th>도서번호</th>
			<th>도서명</th>
			<th>출판사</th>
			<th>위치</th>
			<th>도서상태</th>
			<th></th>
			<th>대여기간</th>
		</tr>
		</thead>
		<c:forEach items="${requestScope.listvo.list }" var="list">
			<tr align="center">
				<!-- 		실제 데이터 for 문	 -->
				<td>${list.BOOKNO }</td>
				<td>${list.TITLE }</td>
				<td>${list.PUBLISHER }</td>
				<td>${list.LOC }</td>
				<td><span id="state${list.BOOKNO }">${list.BOOKSTATE }</span></td>

<!-- 		대여 버튼과 반납버튼 존재  -->
				<td>
					<span id="href${list.BOOKNO }">
						<c:choose>
							<c:when test="${list.BOOKSTATE != '대여중' }">
								<span id="span${list.BOOKNO }" style="visibility:visible">
									<input type="text" id="memberId${list.BOOKNO }" name="memberId" size="6" placeholder="회원ID" value=""></span>
								<b class="but" id="${list.BOOKNO }" name="bookRental">대여</b>
							</c:when>
							<c:otherwise>
								<span id="span${list.BOOKNO }"  style="visibility:hidden">
									<input type="text" id="memberId${list.BOOKNO }"  name="memberId" size="6" placeholder="회원ID"  value=""></span>
								<b class="but" id="${list.BOOKNO }" name="bookRentalCancel">반납</b>
							</c:otherwise>
						</c:choose>
					</span>
				</td>

<!-- 		대여 기간과 연체 상태 값이 있을때에면 보여주고 없을씨에는 공백  -->
				<td>
					<span id="term">
						<c:choose>
							<c:when test="${list.TERM != null }"><span id="rental_term">${list.TERM }</span></c:when>
							<c:otherwise></c:otherwise>
						</c:choose>
					</span>
					<span>
						<c:choose>
							<c:when test="${list.OVERDUE !=null }"><span id="rental_overdue">${list.OVERDUE }</span></c:when>
							<c:otherwise></c:otherwise>
						</c:choose>
					</span>
				</td>
			</tr>
		</c:forEach>
	</table>

<!-- 			전에 페이지 그룹 이동	 -->
	<c:if test="${requestScope.listvo.bean.previousPageGroup }">
		<a href="book.do?command=adminBook&nowPage=${requestScope.listvo.bean.startPageOfPageGroup-1 }" class="font_style">이전</a>
	</c:if>

<!-- 			페이징 처리될 페이지 그룹내의 숫자 -->
	<c:forEach begin="${bean.startPageOfPageGroup }" end="${bean.endPageOfPageGroup }" var="pb">
		<c:choose>
			<c:when test="${bean.nowPage == pb }">${pb }</c:when>
			<c:otherwise>
				<a href="book.do?command=adminBook&nowPage=${pb }">${pb }</a>
			</c:otherwise>
		</c:choose>
	</c:forEach>

<!--  			다음 페이지 그룹 이동 -->
	<c:if test="${requestScope.listvo.bean.nextPageGroup  }">
		<a href="book.do?command=adminBook&nowPage=${requestScope.listvo.bean.endPageOfPageGroup+1 }" class="font_style">이후</a>
	</c:if><br>

<!-- 			출판사 분류 등록 부분 -->
 	<a href="book.do?command=publisher">출판사 등록</a>&nbsp;
	<a href="book.do?command=subject">분류 등록</a>&nbsp;
	<a href="book.do?command=bookInsert">책등록</a>&nbsp;
	<a href="book.do?command=getBookAllList">도서 삭제/수정</a>
	</c:when>

	<c:otherwise>
<!--  			비로그인 접근시 -->
		<script>
			alert("로그인 하셔야 합니다.");
			location.href=document.referrer;
		</script>
	</c:otherwise>
</c:choose>
</span>
