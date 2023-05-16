<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="dto.Product"%>
<%@ page import="dao.ProductRepository"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  <%-- JSTL사용을 위함 --%>

<html>
<head>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<title>상품 수정</title>
</head>
<body>
	<%@ include file="menu.jspf"%>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">상품 수정</h1>
		</div>
	</div>
	<%
		//ArrayList<Product> listOfProducts = productDAO.getAllProducts();
		ProductRepository dao = ProductRepository.getInstance();
		ArrayList<Product> listOfProducts = dao.getAllProducts();

	%>

	<div class="container">
		<div class="row" align="center">
			<c:forEach var = "item" items = "<%=listOfProducts%>">
				<div class="col-md-4">
					<img src ="./resources/images/<c:out value="${item.getFilename()}"/>" style ="width: 100%">
					<h3><c:out value="${item.getPname()}"/></h3>
					<p><c:out value="${item.getDescription()}"/>
					<p><c:out value="${item.getUnitPrice()}"/>원
					<p><a href="./updateProductForm.jsp?id=<c:out value="${item.getProductId()}"/>" class="btn btn-secondary" role="button"> 상품 수정 &raquo;</a>
				</div>
			</c:forEach>
		</div>
		<hr>
	</div>
	<jsp:include page="footer.jspf"/>
</body>
</html>
