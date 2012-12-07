<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
   
<form action="member.do" method="post" id="uodate_form">
	<input type="hidden" name="command" value="update">
	
	아이디 &nbsp${sessionScope.membervo.id }<br>
	비밀번호<input type="password" name="pass" id="pass"><br>
	이름${sessionScope.membervo.name }<br>
	이메일<input type="text" name="email" id="email" value="${sessionScope.membervo.email }"><br>
	관심사항<br>
	
	
	<!--  request.getParameter 로 접근해서 뿌려준다.  -->
	미술<input type="checkbox" name="subject" value="art">
	철학<input type="checkbox" name="subject" value="philosophy">
	역사<input type="checkbox" name="subject" value="history"><br>
	
	<!--  추후에 이미지로 변환 -->
	<input type="button" name="insert_btn" id="update_btn" value="수정완료">
	<input type="button" name="cancel_btn" id="cancel_btn" value="취소">
</form>