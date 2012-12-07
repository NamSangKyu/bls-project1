<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="tiles"  uri="http://tiles.apache.org/tags-tiles"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
/*
css로 페이지 레이아웃을 구성
*/
#container{
	width: 950px;
	border: 1px solid black;
	margin-left: auto; 
	margin-right: auto;
}
#header{
	padding: 5px;
	height:50px;
	border-bottom: 1px solid black;
}

#main{
	padding: 5px;
	height:600px;
	width:650px;
	
}
#footer{
	padding-top: 5px;
	height:70px;
	border-top: 1px solid black;
	clear: both;
}
</style>
</head>
<body>
<div id="container">
	<div id="header"><tiles:insertAttribute name="header"/></div>
	<div id="main"><tiles:insertAttribute name="main"/></div>
	<div id="footer"><tiles:insertAttribute name="footer"/></div>
</div>
</body>
</html>