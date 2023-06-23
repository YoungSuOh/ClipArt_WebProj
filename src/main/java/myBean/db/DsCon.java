package myBean.db;

import javax.naming.*;
import java.sql.*;
import javax.sql.DataSource; 

public class DsCon {
    /**
     * 1. Context로부터 커넥션 풀에 접근하여 Connection 을 가져온다.
     *    커넥션 풀의 URL은 java:/comp/env/jdbc/mydbTest 인 것으로 한다.
    * @return Connection
    * @throws SQLException, NamingException
    */
   public static Connection getConnection() throws SQLException, NamingException {
      Context initContext = new InitialContext();
      DataSource ds = (DataSource)initContext.lookup("java:/comp/env/jdbc/mydbTest");
      return ds.getConnection();
   }
}