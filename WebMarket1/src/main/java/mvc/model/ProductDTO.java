package mvc.model;

public class ProductDTO {
	private String id;
	private String name;
	private int unitPrice;
	private String description;
	private String manufacturer;
	private String category;
	private long unitsInStock;
	private String condition;
	private String fileName;
	
	public ProductDTO() {
		super();
	}
	
	public String getId() {return this.id;}
	public void setId(String id) {this.id = id;}
	public String getName() {return this.name;}
	public void setName(String name) {this.name = name;}
	public int getUnitPrice() {return this.unitPrice;}
	public void setUnitPrice(int unitPrice) {this.unitPrice = unitPrice;}
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
	public String getFileName() {return this.fileName;}
	public void setFileName(String fileName) {this.fileName = fileName;}
}
