package mvc.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DBConnection {
	private static String drivarClass = "com.mysql.jdbc.Driver";  // 드라이버 로딩
	private static String url = "jdbc:mysql://localhost:3306/WebMarketDB";  // 데이터베이스 접속
	private static String user = "web";  // mysql사용자 
	private static String password = "1234";  // 비밀번호

	public static Connection conn = null;  // 연결 객체
	//public static Statement stmt = null;  // Statement 객체
	
	public static Connection getConnection() {
		try {
			// 드라이버 로딩
			Class.forName(drivarClass);
			// 연결
			conn = DriverManager.getConnection(url, user, password);
			// 쿼리 수행을 위한 Statement 객체 생성
			//stmt = conn.createStatement();
		}
		catch(ClassNotFoundException ex){
			resetDB();
		}
		catch(SQLException ex){
			resetDB();
		}
		catch(Exception e){
			resetDB();
		}
		return DBConnection.conn;
	}

	public static void resetDB() {
		close();
		conn = null;
	}
	
	public static void close() {
		try {
			conn.close();
		}
		catch(Exception e) {
		}
	}
}
