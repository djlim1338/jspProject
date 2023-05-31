package database;

import java.sql.*;
import java.util.HashMap;
import dto.Product;

public class ConnDB {
	private String drivarClass = "com.mysql.jdbc.Driver";  // 드라이버 로딩
	private String url = "jdbc:mysql://localhost:3306/WebMarketDB";  // 데이터베이스 접속
	private String user = "web";  // mysql사용자 
	private String password = "1234";  // 비밀번호
	private boolean errorState = false;  // 에러 상태
	
	public Connection conn = null;  // 연결 객체
	public Statement stmt = null;  // Statement 객체
	public ResultSet rs = null;  // 레코드 저장할 ResultSet 객체
	
	public ConnDB() {
		try {
			// 드라이버 로딩
			Class.forName(drivarClass);
			// 연결
			this.conn = DriverManager.getConnection(this.url, this.user, this.password);
			// 쿼리 수행을 위한 Statement 객체 생성
			this.stmt = this.conn.createStatement();
		}
		catch(ClassNotFoundException ex){
			this.errorState = true;
			this.resetDB();
		}
		catch(SQLException ex){
			this.errorState = true;
			this.resetDB();
		}
		catch(Exception e){
			this.errorState = true;
			this.resetDB();
		}
	}
	
	public void resetDB() {
		this.conn = null;
		this.stmt = null;
		this.rs = null;
	}
	
	public boolean getErrorState() {return this.errorState;}
	
	public boolean myslqExecute(String sqlStr) {
		try {
			this.stmt.execute(sqlStr);
			return true;
		}
		catch(Exception e) {
			this.errorState = true;
		}
		return false;
	}
	
	// insert, update, delete ...  
	public boolean myslqExecuteUpdate(String sqlStr) {  
		try {
			this.stmt.executeUpdate(sqlStr);
			return true;
		}
		catch(Exception e) {
			this.errorState = true;
		}
		return false;
	}
	
	// select
	public ResultSet myslqExecuteQuery(String sqlStr) {  
		try {
			this.rs = this.stmt.executeQuery(sqlStr);
			return this.rs;
		}
		catch(Exception e) {
			this.errorState = true;
		}
		return null;
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
	
	public String columnString(String column) {  // 단어에 따옴표 추가.
		return '"' + column + '"';
	}
	
	public boolean addProduct(String p_id, String p_name, long p_unitPrice, String p_description, String p_manufacturer, String p_category, long p_unitsInStock, String p_condition, String p_fileName) {
		String addQueryStr = "INSERT INTO product(p_id, p_name, p_unitPrice, p_description, p_manufacturer, p_category, p_unitsInStock, p_condition, p_fileName)"
				+ "VALUES("
				+ columnString(p_id) +","
				+ columnString(p_name) +","
				+ p_unitPrice +","
				+ columnString(p_description) +","
				+ columnString(p_manufacturer) +","
				+ columnString(p_category) +","
				+ p_unitsInStock +","
				+ columnString(p_condition) +","
				+ columnString(p_fileName)
				+ ")";
		return myslqExecuteUpdate(addQueryStr);
	}
	
	public boolean deleteProductById(String productId) {
		String deleteQueryStr = "DELETE FROM product WHERE p_id="
				+columnString(productId);
		return myslqExecuteUpdate(deleteQueryStr);
	}
	
	public boolean updateProductById(String p_old_id, String p_id, String p_name, long p_unitPrice, String p_description, String p_manufacturer, String p_category, long p_unitsInStock, String p_condition, String p_fileName) {
		String updateQueryStr = "UPDATE product "
				+ "SET "
				+ "p_id = " + columnString(p_id) +","
				+ "p_name = " + columnString(p_name) +","
				+ "p_unitPrice = " + p_unitPrice +","
				+ "p_description = " + columnString(p_description) +","
				+ "p_manufacturer = " + columnString(p_manufacturer) +","
				+ "p_category = " + columnString(p_category) +","
				+ "p_unitsInStock = " + p_unitsInStock +","
				+ "p_condition = " + columnString(p_condition) +","
				+ "p_fileName = " + columnString(p_fileName)
				+ " "
				+ "WHERE p_id="
				+ columnString(p_old_id);
		return myslqExecuteUpdate(updateQueryStr);
	}
	
	public ResultSet selectProductAll() {
		String selectQueryStr = "SELECT * FROM product";
		return myslqExecuteQuery(selectQueryStr);
	}
	
	public ResultSet selectProductById(String productId) {
		String selectQueryStr = "SELECT * FROM product "
				+ "WHERE p_id=" + columnString(productId);
		return myslqExecuteQuery(selectQueryStr);
	}
	
	
	public void close() {
		try {
			this.rs.close();
		}
		catch(Exception e) {
			this.errorState = true;
		}
		try {
			this.stmt.close();
		}
		catch(Exception e) {
			this.errorState = true;
		}
		try {
			this.conn.close();
		}
		catch(Exception e) {
			this.errorState = true;
		}
	}
}
