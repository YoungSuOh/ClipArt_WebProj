<%@ page contentType="text/html;charset=utf-8" 
			import="java.sql.*, myBean.db.*, javax.naming.*"%>
<%--1. 필요한 클래스를 import문에 추가  --%>
<%
String idx = request.getParameter("idx");			//2. 사용자가 선택한 idx 가져오기 
try {
	ArticleDB db = new ArticleDB();
	Article art = db.getRecord(Integer.parseInt(idx));	  //3. idx에 해당하는 레코드 가져오기
%>
<HTML>
<HEAD></HEAD>
<BODY>
<FORM action="user_modify_do.jsp" method="post">
Number : <INPUT type="text" name="idx" readOnly value="<%=idx %>"><BR>
ID : <INPUT type="text" name="id" value="<%=art.getId()%>"><BR>
성명 : <INPUT type="text" name="name" maxlength="12" size="12" value="<%=art.getName()%>"><BR>
암호 : <INPUT type="password" name="pwd" value="<%=art.getPwd()%>"><BR>
<INPUT type="submit" value=" 수  정 ">
</FORM>
</BODY>
</HTML>
<%
	db.close();

}catch(SQLException e) {
	out.print(e);
	return;
}catch(NamingException e) {
	out.print(e);
	return;
}
%>