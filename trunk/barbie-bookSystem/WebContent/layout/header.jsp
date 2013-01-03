<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
	$(function(){
		$("#loginImg").click(function(){
			$.ajax({
				type:"post",
				url:"member.do",
				data:"command=checkLogin&"+$("#login_form").serialize(),
				dataType:"json",
				success:function(data){
					if(data.flag==false){
						alert("로그인 실패");
						$("#memberId").val("");
						$("#pass").val("");
					}else{
						$("#login_form").submit();
					}
				}
			});
		});
		$("#joinImg").click(function(){
			location.href="member.do?command=insertView";
		});
		$("#logout").click(function(){
			location.href="member.do?command=logout";
		});
		$("#myLibrary").click(function(){

		});
		$("#myInfo").click(function(){
			location.href="member.do?command=info";
		});
	});
</script>
<style type="text/css">
#navCircle {
	margin-top: 50px;
	margin-left: auto;
	margin-right: auto;
	padding: 4px 10px 20px 10px;
}

#navCircle li {
	display: inline;
	list-style-type: none;
}
.wrapper {
            display: inline-block;
            padding: 6px 50px 6px 50px;
            margin: 10px;
            background: #F5F2FF;

            color: black;
            font-weight: bold;
            text-decoration: none;
            position: relative;
            box-shadow:
            1px 1px #98bf21,
            2px 2px #98bf21,
            3px 3px #98bf21;

            -webkit-transition: all 0.1s ease-in;
            -moz-transition: all 0.1s ease-in;
            -o-transition: all 0.1s ease-in;
            -ms-transition: all 0.1s ease-in;
            transition: all 0.1s ease-in;
            }

.wrapper:hover {
                    background: #cd1039;
                    color: white;
                   }

.wrapper:active {
                                box-shadow: none;
                                top: 3px;
                                left: 3px;
                              }
#login {
	position: absolute;
	margin-left: 970px;
	margin-top: 3px;
}
#login_imgs {
	position: absolute;
	margin-left: 1046px;
}
.button_section{
	display: inline-block;
	text-decoration: none;
	font-family: 'Trebuchet MS', malgun gothic,Arial, Helvetica, sans-serif;
	BACKGROUND-COLOR: white;
	/* border-bottom-color:#98bf21;
	border-bottom-color:#98bf21;
	border-color:#98bf21;*/
	color:#98bf21;
	margin-right:5px;
	margin-bottom:1px; /* 하단에 외부여백 1px */
	font:14spx Verdana; /* 폰트 속성 순서대로 크기 글꼴 */
}
.font_style{
	font-family:'Trebuchet MS', malgun gothic,Arial, Helvetica, sans-serif;
}
.file_section{
	padding-left: 20px;
}
</style>
<div id="">
<c:choose><c:when test="${sessionScope ==null or sessionScope.membervo == null }">
	<div id="login" >
		<form action="member.do" method="post" id="login_form" >
			<input type="hidden" name="command" value="login">
			<input type="text" id="memberId" name="memberId" size="10" style="height: 15px; width: 70px" placeholder="아이디"><br>
			<input type="password" id="pass" name="pass" size="10" style="height: 15px; width: 70px" placeholder="비밀번호"><br>
			<input type="submit" id="" name="" value=""  style="visibility:hidden">
		</form>
	</div>
	<div id="login_imgs">
		<input type="image" src="${initParam.root}/img/ui/layout/login.jpg" id="loginImg">
		<input type="image" src="${initParam.root}/img/ui/layout/join.jpg" id="joinImg">
	</div>
</c:when>
<c:otherwise>
	<div id="login">
		<p class="font_style">${sessionScope.membervo.name} 님</p><br>
	</div>
	<div id="login_imgs" align="left">
		<br><a href="#" class="button_section" id="logout" name="logout">로그아웃</a><br>
		<a href="#" class="button_section" id="myInfo" name="myInfo">내정보</a>
	</div>
</c:otherwise>
</c:choose>
</div>

	<c:choose><c:when test="${sessionScope.membervo.memberId !='java' }">
		<ul id="navCircle">
			<li><a href="book.do?command=getBookList&nowPage=1" class="wrapper">도서검색</a></li>
			<li><a href="book.do?command=recommandBook" class="wrapper">추천도서</a></li>
			<li><a href="book.do?command=getNewBookList&page=1" class="wrapper">신간도서</a></li>
			<li><a href="board.do?command=list&page=1" class="wrapper">자유게시판</a></li>
		</ul>
	</c:when>
	<c:otherwise>
		<ul id="navCircle">
			<li><a href="member.do?command=list" class="wrapper">회원관리</a></li>
			<li><a href="book.do?command=adminBook" class="wrapper">도서관리</a></li>
			<li><a href="board.do?command=list&page=1" class="wrapper">게시판관리</a></li>
		</ul>
	</c:otherwise>
	</c:choose>
