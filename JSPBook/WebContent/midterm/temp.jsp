<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>온도 단위 변환기</h2>
	<hr>
	<% 
		double temp = Double.parseDouble(request.getParameter("temperature"));;
		String unit1 = request.getParameter("unit");
		double result=0;
		switch(unit1){
			case "Celsius": result = 5.0/9.0*(temp-32.0);break;
			case "Fahrenheit": result = 9.0/5.0*temp+32.0;break;
		}
	%>
	<h3>계산 결과: <%= result %> <%= unit1 %> </h3>
	<hr>
</body>
</html>