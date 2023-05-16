<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="dto.Product"%>
<%@ page import="dao.ProductRepository"%>
<%@ page import="java.io.File" %>  <%-- 파일 관리 --%>

<%
	String id = request.getParameter("id");
	ProductRepository dao = ProductRepository.getInstance();
	Product product = dao.getProductById(id);
	
	String realFolder = request.getServletContext().getRealPath("/resources/images");  // save dirctory 경로
	String filePath = realFolder + "\\" + product.getFilename();  // 실제 파일 특정
	File file = new File(filePath);
	
	dao.removeProduct(product);
	if(file.exists()) file.delete();
	

	response.sendRedirect("products.jsp");
	//response.sendRedirect("products_get.jsp?pageStr=list");
%></html>
