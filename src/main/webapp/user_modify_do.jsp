<%@ page contentType="text/html;charset=utf-8" 
			import="myBean.db.*, java.sql.*, javax.naming.NamingException"%>
<%
request.setCharacterEncoding("utf-8");
String sidx = request.getParameter("idx"); //1. 사용자가 수정한 idx, id, name, pwd 알아내기 
String sid = request.getParameter("id");
String name = request.getParameter("name");
String pwd = request.getParameter("pwd");

Article art = new Article();
art.setIdx(Integer.parseInt(sidx));  //2. Article 객체의 idx, id, name, pwd 지정하기
art.setId(sid);
art.setName(name);
art.setPwd(pwd);

try {
	ArticleDB db = new ArticleDB();

	//3. 레코드 수정하기
	db.updateRecord(art);
	db.close();	
}catch(SQLException e) {
	out.print(e);
	return;
}catch(NamingException e) {
	out.print(e);
	return;
}

//4. 제어를 user_list.jsp 페이지로 이동시키기
response.sendRedirect("user_list.jsp");
%>