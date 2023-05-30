<%@ page contentType="text/html; charset=utf-8"%>
<html>
<head>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<title>사용자 정보</title>
</head>
<body>
	<%@ include file="menu.jspf"%>
	
	<div class="container">
		<div class="text-right"> 
			<a href="logout.jsp" class="btn btn-sm btn-success pull-right">logout</a>
		</div>
		<hr>
		user name = <%= request.getRemoteUser() %>
		<hr>
	</div>

	<jsp:include page="footer.jspf"/>
	<!-- <%@ include file="footer.jspf"%> -->
</body>
</html>
