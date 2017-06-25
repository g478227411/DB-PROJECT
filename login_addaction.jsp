<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@page import="java.util.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.ResultSetMetaData"%>

<%

	response.setCharacterEncoding("UTF-8");
	request.setCharacterEncoding("UTF-8");
	if(session.getAttribute("login")!=null && session.getAttribute("login").equals("ok")){
		String content=0+";URL="+"main.jsp";
		response.setHeader("REFRESH",content);
	}
%>


<!DOCTYPE html>
<!--本机版本的-->
<html>
<head>
	<title>Login</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta charset="utf-8">
	<link href="css/style.css" rel='stylesheet' type='text/css' />
	<link rel="stylesheet" href="css/bootstrap.min.css">
<script src = "js/jquery.3.2.1.min.js"></script>
<script src="js/bootstap.min.js"></script>
</head>
<body>

<div class="login-form">
<!--	<div class="close"> </div>
	<div class="head-info">
		<label class="lbl-1"> </label>
		<label class="lbl-2"> </label>
		<label class="lbl-3"> </label>
	</div>-->
	<div class="clear"> </div>
	<div class="avtar">
		<img src="images/welcome3_1.jpg" /></div>
	<form action="loginResponse.jsp" method="post">
		<input type="text" class="text" value="UserID" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'UserID';}" >
		<!--<div class="key">
			<input type="password" value='' onfocus="this.value = '';" onblur="if (this.value == '') {this.value = '';}">
		</div>-->
		<input type="password" value='' onfocus="this.value = '';" onblur="if (this.value == '') {this.value = '';}">

		<div class="signin col-sm-6">
			<input type="submit" value="登陆" >&nbsp;&nbsp;
		</div>
		<div class="signin col-sm-6">
			<input type="submit" value="注册" onclick="location.href='register.jsp'"> </div>

	</form>

</div>

</body>
</html>>
