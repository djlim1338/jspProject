<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ page import="database.ConnDB"%>

<%
	request.setCharacterEncoding("UTF-8");

	String id = request.getParameter("id");
	String password = request.getParameter("password");
	String name = request.getParameter("name");
	String gender = request.getParameter("gender");
	String year = request.getParameter("birthyy");
	String month = request.getParameterValues("birthmm")[0];
	String day = request.getParameter("birthdd");
	String birth = year + "/" + month + "/" + day;
	String mail1 = request.getParameter("mail1");
	String mail2 = request.getParameterValues("mail2")[0];
	String mail = mail1 + "@" + mail2;
	String phone = request.getParameter("phone");
	String address = request.getParameter("address");

	Date currentDatetime = new Date(System.currentTimeMillis());
	java.sql.Date sqlDate = new java.sql.Date(currentDatetime.getTime());
	java.sql.Timestamp timestamp = new java.sql.Timestamp(currentDatetime.getTime());
	
	
	
	
	ConnDB conndb = new ConnDB();
	boolean addMemberState = conndb.addMember(
			id, 
			password,
			name, 
			gender, 
			birth, 
			mail, 
			phone, 
			address, 
			timestamp.toString());
	
	if(addMemberState == true){
		response.sendRedirect("resultMember.jsp?msg=1");
		/* out.print("회원가입 성공 <br>");
		out.print("add member fail");
		out.print(id + "<br>");
		out.print(password + "<br>");
		out.print(name + "<br>");
		out.print(gender + "<br>");
		out.print(birth + "<br>");
		out.print(mail + "<br>");
		out.print(phone + "<br>");
		out.print(address + "<br>");
		out.print(timestamp.toString() + "<br>"); */
	}
	else{
		out.print("add member fail <br>");
		out.print(id + "<br>");
		out.print(password + "<br>");
		out.print(name + "<br>");
		out.print(gender + "<br>");
		out.print(birth + "<br>");
		out.print(mail + "<br>");
		out.print(phone + "<br>");
		out.print(address + "<br>");
		out.print(timestamp.toString() + "<br>");
	}
	conndb.close();
%>

<%-- <sql:setDataSource var="dataSource"
	url="jdbc:mysql://localhost:3306/WebMarketDB"
	driver="com.mysql.jdbc.Driver" user="root" password="1234" />

<sql:update dataSource="${dataSource}" var="resultSet">
   INSERT INTO member VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
   <sql:param value="<%=id%>" />
	<sql:param value="<%=password%>" />
	<sql:param value="<%=name%>" />
	<sql:param value="<%=gender%>" />
	<sql:param value="<%=birth%>" />
	<sql:param value="<%=mail%>" />
	<sql:param value="<%=phone%>" />
	<sql:param value="<%=address%>" />
	<sql:param value="<%=timestamp%>" />
</sql:update>

<c:if test="${resultSet>=1}">
	<c:redirect url="resultMember.jsp?msg=1" />
</c:if> --%>

