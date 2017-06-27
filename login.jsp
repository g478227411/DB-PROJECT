<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
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
<html>

<head>
	<meta charset=utf-8>
	<title>系统登录</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="css/style.css" rel='stylesheet' type='text/css' />
	<style type="text/css">
		.style1 {
			font-size: 18px;
			font-weight: bold;
		}
		.style2 {
			font-size: 24px;
		}
		.style5 {
			font-size: 16px;
		}
	</style>
</head>

<body>
	<div class="login-form">
		<div class="avtar">
		<img src="images/welcome3_1.jpg" /></div>
	<form action="loginResponse.jsp" method="post">
		<input name="userID" type="text" class="text" value="UserID" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'UserID';}" >
		<!--<div class="key">
			<input type="password" value='' onfocus="this.value = '';" onblur="if (this.value == '') {this.value = '';}">
		</div>-->
		<input name="passwd" type="password" class="text" value='' onfocus="this.value = '';" onblur="if (this.value == '') {this.value = '';}">


	<div class="col-sm-6">
		<input type="submit" value="登陆" > &nbsp;&nbsp;</div>
	<div class="col-sm-6">
		<input type="button" value="注册" onclick="location.href='register.jsp'" /> </div>
		</form>
</div>
</body>

</html>
