<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="${initParam.root }/css/board-table.css" />
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
	$(function() {
		$("#update_btn")
				.click(
						function() {
							location.href = "member.do?command=updateView&memberId=${sessionScope.membervo.memberId}";
						});
		$("#index_btn").click(function() {
			location.href = "book.do?command=getBookList&nowPage=1";
		});
		$("#drop_btn").click(function(){
			window.open("member.do?command=viewDrop","회원탈퇴","width=350,height=200,toolbar=no,status=no,location=no");
		})
	});
</script>

<br><div class="font_style">회원 정보</div><br><br>
<c:choose>
	<c:when test="${sessionScope.membervo != null }">
		<form action="member.do" method="post" id="info_form" name="info_form">
			<input type="hidden" name="command" value="updateView">
			<table class="insert_table" border="0" cellspacing="0">
				<tr>
					<td class="name" width="100px">아이디</td>
					<td class="value">${sessionScope.membervo.memberId }</td>
					<td class="file_section" rowspan="3" width="200px"><c:choose>
						<c:when test="${sessionScope.membervo.mImg !=null }">
							<img src="${initParam.root }/upload/member/${sessionScope.membervo.mImg}">
						</c:when>
						<c:otherwise>회원의 사진은 없습니다.</c:otherwise>
					</c:choose>
					</td>
				</tr>
				<tr>
					<td class="name">비밀번호</td>
					<td class="value">${sessionScope.membervo.pass }</td>
				</tr>
				<tr>
					<td class="name">이름</td>
					<td class="value">${sessionScope.membervo.name }</td>
				</tr>
				<tr>
					<td class="name">이메일</td>
					<td class="value" colspan="2">${sessionScope.membervo.email }</td>
				</tr>
				<tr>
					<td class="name">관심사항</td>
					<td class="value" id="lastValue" colspan="2">
						${sessionScope.membervo.subject1 }&nbsp&nbsp
						${sessionScope.membervo.subject2 }&nbsp&nbsp
						${sessionScope.membervo.subject3 }</td>
				</tr>
			</table><br>
			<span >
				<input style="font-size:12pt;" type="button" class="button_section" name="index_btn" id="index_btn" value="처음" >
				<input style="font-size:12pt;" type="button" class="button_section"  type="button" name="update_btn" id="update_btn"	value="수정">
				<input style="font-size:12pt;" type="button" class="button_section"  type="button" name="drop_btn" id="drop_btn"	value="탈퇴">
			</span>
		</form>
	</c:when>
	<c:otherwise>
		<script type="text/javascript">
			alert("로그인 하셔야 됩니다.");
			location.href=document.referrer;
		</script>
	</c:otherwise>
</c:choose>