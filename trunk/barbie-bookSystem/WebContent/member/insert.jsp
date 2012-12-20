<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
   <%-- <script type="text/javascript" src="${initParam.root }/WEB-INF/js/jquery-1.8.2.js"></script> --%>
   <script src="http://code.jquery.com/jquery-latest.js"></script>
<link rel="stylesheet" href="${initParam.root }/css/member.css">
   <script type="text/javascript" >
  		$(document).ready(function(){
  			$("#insert_btn").click(function(){
  				$("#insert_form").submit();
  			});
  			$("#cancel_img").click(function(){
  				location.href="${initParam.root}/index1.jsp";
  			});
  			//$("tr").css("height","50px");
  			//$("tr td:first-child").css("border-right","1px  solid #2828ce").css("width=30%");		// 공통 색 지정
  			//$("tr td:last-child").css("border-top","1px solid #2828ce");
  			//	$("tr td:last").css("border-bottom","1px solid #2828ce");
  		});
   </script>
 <div class="title">회원가입</div>
<form action="member.do" method="post" id="insert_form"  enctype="multipart/form-data">
	<input type="hidden" name="command" value="insert">
	<table class="insert_table" cellspacing="0">
		<tr>
			<td class="name" >아이디</td>
			<td class="value"><input type="text" size="10" name="memberId" id="memberId" value=""><span id="checkResult"></span>
			<p class="defaultText">한글1~10자, 영문2~20자 이하 별명만 입력 가능합니다.</p></td>
			<td class="file" rowspan="3" ><input type="file" name="uploadFile"></td>

		</tr>
		<tr>
			<td class="name">비밀번호</td>
			<td  class="value"><input type="password" name="pass" id="pass" value=""></td>
		</tr>
		<tr>
			<td class="name">이름</td>
			<td class="value"><input type="text" name="name" id="name" value=""></td>
		</tr>
		<tr>
			<td class="name">성별</td>
			<td class="value" colspan="2" >
				남<input type="radio" name="gender"  value="남">
				여<input type="radio" name="gender" value="여">
			</td>
		</tr>
		<tr>
			<td class="name" >이메일</td>
			<td class="value" colspan="2"><input type="text" name="email" id="email" value="">	</td>
		</tr>
		<tr>
			<td class="name"   rowspan="2">관심사항</td>
			<td class="value" id="lastValue" colspan="2" >
				 <c:forEach items="${requestScope.sbjList }" var="list" varStatus="i">
 					<c:choose>
 						<c:when test="${i.count%3==0}">		<!--  3의 배수일때 한칸 밑으로 -->
 							<input type="checkbox" name="sbj" value= "${list.SUBJECT }">${list.SUBJECT }<br>
 						</c:when>
 						<c:otherwise>
 							<input type="checkbox" name="sbj" value= "${list.SUBJECT }">${list.SUBJECT }
 						</c:otherwise>
 					</c:choose>
 				</c:forEach>
			</td>
		</tr>
	</table>
	<!--  추후에 이미지로 변환 -->
	<input type="button" name="insert_btn" id="insert_btn" value="회원가입">
	<input type="button" name="cancel_btn" id="cancel_img" value="취소">
</form>
