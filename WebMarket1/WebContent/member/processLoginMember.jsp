<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ page import="database.ConnDB"%>
<%@ page import="java.sql.*" %>

<%
	request.setCharacterEncoding("UTF-8");

	String id = request.getParameter("id");
	String password = request.getParameter("password");

	ConnDB conndb = new ConnDB();
	ResultSet rs = conndb.loginMember(id, password);
	if(rs.next()){
		session.setAttribute("sessionId", id);
		
		Cookie userId = new Cookie("userId", URLEncoder.encode(id, "utf-8"));
		Cookie passWord = new Cookie("passWord", URLEncoder.encode(password, "utf-8"));
		response.addCookie(userId);
		response.addCookie(passWord);
		
		HashMap<String, Integer> cartList = (HashMap<String, Integer>) session.getAttribute("cartlistNumber");
		if(cartList != null){
			for (String productId : cartList.keySet()){// 상품리스트 하나씩 출력하기
				ResultSet rsCart = conndb.selectCartById(id, productId);
				if(rsCart.next()){
					int oldQuantity = rsCart.getInt("quantity") + cartList.get(productId);
					conndb.setCartQuantity(id, productId, oldQuantity);
				}
				else{
					conndb.addCart(id, productId, cartList.get(productId));
				}
			}
			session.removeAttribute("cartlistNumber");
		}
	}
	conndb.close();
	
	if(session.getAttribute("sessionId") != null) response.sendRedirect("resultMember.jsp?msg=2");
	else response.sendRedirect("loginMember.jsp?error=1");
%>

<%-- <sql:setDataSource var="dataSource"
	url="jdbc:mysql://localhost:3306/WebMarketDB" driver="com.mysql.jdbc.Driver" user="root" password="1234" />

<sql:query dataSource="${dataSource}" var="resultSet">
	SELECT * FROM MEMBER WHERE ID=? and password=?  
	<sql:param value="<%=id%>" />
	<sql:param value="<%=password%>" />
</sql:query>

<c:forEach var="row" items="${resultSet.rows}">
	<%
		session.setAttribute("sessionId", id);
	%>
	<c:redirect url="resultMember.jsp?msg=2" />
</c:forEach>

<c:redirect url="loginMember.jsp?error=1" /> --%>
