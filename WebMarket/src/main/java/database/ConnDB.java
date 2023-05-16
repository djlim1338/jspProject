package database;

import java.sql.*;
import dto.Product;

public class ConnDB {
	private String drivarClass = "com.mysql.jdbc.Driver";  // 드라이버 로딩
	private String url = "jdbc:mysql://localhost:3306/WebMarketDB";  // 데이터베이스 접속
	private String user = "web";  // mysql사용자 
	private String password = "1234";  // 비밀번호
	private boolean connectState = false;  // DB연결 상태
	private boolean statementState = false;  // statement 객체 상태
	private boolean errorState = false;  // 에러 상태
	
	public Connection conn;  // 연결 객체
	public Statement stmt;  // Statement 객체
	public ResultSet rs;  // 레코드 저장할 ResultSet 객체
	public String errorStr = "";  // 에러 문자열
	
	public ConnDB() {
		try {
			// 드라이버 로딩
			Class.forName(drivarClass);
			// 연결
			this.conn = DriverManager.getConnection(this.url, this.user, this.password);
			// 연결상태 true
			this.connectState = true;
			// 쿼리 수행을 위한 Statement 객체 생성
			this.stmt = this.conn.createStatement();
			this.statementState = true;
		}
		catch(ClassNotFoundException ex){
			this.errorStr = "ClassNotFoundException: " + ex.getMessage();
			this.errorState = true;
		}
		catch(SQLException ex){
			this.errorStr = "SQLException: " + ex.getMessage();
			this.errorState = true;
		}
		catch(Exception e){
			this.errorStr = "Exception: " + e.getMessage();
			this.errorState = true;
		}
	}
	
	public boolean getConnectState() {return this.connectState;}
	public boolean getErrorState() {return this.errorState;}
	public String getErrorMsg() {return this.errorStr;}
	
	public boolean myslqExecute(String sqlStr) {
		try {
			this.stmt.execute(sqlStr);
			return true;
		}
		catch(Exception e) {
			this.errorStr = "Exception: " + e.getMessage();
			this.errorState = true;
		}
		return false;
	}
	
	public boolean createTestTable() {
		String sqlStr = "CREATE TABLE test_table("
				+ "	test_num INT,"
				+ "	test_string CHAR(20)"
				+ ")";
		return myslqExecute(sqlStr);
	}
	
	public boolean deleteTestTable() {
		String sqlStr = "DROP TABLE test_table";
		return myslqExecute(sqlStr);
	}
	
	public void addProduct(Product product) {
		String addQueryStr = "INSERT INTO product( productId, pname, unitPrice, description, manufacturer, category, unitsInStock, conditional , filename)"
				+ "VALUES("
				+ product.getProductId() +","
				+ product.getPname() +","
				+ product.getUnitPrice() +","
				+ product.getDescription() +","
				+ product.getManufacturer() +","
				+ product.getCategory() +","
				+ product.getUnitsInStock() +","
				+ product.getCondition() +","
				+ product.getFilename()
				+ ")";
		myslqExecute(addQueryStr);
	}
	
	
	public void close() {
		try {
			this.conn.close();
			this.connectState = false;
		}
		catch(Exception e) {
			this.errorStr = "Exception: " + e.getMessage();
			this.errorState = true;
		}
		try {
			this.stmt.close();
			this.statementState = false;
		}
		catch(Exception e) {
			this.errorStr = "Exception: " + e.getMessage();
			this.errorState = true;
		}
	}
}
