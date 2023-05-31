<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.io.File" %>  <%-- 파일 관리 --%>
<%@ page import="database.ConnDB"%>
<%@ page import="java.sql.*" %>

<%
	String id = request.getParameter("id");
	
	ConnDB conndb = new ConnDB();
	
	String realFolder = request.getServletContext().getRealPath("/resources/images");  // save dirctory 경로
	ResultSet rs = conndb.selectProductById(id);
	if(rs.next()){
		String filePath = realFolder + "\\" + rs.getString("p_fileName");  // 실제 파일 특정
		File file = new File(filePath);
		if(file.exists()) file.delete();
	}
	
	conndb.deleteProductById(id);
	
	conndb.close();
	

	response.sendRedirect("products.jsp");
	//response.sendRedirect("products_get.jsp?pageStr=list");
%></html>
