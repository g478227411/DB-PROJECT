<!DOCTYPE html>
<html>
	<head>
		<meta charset=utf-8>
		<title>用户注册</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" type="text/css" href="css/style_register.css">
		<script src="js/jquery.3.2.1.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
</head>
<body>
	<h1>用户注册</h1>
	<div class="login-form">
		<form action="registerResponse.jsp" method="post">
			<div class="form-group">
				<label>用户名</label>
				<input type="text" class="text" value="" name="userID">
			</div>
			<div class="form-group">
			<label>密码</label>
				<input class="form-control" type="password" name="passwd" placeholder="请设置密码">
			</div>

			<div class="form-group">
			<label>姓名</label>
				<input class="form-control" type="text" name="userName">
			</div>
			<div class="form-group">
			<label>性别</label>
				<input type="radio" name="sex" value="male" />男
				<input type="radio" name="sex" value="female" />女
				<input type="radio" name="sex" value="other" />其他
				<input type="radio" name="sex" checked="selected" value="unknown" />隐藏
			</div>

			<div class="row">
    			<label>出生年月</label>
    			<SELECT onclick="onSelect(this)" name="birthYear">
				<%
					for (int i=1900;i<=2017;i++){
						%> <option value=<%=i%> <% if (i == 2000) { out.print("selected"); } %> > <%=i%> </option> <%
					}
				%>
				</SELECT>
				<SELECT onclick="onSelect(this)" name="birthMonth">
				<%
					for (int i=1;i<=12;i++){
						%><option value=<%=i%>><%=i%></option><%
					}
				%>
				</SELECT>
  			</div>

			<input type="submit" value="注册" >&nbsp;&nbsp; 
			<input type="button" value="返回" onclick="location.href='login.htm'">
		</form>
	</body>
</html>
