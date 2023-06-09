<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  <%-- JSTL사용을 위함 --%>
<%@ page import="mvc.model.ProductDTO"%>
<%@ page import="java.sql.*" %>
<%-- <jsp:useBean id="productDAO" class="dao.ProductRepository" scope="session" /> 이게 뭐여--%>

<%
	ProductDTO product = (ProductDTO) request.getAttribute("product");
	String productId = (String) request.getAttribute("id");
%>

<html>
<head>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<title>상품 상세 정보</title>
</head>
<body>
	<%@ include file="../menu.jspf"%>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">상품 정보(MVC2)</h1>
		</div>
	</div>
	<div class="container">
	<%
		if(product != null){
	%>
		<div class="row">
			<div class ="col-md-5">
				<img src="./resources/images/<%=product.getFileName()%>" style="width: 100%" />
			</div>
			<div class="col-md-6">
				<h3><%=product.getName()%></h3>
				<p><%=product.getDescription()%>
				<p><b>상품 코드 : </b><span class="badge badge-danger"> <%=product.getId()%></span>
				<p><b>제조사</b> : <%=product.getManufacturer()%>
				<p><b>분류</b> : <%=product.getCategory()%>
				<p><b>상태</b> : <%=product.getCondition()%>
				<p><b>재고 수</b> : <%=product.getUnitsInStock()%>
				<h4><%=product.getUnitPrice()%>원</h4>
				
				<p><form name="addForm" action="./ProductAddCartAction.pdo?id=<%=product.getId()%>" method="post">
					수량<input type="number" name="product_quantity" id="product_quantity" value='1' maxlength="4" style="width:80px" required>개
					<a href="#" class="btn btn-info" onclick="addToCart()"> 상품 담기 &raquo;</a> 
					<a href="./cart.jsp" class="btn btn-warning"> 장바구니 &raquo;</a>
					<a href="/WebMarket1/ProductListAction.pdo" class="btn btn-secondary"> 상품 목록 &raquo;</a>
				</form>
				<%-- 
				<p><form name="addForm" action="./ProductAddCartAction.do?id=<%=product.getId()%>" method="post">
					수량<input type="number" name="product_quantity" id="product_quantity" value='1' maxlength="4" style="width:80px" required>개
					<a href="#" class="btn btn-info" onclick="addToCart()"> 상품 담기 &raquo;</a> 
					<a href="./cart.jsp" class="btn btn-warning"> 장바구니 &raquo;</a>
					<a href="/WebMarket1/ProductListAction.do" class="btn btn-secondary"> 상품 목록 &raquo;</a>
				</form>
				 --%>
			</div>
		</div>
		<hr>
	<%
		}
		else{
			out.print("받은 P_id: "+productId);
			%>
			<H1>선택한 상품이 없음.</H1>
			<!-- <a href="/WebMarket1/ProductListAction.do" class="btn btn-secondary"> 상품 목록 &raquo;</a> -->
			<a href="/WebMarket1/ProductListAction.pdo" class="btn btn-secondary"> 상품 목록 &raquo;</a>
			<%
		}
	%>
	</div>
	<jsp:include page="../footer.jspf"/>
	<script type="text/javascript">
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
