<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
	//<body onload()>와 같다. 즉 html문서가 전부 로딩된 상태
	$(document).ready(function(){
		var publisherNo=0;
		var subjectNo=0;
		$("input[name=publisher]").keyup(function() {
			var str = $(this).val();
		 	$.ajax({
				type:"GET",//전송 타입 POST or GET
				url:"book.do", //Servlet 명
				dataType:"json", //Dispatcher로 부터 받는 데이터 타입
				data:"command=getPblisherNo&publisher="+str,//Dispatcher로 보내는 데이터
				success:function(data){ //callback 함수
					if(data.publisherNo>0){
						$("#pResult").text(str +"의 코드"+data.publisherNo);
						publisherNo = data.publisherNo;
					}
				}//success
			});//ajax		 
		});//publisher keyup
		$("#p_input").click(function() {
			if(publisherNo>0){
				alert(publisherNo);
				$("input[name=publisherNo]").val(publisherNo);
				publisherNo =0;
				$("#pResult").text("");
			}else{
				alert("출판사를 정확히 입력하세요");
			}//if
		});//publisher button click
		
		$("input[name=subject]").keyup(function() {
			var str = $(this).val();
		 	$.ajax({
				type:"GET",//전송 타입 POST or GET
				url:"book.do", //Servlet 명
				dataType:"json", //Dispatcher로 부터 받는 데이터 타입
				data:"command=getSubjectNo&subject="+str,//Dispatcher로 보내는 데이터
				success:function(data){ //callback 함수
					if(data.subjectNo>0){
						$("#sResult").text(str +"의 코드"+data.subjectNo);
						subjectNo = data.subjectNo;
					}
				}//success
			});//ajax		 
		});//subject keyup
		$("#s_input").click(function() {
			if(subjectNo>0){
				alert(subjectNo);
				$("input[name=subjectNo]").val(subjectNo);
				subjectNo =0;
				$("#sResult").text("");
			}else{
				alert("도서 분류를 정확히 입력하세요");
			}//if
		});//subject button click
		$("#cancel").click(function() {
			history.back();			
		});//cancel button click
	})//ready
</script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.9.2/themes/base/jquery-ui.css" />
<script src="http://code.jquery.com/jquery-1.8.3.js"></script>    
<script src="http://code.jquery.com/ui/1.9.2/jquery-ui.js"></script>    
<link rel="stylesheet" href="/resources/demos/style.css" />    
<script>    
$(function() {        
	$("#datepicker").datepicker({
	  	dateFormat:"yy/mm/dd"
	}); //date picker 
});   
</script>
<br>
<center>
<form action="book.do" name="BookInsert">
<input type="hidden" name="command" value="updateBook">
<table width="700" border="0">
<tr>
<td>책제목:</td>
<td><input type="text" name="title" size="70" value="${requestScope.map.TITLE }"></td>
<td></td>
</tr>
<tr>
<td>저자명:</td>
<td><input type="text" name="writer" size="70" value="${requestScope.map.WRITER }"></td>
<td></td>
</tr>
<tr>
<td>출판사: </td>
<td><input type="text" name="publisherNo" size="70" value="${requestScope.map.PUBLISHER }" readonly="readonly"></td>
<td><input type="text" name="publisher" size="10" ><input type="button" id="p_input" value="입력"><br><span id="pResult"></span> </td>
<!-- Ajax으로 출판사 받아와서 넣기  -->
</tr>
<tr>
<td>분류:</td>
<td><input type="text" name="subjectNo" size="70"  value="${requestScope.map.SUBJECT }"></td>
<td><input type="text" name="subject" size="10" ><input type="button" id="s_input" value="입력"><br><span id="sResult"></span> </td> 
<!-- Ajax으로 분류번호 받아와서 넣기  -->
</tr>
<tr>
<td>ISBN:</td>
<td><input type="text" name="isbn" size="70" value="${requestScope.map.ISBN }" readonly="readonly"></td>
<td></td> 
</tr>
<tr>
<td>출간일:</td>
<td><p><input type="text" id="datepicker" name="outputDate"/></p></td>
</tr>
<tr>
<td>서고위치:</td>
<td><input type="text" name="loc" size="70" value="${requestScope.map.LOC }"></td>
<td></td> 
</tr>
<tr>
<td>내용:</td>
<td><textarea rows="10" cols="61" name="cont" >${requestScope.map.CONT }</textarea>

</td>
<td></td> 
</tr>
</table>
</center>
<input type="submit" value="수정하기"> <input type="button" id="cancel" value="취소하기">
</form>
