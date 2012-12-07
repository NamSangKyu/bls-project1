<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>																
   <%-- <script type="text/javascript" src="${initParam.root }/WEB-INF/js/jquery-1.8.2.js"></script> --%>
   <script src="http://code.jquery.com/jquery-latest.js"></script>
   <script type="text/javascript" >
  		$(document).ready(function(){
  			$("#insert_btn").click(function(){
  				$("#insert_form").submit();
  			});
  		});
   </script>
  <center> 
 <h4> 회원가입</h4>
<form action="member.do" method="post" id="insert_form" >
	<input type="hidden" name="command" value="insert">
	<table   border="1" cellspacing="0" width="500px">
		<tr height="50px">
			<td  align="center"><b>아이디</b></td>
			<td><input type="text" name="memberId" id="memberId" value=""></td>
		</tr>
		<tr height="50px">
			<td  align="center"><b>비밀번호</b></td>
			<td><input type="password" name="pass" id="pass" value=""></td>
		</tr>
		<tr height="50px">
			<td  align="center"><b>이름</b></td>
			<td><input type="text" name="name" id="name" value=""></td>
		</tr>
		<tr height="50px">
			<td  align="center" ><b>성별</b></td>
			<td>
				남<input type="radio" name="gender"  value="남">
				여<input type="radio" name="gender" value="여">
			</td>
		</tr>
		<tr height="50px">
			<td  align="center"><b>이메일</b></td>
			<td><input type="text" name="email" id="email" value="">	</td>
		</tr>
		<tr height="50px">
			<td  align="center"   rowspan="2"><b>관심사항</b></td>
			<td>
				미술<input type="checkbox" name="sub" value="art">
				철학<input type="checkbox" name="sub" value="philosophy">
				역사<input type="checkbox" name="sub" value="history">
			</td>
		</tr>
		<tr height="50px">
			
			<td>
				소설<input type="checkbox" name="sub" value="novel">
				경제<input type="checkbox" name="sub" value="economy">
			</td>
		</tr>
	</table>
	<!--  추후에 이미지로 변환 -->
	<input type="button" name="insert_btn" id="insert_btn" value="회원가입">
	<input type="button" name="cancel_btn" id="cancel_btn" value="취소">
</form>
	</center>