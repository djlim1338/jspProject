<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.net.URLDecoder"%>

<html>
<head>
<link rel="stylesheet" href="../resources/css/bootstrap.min.css" />
<title>Login</title>
</head>
<body>
	<%@ include file="../menu.jspf" %>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">사용자 로그인</h1>
		</div>
	</div>
	<div class="container" align="center">
		<div class="col-md-4 col-md-offset-4">
			<h3 class="form-signin-heading">Please sign in</h3>
			<%
				String error = request.getParameter("error");
				if (error != null) {
					out.println("<div class='alert alert-danger'>");
					out.println("아이디와 비밀번호를 확인해 주세요");
					out.println("</div>");
				}
				
				String cookieUserId = "";
				String cookiePassWord = "";
				
				
				Cookie[] cookies = request.getCookies();

				if (cookies != null) {
					for (int i = 0; i < cookies.length; i++) {
						Cookie thisCookie = cookies[i];
						String n = thisCookie.getName();
						if (n.equals("userId")){
							cookieUserId = URLDecoder.decode((thisCookie.getValue()), "utf-8");
							continue;}
						if (n.equals("passWord")){
							cookiePassWord = URLDecoder.decode((thisCookie.getValue()), "utf-8");
							continue;}
					}
				}
				
			%>
			<form class="form-signin" action="processLoginMember.jsp" method="post">
				<div class="form-group">
					<label for="inputUserName" class="sr-only">User Name</label> 
					<input type="text" class="form-control" value="<%=cookieUserId%>" placeholder="ID" name='id' required autofocus>
				</div>
				<div class="form-group">
					<label for="inputPassword" class="sr-only">Password</label> 
					<input type="password" class="form-control" value="<%=cookiePassWord%>" placeholder="Password" name='password' required>
				</div>
				<button class="btn btn btn-lg btn-success btn-block" type="submit">로그인</button>
			</form>
		</div>
	</div>
</body>
</html>
