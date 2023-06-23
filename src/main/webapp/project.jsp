<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*, myBean.db.*, javax.naming.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ClipArt Management</title>
<link rel="stylesheet" type="text/css" href="project.css">
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
request.setCharacterEncoding("UTF-8");
String nameStr = request.getParameter("myVariable1");
String Search = request.getParameter("myVariable2");
%>
<%
Class.forName("org.mariadb.jdbc.Driver");
String DB_URL = "jdbc:mariadb://localhost:3306/mydb?useSSL=false";
String DB_USER = "admin";
String DB_PASSWORD= "1234";

Connection con = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
try {
	//[문1]. DB 연결자 정보를 획득한다.
	con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
	
	//[문2]. clipart 테이블에서 모든 필드의 레코드를 가져오는 쿼리 문자열을 구성한다. 
	String sql = "SELECT * FROM clipart";
	
	//[문3]. SQL문을 실행하기 위한 PreparedStatement 객체를 생성한다.
	pstmt = con.prepareStatement(sql);

	//[문4]. 쿼리 실행
	rs = pstmt.executeQuery();
%>
	<header>
    <div class="title">
        <button type="button" class="button" style="background-color: white" onclick="location.href='project.jsp'">ClipArt Management</button>            
        <button type="button" class="title-items" style="background-color: white" id="loginButton" onclick="openLogin()">login</button>
        <button type="button" class="title-items" style="background-color: white" onclick="window.open('user_save.jsp')">join</button>
    </div>
</header>
	<br><br><br><br>
	<div class="title"><a href="InsertSubject.jsp">Input ClipArt Subject</a></div> 	
<table border="1" style="width: 100%">
	<tr>
		<th>번호</th>
		<th>Subject</th>
		<th>Search</th>		
		<th>사진</th>		
		<th>Subject 수정|삭제</th>
	</tr>
<%
    Set<String> processedSubjects = new HashSet<>();
	while (rs.next()) {
		String subject = rs.getString("Subject");
		    
		
		if (processedSubjects.contains(subject)) {
			continue;
		}
		    
		processedSubjects.add(subject);
%>
		<tr>
			<td><%= rs.getInt("idx") %></td>			
			<td><%= subject %></td>
			<td><%= rs.getString("Search") %></td>
			<td>				
				<a href="project2.jsp?idx=<%= rs.getInt("idx") %>">
                <img src="./images/<%= rs.getString("savedFileName") %>" width="50" height="50"></a>
			</td>			
			<td>			   		
				<a href="subject_delete_do.jsp?idx=<%= rs.getInt("idx") %>">삭제</a>
				<a href="subject_modify.jsp?idx=<%= rs.getInt("idx") %>">수정</a>				
			</td>
		</tr>
<%
	}
	
	rs.close();
	pstmt.close();
	con.close();
} catch (SQLException e) {
	out.println(e);
}
%>
</table>
<br><br>
<div class="search"> 	
            <form action="Search.jsp" method="GET">
                <input type="text" name="searchKeyword" placeholder="클립아트 검색">
                <input type="submit" value="검색">
            </form>
        </div>
</body>
</html>
