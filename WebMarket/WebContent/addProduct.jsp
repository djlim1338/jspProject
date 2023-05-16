<%@ page contentType="text/html; charset=utf-8"%>
<html>
<head>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<title>상품 등록</title>
</head>
<body>
	<%@ include file="menu.jspf"%>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">상품 등록</h1>
		</div>
	</div>
	<div class="container">
		<div class="text-right"> 
			<a href="logout.jsp" class="btn btn-sm btn-success pull-right">logout</a>
		</div>
		<form name="newProduct" id="newProductForm" action="./processAddProduct.jsp" class="form-horizontal" method="post" enctype ="multipart/form-data">
			<div class="form-group row">
				<label class="col-sm-2">상품 코드</label>
				<div class="col-sm-3">
					<input type="text" name="productId" id="productId" class="form-control checkNull" onchange="changePruductId()" required>
					<input type="hidden" name="productIdLastCheck">
					<img src="./resources/images/img_x_15.png" id="samePruductIdStateImg">
					<input type="button" name="sameIdCheckBtn" id="sameIdCheckBtn" class="btn btn-danger" value="중복확인" onclick="sameIdCheck()">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">상품명</label>
				<div class="col-sm-3">
					<input type="text" name="name" class="form-control checkNull" required>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">가격</label>
				<div class="col-sm-3">
					<input type="number" name="unitPrice" class="form-control checkNull" required>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">상세 정보</label>
				<div class="col-sm-5">
					<textarea name="description" cols="50" rows="2"
						class="form-control checkNull"></textarea>
				</div>
			</div>
						<div class="form-group row">
				<label class="col-sm-2">제조사</label>
				<div class="col-sm-3">
					<input type="text" name="manufacturer" class="form-control checkNull" required>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">분류</label>
				<div class="col-sm-3">
					<input type="text" name="category" class="form-control checkNull" required>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">재고 수</label>
				<div class="col-sm-3">
					<input type="number" name="unitsInStock" class="form-control checkNull" required>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">상태</label>
				<div class="col-sm-5">
					<input type="radio" name="condition" value="New" > 신규 제품 
					<input type="radio" name="condition" value="Old" > 중고 제품 
					<input type="radio" name="condition" value="Refurbished" > 재생 제품
				</div>
			</div>
			<div class ="form-group row">
			<label class ="col-sm-2">이미지</label>
				<div class ="col-sm-5">
 					<input type="file" name="productImage" class="form-control checkNull">
 				</div>
 			</div>
			<div class="form-group row">
				<div class="col-sm-offset-2 col-sm-10 ">
					<input type="button" class="btn btn-primary" value="등록" onclick="formSubmit()" >
				</div>
			</div>
		</form>
	</div>
	<script src="./resources/js/productValueCheck.js"></script>
	<jsp:include page="footer.jspf"/>
</body>
</html>
			
			
