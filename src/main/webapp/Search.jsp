<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Results</title>
    <link rel="stylesheet" type="text/css" href="project.css">
</head>
<body>
    <%
    request.setCharacterEncoding("UTF-8");
    String searchKeyword = request.getParameter("searchKeyword");
    
    Class.forName("org.mariadb.jdbc.Driver");
    String DB_URL = "jdbc:mariadb://localhost:3306/mydb?useSSL=false";
    String DB_USER = "admin";
    String DB_PASSWORD = "1234";
    
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    try {
        con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        String sql = "SELECT * FROM clipart WHERE Search = ?";
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, searchKeyword);
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
    
    <div class="title">Search Results for <%= searchKeyword %></div>
    
    <table border="1" style="width: 100%">
        <tr>
            <th>번호</th>
            <th>Subject</th>
            <th>Search</th>		
            <th>사진</th>		
            <th>클립아트 수정|삭제</th>
        </tr>
    <%
        while (rs.next()) {
    %>
        <tr>
            <td><%= rs.getInt("idx") %></td>			
            <td><%= rs.getString("Subject") %></td>
            <td><%= rs.getString("Search") %></td>
            <td>				
                <a href="project3.jsp?idx=<%= rs.getInt("idx") %>">
                    <img src="./images/<%= rs.getString("savedFileName") %>" width="50" height="50">
                </a>
            </td>			
            <td>			   		
                <a href="ClipArt_delete_do.jsp?idx=<%= rs.getInt("idx") %>">삭제</a>
                <a href="ClipArt_modify.jsp?idx=<%= rs.getInt("idx") %>">수정</a>				
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
