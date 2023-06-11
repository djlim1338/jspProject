<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap" %>
<%@ page import="database.ConnDB"%>
<%@ page import="dto.Product"%>
<%@ page import="dao.ProductRepository"%>

<%
	String id = request.getParameter("id");
	if (id == null || id.trim().equals("")) {
		response.sendRedirect("products_get.jsp?pageStr=list");
		return;
	}

	String sessionId = (String) session.getAttribute("sessionId");
	if(sessionId != "" && sessionId != null){
		ConnDB conndb = new ConnDB();
		conndb.deleteCartById(sessionId, id);
		conndb.close();
	}
	else{
		HashMap<String, Integer> cartList = (HashMap<String, Integer>) session.getAttribute("cartlistNumber");
		cartList.remove(id);
	}
	


	response.sendRedirect("cart.jsp");
%>
