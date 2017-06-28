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
	<SCRIPT type="text/javascript">
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
			if (strInput!=""){
				var xmlhttp=null;
				if (window.XMLHttpRequest){
					// code for IE7+, Firefox, Chrome, Opera, Safari
					xmlhttp=new XMLHttpRequest();
				}
				else{
					// code for IE6, IE5
					xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
				}
				if (xmlhttp!=null){
					xmlhttp.onreadystatechange=function(){
						if (xmlhttp.readyState==4 && xmlhttp.status==200){

							window.location.reload();
						}
					}
					xmlhttp.open("GET","submitReply.jsp?words="+strInput+"&statementID="+statementID,true);
					xmlhttp.send();
				}
			}else{
				alert("请输入内容！");
			}
		}
	</SCRIPT>
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
<p class="exr">你关注的
<%
sql= "SELECT * FROM `account` "
+"WHERE user_id in "
+"(SELECT A.friend_id FROM `friends` as A ,`friends`  as B WHERE A.user_id= '"+userID+"' AND B.friend_id= '"
+targetID+"' AND A.friend_id=B.user_id) ";
System.out.println(sql);
//取得结果

int count =0;

rs = stmt.executeQuery(sql);
rs.last();
int rowcount = rs.getRow();
rs.beforeFirst();
while (rs.next()){
	%>
	<a href="view.jsp?userID=<%out.print(rs.getString("user_id"));%>">
<img src="heads/<% out.print(rs.getString("avatar_index"));%>.jpg" class="head" alt="none" style="float:center;">
<p class="exr"><%out.print(rs.getString("user_name"));%></p>
</a>
<%
count++;
if(count>=3)break;
}
	%>
	等<% out.print(rowcount);%>位好友也在关注TA
	</p>
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
			       <P><a class="large blue button" href="Following.jsp?userID=targetID">我的关注</a></P>
			       <P><a class="large green button" href="Follower.jsp?userID=targetID">我的粉丝</a></P>
						 <br>
			</div>
				</div>
				<div id="section">
				<div class="h1" >好友动态</div>
					<%
					sql= "SELECT a.user_id as user_id, user_name, statement_id, avatar_index,release_time, content "
						+				"FROM `account` as a, `statement` as b "
						+	"where a.user_id = b.user_id and ("
						+	"(b.user_id='" + targetID + "') "
						+	"or b.user_id in("
						+		"SELECT friend_id from `friends` where user_id = '" + targetID + "'"
						+	") "
						+") ORDER BY release_time DESC LIMIT 0,10;";
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
					<p class="exl"><%out.print(rs.getString("release_time"));%></p>

				  </div>
				  <div id="lcontent">
				      <div class="messenger-container">
				      <p><%out.print(rs.getString("content"));%></p>
				      </div>
				      </div>
				  </div>
					<%
					String sql2="SELECT a.user_id as user_id, user_name, comment_id, release_time,avatar_index, content "
						+				"FROM `account` as a, `comment` as b "
						+	"where a.user_id = b.user_id and "
						+	"b.statement_id = '"+ rs.getString("statement_id")+"' "
						+"ORDER BY release_time LIMIT 0,10;";
					System.out.println(sql2);
					ResultSet rs2 = stmt2.executeQuery(sql2);
					while (rs2.next()){
					%>

					<div class="clear"></div>
				  <div class="msg-list sender">
				    <div id="rphoto">
				   <a href="view.jsp?userID=<%out.print(rs2.getString("user_id"));%>">
				  <img src="heads/<% out.print(rs2.getString("avatar_index"));%>.jpg" class="head" alt="none">
				   <p class="exl"><%out.print(rs2.getString("user_name"));%></p></a>
					 <p class="exl"><%out.print(rs2.getString("release_time"));%></p>
				   </div>
				   <div id="rcontent">
				      <div class="messenger-container">
				          <p><%out.print(rs2.getString("content"));%></p>
				      </div>
						</div>
				  </div>
					<!--tr height="">

					<td class="comment" width="500"><font size="3" color="black"><a href="view.jsp?userID=<%out.print(rs2.getString("user_id"));%>"><img src="fake-icon.png"><%out.print(rs2.getString("user_name"));%></a>回复: </font><font size="4" color="black"><%out.print(rs2.getString("content"));%></font>
					</td>
					<td  class="comment" width="110"><font size="3" color="gray"><%out.print(rs2.getString("release_time"));%></font>
					</td>
					<td  class="comment" width="60"><td>
					</tr-->
					<%
					}
					rs2.close();
					%>
				<!--/table-->
					<div style="text-align:center;">
						评论：
					<input style=" height:25;width:500" id="<%out.print(rs.getString("statement_id"));%>" value=""/>
					<input type="button" id="<%out.print(rs.getString("statement_id"));%>Button" value="确定" onclick="submitReply('<%out.print(rs.getString("statement_id"));%>')"/>
					</div>
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
