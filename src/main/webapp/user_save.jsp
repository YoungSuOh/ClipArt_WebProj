<%@ page contentType="text/html;charset=utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" type="text/css" href=project.css>
<title>회원가입</title>
</head>
<body>
	<div class="title">
		<button type="button" class="button" style="background-color: white"
			onclick="location.href='project.jsp'">ClipArt Management</button>
	</div>
	<form action="user_save_do.jsp" method="post">
		ID : <input type="text" name="id" maxlength="8" size="8"><br>
		성명 : <input type="text" name="name" maxlength="12" size="12"><br>
		암호 : <input type="password" name="pwd"><br> 
		<input type="submit" value=" 회원 가입 ">
	</form>
</body>
</html>