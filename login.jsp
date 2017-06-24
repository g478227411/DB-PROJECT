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
<html>

<head>
	<meta charset=utf-8>
	<title>系统登录33</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<meta name="viewport" content="width=device-width, initial-scale=1">
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

<body bgcolor="papayawhip" width="300" height="300">
	<center>
		<div align="center" class="style1 style2">系 统 登 录
		</div>
		<form action="loginResponse.jsp" method="post">
			<table border="2" bordercolor="black" bgcolor="">
				<tbody>
					<tr>
						<td height="28">
							<span class="style5">用户名</span>
							<input type="text" name="userID" maxlength="20" style="width:150">
						</td>
					</tr>
					<tr>
						<td>
							<span class="style5">密码</span>
							<input type="password" name="passwd" maxlength="20" style="width:150">
						</td>
					</tr>
				</tbody>
			</table>
			<div align="center">
				<input type="submit" value="登录" />&nbsp;&nbsp;
				<input type="button" value="注册" onclick="location.href='register.jsp'" />
			</div>
		</form>
	</center>
</body>

</html>
