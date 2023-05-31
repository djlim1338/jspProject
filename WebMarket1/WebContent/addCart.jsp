<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.LinkedHashMap" %>
<%@ page import="database.ConnDB"%>
<%@ page import="java.sql.*" %>

<%
	String id = request.getParameter("id");
	int productQuantity = Integer.parseInt(request.getParameter("product_quantity"));
	
	HashMap<String, Integer> cartList = (HashMap<String, Integer>) session.getAttribute("cartlistNumber");
	if (cartList == null) { 
		cartList = new LinkedHashMap<String, Integer>();
		session.setAttribute("cartlistNumber", cartList);
	}
	Integer cartNumber = cartList.get(id);  // 카트에 담은 수
	if(cartNumber == null) cartList.put(id, productQuantity);  // 없으면 productQuantity로
	else cartList.put(id, cartNumber + productQuantity);  // 있으면 +productQuantity
	

	response.sendRedirect("product.jsp?id=" + id + "&addCart=1");
%>
