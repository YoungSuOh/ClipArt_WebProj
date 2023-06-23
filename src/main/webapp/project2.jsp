<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*, myBean.db.*, javax.naming.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ClipArt Management - Subject Page</title>
    <link rel="stylesheet" type="text/css" href="project.css">
</head>
<body>
    <%
    request.setCharacterEncoding("UTF-8");
    int idx = Integer.parseInt(request.getParameter("idx"));
    
    Class.forName("org.mariadb.jdbc.Driver");
    String DB_URL = "jdbc:mariadb://localhost:3306/mydb?useSSL=false";
    String DB_USER = "admin";
    String DB_PASSWORD= "1234";
    
    Connection con=null;
    PreparedStatement pstmt = null;
    ResultSet rs=null;
    try {
        con = DriverManager.getConnection(DB_URL,DB_USER,DB_PASSWORD);
        String sql = "SELECT * FROM clipart WHERE idx = ?";
        pstmt = con.prepareStatement(sql);
        pstmt.setInt(1, idx);
        rs = pstmt.executeQuery();
        
        if (rs.next()) {
            String subject = rs.getString("Subject");
    %>
    <header>
    <div class="title">
        <button type="button" class="button" style="background-color: white" onclick="location.href='project.jsp'">ClipArt Management</button>            
        <button type="button" class="title-items" style="background-color: white" id="loginButton" onclick="openLogin()">login</button>
        <button type="button" class="title-items" style="background-color: white" onclick="window.open('user_save.jsp')">join</button>
    </div>
</header>
	<br><br>
    <h1><%= subject %> 페이지</h1>
    
    <%
            // 분야에 해당하는 내용을 가져오는 로직을 구현합니다.
            // 예시로 해당 분야의 이미지 목록을 출력합니다.
            
            String subjectSql = "SELECT * FROM clipart WHERE Subject = ?";
            pstmt = con.prepareStatement(subjectSql);
            pstmt.setString(1, subject);
            rs = pstmt.executeQuery();
    %>
    <div class="title"><a href="InsertClipArt.jsp">input ClipArt</a></div> 	
    <table border="1" style="width: 100%">
        <tr>
            <th>번호</th>
            <th>Subject</th>
            <th>Search</th>		
            <th>사진</th>		
            <th>클립아트 수정|삭제</th>
        </tr>
    <%
            while(rs.next()) {
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
        }
        
        rs.close();
        pstmt.close();
        con.close();
    } catch(SQLException e) {
        out.println(e);
    }
    %>
    </table>
</body>
</html>
