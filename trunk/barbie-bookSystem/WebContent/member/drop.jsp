<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="${initParam.root }/css/board-table.css" />
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$("#check_btn").click(function(){
			var pass = $("#password");
			$.ajax({
				type:"POST",
				url:"member.do",
				data:"command=checkMemberForDrop&password="+pass.val(),
				success:function(data){
					if(data.state=="탈퇴"){
						alert("탈퇴 성공");
						opener.document.location.href="book.do?command=getBookList&nowPage=1";
						self.close();
					}else if(data.state=="없음"){
						alert("비밀 번호가 틀렸습니다.");
						pass.val("").focus();
					}else if(data.state=="둘다"){
						alert("예약도서와 대여도서가 있어서 탈퇴 불가능 합니다. 관리자에게 문의하시길 바랍니다.");
						opener.window.location.reload();
						self.close();
					}else if(data.state=="예약"){
						alert("예약된 도서가 있어서 탈퇴가 불가능 합니다. 관리자에게 문의하시길 바랍니다.");
						opener.window.location.reload();
						self.close();
					}else if(data.state=="대여"){
						alert("대여중인 도서가 있어서 탈퇴가 불가능 합니다. 관리자에게 문의하시길 바랍니다.");
						opener.window.location.reload();
						self.close();
					}
				}
			});	//ajax
		});	//click
		$("#cancel_btn").click(function(){
			opener.window.location.reload();
			self.close();
		})
	});
</script><br>
<div class="font_style">비밀번호 <input type="text" name="password" id="password">
	<input style="padding-left:5px;"  type="button" class="button_section" id="check_btn" value="확인">
	<input type="button" class="button_section" id="cancel_btn" value="취소">
</div>