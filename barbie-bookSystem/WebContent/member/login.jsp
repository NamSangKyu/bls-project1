<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
       <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <script src="http://code.jquery.com/jquery-latest.js"></script>
 <div>
 <div align="left"> 우헤헤</div>
<div align="right"  >
<form action="member.do" method="post" id="login_form">
<c:choose>
	<c:when test="${sessionScope.membervo ==null }">
	<b>LOGIN</b>											
	<table border="0"  width="200" cellpadding="0" id="loginTable">
		<tr>
			<td width="50" >
				I D
			</td>
			<td width="150">
		     	<input type="text" size='15'  style="IME-MODE:disabled;" maxlength="13" name="id" ></input>
		     </td>
		 </tr>
		 <tr>
				<td>
					PASS
				</td>
				<td>	
					 <input type="password"  size='15' maxlength="13" name="password"></input>
				</td>
		</tr>
	</table>
				<input type="button"   value="회원 가입" id="register_btn">
				<input type="button"   value="LOGIN"  id="login_btn">
	</c:when>
	<c:otherwise>
		${sessionScope.membervo.name } 님<br> 환영합니다.  
		<input type="button" value="자기정보수정" id="modify_btn">
		<input type="button"  value="로그아웃"  id="logout_btn">
	</c:otherwise>
</c:choose>
</form>
</div>
</div>




















