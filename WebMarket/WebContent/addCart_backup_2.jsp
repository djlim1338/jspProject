<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="dto.Product"%>
<%@ page import="dao.ProductRepository"%>

<%
	String id = request.getParameter("id");

	ProductRepository dao = ProductRepository.getInstance();
	
	ArrayList<Product> cartList = (ArrayList<Product>) session.getAttribute("cartlist");
	ArrayList<Integer> cartListNumber = (ArrayList<Integer>) session.getAttribute("cartlistNumber");
	int list_counter = 0;  // 리스트 계수기
	Product goods = null;
	if (cartList == null) { 
		cartList = new ArrayList<Product>();
		session.setAttribute("cartlist", cartList);
	}
	else{
		for (list_counter = 0; list_counter<cartList.size(); list_counter++){
			goods = cartList.get(list_counter);
			if(goods.getProductId().equals(id)) break;
		}
	}
	
	if(list_counter == cartList.size()){
		goods = dao.getProductById(id);
		goods.setQuantity(1);
		cartList.add(goods);
	}
	else{
		goods.setQuantity(goods.getQuantity() + 1);
	}

	response.sendRedirect("product.jsp?id=" + id + "&addCart=1");
%>
