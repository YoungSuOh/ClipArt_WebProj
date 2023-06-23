<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ClipArt Subject 추가</title>
</head>
<form method="POST" action="subject_Insert_do.jsp" enctype="multipart/form-data">

Subject:<input type="text" name="id"><br>
Search : <input type="text" name="search"><br>
사진 : <input type="file" name="fileName"><br>
<br> 
<input type="submit" value="Subject 추가">
</form>
</body>
</html>
