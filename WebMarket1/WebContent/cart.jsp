<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap" %>
<%@ page import="database.ConnDB"%>
<%@ page import="java.sql.*" %>
<html>
<head>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<%
	String cartId = session.getId();
	String sessionId = (String) session.getAttribute("sessionId");
%>
<title>장바구니</title>
</head>
<body>
	<%@ include file="menu.jspf"%>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">장바구니</h1>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<table width="100%">
				<tr>
					<td align="left"><a href="./deleteCart.jsp?cartId=<%=cartId%>" class="btn btn-danger">전체 삭제하기</a></td>
					<td align="right">
						<!-- <a href="./orderConfirmation_view.jsp" class="btn btn-info">주문정보</a> -->
						<input type="button" class="btn btn-info" value="주문정보" onclick="checkLogin2()">
						<input type="button" class="btn btn-success" value="주문하기" onclick="checkLogin('<%=cartId%>')">
					</td>
				</tr>
			</table>
		</div>
		<div style="padding-top: 50px">
			<table class="table table-hover">
				<tr>
					<th>상품</th>
					<th>가격</th>
					<th>수량</th>
					<th>소계</th>
					<th>비고</th>
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
						cartList = new HashMap<String, Integer>();

					for (String productId : cartList.keySet()){// 상품리스트 하나씩 출력하기
						ResultSet rs = conndb.selectProductById(productId);
						if(rs.next()){
							int total = rs.getInt("p_unitPrice") * cartList.get(productId);
							//long total = rs.getLong("p_unitPrice") * cartList.get(productId);
							sum = sum + total;
				%>
				<tr>
					
					<td><a href="./product.jsp?id=<%=rs.getString("p_id")%>">
					<%=rs.getString("p_id")%> - <%=rs.getString("p_name")%></a></td>
					<td><%=rs.getString("p_unitPrice")%></td>
					<td><%=cartList.get(productId)%></td>
					<td><%=total%></td>
					<td><a href="./removeCart.jsp?id=<%=rs.getString("p_id")%>" class="badge badge-danger">삭제</a></td>
				</tr>
				<%
						}
					}
					conndb.close();
				%>
				<tr>
					<th></th>
					<th></th>
					<th>총액</th>
					<th><%=sum%></th>
					<th></th>
				</tr>
			</table>
			<a href="./products.jsp" class="btn btn-secondary"> &laquo; 쇼핑 계속하기</a>
		</div>
		<hr>
	</div>
	<jsp:include page="footer.jspf" />
	<script type="application/javascript">
		function checkLogin(value){
			var sessionId = "<%= (String) session.getAttribute("sessionId")%>";
			if(sessionId != "null") location.href="./shippingInfo.jsp?cartId="+value;
			else alert("로그인 해주세요.");
		}
		function checkLogin2(){
			var sessionId = "<%= (String) session.getAttribute("sessionId")%>";
			if(sessionId != "null") location.href="./orderConfirmation_view.jsp";
			else alert("로그인 해주세요.");
		}
	</script>
</body>
</html>
