<%@ page contentType="text/html; charset=utf-8"%>

<%
	session.invalidate();  // 세션 초기화.
	response.sendRedirect("addProduct.jsp");
%>
