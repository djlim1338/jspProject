package mvc.model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import mvc.database.DBConnection;

public class ProductDAO {
	protected Connection conn = null;
	protected Statement stmt = null;
	protected ResultSet rs = null;

	private static ProductDAO instance;
	
	private ProductDAO() {
		
	}

	public static ProductDAO getInstance() {
		if (instance == null)
			instance = new ProductDAO();
		return instance;
	}
	
	public String ts(String str) {  // to String
		return "'"+str+"'";
	}
	
	public void closeDB() {
		try {
			if (rs != null) 
				rs.close();		
			if (conn != null) 
				conn.close();
		} catch (Exception ex) {
			throw new RuntimeException(ex.getMessage());
		}
	}

	public ArrayList<ProductDTO> getProductListAll() {

		String sql = "SELECT * FROM product";

		ArrayList<ProductDTO> list = new ArrayList<ProductDTO>();

		try {
			conn = DBConnection.getConnection();
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
			rs = stmt.executeQuery(sql);
			
			while (rs.next()) {
				ProductDTO product = new ProductDTO();
				product.setId(rs.getString("p_id"));
				product.setName(rs.getString("p_name"));
				product.setUnitPrice(rs.getInt("p_unitPrice"));
				product.setDescription(rs.getString("p_description"));
				product.setManufacturer(rs.getString("p_manufacturer"));
				product.setCategory(rs.getString("p_category"));
				product.setUnitsInStock(rs.getLong("p_unitsInStock"));
				product.setCondition(rs.getString("p_condition"));
				product.setFileName(rs.getString("p_fileName"));
				list.add(product);
			}
			//return list;
		} catch (Exception ex) {
			System.out.println("getBoardList() 에러 : " + ex);
		} finally {
			closeDB();
		}
		return list;
	}
	
	public ProductDTO getProductById(String id) {  // 상품 ID로 상품 찾아옴
		String sql = "SELECT * FROM product WHERE P_id='" + id + "'";
		
		ProductDTO product = null;
		
		try {
			conn = DBConnection.getConnection();
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
			rs = stmt.executeQuery(sql);
			
			if(rs.next()) {
				product = new ProductDTO();
				product.setId(rs.getString("p_id"));
				product.setName(rs.getString("p_name"));
				product.setUnitPrice(rs.getInt("p_unitPrice"));
				product.setDescription(rs.getString("p_description"));
				product.setManufacturer(rs.getString("p_manufacturer"));
				product.setCategory(rs.getString("p_category"));
				product.setUnitsInStock(rs.getLong("p_unitsInStock"));
				product.setCondition(rs.getString("p_condition"));
				product.setFileName(rs.getString("p_fileName"));
			}
		} catch (Exception ex) {
			System.out.println("getBoardList() 에러 : " + ex);
		} finally {
			closeDB();
		}
		
		return product;
	}
	
	public int getCartProductQuantity(String userId, String productId) {  // 사용자ID, 상품ID로 카트 내 수량 반환
		String sql = "SELECT quantity FROM cart WHERE userId='"+userId+"' AND P_id='" + productId + "'";
		
		int productQuantity = 0;
		
		try {
			conn = DBConnection.getConnection();
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
			rs = stmt.executeQuery(sql);
			
			if(rs.next()) {
				productQuantity = rs.getInt("quantity");
			}
		} catch (Exception ex) {
			System.out.println("getBoardList() 에러 : " + ex);
		} finally {
			closeDB();
		}
		
		return productQuantity;
	}
	
	public int addCart(String userId, String productId, int quantity) {
		String sql = "";
		
		int productCartQuantity = getCartProductQuantity(userId, productId);
		int insertState = 0;
		
		if(productCartQuantity > 0) {
			productCartQuantity += quantity;
			sql = "UPDATE cart"
					+ " SET"
					+ " quantity = '"+productCartQuantity+"'"
					+ " WHERE userId='"+userId+"'"
					+ " AND P_id='"+productId+"'";
		}
		else {
			sql = "INSERT INTO cart(userId, P_id, quantity)"
					+ " VALUES("
					+ "'"+userId+"'"
					+ ",'"+productId+"'"
					+ ","+quantity+")";
		}
		
		try {
			conn = DBConnection.getConnection();
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
			insertState = stmt.executeUpdate(sql);  // 0:fail, 1:success (추정)

		} catch (Exception ex) {
			System.out.println("getBoardList() 에러 : " + ex);
		} finally {
			closeDB();
		}
		
		return insertState;
	}
}
