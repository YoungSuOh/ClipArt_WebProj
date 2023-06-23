<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*, myBean.db.*, javax.naming.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ClipArt Management</title>
<link rel="stylesheet" type="text/css" href=project.css>
<script>
	function openLogin() {		
		window.open('login.jsp', 'Login', 'width=400,height=300');
	}
	
	function openSubject() {		
		window.open('InsertSubject.jsp', 'width=400,height=300');
	}
	
	window.onload = function() {
		var loginButton = document.getElementById("loginButton");
		if (loginButton.textContent === "logout") {
			loginButton.onclick = function() {
				loginButton.textContent = "login";
			};
		}
	};
</script>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");
int idx = Integer.parseInt(request.getParameter("idx"));

Class.forName("org.mariadb.jdbc.Driver");
String url = "jdbc:mariadb://localhost:3306/mydb?useSSL=false";

Connection con = DriverManager.getConnection(url, "admin", "1234");

//[문2] member테이블에서 idx에 해당하는 레코드 검색하기 위한 SQL문 구성 
String sql = "SELECT * FROM clipart WHERE idx=?";
PreparedStatement pstmt = con.prepareStatement(sql);
pstmt.setInt(1,idx);

//[문3] 쿼리 실행
ResultSet rs = pstmt.executeQuery();

//[문4] 레코드 오프셋 커서 이동
rs.next();

%>	
	<header>
		<div class="title">
			<button type="button" class="button" style="background-color: white" onclick="location.href='project.jsp'">ClipArt Management</button>
			<div class="search"> 	
				<input type="text" placeholder="클립아트 검색">
			</div>
			<button type="button" class="title-items" style="background-color: white" id="loginButton" onclick="openLogin()">login</button>
			<button type="button" class="title-items" style="background-color: white" onclick="window.open('user_save.jsp')">join</button>			
		</div>
	</header>
	<br><br><br><br>	
	<section>
	<h2 style="font-family:Bauhaus 93;">Subject >  <%= rs.getString("Subject")%> >  <%= rs.getString("Search")%></h2>
	<div class="article2">	
	<div class="article3"><img src="./images/<%= rs.getString("savedFileName") %>"></div>
	<div class="article4" style=margin-left:20px;>
	Number: <%=idx %><br>	
	Subject:  <%= rs.getString("Subject")%><br>	
	Search:  <%= rs.getString("Search")%><br>
	Modified:  2023.06.17 <br>
	FileName:  <%= rs.getString("originalfileName")%>
	</div>	
	</div>
	</section>
</body>
</html>
<%
rs.close();
pstmt.close();
con.close();
%>