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

<!DOCTYPE html>

<html>
<head>
	<meta charset=utf-8>
	<title>WELCOME TO MY HOMEPAGE</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<style>
		@media (max-width: 29.99em) {
			
			#mobile_logout {
				float: right;
			}

			#desktop_logout {
				display: none;
			}
		}

		@media (min-width: 30em) {

			#desktop_logout {
				float: right;
			}

			#mobile_logout {
				display: none;
			}
		}
		.input_detail {
			width:500px;
			height: 80px;
			border: 1px solid #ccc;
			border-left-color: #9a9a9a;
			border-top-color: #9a9a9a;
			outline: none;
			word-wrap: break-word;
			font-size: 18px;
			overflow:auto;
		}
		.comment{
			border-style: dashed;
			border-width: 1px 0px 0px 0px;
			border-color: "#202020";
		}
	</style>
	<script>
		function submitStatement(){
			var statement=document.getElementById("statement");
			var strInput = statement.value;
			if (strInput != "") {
				var xmlhttp = new XMLHttpRequest();
				if (xmlhttp != null){
					xmlhttp.onreadystatechange=function(){
						if (xmlhttp.readyState == 4 && xmlhttp.status == 200){
							window.location.reload();
						}
					}
					strInput="submitStatement.jsp?words="+strInput;
					strInput=encodeURI(strInput);
					strInput=encodeURI(strInput);
					xmlhttp.open("GET", strInput, true);
					xmlhttp.send();
				}
			}else{
				alert("请输入内容！");
			}
		}
		function reply(statementID){
			var statementDoc=document.getElementById(statementID);
			if(statementDoc.style.display=="none"){
				statementDoc.style.display="";
				statementDoc=document.getElementById(statementID+"Button");
				statementDoc.style.display="";
			}
			else{
				statementDoc.style.display="none";
				statementDoc=document.getElementById(statementID+"Button");
				statementDoc.style.display="none";
			}
		}
		function submitReply(statementID){
			var statementDoc=document.getElementById(statementID);
			var strInput = statementDoc.value;
			if (strInput != ""){
				var xmlhttp = new XMLHttpRequest();
				if (xmlhttp != null){
					xmlhttp.onreadystatechange=function(){
						if (xmlhttp.readyState==4 && xmlhttp.status==200) {
							window.location.reload();
						}
					}
					strInput="submitReply.jsp?words="+strInput+"&statementID="+statementID;
					strInput=encodeURI(strInput);
					strInput=encodeURI(strInput);
					xmlhttp.open("GET",strInput,true);
					xmlhttp.send();
				}
			}else{
				alert("请输入内容！");
			}
		}
	</script>
</head>
<body>
	<header>
		<p>
			Hi,  <a href="main.jsp"><%
			sql= "SELECT * FROM `account` where user_id = '"+userID+"' LIMIT 1";
			System.out.println(sql);

			//取得结果
			ResultSet rs = stmt.executeQuery(sql);
			if (rs.next()){
				out.println(rs.getString("user_name"));
			}%></a>
		</p>

		<input type="button" value="退出登录" onclick="location.href='logout.jsp'" id="mobile_logout">

		<form action="search.jsp" method="post">
			<input type="text" name="searchName" maxlength="20">
			<input type="submit" value="查找好友">
		</form>

		<input type="button" value="退出登录" onclick="location.href='logout.jsp'" id="desktop_logout">
	</header>

	<main>
		<p>我想灌水：</p>
		<textarea type="text" id="statement" rows=4 cols=15 class="input_detail"></textarea>
		<input type="button" value="发布" onclick="submitStatement()"/>
	</main>

	<%
	sql= "SELECT a.user_id as user_id, user_name, statement_id, release_time, content "
		+				"FROM `account` as a, `statement` as b "
		+	"where a.user_id = b.user_id and ("
		+	"(b.user_id='" + userID + "') "
		+	"or b.user_id in ( "
		+		"SELECT user_id from `friends` where friend_id = '" + userID + "'"
		+	")or b.user_id in("
		+		"SELECT friend_id from `friends` where user_id = '" + userID + "'"
		+	") "
		+") ORDER BY release_time DESC LIMIT 0,10;";
	System.out.println(sql);
	//取得结果
	rs = stmt.executeQuery(sql);

	while (rs.next()){
	%>
	<div align="center">
	<hr width="700"/>
	<table bgcolor="">
	<tr height="10">
	<td  width="500"><font size="4" color="black"><a href="view.jsp?userID=<%out.print(rs.getString("userID"));%>"><%out.print(rs.getString("userName"));%></a>:</font>
	</td>
	</tr>
	<tr height="100">
	<td width="500"><font size="4" color="black"><%out.print(rs.getString("content"));%></font>
	</td>
	<td width="110"><font size="3" color="gray"><%out.print(rs.getString("release_time"));%></font>
	</td>
	<td width="40"><a href="javascript:reply('<%out.print(rs.getString("statement_id"));%>')">回复</a><td>
	</tr>
	<%
	String sql2="SELECT a.user_id as user_id, user_name, comment_id, release_time, content "
		+				"FROM `account` as a, `comment` as b "
		+	"where a.user_id = b.user_id and "
		+	"b.statementID='"+ rs.getString("statementID")+"' "
		+"ORDER BY release_time DESC LIMIT 0,10;";
	System.out.println(sql2);
	ResultSet rs2 = stmt2.executeQuery(sql2);
	while (rs2.next()){
	%>
	<tr height="">

	<td class="comment" width="500"><font size="3" color="black"><a href="view.jsp?userID=<%out.print(rs2.getString("user_id"));%>"><%out.print(rs2.getString("userName"));%></a>回复:</font><font size="4" color="black"><%out.print(rs2.getString("content"));%></font>
	</td>
	<td  class="comment" width="110"><font size="3" color="gray"><%out.print(rs2.getString("release_time"));%></font>
	</td>
	<td  class="comment" width="60"><td>
	</tr>
	<%
	}
	rs2.close();
	%>
	</table>
	<div>
	<input style="display:none; height:25;width:500" id="<%out.print(rs.getString("statement_id"));%>" value=""/>
	<input type="button" style="display:none;" id="<%out.print(rs.getString("statement_id"));%>Button" value="确定" onclick="submitReply('<%out.print(rs.getString("statement_id"));%>')"/>
	</div>
	</div>
	<%
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
