<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.net.URLDecoder"%>
<%@ page import="database.ConnDB"%>
<%@ page import="java.sql.*" %>

<html>
<head>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<title>배송 정보</title>
</head>
<body>
	<%@ include file="menu.jspf" %>
	<%
		String name = "";
		String addressName = "";
		
		String memberName = (String) session.getAttribute("sessionId");
		if(memberName != "" && memberName != null){
			ConnDB conndb = new ConnDB();
			ResultSet rs = conndb.selectMember(memberName);
			if(rs.next()){
				name = rs.getString("name");
				addressName = rs.getString("address");
			}
			conndb.close();
		}
		
		String shipping_shippingDate = "";
		String shipping_country = "";
		String shipping_zipCode = "";	

		Cookie[] cookies = request.getCookies();

		if (cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
				Cookie thisCookie = cookies[i];
				String n = thisCookie.getName();
				if (n.equals("Shipping_name"))
					name = URLDecoder.decode((thisCookie.getValue()), "utf-8");
				if (n.equals("Shipping_shippingDate"))
					shipping_shippingDate = URLDecoder.decode((thisCookie.getValue()), "utf-8");
				if (n.equals("Shipping_country"))
					shipping_country = URLDecoder.decode((thisCookie.getValue()), "utf-8");
				if (n.equals("Shipping_zipCode"))
					shipping_zipCode = URLDecoder.decode((thisCookie.getValue()), "utf-8");
				if (n.equals("Shipping_addressName"))
					addressName = URLDecoder.decode((thisCookie.getValue()), "utf-8");
			}
		}
	%>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">배송 정보</h1>
		</div>
	</div>
	<div class="container">
		<form action="./processShippingInfo.jsp" class="form-horizontal" method="post">
			<input type="hidden" name="cartId" value="<%=request.getParameter("cartId")%>" />
			<div class="form-group row">
				<label class="col-sm-2">성명</label>
				<div class="col-sm-3">
					<input name="name" type="text" class="form-control" value="<%= name %>" />
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">배송일</label>
				<div class="col-sm-3">
					<input name="shippingDate" type="text" class="form-control" value="<%= shipping_shippingDate %>"/>(yyyy/mm/dd)
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">국가명</label>
				<div class="col-sm-3">
					<input name="country" type="text" class="form-control" value="<%= shipping_country %>" />
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">우편번호</label>
				<div class="col-sm-3">
					<input name="zipCode" type="text" class="form-control" value="<%= shipping_zipCode %>" />
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">주소</label>
				<div class="col-sm-5">
					<input name="addressName" type="text" class="form-control" value="<%= addressName %>" />
				</div>
			</div>
			<div class="form-group row">
				<div class="col-sm-offset-2 col-sm-10 ">
					<a href="./cart.jsp?cartId=<%=request.getParameter("cartId")%>" class="btn btn-secondary" role="button"> 이전 </a> 
					<input	type="submit" class="btn btn-primary" value="등록" />
					<a href="./checkOutCancelled.jsp" class="btn btn-secondary" role="button"> 취소 </a>
				</div>
			</div>
		</form>
	</div>
	<jsp:include page="footer.jspf" />
</body>
</html>

