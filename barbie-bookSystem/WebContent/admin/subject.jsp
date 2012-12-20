<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		var list = null;
		$.ajax({
			type:"GET",//전송 타입 POST or GET
			url:"book.do", //Servlet 명
			dataType:"json", //Dispatcher로 부터 받는 데이터 타입
			data:"command=getSubjectList",//Dispatcher로 보내는 데이터
			success:function(data){ //callback 함수
				var subject = "";
				list = data.list;
				for(i=0;i<data.list.length;i++){
					subject += "<option>"+data.list[i].subject+"</option>";
				}
					$("#subject").html(subject);	
			}//success
		});//ajax
			$("#insert").click(function() {
				var flag = false;
				for(i=0;i<list.length;i++){
					if(list[i].subject==$("input[name=subject]").val()){
						alert("이미 도서분류가 등록되 있습니다.");
						break;
					}else if($("input[name=subject]").val() == ""){
						alert("도서분류를 입력하세요");
						break;
					}
					else{
						flag = true;
					}
				}
				if(flag==true){
				alert($("input[name=subject]").val());
				$.ajax({
					type:"GET",//전송 타입 POST or GET
					url:"../book.do", //Servlet 명
					dataType:"json", //Dispatcher로 부터 받는 데이터 타입
					data:"command=insertSubject&subject="+$("input[name=subject]").val(),//Dispatcher로 보내는 데이터
					success:function(data){ //callback 함수
						var subject = "";
						$("#subject").html(subject);
						list = data.list;
						for(i=0;i<data.list.length;i++){
							subject += "<option>"+data.list[i].subject+"</option>";
						}
							$("#subject").html(subject);	
					}//success
			});
				}
			});
			
	});
</script>

<h3>도서분류 삽입 페이지</h3>
<table align="center">
<tr align="center">
<td><input type="text" name="subject"></td>
<td><input type="button" id="insert" value="도서분류 삽입"></td>
</tr>
<tr align="center">
<td colspan="2">
	<select id="subject" multiple="multiple" size="10" width="30" disabled="disabled"></select>
</td>
</tr>
</table>
