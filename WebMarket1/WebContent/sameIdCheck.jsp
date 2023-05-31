<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="dao.ProductRepository"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  <%-- JSTL사용을 위함 --%>
<%@ page import="database.ConnDB"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<title>아이디 중복확인</title>
</head>
<body>
	<%
		String pruductId = request.getParameter("id");
	
		//ProductRepository dao = ProductRepository.getInstance();

		boolean sameState;
		ConnDB conndb = new ConnDB();
		ResultSet rs = conndb.selectProductById(pruductId);
		if(rs.next())sameState = true;
		else sameState = false;
		conndb.close();
	%>
	<div class="container">
		<c:choose>
			<c:when test="<%= sameState %>">
				<p class="font-weight-bold">해당 아이디는[<%= pruductId %>] 이미 사용중입니다!
			</c:when>
			<c:otherwise>
				<p class="font-weight-bold">해당 아이디는[<%= pruductId %>] 사용 가능합니다!
				<input type="button" class="btn btn-primary"  value="사용하기" onclick="useId()"/>
			</c:otherwise>
		</c:choose>
		<input type="button" class="btn btn-danger" value="취소" onclick="cancelId()"/>
		<!-- <p class="font-weight-bold">테스트 문장 -->
	</div>
	<script src="./resources/js/productValueCheck.js"></script>
	<script type="text/javascript">
		var samePruductIdStateImg = opener.document.getElementById("samePruductIdStateImg");
		var samePruductIdBtn = opener.document.getElementById("sameIdCheckBtn")
		
		function cancelId(){
			window.close();
		}
		function useId(){
			//samePruductIdStateImg.src="./resources/images/img_o_15.png";
			//samePruductIdBtn.value="확인완료";
			samePruductIdStateImg.src=btnSrcO;
			samePruductIdBtn.value=btnStrO;
			samePruductIdBtn.classList.replace("btn-danger", "btn-success");
			window.close();
		}
	</script>
</body>
</html>