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
	width: 1200px;
	margin-left: auto; 
	margin-right: auto;
}
#header{
	padding: 5px;
	height:100px;
	border-bottom: 1px solid #708491;
}

#main{
	width: 1200px;
	padding: 5px;
	height:600px;
	margin-left: auto; 
	margin-right: auto;
}
#footer{
	padding: 5px;
	height:70px;
	margin-left: auto; 
	margin-right: auto;
	border-top: 1px solid #708491;
}
</style>
</head>
<body>
<div id="container">
	<center><div id="header"><tiles:insertAttribute name="header"/></div></center>
	<center><div id="main"><tiles:insertAttribute name="main"/></div></center>
	<center><div id="footer"><tiles:insertAttribute name="footer"/></div></center>
</div>
</body>
</html>