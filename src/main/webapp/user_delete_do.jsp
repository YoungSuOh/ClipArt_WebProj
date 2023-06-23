<%@ page  contentType="text/html;charset=utf-8" 
		import="java.sql.*, myBean.db.*, javax.naming.*" %>
<%
request.setCharacterEncoding("utf-8");		

String idx = request.getParameter("idx");	//1. 사용자가 전달한 idx 알아내기 

try {
	ArticleDB db = new ArticleDB();

	//2. 지정한 idx의 레코드 삭제하기

	db.deleteRecord(Integer.parseInt(idx));	
	db.close();
}catch(SQLException e) {
	out.print(e);
	return;
}catch(NamingException e) {
	out.print(e);
	return;
}

//만일, 저장이 안되면, 아래 코드 주석처리하여 오류 확인할 것.
response.sendRedirect("user_list.jsp");
%>