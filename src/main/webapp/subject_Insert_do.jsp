<%@ page contentType="text/html;charset=utf-8" 
	import="java.sql.*,java.io.*"  
	import="java.util.*,myBean.multipart.*" 
%>


<%
request.setCharacterEncoding("utf-8");

Class.forName("org.mariadb.jdbc.Driver");
String DB_URL = "jdbc:mariadb://localhost:3306/mydb?useSSL=false";
String DB_USER = "admin";
String DB_PASSWORD= "1234";

//[문2]. 사용자가 id, name, pwd 파라미터에 전송한 값 알아내기
String Subject = request.getParameter("id");
String Search = request.getParameter("search");

//[문3]. upload 이름을 가지는 실제 서버의 경로명 알아내기 
ServletContext context = getServletContext();
String realFolder = context.getRealPath("images");

//[문4]. multipart/form-data 유형의 클라이언트 요청에 대한 모든 Part 구성요소를 가져옴.
Collection<Part> parts = request.getParts();
MyMultiPart multiPart = new MyMultiPart(parts,realFolder);

String originalfileName="";
String savedFileName="";

if(multiPart.getMyPart("fileName") != null) {  //클라이언트에서 업로드한 파일이 없으면 null 임
	//[문5]. 클라이언트가 전송한 원래 파일명 알아내기
	originalfileName = multiPart.getOriginalFileName("fileName");
	
	//[문6]. 서버에 저장된 파일 이름 알아내기(UUID적용된 파일명)
	savedFileName =  multiPart.getSavedFileName("fileName");
}

//DB 연결자 생성(이곳에 빈즈나 Connection Pool로 대체 가능)
Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
	
//[문7]. id, name, pwd, originalFileName, savedFileName을 저장하기 위한 insert 문자열 구성
String sql = "INSERT INTO clipart(Subject, Search, originalfileName, savedFileName) VALUES(?,?,?,?)";
	
PreparedStatement pstmt = con.prepareStatement(sql);

//[문8]. pstmt의 SQL 쿼리 구성
pstmt.setString(1,Subject);
pstmt.setString(2,Search);
pstmt.setString(3,originalfileName);
pstmt.setString(4,savedFileName);




//[문9]. 쿼리 실행

pstmt.executeUpdate();

pstmt.close();
con.close();

response.sendRedirect("project.jsp");
%>