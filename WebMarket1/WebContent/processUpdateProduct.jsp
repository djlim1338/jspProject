<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.oreilly.servlet.multipart.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.File" %>  <%-- 파일 관리 --%>
<%@ page import="database.ConnDB"%>
<%@ page import="java.sql.*" %>

<%
	request.setCharacterEncoding("UTF-8");

	String filename = "";
	String realFolder = request.getServletContext().getRealPath("/resources/images");  // save dirctory 경로
	
	String encType = "utf-8";
	int maxSize = 5 * 1024 * 1024;
	MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
	

	String productId = multi.getParameter("productId");
	String name = multi.getParameter("name");
	String unitPrice = multi.getParameter("unitPrice");
	String description = multi.getParameter("description");
	String manufacturer = multi.getParameter("manufacturer");
	String category = multi.getParameter("category");
	String unitsInStock = multi.getParameter("unitsInStock");
	String condition = multi.getParameter("condition");

	String productIdOld = multi.getParameter("productId_old");  // 수정 전 상품 아이디.
	String fileNameOld = multi.getParameter("productImage_old");  // 수정 전 이미지 파일 이름
	
	
	Integer price;

	if (unitPrice.isEmpty())
		price = 0;
	else
		price = Integer.valueOf(unitPrice);

	long stock;

	if (unitsInStock.isEmpty())
		stock = 0;
	else
		stock = Long.valueOf(unitsInStock);
	
	Enumeration files = multi.getFileNames();
	
	
	
	String fname = (String) files.nextElement();
	String fileName = multi.getFilesystemName(fname);
	
	ConnDB conndb = new ConnDB();
	if(fileName == null) fileName = fileNameOld;
	else{
		ResultSet rs = conndb.selectProductById(productIdOld);
		if(rs.next()){
			String filePath = realFolder + "\\" + rs.getString("p_fileName");  // 실제 파일 특정
			File file = new File(filePath);
			if(file.exists()) file.delete();
		}
	}
	//conndb.updateProductById(productIdOld, product);
	conndb.updateProductById(
			productIdOld,
			productId, 
			name, 
			price, 
			description, 
			manufacturer, 
			category, 
			stock, 
			condition, 
			fileName);
	conndb.close();

	//response.sendRedirect("products.jsp");
	//response.sendRedirect("products_get.jsp?pageStr=list");
	//response.sendRedirect("product.jsp?id="+productId);
	response.sendRedirect("products_get.jsp?pageStr=update");
%>

