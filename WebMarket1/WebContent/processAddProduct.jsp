<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.oreilly.servlet.multipart.*"%>
<%@ page import="java.util.*" %>
<%@ page import="dto.Product"%>
<%@ page import="dao.ProductRepository"%>
<%@ page import="database.ConnDB"%>

<%
	request.setCharacterEncoding("UTF-8");

	String filename = "";
	//String savePath = request.getServletContext().getRealPath("/resources/images");  // save dirctory 경로
	//String realFolder = savePath;
	String realFolder = request.getServletContext().getRealPath("/resources/images");  // save dirctory 경로
	//String realFolder = "D:/NAS/unversityData/jsp/4_1/practice/WebMarket/WebContent/resources/images";
	
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
	if(fileName == null) fileName = "P_none.png";

	ProductRepository dao = ProductRepository.getInstance();

	Product newProduct = new Product();
	newProduct.setProductId(productId);
	newProduct.setPname(name);
	newProduct.setUnitPrice(price);
	newProduct.setDescription(description);
	newProduct.setManufacturer(manufacturer);
	newProduct.setCategory(category);
	newProduct.setUnitsInStock(stock);
	newProduct.setCondition(condition);
	newProduct.setFilename(fileName);

	dao.addProduct(newProduct);
	
	ConnDB conndb = new ConnDB();
	conndb.addProduct(newProduct);
	conndb.close();

	response.sendRedirect("products.jsp");
	//response.sendRedirect("products_get.jsp?pageStr=list");
%>

