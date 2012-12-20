<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="${initParam.root}/login.js">
</script>
<style type="text/css">
#navCircle {
	margin-top: 60px;
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
            padding: 0 50px 6px 50px;
            margin: 10px;
            background: #08C;

            color: white;
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
                    background: #cd1039
                   }

.wrapper:active {
                                box-shadow: none;
                                top: 3px;
                                left: 3px;
                              }


#login {
	position: absolute;
	margin-left: 970px;
	margin-top: 5px;
}

#login_form {
	position: absolute;
	margin-left: 1046px;
}
</style>
<div id="login">
	<input type="text" id="memberId" name="memberId" size="10" style="height: 15px; width: 70px" placeholder="아이디"><br>
	<input type="password" id="pass" name="pass" size="10" style="height: 15px; width: 70px" placeholder="비밀번호">
</div>
<div id="login_form">
	<input type="image" src="${initParam.root}/img/ui/layout/login.jpg" id="loginImg">
	<input type="image" src="${initParam.root}/img/ui/layout/join.jpg" id="joinImg">
</div>
	<ul id="navCircle">
		<li><a href="book.do?command=getBookAllList" class="wrapper">도서검색</a></li>
		<li><a href="member.do?command=insertView" class="wrapper">추천도서</a></li>
		<li><a href="#" class="wrapper">신간도서</a></li>
		<li><a href="board.do?command=list&page=1" class="wrapper">자유게시판</a></li>
	</ul>
