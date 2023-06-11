<%@ page contentType="text/html; charset=utf-8"%>

<%
	session.setAttribute("sessionId", null);
	response.sendRedirect("loginMember.jsp");
%>
