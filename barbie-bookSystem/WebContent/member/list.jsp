<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
          <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
리스트 화면
<%-- <center>
<table border="1">
	<thead>
		<tr>
			<td>아이디</td><td>이름</td><td>성별</td><td colspan="3">관심사항</td>
		</tr>
	</thead>
	<tbody id ="tbody">
		<c:forEach items="${requestScope.listvo.list }" var="list">
			<tr>
				<td>${list.memberId }</td><td>${list.name }</td><td>${list.gender }</td>
				<td>${list.subject1}</td><td>${list.subject2}</td><td>${list.subject3}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<c:if test="${requestScope.listvo.pb.previousPage }">
<a href="member.do?command=list&nowPage=${requestScope.listvo.pb.startNumOfPageGroup -1}">좌</a></c:if>
<c:forEach begin="${requestScope.listvo.pb.startNumOfPageGroup }" end="${requestScope.listvo.pb.endNumOfPageGroup }" var="list">
			<c:if test="${list == requestScope.listvo.pb.nowPage }">${ list}</c:if>
			<a href="member.do?command=list&nowPage=${list }">${ list}</a>
</c:forEach>
<c:if test="${requestScope.listvo.pb.nextPage }">
	<a href="member.do?command=list&nowPage=${requestScope.listvo.pb.endNumOfPageGroup +1}">우</a></c:if>
</center> --%>