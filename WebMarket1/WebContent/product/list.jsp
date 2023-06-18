<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ page import="database.ConnDB"%>
<%@ page import="java.sql.*" %>
<%@ page import="mvc.model.ProductDTO"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  <%-- JSTL사용을 위함 --%>

<%
	List productList = (List) request.getAttribute("productList");
%>

<html>
<head>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<title>상품 목록</title>
</head>
<body>
	<%@ include file="../menu.jspf"%>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">상품 목록(MVC)</h1>
		</div>
	</div>

	<div class="container">
		<div class="row" align="center">
		<%
			if(productList != null){
				for(int i=0; i<productList.size(); i++){
					ProductDTO product = (ProductDTO) productList.get(i);
		%>
			<div class="col-md-4">
				<img src ="./resources/images/<%= product.getFileName()%>" style ="width: 100%">
				<h3><%= product.getName()%></h3>
				<p><%= product.getDescription()%>
				<p><%= product.getUnitPrice()%>원
				<p><a href="./ProductDetailAction.do?id=<%= product.getId()%>" class="btn btn-secondary" role="button"> 상세 정보 &raquo;</a>
			</div>
		<%
				}
			}
		%>
		</div>
		<hr>
	</div>
	<jsp:include page="../footer.jspf"/>
</body>
</html>
