<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="dto.Product"%>
<%@ page import="dao.ProductRepository"%>
<%@ page import="java.util.HashMap" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  <%-- JSTL사용을 위함 --%>

<html>
<head>
	<% 
		//HashMap<String, String> titleMap = new HashMap<String, String>();
		String pageStr = request.getParameter("pageStr");  // get으로 넘어온 값중 pageStr의 값
		String title = "이름없는 제목";  // 제목
		String btnTitle = "이름없는 버튼";  // 버튼 이름
		String btnSrc = "";  // 버튼 누르면 이동할 페이지
		
		boolean checkState = false;  // 체크박스 표기 여부
		String checkLabel = "이름없는 체크박스";  // 체크박스 주석
		String checkName = "";  // 체크박스 name속성값
		switch(pageStr){
			case "list": 
				title = "상품 목록"; 
				btnTitle = "상세 정보";
				btnSrc = "product.jsp";
				break;
			case "remove": 
				title = "상품 삭제"; 
				btnTitle = "상품 삭제";
				checkState = true;
				checkLabel = "연속 삭제";
				checkName = "remove_again";
				btnSrc = "processRemoveProduct.jsp";
				break;
			case "update": 
				title = "상품 수정(수정)"; 
				btnTitle = "상품 수정";
				btnSrc = "updateProductForm.jsp";
				break;
			case "update_test": 
				title = "상품 수정(삭제 추가)"; 
				btnTitle = "상품 수정";
				btnSrc = "updateProductForm_test.jsp";
				break;
		}
	%>
	<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
	<title><%= title %></title>
</head>
<body>
	
	<%@ include file="menu.jspf"%>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3"><%= title %></h1>
		</div>
	</div>
	<%
		//ArrayList<Product> listOfProducts = productDAO.getAllProducts();
		ProductRepository dao = ProductRepository.getInstance();
		ArrayList<Product> listOfProducts = dao.getAllProducts();

	%>

	<div class="container">
		<c:set var="checkboxState" value="<%= checkState %>" />
		<c:if test="${ checkboxState }">
			<p>연속 삭제: <input type="checkbox" name="remove_again" checked></p>
		</c:if>
		<div class="row" align="center">
			<c:forEach var = "item" items = "<%=listOfProducts%>">
				<div class="col-md-4">
					<img src ="./resources/images/<c:out value="${item.getFilename()}"/>" style ="width: 100%">
					<h3><c:out value="${item.getPname()}"/></h3>
					<p><c:out value="${item.getDescription()}"/>
					<p><c:out value="${item.getUnitPrice()}"/>원
					<p><a href="./<%= btnSrc %>?id=<c:out value="${item.getProductId()}"/>" class="btn btn-secondary" role="button"> <%= btnTitle %> &raquo;</a>
				</div>
			</c:forEach>
		</div>
		<hr>
	</div>
	<jsp:include page="footer.jspf"/>
	<script type="text/javascript">
	</script>
</body>
</html>
