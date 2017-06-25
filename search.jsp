<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="checkvalid.jsp" %>
<%@page import="java.util.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.ResultSetMetaData"%>

<%

	response.setCharacterEncoding("UTF-8");
	request.setCharacterEncoding("UTF-8");
	
	String path = request.getContextPath();
		String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	
	/** 链接数据库参数 **/
	String driverName = "com.mysql.jdbc.Driver"; //驱动名称
	String DBUser = "chat"; //mysql用户名
	String DBPasswd = "dev.ethyl.cc-chat-database-user"; //mysql密码
	String DBName = "chat"; //数据库名
	String MySQLServer = "localhost"; //MySQL地址
	String MySQLServerPort = "3306"; //MySQL端口号（默认为3306）

	//数据库完整链接地址
	String connUrl = "jdbc:mysql://"+MySQLServer+":"+MySQLServerPort+"/" + DBName + "?user="
		+ DBUser + "&password=" + DBPasswd ;

	//加载数据库驱动
	Class.forName(driverName).newInstance();

	//链接数据库并保存到 conn 变量中
	Connection conn = DriverManager.getConnection(connUrl);

	//申明～？
	Statement stmt = conn.createStatement();

	//要执行的 sql 查询
	
	String userID=(String)session.getAttribute("userID");
	
	String searchName=(String)request.getParameter("searchName");
	System.out.println(searchName);
	String sql=null;
	
%>

<!DOCTYPE html>
<html>
<head>
	<title>Search page</title>
	<meta http-equiv="content-Type" content="text/html;charset=UTF-8"> 
	
	<SCRIPT type="text/javascript">
		function addFriend(userID){
			if (userID!=""){
				var xmlhttp = new XMLHttpRequest();
				if (xmlhttp!=null){
					xmlhttp.onreadystatechange=function(){
						if (xmlhttp.readyState==4 && xmlhttp.status==200){
							//window.location.href="search.jsp?searchName=<%out.print(searchName);%>";
							var s=document.getElementById(userID);
							s.innerHTML="已添加";
						}
					}
					xmlhttp.open("GET","add.jsp?friendID="+userID,true);
					xmlhttp.send();
				}
			}else{
				alert("请输入内容！");
			}
		}
	</SCRIPT>
</head>

<body  align="center" style="width:700" bgcolor="papayawhip">
	<div align="center">
	<table>
	<tr>
	<td style="width:400">Hi, <a href="main.jsp"><%
	sql= "SELECT * FROM `account` where user_id = '" + userID + "' LIMIT 15";
	System.out.println(sql);

	//取得结果
	ResultSet rs = stmt.executeQuery(sql);
	if (rs.next()){
		out.println(rs.getString("user_name"));
	}%></a>
	</td>
	<td style="width:300">
	<form action="search.jsp" method="post">
		<input type="text" name="searchName" maxlength="20" style="width:120"/>
		<input type="submit" value="查找好友" />
		<input type="button" value="退出登录" onclick="location.href='logout.jsp'" />
	</form>
	</td>
	</tr>
	</table>
	</div>
	<hr  style="width:700" />
	<%
	if (searchName!=null){
		
		sql = "SELECT * FROM `account` "
			+ "where user_name like '%" + searchName + "%' "
			+ "and user_id !='" + userID + "' "
			+ "and user_id not in ( "
			+ "select friend_id from `friends` where user_id = '" + userID + "'"
			+ ") and user_id not in ( "
			+ "select user_id from `friends` where friend_id = '" + userID + "');";
		
		//取得结果
		System.out.println(sql);
		rs = stmt.executeQuery(sql);
		while (rs.next()){
		%>
		<div align="center" style="width:700" >
		<li>
		<a href="view.jsp?userID=<%out.print(rs.getString("user_id"));%>"><%out.print(rs.getString("user_id"));%></a> <%out.print(rs.getString("sex"));%> <%out.print(rs.getString("birth_year"));%>年<%out.print(rs.getString("birth_month"));%>月
		
		<span id="<%out.print(rs.getString("user_id"));%>"><input type="button" value="加为好友" onclick="addFriend('<%out.print(rs.getString("user_id"));%>')" /></span>
		
		</li>
		</div>
		<%
		}
	}
	%>
</body>
</html>
<%

		/** 关闭连接 **/
		conn.close();
		stmt.close();
		rs.close();
%>