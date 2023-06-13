package mvc.model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import mvc.database.DBConnection;

public class ProductDAO {

	private static ProductDAO instance;
	
	private ProductDAO() {
		
	}

	public static ProductDAO getInstance() {
		if (instance == null)
			instance = new ProductDAO();
		return instance;
	}

	public ArrayList<ProductDTO> getProductListAll() {
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;

		String sql = "SELECT * FROM product";

		ArrayList<ProductDTO> list = new ArrayList<ProductDTO>();

		try {
			conn = DBConnection.getConnection();
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
			rs = stmt.executeQuery(sql);
			
			while (rs.next()) {
				ProductDTO product = new ProductDTO();
				product.setId(rs.getString("id"));
				product.setName(rs.getString("name"));
				product.setUnitPrice(rs.getInt("unitPrice"));
				product.setDescription(rs.getString("description"));
				product.setManufacturer(rs.getString("manufacturer"));
				product.setCategory(rs.getString("category"));
				product.setUnitsInStock(rs.getLong("unitsInStock"));
				product.setCondition(rs.getString("condition"));
				product.setFileName(rs.getString("fileName"));
				list.add(product);
			}
			return list;
		} catch (Exception ex) {
			System.out.println("getBoardList() 에러 : " + ex);
		} finally {
			try {
				if (rs != null) 
					rs.close();		
				if (conn != null) 
					conn.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}			
		}
		return list;
	}

}
