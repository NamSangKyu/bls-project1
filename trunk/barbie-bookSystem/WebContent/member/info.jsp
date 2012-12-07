<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
       <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<center>
<form action="member.do" method="post" id="info_form">
	<input type="hidden" name="command" value="info">
	<table border="1" >
		<tr>
			<td align="center"><b>아이디</b></td>
			<td>${sessionScope.membervo.memberId }</td>
		</tr>
		<tr>
			<td align="center">비밀번호</td>
			<td>${sessionScope.membervo.pass }</td>
		</tr>
		<tr>
			<td align="center">이름</td>
			<td>${sessionScope.membervo.name }</td>
		</tr>
		<tr>
			<td align="center">이메일</td>
			<td>${sessionScope.membervo.email }</td>
		</tr>
		<tr>
			<td align="center">관심사항</td>
			<td>	${sessionScope.membervo.subject1 }&nbsp&nbsp
					${sessionScope.membervo.subject2 }&nbsp&nbsp
					${sessionScope.membervo.subject3 }
			</td>
		</tr>
		<tr>
		<td colspan="2">	
			<input type="button" name="update_btn" id="update_btn" value="회원정보수정">
			<c:if test="${sessionScope.membervo.memberId=='java' }">
				<input type="button" name="list_btn" id="list_btn" value="전체회원보기">
			</c:if>
		</td>
		</tr>
	</table>
</form>
</center>