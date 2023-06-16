<%@ page contentType="text/html; charset=utf-8"%>

<%
	session.removeAttribute("sessionId");
	response.sendRedirect("loginMember.jsp");
%>
