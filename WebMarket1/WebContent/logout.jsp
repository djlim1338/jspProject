<%@ page contentType="text/html; charset=utf-8"%>

<%
	session.invalidate();  // 세션 초기화.
	//response.sendRedirect("addProduct.jsp");
%>

<script>
	// 뒤로가기 + 새로고침 https://issac-developer.tistory.com/16
	//location.href = document.referrer;
	location.href = "./products.jsp;"
</script>
