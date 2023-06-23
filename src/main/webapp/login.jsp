<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*, myBean.db.*, javax.naming.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" type="text/css" href=project.css>
<title>로그인</title>

</head>
<body>
	<div class="title">
		<button type="button" class="button" style="background-color: white"
			onclick="location.href='project.jsp'">ClipArt Management</button>			
	</div>
	<fieldset>
	<legend>회원정보</legend>
	아이디:<input type="text" name="id" size="20" maxlength="12"><br>
	비밀번호:<input type="password" name="pwd" size="20" maxlength="12"><br>
	<p></p><p></p><p></p><p></p><p></p><p></p>	
	<button type="button" onclick="loginClicked()">로그인</button>
	<br>
	<a href="user_save.jsp">아직 회원이 아니신가요?</a>
	</fieldset>

	<script>	
	function loginClicked() {
		// 로그인 버튼 클릭 시 메인 페이지의 login 버튼을 logout으로 변경
		window.opener.document.getElementById("loginButton").textContent = "logout";
		window.close();
	}
	</script>
</body>
</html>
