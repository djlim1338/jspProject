package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

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

	public String columnString(String column) {
		return '"' + column + '"';
	}

	public boolean addProduct(Product product) {
		String addQueryStr = "INSERT INTO product( productId, pname, unitPrice, description, manufacturer, category, unitsInStock, conditional , filename)"
				+ "VALUES("
				+ columnString(product.getProductId()) +","
				+ columnString(product.getPname()) +","
				+ product.getUnitPrice() +","
				+ columnString(product.getDescription()) +","
				+ columnString(product.getManufacturer()) +","
				+ columnString(product.getCategory()) +","
				+ product.getUnitsInStock() +","
				+ columnString(product.getCondition()) +","
				+ columnString(product.getFilename())
				+ ")";
		return myslqExecute(addQueryStr);
	}

	public boolean deleteProductById(String productId) {
		String deleteQueryStr = "DELETE FROM product WHERE productId="
				+columnString(productId);
		return myslqExecute(deleteQueryStr);
	}

	public boolean updateProductById(String productOldId, Product product) {
		String updateQueryStr = "UPDATE product "
				+ "SET "
				+ "productId = " + columnString(product.getProductId()) +","
				+ "pname = " + columnString(product.getPname()) +","
				+ "unitPrice = " + product.getUnitPrice() +","
				+ "description = " + columnString(product.getDescription()) +","
				+ "manufacturer = " + columnString(product.getManufacturer()) +","
				+ "category = " + columnString(product.getCategory()) +","
				+ "unitsInStock = " + product.getUnitsInStock() +","
				+ "conditional = " + columnString(product.getCondition()) +","
				+ "filename = " + columnString(product.getFilename())
				+ " "
				+"WHERE productId="
				+columnString(productOldId);
		return myslqExecute(updateQueryStr);
	}


	public void close() {
		try {
			this.conn.close();
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
	}
}
