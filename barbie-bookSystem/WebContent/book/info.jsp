<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<table border="1" height="600">
<tr height="40">
<td>도서명</td>
<td width="350" >${requestScope.map.TITLE }</td>
<td rowspan="5" align="center"><img src="${initParam.root }/upload/${requestScope.map.IMG }" width="150" height="200"></td>
</tr>

<tr height="40">
<td>저자명</td>
<td>${requestScope.map.WRITER }</td>
</tr>

<tr height="40">
<td>출판사</td>
<td>${requestScope.map.PUBLISHER }</td>
</tr>

<tr height="40">
<td>분류</td>
<td>${requestScope.map.SUBJECT }</td>
</tr>

<tr height="40">
<td>위치</td>
<td>${requestScope.map.LOC }</td>
</tr>


<tr height="100">
<td>내용</td>
<td colspan="2">
<textarea rows="15" cols="70" readonly="readonly">${requestScope.map.CONT }</textarea>
</td>

</tr>
<tr>
<td>답글</td>
<td colspan="2">
답글 들어가는 부분
</td>

</tr>

</table>
