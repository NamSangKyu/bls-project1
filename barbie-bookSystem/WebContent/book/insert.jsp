<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		var publisherNo=0;
		var subjectNo=0;
			
		$("#commit").click(function() {
			//alert("버튼클릭");
			var str = $("#insert").serialize();
			alert(str);
			$("form").submit();
			 /* $.ajax({
				type:"POST",
				url:"book.do",
				data:str,
				dataType:"json",
				success:function(data){
				}//success
		});//ajax */ 
		});//button click
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
		$("input[name=subject]").keyup(function() {
			var str = $(this).val();
			//alert(str);
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
		$("#p_input").click(function() {
			if(publisherNo>0){
				//alert(publisherNo);
				$("input[name=publisherNo]").val(publisherNo);
				publisherNo =0;
				$("#pResult").text("");
			}else{
				alert("출판사를 정확히 입력하세요");
			}//if
		});//publisher button click
		
	})
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

<form action="book.do" id="insert" name="insert" enctype="multipart/form-data" method="post">
<input type="hidden" name="command" value="insert"> 
<table>
<tr>
<td>책제목:</td>
<td><input type="text" name="title" size="70"></td>
</tr>
<tr>
<td>저자명:</td>
<td><input type="text" name="writer" size="70"></td>
</tr>
<tr>
<td>출판사:</td>
<td><input type="text" name="publisherNo" size="70"></td>
<!-- Ajax으로 출판사 받아와서 넣기  -->
<td><input type="text" name="publisher" size="10" ><input type="button" id="p_input" value="입력"><br><span id="pResult"></span> </td>
</tr>
<tr>
<td>분류번호:</td>
<td><input type="text" name="subjectNo" size="70"></td> 
<!-- Ajax으로 분류번호 받아와서 넣기  -->
<td><input type="text" name="subject" size="10" ><input type="button" id="s_input" value="입력"><br><span id="sResult"></span> </td>
</tr>
<tr>
<td>ISBN:</td>
<td><input type="text" name="isbn" size="70"></td>
</tr>
<tr>
<td>서고위치:</td>
<td><input type="text" name="loc" size="70"></td>
</tr>
<tr>
<td>책사진:</td>
<td><input type="file" name="file" ></td>
</tr>
<tr>
<td>출간일:</td>
<td><p><input type="text" id="datepicker" name="outputDate"/></p></td>
</tr>

<tr>
<td>내용:</td>
<td><textarea rows="10" cols="70" name="cont"></textarea>
</td>
</tr>
</table>
</form>
<input type="button" id="commit" value="입력하기"> <input type="button" id="cancel" value="취소하기"> 
