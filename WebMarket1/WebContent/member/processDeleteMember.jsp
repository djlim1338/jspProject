<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ page import="database.ConnDB"%>

<%
	request.setCharacterEncoding("UTF-8");

	String id = (String) session.getAttribute("sessionId");

	ConnDB conndb = new ConnDB();
	boolean deleteMemberState = conndb.deleteMember(id);
	
	if(deleteMemberState == true){
		session.setAttribute("sessionId", null);
		response.sendRedirect("resultMember.jsp");
	}
	else{
		out.print("delete member fail <br>");
		out.print(id + "<br>");
	}
	conndb.close();
%>

<%-- <sql:setDataSource var="dataSource"
	url="jdbc:mysql://localhost:3306/WebMarketDB"
	driver="com.mysql.jdbc.Driver" user="root" password="1234" />

<sql:update dataSource="${dataSource}" var="resultSet">
   INSERT INTO member VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
   <sql:param value="<%=id%>" />
	<sql:param value="<%=password%>" />
	<sql:param value="<%=name%>" />
	<sql:param value="<%=gender%>" />
	<sql:param value="<%=birth%>" />
	<sql:param value="<%=mail%>" />
	<sql:param value="<%=phone%>" />
	<sql:param value="<%=address%>" />
	<sql:param value="<%=timestamp%>" />
</sql:update>

<c:if test="${resultSet>=1}">
	<c:redirect url="resultMember.jsp?msg=1" />
</c:if> --%>

