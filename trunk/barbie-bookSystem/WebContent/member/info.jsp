<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
       <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
          <script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
	$(function(){
		$("#update_btn").click(function(){
			location.href="member.do?command=updateView&memberId=${sessionScope.membervo.memberId}";
		});
		$("#list_img").click(function(){
			location.href="member.do?command=list";
		});
		$("#index_btn").click(function(){
			location.href="index1.jsp";
		});
	});
</script>
<link rel="stylesheet" href="${initParam.root }/css/member.css"/>

<div class="title">회원 정보</div>
<form action="member.do" method="post" id="info_form">
	<input type="hidden" name="command" value="updateView">
	${initParam.filePath }${sessionScope.membervo.newfilename}
	<table class="insert_table"  border="0"  cellspacing="0">
		<tr>
			<td class="name">아이디</td>
			<td class="value">${sessionScope.membervo.memberId }</td>
			<td class="file" rowspan="3">
				<c:choose>
					<c:when test="${sessionScope.membervo.newfilename !=null }"><img width="150"  src="${initParam.root }/upload/member/${sessionScope.membervo.newfilename}"></td></c:when>
					<c:otherwise>회원의 사진은 없습니다.</c:otherwise>
				</c:choose>
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
			<td class="value" id="lastValue" colspan="2">	${sessionScope.membervo.subject1 }&nbsp&nbsp
					${sessionScope.membervo.subject2 }&nbsp&nbsp
					${sessionScope.membervo.subject3 }
			</td>
		</tr>
	</table>
			<input type="button" name="index_btn" id="index_btn" value="처음으로">
			<input type="button" name="update_btn" id="update_btn" value="회원정보수정">
			<c:if test="${sessionScope.membervo.memberId=='java' }">
				<img src="${initParam.root }/img/board/list_btn.jpg">
				<input type="button" name="list_btn" id="list_img" value="전체회원보기">
			</c:if>
</form>