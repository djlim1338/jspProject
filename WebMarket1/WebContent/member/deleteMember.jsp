<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<html>
<head>
<link rel="stylesheet" href="../resources/css/bootstrap.min.css" />
<title>회원 삭제</title>
</head>
<body>
	<%@ include file="../menu.jspf" %>
	<%-- <jsp:include page="../menu.jspf"/> --%>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">회원 삭제</h1>
		</div>
	</div>
	<div class="container">
		<form name="newMember" class="form-horizontal"
			method="post" id="mainForm">
			<label>정말 탈퇴하시겠습니까?</label>
			<input class="btn btn-danger" type="button" value="탈퇴" onclick="deleteMember()">
			<input class="btn btn-success" type="button" value="취소" onclick="cancel()">
		</form>	
	</div>
</body>
</html>
<script type="text/javascript">
	var mainForm = document.getElementById("mainForm");
	function deleteMember(){
		mainForm.action="processDeleteMember.jsp";
		mainForm.submit();
	}
	function cancel(){
		mainForm.action="../welcome.jsp";
		mainForm.submit();
	}
</script>
			