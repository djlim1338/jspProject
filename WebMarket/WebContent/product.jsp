<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="dto.Product"%>
<%@ page import="dao.ProductRepository"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  <%-- JSTL사용을 위함 --%>
<jsp:useBean id="productDAO" class="dao.ProductRepository" scope="session" />
<html>
<head>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<title>상품 상세 정보</title>
</head>
<body>
	<%@ include file="menu.jspf"%>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">상품 정보</h1>
		</div>
	</div>
	<%
		String id = request.getParameter("id");
		//Product product = productDAO.getProductById(id);
		ProductRepository dao = ProductRepository.getInstance();
		Product product = dao.getProductById(id);
	%>
	<div class="container">
		<div class="row">
			<div class ="col-md-5">
				<img src="./resources/images/<%=product.getFilename()%>" style="width: 100%" />
			</div>
			<div class="col-md-6">
				<h3><%=product.getPname()%></h3>
				<p><%=product.getDescription()%>
				<p><b>상품 코드 : </b><span class="badge badge-danger"> <%=product.getProductId()%></span>
				<p><b>제조사</b> : <%=product.getManufacturer()%>
				<p><b>분류</b> : <%=product.getCategory()%>
				<p><b>상태</b> : <%=product.getCondition()%>
				<p><b>재고 수</b> : <%=product.getUnitsInStock()%>
				<h4><%=product.getUnitPrice()%>원</h4>
				
				<p><form name="addForm" action="./addCart.jsp?id=<%=product.getProductId()%>" method="post">
					수량<input type="number" name="product_quantity" id="product_quantity" value='1' maxlength="4" style="width:80px" required>개
					<!-- <a href="./addCart.jsp?id=<%=product.getProductId()%>" id="addCart" class="btn btn-info"> 상품 담기 &raquo;</a> -->
					<a href="#" class="btn btn-info" onclick="addToCart()"> 상품 담기 &raquo;</a> 
					<a href="./cart.jsp" class="btn btn-warning"> 장바구니 &raquo;</a>
					<a href="./products.jsp" class="btn btn-secondary"> 상품 목록 &raquo;</a>
				</form>
				
				<!-- 
				<c:if test="<%= loginState %>">
					<a href="./processRemoveProduct.jsp?id=<%=product.getProductId()%>" class="btn btn-danger" role="button" > 삭제 &raquo;</a>
				</c:if> 
				-->
			</div>
		</div>
		<hr>
	</div>
	<jsp:include page="footer.jspf"/>
	<script type="text/javascript">
		/*
		document.getElementById('addCart').onclick = function(event){
			if (confirm("상품을 장바구니에 추가하시겠습니까?")) {
				alert("장바구니에 추가되었습니다.")
				return true
			} else {		
				alert("취소하셨습니다.")
				return false
			}
		}
		*/
		function addToCart() {
			var productQuantity = document.getElementById('product_quantity');
			
			if(!(productQuantity.value > 0)){
				alert("수량은 1개 이상이어야 합니다.");
				document.addForm.reset();
				return;
			}
			
			if (confirm("상품을 장바구니에 추가하시겠습니까? 수량:["+productQuantity.value+"]")) {
				alert("장바구니에 추가했습니다! 수량:["+productQuantity.value+"]")
				document.addForm.submit();
			} else {		
				alert("취소했습니다.")
				return;
				//document.addForm.reset();  // reset시 입력값이 초기화됨. 그냥 두기위해 return
			}
		}

	</script>
	
</body>
</html>
