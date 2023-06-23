<%@ page contentType="text/html;charset=utf-8"
		import="java.sql.*"  %>
<%-- [문1] error.jsp 파일 생성 --%>
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
<!DOCTYPE html>
<html>
<head><title>사용자 정보 수정</title></head>
<body>
<!-- [문5] 수정된 정보를 저장하기 위한 form문 구성과 member 테이블에 저장된 idx 레코드의 정보를 입력 양식에 출력  -->

<form method="POST" action="subject_modify_do.jsp" enctype="multipart/form-data">
번호: <%=idx %> <input type="hidden" name="idx" value="<%=idx %>"><br>
Subject:<input type="text" name="Subject" value="<%= rs.getString("Subject")%>"><br>
Search : <input type="text" name="Search" value="<%= rs.getString("Search")%>"><br>
파일명: <%=  rs.getString("originalfileName")%>

<!--[문6] 저장된 파일명을 가지는 이미지 출력 -->
<img src="./images/<%=rs.getString("savedFilename") %>" width="100" height="100">

<p>변경할 사진 : <input type="file" name="fileName">
</p> 
<input type="submit" value="수  정">
</form>
</body>
</html>
<%
rs.close();
pstmt.close();
con.close();
%>