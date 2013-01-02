<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <script src="http://code.jquery.com/jquery-latest.js"></script>
 <link rel="stylesheet" href="${initParam.root }/css/board-table.css" />
 <script type="text/javascript">
 	$(function(){
 		$("#list_img").click(function(){
 			location.href="member.do?command=list";
 		});
 		$("#update_img").click(function(){
 			location.href="member.do?command=updateView&memberId=${requestScope.membervo.memberId}";
 		});
 		$("#delete_img").click(function(){
 			if(confirm("삭제 하시겠습니까?")){
 				location.href="member.do?command=delete&memberId=${requestScope.membervo.memberId}&nowPage=${param.nowPage}";
 			}
 		})
 	});
 </script>
<br><div class="font_style">회원 정보</div><br><br>
<form action="member.do" method="post" id="info_form">
	<input type="hidden" name="command" value="update">
	<table class="insert_table" border="0" cellspacing="0">
		<tr>
			<td class="name" width="100px">아이디</td>
			<td class="value">${requestScope.membervo.memberId }</td>
			<td class="file" rowspan="3" width="200px">
				<c:choose>
					<c:when test="${requestScope.membervo.mImg !=null }">
						<img  src="${initParam.root }/upload/member/${requestScope.membervo.mImg}"></c:when>
					<c:otherwise>회원의 사진은 없습니다.</c:otherwise>
				</c:choose>
			</td>
		</tr>
		<tr>
			<td class="name">비밀번호</td>
			<td class="value">${requestScope.membervo.pass }</td>
		</tr>
		<tr>
			<td class="name">이름</td>
			<td class="value">${requestScope.membervo.name }</td>
		</tr>
		<tr>
			<td class="name">성별</td>
			<td class="value" colspan="2">${requestScope.membervo.gender }</td>
		</tr>
		<tr>
			<td class="name">이메일</td>
			<td class="value" colspan="2">${requestScope.membervo.email }</td>
		</tr>
		<tr>
			<td class="name">관심사항</td>
			<td id="lastValue" class="value" colspan="2">	${requestScope.membervo.subject1 }&nbsp&nbsp
					${requestScope.membervo.subject2 }&nbsp&nbsp
					${requestScope.membervo.subject3 }
			</td>
		</tr>
	</table>
</form><br>
	<input style="font-size:12pt;" class="button_section" type="button" id="update_img" value="수정">
	<input style="font-size:12pt;" class="button_section" type="button" id="delete_img" value="삭제">
	<input style="font-size:12pt;" class="button_section" type="button" id="list_img" value="목록">