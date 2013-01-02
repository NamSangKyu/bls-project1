<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
	$(function() {
		// file ajax
		$("#deleteFile_img").click(function() {
			$.ajax({
				type : "post",
				url : "member.do",
				data : "command=deleteFile&mImg=${requestScope.map.membervo.mImg}",
				success : function() {
					alert("성공");
					$("#filewrap")
					.html("<input type='file' name='uploadFile'>");
				},
				error : function() {
					alert("실패");
				}
				});
			});
		$("#confirm_img").click(function() {
			$("#update_form").submit();
		});
		$("#cancel_img").click(function() {
			if (confirm("취소하시겠습니까?"))
				location.href = "index.jsp";
		});
	});
</script>
<link rel="stylesheet" href="${initParam.root }/css/board-table.css" />
<br>
	<div class="font_style">회원 수정</div>
	<br><br>
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
						type="hidden" name="mImg"
						value="${requestScope.map.membervo.mImg }">
					<!--  값이 null 일경우 값을 Defaule 값을 보낸다.  -->
					<table class="insert_table" border="0" cellspacing="0">
						<tr>
							<!-- e6e6fa -->
							<td class="name" width="100px">아이디</td>
							<td class="value">${requestScope.map.membervo.memberId }</td>
							<td class="file_section" rowspan="3" width="200px"><span id="filewrap"> <c:choose>
									<c:when test="${requestScope.map.membervo.mImg!=null }">
										<img id="deleteFile_img" src="${initParam.root }/img/ui/board/delete_btn.jpg">
									</c:when>
									<c:otherwise>
										<input type="file" name="uploadFile">
									</c:otherwise>
								</c:choose>
							</span></td>
						</tr>
						<tr>
							<td class="name">비밀번호</td>
							<td class="value"><input type="password" name="pass" id="pass"></td>
						</tr>
						<tr>
							<td class="name">이름</td>
							<td class="value">${requestScope.map.membervo.name }</td>
						</tr>
						<tr>
							<td class="name">성별</td>
							<td class="value">${requestScope.map.membervo.gender }</td>
							<td></td>
						</tr>
						<tr>
							<td class="name">이메일</td>
							<td class="value"><input type="text" name="email" id="email"
								value="${requestScope.map.membervo.email }"></td>
							<td></td>
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
											<input type="checkbox" name="sbj" value="${sbjList.SUBJECT}"checked="checked">${sbjList.SUBJECT }
										</c:when>
										<c:otherwise>
											<input type="checkbox" name="sbj" value="${sbjList.SUBJECT}">${sbjList.SUBJECT }
										</c:otherwise>
									</c:choose>
									<c:if test="${num.count%3==0 }">
										<br>
									</c:if>
								</c:forEach></td>
								<td></td>
						</tr>
					</table>
				</form><br>
				<div id="button_wrap">
					<input style="font-size:12pt;" type="button" class="button_section" name="confirm_img" id="confirm_img" value="완료" >&nbsp
					<input style="font-size:12pt;" type="button" class="button_section"  type="button" name="cancel_img" id="cancel_img" value="취소">
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