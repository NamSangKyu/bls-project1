<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<link rel="stylesheet" href="${initParam.root }/css/board-table.css" />
<script type="text/javascript" >
  		$(document).ready(function(){

  			// 		가입 버튼
  			$("#insert_img").click(function(){
  				if($("#checkIdState").val() == "false"){
  					alert("아이디 체크 해주세요.")
  					return;
  				}
  				$("#insert_form").submit();
  			});

  			//			취소 버튼
  			$("#cancel_img").click(function(){
  				location.href=document.referrer;
  			});

  			// 		아이디 중복 체크 ajax
  			$("#insert_form .memberId").keyup(function(){
  				var resultCheck = $("#resultCheck");
  				var checkIdState = $("#checkIdState");
  				checkIdState.val("false");	// 상태 값 초기화
  				resultCheck.html("");				// 값 초기화
  				var memberId = $(this).val();
  				if(memberId.length < 4)
  					return;

				$.ajax({
					type:"get",
					url:"member.do",
					data:"command=checkIdForInsert&memberId="+memberId,
					success:function(data){
						if(data.flag){
							resultCheck.html("중복 아이디 존재");
							checkIdState.val("false");
						}else{
							resultCheck.html("사용 가능");
							checkIdState.val("true");
						}
					}
				});	//ajax
  			});	//keyup
  		});
</script>
<br> <div class="font_style">회원가입</div><br><br>
<form action="member.do" method="post" id="insert_form"  enctype="multipart/form-data">
	<input type="hidden" name="command" value="insert">
	<input type="hidden" id="checkIdState" value="false">
	<table class="insert_table" cellspacing="0">
		<tr>
			<td class="name" width="100px">아이디</td>
			<td class="value"><input type="text" size="10" name="memberId" class="memberId" id="memberId" value=""><span id="resultCheck"></span><br>
			<p style="font-size:9px;" >한글1~10자, 영문2~20자 이하 별명만 입력 가능합니다.</p></td>
			<td class="file_section" rowspan="3"  width="150px"><input type="file" name="uploadFile"></td>

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
	</table><br>
	<!--  추후에 이미지로 변환 -->
	<input style="font-size:12pt;" type="button" class="button_section" name="insert_img" id="insert_img" value="가입" >
	<input style="font-size:12pt;" type="button" class="button_section"  type="button" name="cancel_img" id="cancel_img" value="취소">
</form>
