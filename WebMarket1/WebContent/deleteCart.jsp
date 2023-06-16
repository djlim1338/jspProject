<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="database.ConnDB"%>

<%
	String id = request.getParameter("cartId");
	if (id == null || id.trim().equals("")) {
		response.sendRedirect("cart.jsp");
		return;
	}

	//session.invalidate();  // 세션 초기화시 로그인 상태를 비롯하여 모든 정보가 사라짐
	String sessionId = (String) session.getAttribute("sessionId");
	if(sessionId != "" && sessionId != null){
		ConnDB conndb = new ConnDB();
		conndb.deleteCartAll(sessionId);
		conndb.close();
	}
	else{
		session.removeAttribute("cartlistNumber");  // cart list만 제거함
	}
	
	response.sendRedirect("cart.jsp");
%>
