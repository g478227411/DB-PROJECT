<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="checkvalid.jsp" %>
<%@page import="java.util.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.ResultSetMetaData"%>

<%

	response.setCharacterEncoding("UTF-8");
	request.setCharacterEncoding("UTF-8");
	String userID=(String)session.getAttribute("userID");
	String targetID=(String)request.getParameter("userID");
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

	//申明～？
	Statement stmt2 = conn.createStatement();

	//要执行的 sql 查询
	String sql;


%>
<html>
<head>
	<title>~WELCOME TO MY HOMEPAGE~</title>
	<meta http-equiv="content-Type" content="text/html;charset=UTF-8">
	<style>
		.comment{
			border-style: dashed;
			border-width: 1px 0px 0px 0px;
			border-color: "#202020";
		}
	</style>
	<link rel="stylesheet" href="chatbox.css" media="screen" >
		<link href="playground.css" media="all" rel="stylesheet" type="text/css" />
	<link href="blingbling.css" media="all" rel="stylesheet" type="text/css" />
	<link href="css/style.css" rel='stylesheet' type='text/css' />
</head>
<body  >
	<%

	ResultSet rs =null;
	String head_id=null;
	%>
	<div class="header">
			<div class="header left">
				<%
				sql= "SELECT * FROM `account` where user_id = '" + targetID + "' LIMIT 15";
				System.out.println(sql);

				//取得结果
				String targetName=null;
				String targethead=null;
				rs = stmt.executeQuery(sql);
				if (rs.next()){
					targethead=rs.getString("avatar_index");
					targetName=rs.getString("user_name");
					%>

<img src="heads/<% out.print(targethead);%>.jpg" class="head" alt="none" >
<p class="exr">我的名字是<%out.print(targetName+" ");%>~</p>
<p class="exr">我的性别是：<%out.print(rs.getString("sex")+" ");%></p>
<p class="exr">我出生在<%out.print(rs.getString("birth_year")+"年");%>
<%out.print(rs.getString("birth_month")+"月");
}%></p>
			</div>
				<div class="header center">

						<form action="search.jsp" method="post" id="desktop-header-search">
							<input type="text" name="searchName" maxlength="20">
							<input type="submit" value="查找好友">
						</form>
					</div>
						<div class="header right">
						<input type="button"  value="退出登录" onclick="location.href='logout.jsp'" id="desktop-header-logout">

				</div>
				</div>

				<div id="nav" >
					<%
					sql= "SELECT * FROM `account` where user_id = '"+userID+"' LIMIT 1";
					System.out.println(sql);

					ResultSet rs1 = stmt.executeQuery(sql);
					if (rs1.next()){
						head_id=rs1.getString("avatar_index");
						%>
						<img src="heads/<% out.print(head_id);%>.jpg" class="head" alt="none" >
						<%
						out.println(rs1.getString("user_name"));
					}%>
						<div class="wall-of-buttons">
			       <P><a class="large blue button">我的关注</a></P>
			       <P><a class="large green button">我的粉丝</a></P>
						 <br>
			</div>
				</div>
				<div id="section">
				<div class="h1" >我的粉丝</div>
					<%
					sql= "SELECT * FROM `account` where user_id in("
						+	"SELECT user_id FROM `friends`  "
						+	"where friend_id = '"+ userID + "') ";
					System.out.println(sql);
					//取得结果
					rs = stmt.executeQuery(sql);
					while (rs.next()){
					%>
					<div class="linear">
					<div class="clear"></div>
						<div class="msg-list">
				  			 <div id="lphoto">
								<a href="view.jsp?userID=<%out.print(rs.getString("user_id"));%>">
								<img src="heads/<% out.print(rs.getString("avatar_index"));%>.jpg" class="head" alt="none">
				 				<p class="exl"><%out.print(rs.getString("user_name"));%></p>
								</a>
				  			</div>
				  		</div>
				<!--/table-->
					</div>
					<%
					}
					%>
				</div>
</body>
</html>
<%

		/** 关闭连接 **/
		conn.close();
		stmt.close();
		rs.close();
%>
