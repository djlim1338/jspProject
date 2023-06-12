<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.LinkedHashMap" %>
<%@ page import="java.net.URLDecoder"%>
<%@ page import="database.ConnDB"%>
<%@ page import="java.sql.*" %>

<%
	request.setCharacterEncoding("UTF-8");

	String cartId = session.getId();  // 이거 아래에서 전혀 사용하지 않음.
	// 뭐야 이거 왜있는거여
	// 교수님도 이거 왜있는지 모르겠다고 하시는데
	
	String sessionId = (String) session.getAttribute("sessionId");

	String shipping_cartId = "";
	String shipping_name = "";
	String shipping_shippingDate = "";
	String shipping_country = "";
	String shipping_zipCode = "";
	String shipping_addressName = "";
	
	Cookie[] cookies = request.getCookies();

	if (cookies != null) {
		for (int i = 0; i < cookies.length; i++) {
			Cookie thisCookie = cookies[i];
			String n = thisCookie.getName();
			if (n.equals("Shipping_cartId")){
				shipping_cartId = URLDecoder.decode((thisCookie.getValue()), "utf-8");
				continue;}
			if (n.equals("Shipping_name")){
				shipping_name = URLDecoder.decode((thisCookie.getValue()), "utf-8");
				continue;}
			if (n.equals("Shipping_shippingDate")){
				shipping_shippingDate = URLDecoder.decode((thisCookie.getValue()), "utf-8");
				continue;}
			if (n.equals("Shipping_country")){
				shipping_country = URLDecoder.decode((thisCookie.getValue()), "utf-8");
				continue;}
			if (n.equals("Shipping_zipCode")){
				shipping_zipCode = URLDecoder.decode((thisCookie.getValue()), "utf-8");
				continue;}
			if (n.equals("Shipping_addressName")){
				shipping_addressName = URLDecoder.decode((thisCookie.getValue()), "utf-8");
				continue;}
		}
	}
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

	<div class="container col-8 alert alert-info">
		<div class="text-center ">
			<h1>영수증</h1>
		</div>
		<div class="row justify-content-between">
			<div class="col-4" align="left">
				<strong>배송 주소</strong> <br> 
				성명 : <% out.println(shipping_name); %><br> 
				우편번호 : <% 	out.println(shipping_zipCode);%><br> 
				주소 : <% out.println(shipping_addressName);%><br>
				국가 : <% out.println(shipping_country);%><br>
			</div>
			<div class="col-4" align="right">
				<p>	<em>배송일: <% out.println(shipping_shippingDate);%></em>
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
				ConnDB conndb = new ConnDB();
				int sum = 0;
				
				HashMap<String, Integer> cartList;
				//long sum = 0;
				if(sessionId != "" && sessionId != null){
					cartList = new HashMap<String, Integer>();
					ResultSet rs = conndb.selectCartAll(sessionId);
					if(rs != null){
						while(rs.next()){
							cartList.put(rs.getString("P_id"), rs.getInt("quantity"));
						}
					}
				}
				else{
					cartList = (HashMap<String, Integer>) session.getAttribute("cartlistNumber");
				}
				
				if (cartList == null)
					cartList = new LinkedHashMap<String, Integer>();
				for (String productId : cartList.keySet()){
					ResultSet rs = conndb.selectProductById(productId);
					if(rs.next()){
						int total = rs.getInt("p_unitPrice") * cartList.get(productId);
						sum = sum + total;
			%>
			<tr>
				<td class="text-center"><em><%=rs.getString("p_name")%> </em></td>
				<td class="text-center"><%=cartList.get(productId)%></td>
				<td class="text-center"><%=rs.getString("p_unitPrice")%>원</td>
				<td class="text-center"><%=total%>원</td>
			</tr>
			<%
					}
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
			
				<a href="./shippingInfo.jsp?cartId=<%=shipping_cartId%>"class="btn btn-secondary" role="button"> 이전 </a>
				<a href="./thankCustomer.jsp"  class="btn btn-success" role="button"> 주문 완료 </a>
				<a href="./checkOutCancelled.jsp" class="btn btn-secondary"	role="button"> 취소 </a>			
		</div>
	</div>
	<jsp:include page="footer.jspf" />
</body>
</html>
