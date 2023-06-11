<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.util.Enumeration"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  <%-- JSTL사용을 위함 --%>
<%@ page import = "database.ConnDB" %>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
	<meta charset="UTF-8">
	<title>코드 테스트</title>
</head>
<body>
	<%@ include file="./menu.jspf" %>
	<div class="container">
		<%
			boolean databaseState = false;
		
			ConnDB conndb = new ConnDB();
			
			if (conndb.conn != null) databaseState = true;
			else databaseState = false;
				
			
			String[] roles = request.getParameterValues("role");
		%>
		<hr>
		<a href="logout.jsp" class="btn btn-sm btn-danger pull-right">reset session</a>
		<p> SESSION ID = <%= session.getId() %>
		<p> SESSION 생성시간 = <%= session.getCreationTime() %>
		<p> SESSION 마지막 요청시간 = <%= session.getLastAccessedTime() %>
		<p> SESSION 최대 허용시간 = <%= session.getMaxInactiveInterval() %>
		<p> 사용자 이름 = <%= session.getAttribute("sessionId") %>
		<p> 관리자 이름 = <%= request.getRemoteUser() %>
		<p> 인증 방식 = <%= request.getAuthType() %>
		<p> protocol = <%= request.getProtocol() %>
		<p> real path = <%= request.getServletContext().getRealPath("./")%>
		<p> 데이터베이스 연동 상태 = <%= databaseState %>
		<c:if test="${ conndb.getErrorState() }">
			<p> 데이터베이스 error!
		</c:if>
		
		<br><hr><br>
		<%
			String ls_name = "";
		    String ls_value = "";
			int i = 0;
			
			//session.setAttribute("session_test_1", "session");
			//session.setAttribute("session_test_2", "test");
			//session.setAttribute("session_test_3", "3");
			Enumeration<String> attr = session.getAttributeNames();
			while(attr.hasMoreElements()) {
				   
		        i++;
		        ls_name = attr.nextElement().toString();
		        ls_value = session.getAttribute(ls_name).toString();
		   
		        out.println("<br/>얻어온 세션 이름 [ " + i +" ] : " + ls_name + "<br/>");
		        out.println("<br/>얻어온 세션 값 [ " + i +" ] : " + ls_value + "<hr/>");
			}
			
			conndb.close();
		%>
	</div>
	
	<jsp:include page="./footer.jspf"/>
</body>
</html>