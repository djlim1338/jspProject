<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="database.ConnDB"%>
<%@ page import="java.sql.*" %>
<html>
<head>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<title>상품 수정</title>
</head>
<body>
	<% 
		String id = request.getParameter("id");

		ConnDB conndb = new ConnDB();
		ResultSet rs = conndb.selectProductById(id);
		rs.next();
	%>
	<%@ include file="menu.jspf"%>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">상품 수정</h1>
		</div>
	</div>
	<div class="container">
		<form name="newProduct" id="newProductForm" action="./processUpdateProduct.jsp" class="form-horizontal" method="post" enctype ="multipart/form-data">
			<div class ="col-md-5">
				<img src="./resources/images/<%= rs.getString("p_fileName") %>" style="width: 100%" />
				<input type="hidden" name="productImage_old" id="productImage_old" value="<%= rs.getString("p_fileName") %>">
			</div>
			<div class="form-group row">
				<label class="col-sm-2">상품 코드</label>
				<div class="col-sm-3">
					<input type="text" name="productId" id="productId" value="<%= rs.getString("p_id") %>" class="form-control checkNull" onchange="changePruductId()" required>
					<input type="hidden" name="productId_old" id="productId_old" value="<%= rs.getString("p_id") %>" >
					<img src="./resources/images/img_o_15.png" id="samePruductIdStateImg">
					<input type="button" name="sameIdCheckBtn" id="sameIdCheckBtn" class="btn btn-success" value="확인완료" onclick="sameIdCheck()">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">상품명</label>
				<div class="col-sm-3">
					<input type="text" name="name" value="<%= rs.getString("p_name") %>" class="form-control checkNull" required>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">가격</label>
				<div class="col-sm-3">
					<input type="number" name="unitPrice" value="<%= rs.getString("p_unitPrice") %>" class="form-control checkNull" required>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">상세 정보</label>
				<div class="col-sm-5">
					<textarea name="description" cols="50" rows="2"
						class="form-control checkNull"><%= rs.getString("p_description") %></textarea>
				</div>
			</div>
						<div class="form-group row">
				<label class="col-sm-2">제조사</label>
				<div class="col-sm-3">
					<input type="text" name="manufacturer" value="<%= rs.getString("p_manufacturer") %>" class="form-control checkNull" required>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">분류</label>
				<div class="col-sm-3">
					<input type="text" name="category" value="<%= rs.getString("p_category") %>" class="form-control checkNull" required>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">재고 수</label>
				<div class="col-sm-3">
					<input type="number" name="unitsInStock" value="<%= rs.getString("p_unitsInStock") %>" class="form-control checkNull" required>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">상태</label>
				<div class="col-sm-5">
					<%
						String[] checked = {"", "", ""};
						switch(rs.getString("p_condition")){
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
					<input type="button" class="btn btn-primary" value="수정"  onclick="formSubmit()">
				</div>
			</div>
		</form>
	</div>
	<%
		conndb.close();
	%>
	<script src="./resources/js/productValueCheck.js"></script>
	<jsp:include page="footer.jspf"/>
</body>
</html>


