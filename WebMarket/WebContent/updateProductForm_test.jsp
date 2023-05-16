<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="dto.Product"%>
<%@ page import="dao.ProductRepository"%>
<html>
<head>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<title>상품 수정(삭제 추가)</title>
</head>
<body>
	<% 
		String id = request.getParameter("id");
		ProductRepository dao = ProductRepository.getInstance();
		Product product = dao.getProductById(id);
	%>
	<%@ include file="menu.jspf"%>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">상품 수정(삭제 추가)</h1>
		</div>
	</div>
	<div class="container">
		<form name="newProduct" action="./processUpdateProduct_test.jsp" class="form-horizontal" method="post" enctype ="multipart/form-data">
			<div class ="col-md-5">
				<img src="./resources/images/<%= product.getFilename() %>" style="width: 100%" />
				<input type="hidden" name="productImage_old" value="<%= product.getFilename() %>">
			</div>
			<div class="form-group row">
				<label class="col-sm-2">상품 코드</label>
				<div class="col-sm-3">
					<input type="text" name="productId" value="<%= product.getProductId() %>" class="form-control" >
					<input type="hidden" name="productId_old" value="<%= product.getProductId() %>" class="form-control" >
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">상품명</label>
				<div class="col-sm-3">
					<input type="text" name="name" value="<%= product.getPname() %>" class="form-control" >
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">가격</label>
				<div class="col-sm-3">
					<input type="number" name="unitPrice" value="<%= product.getUnitPrice() %>" class="form-control" >
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">상세 정보</label>
				<div class="col-sm-5">
					<textarea name="description" cols="50" rows="2"
						class="form-control"><%= product.getDescription() %></textarea>
				</div>
			</div>
						<div class="form-group row">
				<label class="col-sm-2">제조사</label>
				<div class="col-sm-3">
					<input type="text" name="manufacturer" value="<%= product.getManufacturer() %>" class="form-control">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">분류</label>
				<div class="col-sm-3">
					<input type="text" name="category" value="<%= product.getCategory() %>" class="form-control" >
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">재고 수</label>
				<div class="col-sm-3">
					<input type="number" name="unitsInStock" value="<%= product.getUnitsInStock() %>" class="form-control" >
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">상태</label>
				<div class="col-sm-5">
					<%
						String[] checked = {"", "", ""};
						switch(product.getCondition()){
							case "New": checked[0] = "checked"; break;
							case "Old": checked[1] = "checked"; break;
							case "Refurbished": checked[2] = "checked"; break;
						}
					%>
					<input type="radio" name="condition" value="New" <%= checked[0] %>> 신규 제품 
					<input type="radio" name="condition" value="Old" <%= checked[1] %>> 중고 제품 
					<input type="radio" name="condition" value="Refurbished" <%= checked[2] %>> 재생 제품
				</div>
			</div>
			<div class ="form-group row">
			<label class ="col-sm-2">이미지</label>
				<div class ="col-sm-5">
 					<input type="file" name="productImage" class="form-control">
 				</div>
 			</div>
			<div class="form-group row">
				<div class="col-sm-offset-2 col-sm-10 ">
					<input type="submit" class="btn btn-primary" value="수정" >
				</div>
			</div>
		</form>
	</div>
	<jsp:include page="footer.jspf"/>
</body>
</html>


