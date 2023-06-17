<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.LinkedHashMap" %>
<%@ page import="java.net.URLDecoder"%>
<%@ page import="database.ConnDB"%>
<%@ page import="java.sql.*" %>

<%
	String sessionId = (String) session.getAttribute("sessionId");
%>
<html>
<head>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<title>배송 정보</title>
</head>
<body>
	<%@ include file="menu.jspf" %>
	
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">주문 정보</h1>
		</div>
	</div>

	<%
	%>
	<div class="container col-8 alert alert-info">
		<div>
			<table class="table table-hover">			
			<tr>
				<th class="text-center">주문 번호</소>
				<th class="text-center">주문자 이름</th>
				<th class="text-center">배송일</th>
				<th class="text-center">국가</th>
				<th class="text-center">우편번호</th>
				<th class="text-center">주소</th>
			</tr>
			<%
				ConnDB conndb = new ConnDB();
				ResultSet rs = null;
				if(sessionId != "" && sessionId != null){
					rs = conndb.selectOrderByUserId(sessionId);
				}

				while(rs.next()){
			%>
				<tr>
					<td class="text-center"><a href="orderConfirmation_one.jsp?cartId=<%=rs.getString("cart_id")%>"><%=rs.getString("cart_id")%> </a></td>
					<td class="text-center"><%=rs.getString("user_name")%></td>
					<td class="text-center"><%=rs.getString("order_date")%></td>
					<td class="text-center"><%=rs.getString("order_country")%></td>
					<td class="text-center"><%=rs.getString("order_zip")%></td>
					<td class="text-center"><%=rs.getString("order_address")%></td>
				</tr>
			<%
				}
				conndb.close();
			%>
			</table>	
				<a href="cart.jsp"class="btn btn-secondary" role="button"> 이전 </a>	
		</div>
	</div>
	<jsp:include page="footer.jspf" />
</body>
</html>
