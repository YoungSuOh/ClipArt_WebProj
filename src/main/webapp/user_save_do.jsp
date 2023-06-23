<%@ page  contentType="text/html;charset=utf-8" 
			import="java.sql.*, myBean.db.*, javax.naming.*" %>
<%
request.setCharacterEncoding("utf-8");		//URL 인코딩 : UTF-8. MySQL 인코딩 : utf8

String id = request.getParameter("id");//1. 사용자로부터 전달 받은 id, name, pwd를 각 변수에 저장 
String name = request.getParameter("name");
String pwd = request.getParameter("pwd");

Article art = new Article();  //2. Article 객체 생성
art.setId(id);			//3. 생성된 Article 객체의 각 멤버변수들에 사용자로부터 전달 받은 값을 저장
art.setName(name);
art.setPwd(pwd);

try {
	ArticleDB db = new ArticleDB();		//4. ArticleDB 객체 생성
	
	db.insertRecord(art);	//5. 레코드 추가
	db.close();	//6. DB연결 종료
}catch(NamingException e) {
	out.print(e);
	return;
}catch(SQLException e) {
	out.print(e);
	return;
}
//7. 리스트 출력페이지 user_list.jsp 로 제어 이동시킴
response.sendRedirect("project.jsp");

%>