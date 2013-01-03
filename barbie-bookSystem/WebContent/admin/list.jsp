<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${initParam.root }/css/board-table.css" />
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
	$(function(){
		$("#search_img").click(function(){
			alert($("#condition").val());
		});
	});
</script>
<br><div class="font_style">회원 리스트</div><br><br>
<input type="hidden" name="isSearch" value="false">
<table class="board_table" cellspacing="0">
	<thead>
		<tr>
			<td class="board_header">아이디</td><td class="board_header">이름</td><td class="board_header">성별</td><td class="board_header" colspan="3">관심사항</td>
		</tr>
	</thead>
	<tbody id ="tbody">
		<c:forEach items="${requestScope.listvo.list }" var="list">
			<tr>
				<td class="board_body" width="100px"><a href="member.do?command=memberInfo&memberId=${list.memberId }&nowPage=${requestScope.listvo.bean.nowPage}&isSearch=#isSearch.val()">${list.memberId }</a></td>
				<td class="board_body" width="120px">${list.name }</td><td class="board_body" width="120px">${list.gender }</td>
				<td class="board_body">${list.subject1}</td><td class="board_body">${list.subject2}</td><td class="board_body">${list.subject3}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<div id="paging" style ="padding: 10px" >
<!-- 전 페이지 그룹으로  -->
<c:if test="${requestScope.listvo.bean.previousPageGroup }">
	<a  href="member.do?command=list&nowPage=${requestScope.listvo.bean.startPageOfPageGroup -1}" class="font_style">이전</a></c:if>

<!-- 페이지 그룹 숫자 -->
<c:forEach begin="${requestScope.listvo.bean.startPageOfPageGroup }" end="${requestScope.listvo.bean.endPageOfPageGroup }" var="list">
	<c:choose>
		<c:when test="${list == requestScope.listvo.bean.nowPage }">${list}	</c:when>
		<c:otherwise>
			<a   href="member.do?command=list&nowPage=${list }">${ list}</a>
		</c:otherwise>
	</c:choose>
</c:forEach>

<!-- 다음 페이지 그룹으로 -->
<c:if test="${requestScope.listvo.bean.nextPageGroup }">
	<a href="member.do?command=list&nowPage=${requestScope.listvo.bean.endPageOfPageGroup +1}" class="font_style">다음</a></c:if>
</div><br>

<div id="search_wrap">
	<select id="condition" name="condition">
		<option value="">--선택--</option>
		<option value="by_all">전체</option>
		<option value="by_subject">관심분야</option>
		<option value="by_name">이름</option>
	</select>
	<input type="text" maxlength="10" id="search_text">
	<input style="font-size:12pt;" class="button_section" type="button" id="search_img" value="검색">
</div>


















