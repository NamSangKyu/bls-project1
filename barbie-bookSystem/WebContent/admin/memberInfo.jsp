<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <script src="http://code.jquery.com/jquery-latest.js"></script>
 <%-- <script type="text/javascript" src="${initParam.root }/WEB-INF/js/jquery-1.8.2.js"></script> --%>
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
 <link rel="stylesheet" href="${initParam.root }/css/member.css"/>
<center>
<div class="title">회원 정보</div>
<form action="member.do" method="post" id="info_form">
	<input type="hidden" name="command" value="update">
	<table class="insert_table" border="0" cellspacing="0">
		<tr>
			<td class="name">아이디</td>
			<td class="value">${requestScope.membervo.memberId }</td>
			<td class="file" rowspan="3">
				<c:choose>
					<c:when test="${requestScope.membervo.newfilename !=null }">

					<img width="150"  src="${initParam.root }/upload/member/${requestScope.membervo.newfilename}"></c:when>

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
</form>
	<img style="padding: 10px" src="${initParam.root }/img/ui/board/modify_btn.jpg" id="update_img" >
	<img style="padding: 10px"  src="${initParam.root}/img/ui/board/delete_btn.jpg" id="delete_img">
	<img style="padding: 10px"  src="${initParam.root}/img/ui/board/list_btn.jpg" id="list_img">
</center>