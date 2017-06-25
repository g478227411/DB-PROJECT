<%@page language="java" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.ResultSetMetaData"%>

<%
	int ok=0;
	request.setCharacterEncoding("UTF-8");
    	response.setCharacterEncoding("UTF-8");
	if(request.getParameter("userID")!=null)
	if(request.getParameter("passwd")!=null)
	if(request.getParameter("userName")!=null)
	if(request.getParameter("sex")!=null)
	if(request.getParameter("birthYear")!=null)
	if(request.getParameter("birthMonth")!=null){
		String userID=request.getParameter("userID");
		String passwd=request.getParameter("passwd");
		String userName= java.net.URLDecoder.decode(request.getParameter("userName"),"UTF-8");//获取请求参数
		String sex=request.getParameter("sex");
		int birthYear = Integer.parseInt(request.getParameter("birthYear"));
		int birthMonth = Integer.parseInt(request.getParameter("birthMonth"));

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
		String sql = "SELECT * FROM `account` where user_id='" + userID + "' LIMIT 1";
		//取得结果
		ResultSet rs = stmt.executeQuery(sql);
		if (!rs.next()){
			sql = "INSERT INTO `" + DBName + "`.`account` (user_id,password,sex,birthYear,birthMonth) VALUES('"+userID+"','"+passwd+"','"+userName+"','"+sex+"',"+birthYear+","+birthMonth+")";
			System.out.println(sql);
			stmt.execute(sql);
			ok=1;
		}
		/** 关闭连接 **/
		conn.close();
		stmt.close();
		rs.close();
	}
%>

<body bgcolor="papayawhip">
<%
if (ok==1){
	out.println("<p>注册成功！！</p>");
	out.println("<p>5秒后返回<a href=\"login.jsp\">登陆</a>页面！</p>");
	String content=5+";URL="+"login.jsp";
	response.setHeader("REFRESH",content);
}else{
	out.println("<p>该用户名已占用！</p>");
	out.println("<p>5秒后返回注册页面！！</p>");
	String content=5+";URL="+"register.jsp";
	response.setHeader("REFRESH",content);
}
%>
</body>
