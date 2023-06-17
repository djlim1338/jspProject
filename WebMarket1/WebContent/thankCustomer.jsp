<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.net.URLDecoder"%>
<%@ page import="database.ConnDB"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Random" %>
<html>
<head>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<title>주문 완료</title>
</head>
<body>
	<%
		ConnDB conndb;
		String sessionId = (String) session.getAttribute("sessionId");
	
		Random random = new Random();
		String randomCartId = "";
		int RANDOM_MAX = 16;
		int stateIndex = 0; // 0=>소문자, 1=>숫자, 2=>대문자
		conndb = new ConnDB();
		while(true){
			randomCartId = "";
			for(int i=0; i<RANDOM_MAX; i++){
				stateIndex = random.nextInt(3);
				switch(stateIndex){
				case 0:
					randomCartId+=(char)((int)(random.nextInt(24) + 97));
					break;
				case 1:
					randomCartId+=Integer.toString(random.nextInt(10));
					break;
				case 2:
					randomCartId+=(char)((int)(random.nextInt(24) + 65));
					break;
				}
			}
			if(!conndb.sameCartIdState(randomCartId)) break;
		}
		conndb.close();
		
	
	
		//String shipping_cartId = "";
		String shipping_cartId = randomCartId;
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
				//if (n.equals("Shipping_cartId"))
				//	shipping_cartId = URLDecoder.decode((thisCookie.getValue()), "utf-8");
				if (n.equals("Shipping_name"))
					shipping_name = URLDecoder.decode((thisCookie.getValue()), "utf-8");
				if (n.equals("Shipping_shippingDate"))
					shipping_shippingDate = URLDecoder.decode((thisCookie.getValue()), "utf-8");
				if (n.equals("Shipping_country"))
					shipping_country = URLDecoder.decode((thisCookie.getValue()), "utf-8");
				if (n.equals("Shipping_zipCode"))
					shipping_zipCode = URLDecoder.decode((thisCookie.getValue()), "utf-8");
				if (n.equals("Shipping_addressName"))
					shipping_addressName = URLDecoder.decode((thisCookie.getValue()), "utf-8");
			}
		}
	%>
	<%@ include file="menu.jspf" %>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">주문 완료</h1>
		</div>
	</div>
	<div class="container">
		<h2 class="alert alert-success">주문해주셔서 감사합니다.</h2>
		<p>	주문은	<%out.println(shipping_shippingDate);%>에 배송될 예정입니다! !	
		<p>	주문번호 :	<%out.println(shipping_cartId);%>		
		<p>	SESSION ID :	<%= session.getId() %>	
		<!-- 
			당연하게도 SESSION ID와 주문번호가 같음.
			첫 cartId를 저장한게 cart.jsp에서 String cartId = session.getId();
			
			왜 저 멀리서 건너건너 오는거지..?
			몇단계여..
			cart.jsp(첫 getId) -> shippingInfo.jsp -> processShippingInfo.jsp ->
			orderConfirmation -> thankCustomer.jsp
			4단계나 건너오는구먼...
			
			=> 나중에 재접속 하면 세션 ID가 바뀌기 때문에 기존 ID를 쿠키로 저장해두기
			위해 이렇게 하는듯 함.
			
			그런데 cartId가 애초에 역할이 뭐지..? 식별 번호면 그냥 주문할 때 하면 되는거
			아닌가..?
			
		 -->	
	</div>
	<div class="container">
		<p>	<a href="./products.jsp" class="btn btn-secondary"> &laquo; 상품 목록</a>		
	</div>
	<%
		boolean stateTmp = true ;
		//session.invalidate();	
		if(sessionId != "" && sessionId != null){
			conndb = new ConnDB();
			ConnDB insertDB = new ConnDB();
			ResultSet rs = conndb.selectCartAll(sessionId);
			insertDB.insertOrderCart(shipping_cartId, sessionId, shipping_name, shipping_shippingDate, shipping_country, shipping_zipCode, shipping_addressName);
			while(rs.next()){
				insertDB.insertOrderProduct(
						shipping_cartId,
						rs.getString("P_id"), 
						rs.getInt("quantity"));
			}
			insertDB.close();
			conndb.deleteCartAll(sessionId);
			conndb.close();
		}
		else{
			session.removeAttribute("cartlistNumber");  // cart list만 제거함
		}
	
		for (int i = 0; i < cookies.length; i++) {
			Cookie thisCookie = cookies[i];
			String n = thisCookie.getName();
			if (n.equals("Shipping_cartId"))
				thisCookie.setMaxAge(0);
			if (n.equals("Shipping_name"))
				thisCookie.setMaxAge(0);
			if (n.equals("Shipping_shippingDate"))
				thisCookie.setMaxAge(0);
			if (n.equals("Shipping_country"))
				thisCookie.setMaxAge(0);
			if (n.equals("Shipping_zipCode"))
				thisCookie.setMaxAge(0);
			if (n.equals("Shipping_addressName"))
				thisCookie.setMaxAge(0);
			
			response.addCookie(thisCookie);
		}
	%>
</body>
</html>
