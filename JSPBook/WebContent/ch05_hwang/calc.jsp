<%@ page contentType="text/html; charset=utf-8"%>
<html>
<head>
<meta charset="UTF-8">
<title>계산기 JSP</title>
</head>
<body>
	<h2>계산기 JSP</h2>
	<% 
		double num1 = Double.parseDouble(request.getParameter("n1"));
		double num2 = Double.parseDouble(request.getParameter("n2"));
		double result = 0;

		switch(request.getParameter("op")){
			case "+" : result = num1 + num2; break;
			case "-" : result = num1 - num2; break;
			case "*" : result = num1 * num2; break;
			case "/" : result = num1 / num2; break;
		}
	%>
	<hr>
	<h4>계산 결과 : <%= result %></h4>
</body>
</html>
