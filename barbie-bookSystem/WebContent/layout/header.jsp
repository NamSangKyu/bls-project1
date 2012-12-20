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
	margin-left: 950px;
	margin-top: 5px;
}

#login_imgs {
	position: absolute;
	margin-left: 1046px;
}
</style>
<div id="">
<c:choose><c:when test="${sessionScope ==null or sessionScope.membervo == null }">
	<div id="login">
		<form action="member.do" method="post" id="login_form" >
			<input type="hidden" name="command" value="login">
			<input type="text" id="memberId" name="memberId" size="10" style="height: 15px; width: 70px" placeholder="아이디"><br>
			<input type="password" id="pass" name="pass" size="10" style="height: 15px; width: 70px" placeholder="비밀번호">
		</form>
	</div>
	<div id="login_imgs">
		<input type="image" src="${initParam.root}/img/ui/layout/login.jpg" id="loginImg">
		<input type="image" src="${initParam.root}/img/ui/layout/join.jpg" id="joinImg">
	</div>
</c:when>
<c:otherwise>
	<div id="login">
		${sessionScope.membervo.name} 님<br>
		 환영합니다.
	</div>
	<div id="login_imgs">
		<input type="button" name="logout" id="logout" value="로그아웃"><br>
		<input type='button' name='myLibrary' id='myLibrary' value='내 서고'><br>
		<input type='button' name='myInfo' id='myInfo' value='내 정보'>
	</div>
</c:otherwise>
</c:choose>
</div>

	<c:choose><c:when test="${sessionScope.membervo.memberId !='java' }">
		<ul id="navCircle">
			<li><a href="book.do?command=getBookAllList" class="wrapper">도서검색</a></li>
			<li><a href="book.do?command=recommandBook" class="wrapper">추천도서</a></li>
			<li><a href="#" class="wrapper">신간도서</a></li>
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
