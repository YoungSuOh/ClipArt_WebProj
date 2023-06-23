<%@ page  contentType="text/html;charset=utf-8" import="java.sql.*, myBean.db.*, javax.naming.*" %>
<%-- //ⓐpage 지시어에 필요한 패키지 import --%>
<%
//ⓑ JDBC Driver(Connector) 클래스 로드 
Class.forName("org.mariadb.jdbc.Driver");
String DB_URL = "jdbc:mariadb://localhost:3306/mydb?useSSL=false";
		//★주의 : mydb를 자신이 생성한 DB이름으로 변경하여 테스트 할것~!
String jdbc_driver = "org.mariadb.jdbc.Driver";
String DB_USER = "admin";
String DB_PASSWORD= "1234";

Connection con= null;
Statement stmt = null;
ResultSet rs   = null;

try {
	Class.forName(jdbc_driver);
    con = DriverManager.getConnection(DB_URL,DB_USER,DB_PASSWORD); //ⓒ 연결자 획득

    
    stmt = con.createStatement();//ⓓ Statement 객체 생성

    
    String query = "SELECT * FROM member"; //ⓔ member 테이블의 모든 필드를 검색하는 쿼리 구성
    rs = stmt.executeQuery(query); //ⓕ 쿼리 실행

%>
<table border="1" style="border-collapse:collapse">
<tr style="background-color:#dddddd">
	<th>번호</th>
	<th>ID</th>
	<th>성명</th>
	<th>암호</th>
	<th>비고 </th>
</tr>
<%
    while(rs.next()) {
%><tr>
<td><%=rs.getInt("idx")  /*ⓖ idx 값 출력하기*/%></td>
<td><%=rs.getString(2)%></td>
<td><%=rs.getString("name")  /*ⓗ name 값 출력하기*/%></td>
<td><%=rs.getString("pwd")%></td>

<TD>

<!-- ⓘ 삭제 링크 구성하기 -->
<a href="user_delete_do.jsp?idx=<%=rs.getInt("idx")%>">삭제</a>

<!-- ⓙ javascript의 location.href 를 사용하여 수정 버튼 만들기 -->

<input type="button" value="수정" onClick="location.href='user_modify.jsp?idx=<%=rs.getInt("idx")%>'">
</TD>

</tr>
<%
    } // end while
%></table>
<%

	rs.close();     // ResultSet 종료

    stmt.close();     // Statement 종료

    con.close(); 	// Connection 종료

} catch (SQLException e) {
      out.println("err:"+e.toString());
      return;
} 
%>
<A href="user_save.jsp">회원 추가</A>