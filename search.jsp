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
		<link rel="stylesheet" href="chatbox.css" media="screen" >
			<link href="playground.css" media="all" rel="stylesheet" type="text/css" />
		<link href="blingbling.css" media="all" rel="stylesheet" type="text/css" />
		<link href="css/style.css" rel='stylesheet' type='text/css' />
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

<body >
	<%

	ResultSet rs =null;
	String head_id=null;
	%>


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
	<form action="search.jsp" method="post">
		<input type="text" name="searchName" maxlength="20" style="width:120"/>
		<input type="submit" value="查找好友" />
		<input type="button" value="退出登录" onclick="location.href='logout.jsp'" />
	</form>
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
		<li>
			<div class="clear"></div>
			<div class="msg-list">
					<div id="lphoto">
					<a href="view.jsp?userID=<%out.print(rs.getString("user_id"));%>">
					<img src="heads/<% out.print(rs.getString("avatar_index"));%>.jpg" class="head" alt="none">
					</a>
					</div>
					<div id="lcontent">
						<div class="messenger-container">
						<p><%out.print(rs.getString("user_name"));%></p>
						<p>性别：<%out.print(rs.getString("sex")+" ");%></p>
						<p>出生年月：<%out.print(rs.getString("birth_year")+"年"+rs.getString("birth_month")+"月");%></p>
						</div>
					</div>
				</div>

		<span id="<%out.print(rs.getString("user_id"));%>"><input type="button" value="加为关注" onclick="addFriend('<%out.print(rs.getString("user_id"));%>')" /></span>

		</li>
		<%
		}
	}
	%>
	</div>
</body>
</html>
<%

		/** 关闭连接 **/
		conn.close();
		stmt.close();
		//rs.close();
%>
