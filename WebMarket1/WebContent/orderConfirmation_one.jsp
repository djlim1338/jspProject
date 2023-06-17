<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.LinkedHashMap" %>
<%@ page import="java.net.URLDecoder"%>
<%@ page import="database.ConnDB"%>
<%@ page import="java.sql.*" %>

<%
	request.setCharacterEncoding("UTF-8");
	String sessionId = (String) session.getAttribute("sessionId");
	String cartId = (String) request.getParameter("cartId");
	out.print(cartId);
%>
<html>
<head>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<title>주문 정보</title>
</head>
<body>
	<%@ include file="menu.jspf" %>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">주문 정보</h1>
		</div>
	</div>
	
	<%

		ConnDB conndb = new ConnDB();
		ResultSet rs = conndb.selectOrderByUserId(sessionId);
		if(rs.next()){
	%>

	<div class="container col-8 alert alert-info">
		<div class="text-center ">
			<h1>영수증</h1>
		</div>
		<div class="row justify-content-between">
			<div class="col-4" align="left">
				<strong>배송 주소</strong> <br> 
				주문번호 : <% out.println(rs.getString("cart_id")); %><br> 
				성명 : <% out.println(rs.getString("user_name")); %><br> 
				우편번호 : <% 	out.println(rs.getString("order_zip"));%><br> 
				주소 : <% out.println(rs.getString("order_address"));%><br>
				국가 : <% out.println(rs.getString("order_country"));%><br>
			</div>
			<div class="col-4" align="right">
				<p>	<em>배송일: <% out.println(rs.getString("order_date"));%></em>
			</div>
		</div>
		<div>
			<table class="table table-hover">			
			<tr>
				<th class="text-center">상품</소>
				<th class="text-center">개수</th>
				<th class="text-center">가격</th>
				<th class="text-center">소계</th>
			</tr>
			<%
				int sum = 0;
				
				//long sum = 0;
				conndb.close();
				conndb = new ConnDB();
				rs = conndb.selectOrderByCartId(cartId);

				while (rs.next()){
					ConnDB conndbProduct = new ConnDB();
					ResultSet rsProduct = conndbProduct.selectProductById(rs.getString("P_id"));
					if(rsProduct.next()){
						int total = rsProduct.getInt("p_unitPrice") * rs.getInt("P_quantity");
						sum = sum + total;
			%>
			<tr>
				<td class="text-center"><em><%=rsProduct.getString("p_name")%> </em></td>
				<td class="text-center"><%=rs.getString("P_quantity")%></td>
				<td class="text-center"><%=rsProduct.getString("p_unitPrice")%>원</td>
				<td class="text-center"><%=total%>원</td>
			</tr>
			<%
					}
					conndbProduct.close();
					if(rsProduct != null) rsProduct.close();
				}
				conndb.close();
			%>
			<tr>
				<td> </td>
				<td> </td>
				<td class="text-right">	<strong>총액: </strong></td>
				<td class="text-center text-danger"><strong><%=sum%> </strong></td>
			</tr>
			</table>
				<a href="orderConfirmation_view.jsp"class="btn btn-secondary" role="button"> 이전 </a>		
		</div>
	</div>
	<%
		}
		conndb.close();
	
	%>
	<jsp:include page="footer.jspf" />
</body>
</html>
