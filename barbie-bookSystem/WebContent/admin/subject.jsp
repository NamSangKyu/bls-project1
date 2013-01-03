<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<link rel="stylesheet" href="${initParam.root}/css/book-table.css">
<script type="text/javascript">
	$(document).ready(function() {
		var list = null;
	
		$("#resultSubject").on("click","input[type=button]",function() {
			//alert($(this).attr("id"));
			var id = $(this).attr("id");
			if(confirm("도서 코드"+ id +"를 삭제하시겠습니까?")){
				$.ajax({
					type:"GET",//전송 타입 POST or GET
					url:"book.do", //Servlet 명
					dataType:"json", //Dispatcher로 부터 받는 데이터 타입
					data:"command=deleteSubjectAdmin&subjectNo="+id,//Dispatcher로 보내는 데이터
					success:function(data){ //callback 함수
						alert(data.result);
						$("#resultSubject").html("");	
					}//success
				});//ajax
			}
		});//button
			$("input[name=subject]").keyup(function() {
				var inputSubject = $(this).val();
				$.ajax({
					type:"GET",//전송 타입 POST or GET
					url:"book.do", //Servlet 명
					dataType:"json", //Dispatcher로 부터 받는 데이터 타입
					data:"command=getSubjectAdmin&subject="+inputSubject,//Dispatcher로 보내는 데이터
					success:function(data){ //callback 함수
						var subject = "";
						$("#resultSubject").html(subject);
						list = data.list;
						for(i=0;i<data.list.length;i++){
							subject += "<tr><td>"+data.list[i].subjectNo+"</td><td>"+data.list[i].subject+"</td><td><input type='button' value='삭제' id='"+data.list[i].subjectNo+"'></td></tr>";
						}
							$("#resultSubject").html(subject);	
					}//success
			});
			});//keyup
			$("#insert").click(function() {
				var flag = false;
				
				$.ajax({
					type:"GET",//전송 타입 POST or GET
					url:"book.do", //Servlet 명
					dataType:"json", //Dispatcher로 부터 받는 데이터 타입
					data:"command=insertSubject&subject="+$("input[name=subject]").val(),//Dispatcher로 보내는 데이터
					success:function(data){ //callback 함수
						alert(data.result);
						$("#resultSubject").html("");	
					}//success
			});
			});
			
	});
</script>

<h3>도서분류 삽입 페이지</h3>
<a href="book.do?command=publisher">출판사 등록</a> &nbsp;
<a href="book.do?command=subject">분류 등록</a>&nbsp;
<a href="book.do?command=bookInsert">책등록</a>&nbsp;
<a href="book.do?command=getBookAllList">도서 삭제/수정</a>
<table align="center">
<tr align="center">
<td><input type="text" name="subject"></td>
<td><input type="button" id="insert" value="도서분류 삽입"></td>
</tr>
<tr align="center">
<td colspan="2">
	<table border="0">
		<tr align="center">
		<th>코드</th><th>도서분류</th><th>옵션</th>
		</tr>
		<tbody id="resultSubject" align="center">
			
		</tbody>
		<tfoot align="center">
			<tr>
				<td colspan="3">분류명 입력시 자동으로 <br>해당 분류 전부 출력됨</td>
			</tr>
		</tfoot>
	</table>
</td>
</tr>
</table>
