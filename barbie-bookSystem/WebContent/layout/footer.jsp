<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style> 
#home{
	position: absolute;
	margin-left: 100px;
	margin-top: 10px;
}
#foot{
position: absolute;
	margin-left: 250px;
	margin-top: 10px;
}
    </style>
<div id="foot"><img src="${initParam.root}/img/ui/layout/foot.jpg" ></div>
<div id="home"><a href="member.do?command=home&memberId=${sessionScope.membervo.memberId }&pass=${sessionScope.membervo.pass }"><input type="image" src="${initParam.root}/img/ui/layout/home.jpg" id="loginImg"></a></div>