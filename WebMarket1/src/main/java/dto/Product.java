package dto;
import java.io.Serializable;
public class Product implements Serializable {

	private static final long serialVersionUID = -4274700572038677000L;

	private String productId;	//상품 아이디
	private String pname;		//상품명
	private Integer unitPrice; //상품 가격
	private String description; //상품 설명
	private String manufacturer;//제조사
	private String category; 	//분류
	private long unitsInStock; //재고수 
	private String condition; 	//신상품 or 중고품 or 재생품
	private String filename; 	//이미지 파일명
	//private int quantity;  // 장바구니 담은 수

	public Product() {
		super();
	}
	public Product(String productId, String pname, Integer unitPrice) {
		this.productId = productId;
		this.pname = pname;
		this.unitPrice = unitPrice;
	}
	
	public String getProductId() {return this.productId;}
	public void setProductId(String productId) {this.productId = productId;}

	public String getPname() {return this.pname;}
	public void setPname(String pname) {this.pname = pname;}
	
	public Integer getUnitPrice() {return this.unitPrice;}
	public void setUnitPrice(Integer unitPrice) {this.unitPrice = unitPrice;}
	
	public String getDescription() {return this.description;}
	public void setDescription(String description) {this.description = description;}
	
	public String getManufacturer() {return this.manufacturer;}
	public void setManufacturer(String manufacturer) {this.manufacturer = manufacturer;}
	
	public String getCategory() {return this.category;}
	public void setCategory(String category) {this.category = category;}
	
	public long getUnitsInStock() {return this.unitsInStock;}
	public void setUnitsInStock(long unitsInStock) {this.unitsInStock = unitsInStock;}
	
	public String getCondition() {return this.condition;}
	public void setCondition(String condition) {this.condition = condition;}
	
	public String getFilename() {return this.filename;}
	public void setFilename(String filename) {this.filename = filename;}
	
	/*
	public int getQuantity() {return this.quantity;}
	public void setQuantity(int quantity) {this.quantity = quantity;}
	*/
}
