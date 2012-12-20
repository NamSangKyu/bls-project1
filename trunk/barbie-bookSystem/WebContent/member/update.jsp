<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
	$(function() {
		// file ajax
		$("#deleteFile_img")
				.click(
						function() {
							$
									.ajax({
										type : "post",
										url : "member.do",
										data : "command=deleteFile&newfilename=${requestScope.map.membervo.newfilename}",
										success : function() {
											alert("성공");
											$("#filewrap")
													.html(
															"<input type='file' name='uploadFile' width='150px'>");
										},
										error : function() {
											alert("실패");
										}
									});
						});
		$("#confirm_img").click(function() {
			alert(1);
			$("#update_form").submit();
		});
		$("#cancel_img").click(function() {
			if (confirm("취소하시겠습니까?"))
				location.href = "index1.jsp";
		});
	});
</script>
<link rel="stylesheet" href="${initParam.root }/css/member.css">
	<div class="title">회원 수정</div>
	<c:choose>
		<c:when test="${sessionScope.membervo != null }">
			<div>
				<form action="member.do" method="post" id="update_form"
					enctype="multipart/form-data">
					<input type="hidden" name="command" value="update"> <input
						type="hidden" name="memberId"
						value="${requestScope.map.membervo.memberId }"> <input
						type="hidden" name="name"
						value="${requestScope.map.membervo.name }"> <input
						type="hidden" name="gender"
						value="${requestScope.map.membervo.gender }"> <input
						type="hidden" name="newfilename"
						value="${requestScope.map.membervo.newfilename }"> <input
						type="hidden" name="orgfilename"
						value="${requestScope.map.membervo.orgfilename }">
					<!--  값이 null 일경우 값을 Defaule 값을 보낸다.  -->
					<table class="insert_table" border="0" cellspacing="0">
						<tr>
							<!-- e6e6fa -->
							<td class="name">아이디</td>
							<td class="value">${requestScope.map.membervo.memberId }</td>
							<td class="file" rowspan="3"><span id="filewrap"> <c:choose>
										<c:when test="${requestScope.map.membervo.orgfilename!=null }">
						${requestScope.map.membervo.orgfilename } <img id="deleteFile_img"
												src="${initParam.root }/img/ui/board/delete_btn.jpg">
										</c:when>
										<c:otherwise>
											<input type="file" name="uploadFile">
										</c:otherwise>
									</c:choose>
							</span></td>
						</tr>
						<tr>
							<td class="name">비밀번호</td>
							<td class="value"><input type="password" name="pass"
								id="pass"></td>
						</tr>
						<tr>
							<td class="name">이름</td>
							<td class="value">${requestScope.map.membervo.name }</td>
						</tr>
						<tr>
							<td class="name">성별</td>
							<td class="value">${requestScope.map.membervo.gender }</td>
						</tr>
						<tr>
							<td class="name">이메일</td>
							<td class="value"><input type="text" name="email" id="email"
								value="${requestScope.map.membervo.email }"></td>
						</tr>
						<tr>
							<td class="name">관심사항</td>
							<td class="value" id="lastValue"><c:forEach
									items="${requestScope.map.sbjList }" var="sbjList"
									varStatus="num">
									<c:choose>
										<c:when
											test="${sbjList.SUBJECT == requestScope.map.membervo.subject1
						or sbjList.SUBJECT == requestScope.map.membervo.subject2
						or sbjList.SUBJECT == requestScope.map.membervo.subject3}">
											<input type="checkbox" name="sbj" value="${sbjList.SUBJECT}"
												checked="checked">${sbjList.SUBJECT }
					</c:when>
										<c:otherwise>
											<input type="checkbox" name="sbj" value="${sbjList.SUBJECT}">${sbjList.SUBJECT }
					</c:otherwise>
									</c:choose>
									<c:if test="${num.count%3==0 }">
										<br>
									</c:if>
								</c:forEach></td>
						</tr>
					</table>
				</form>
				<div id="button_wrap">
					<img style="padding: 10px"
						src="${initParam.root }/img/ui/board/confirm.gif" id="confirm_img">
					<img style="padding: 10px"
						src="${initParam.root }/img/ui/board/cancel.jpg" id="cancel_img">
				</div>
			</div>
		</c:when>
		<c:otherwise>
			<script type="text/javascript">
				alert("로그인 하셔야 합니다.");
				location.href = "index.jsp";
			</script>
		</c:otherwise>
	</c:choose>