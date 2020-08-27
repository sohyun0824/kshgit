package shop.goods.model;

public class GoodsListDTO {
	
	private String group_no;
	private String name;
	private String main_img;
	private String line_discript;
	private int discount;
	private int price;
	//private int soldout;
	private int kurly_only;
	private int healthy;
	private int limited;
	
	public String getGroup_no() {
		return group_no;
	}
	public void setGroup_no(String group_no) {
		this.group_no = group_no;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getMain_img() {
		return main_img;
	}
	public void setMain_img(String main_img) {
		this.main_img = main_img;
	}
	public String getLine_discript() {
		return line_discript;
	}
	public void setLine_discript(String line_discript) {
		this.line_discript = line_discript;
	}
	public int getDiscount() {
		return discount;
	}
	public void setDiscount(int discount) {
		this.discount = discount;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
//	public int getSoldout() {
//		return soldout;
//	}
//	public void setSoldout(int soldout) {
//		this.soldout = soldout;
//	}
	public int getKurly_only() {
		return kurly_only;
	}
	public void setKurly_only(int kurly_only) {
		this.kurly_only = kurly_only;
	}
	public int getHealthy() {
		return healthy;
	}
	public void setHealthy(int healthy) {
		this.healthy = healthy;
	}
	public int getLimited() {
		return limited;
	}
	public void setLimited(int limited) {
		this.limited = limited;
	}
	
}
