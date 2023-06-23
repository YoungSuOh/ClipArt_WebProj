package myBean.db;


import java.sql.*;
import javax.naming.NamingException;
import myBean.db.DsCon;
//import myBean.db.*;   //필요 패키지 선언

public class ArticleDB {
   private Connection con;   
   private PreparedStatement pstmt;
   private ResultSet rs;

   //1. 생성자 선언 : Connection 인스턴스가 생성되도록 한다.
   public ArticleDB()throws SQLException, NamingException {
      con = DsCon.getConnection();
      
   }
   
   public void insertRecord(Article art) throws SQLException {
      String sql = "INSERT INTO member(id, name, pwd) VALUES(?, ?, ?)";

      pstmt = con.prepareStatement(sql);
      pstmt.setString(1, art.getId());
      pstmt.setString(2, art.getName());
      pstmt.setString(3, art.getPwd());
   
      pstmt.executeUpdate();
   }   

   //2. DB에 레코드 갱신을 위한 updateRecord() 메소드 선언
   //   @param : Article
   //   @return : void

   public void updateRecord(Article art) throws SQLException {
      String sql = "UPDATE member SET id=?, name=?, pwd=? WHERE idx=?";
      
      pstmt = con.prepareStatement(sql);
      pstmt.setString(1, art.getId());
      pstmt.setString(2, art.getName());
      pstmt.setString(3, art.getPwd());
      pstmt.setInt(4, art.getIdx());
   
      pstmt.executeUpdate();
   }

   //3. 지정된 idx에 해당하는 DB에 저장된 레코드를 반환하는 getRecord() 선언
   //   @param : int
   //    @return : Article
   //   @throws : SQLException
   
   public Article getRecord(int idx) throws SQLException {
      String sql = "SELECT id, name, pwd FROM member WHERE idx=?";
      
      pstmt = con.prepareStatement(sql);
      pstmt.setInt(1, idx);
      
      rs = pstmt.executeQuery();
      rs.next();
      
      Article art = new Article();
      art.setId(rs.getString("id"));
      art.setName(rs.getString("name"));
      art.setPwd(rs.getString("pwd"));
      art.setIdx(idx);
      
      
      return art;
   }
   
   
   
   
   //4. 지정된 idx에 해당하는 레코드 삭제 deleteRecord() 선언
   //   @param : int
   //   @return : void
   //   @throws : SQLException
   public void deleteRecord(int idx) throws SQLException {
      String sql = "DELETE FROM member WHERE idx=?";

      pstmt = con.prepareStatement(sql);
      pstmt.setInt(1, idx);
      
      pstmt.executeUpdate();
   }
   
   
   
   
   
   //5. open된 모든 연결자 정보를 제거
   //   @param is'nt 
   //   @return void
   public void close() throws SQLException {
      if(rs != null) rs.close();
      if(pstmt != null) pstmt.close();
      if(con != null) con.close();
   }
}