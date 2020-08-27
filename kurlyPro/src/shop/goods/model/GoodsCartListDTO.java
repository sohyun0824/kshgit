package shop.goods.model;

public class GoodsCartListDTO {
	
	private String basket_no;
	private String group_name;
	private String goods_name;
	private int cnt;
	private int discount;
	private int min;
	private int b_price;
	private int g_price;
	private int dc_price;
	private String goods_no;
	private String main_img;
	private int soldout;
	
	public GoodsCartListDTO() {	}
	
	public String getBasket_no() {
		return basket_no;
	}
	public void setBasket_no(String basket_no) {
		this.basket_no = basket_no;
	}
	public String getGroup_name() {
		return group_name;
	}
	public void setGroup_name(String group_name) {
		this.group_name = group_name;
	}
	public String getGoods_name() {
		return goods_name;
	}
	public void setGoods_name(String goods_name) {
		this.goods_name = goods_name;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public int getDiscount() {
		return discount;
	}
	public void setDiscount(int discount) {
		this.discount = discount;
	}
	public int getMin() {
		return min;
	}
	public void setMin(int min) {
		this.min = min;
	}
	public int getB_price() {
		return b_price;
	}
	public void setB_price(int b_price) {
		this.b_price = b_price;
	}
	public int getG_price() {
		return g_price;
	}
	public void setG_price(int g_price) {
		this.g_price = g_price;
	}
	public int getDc_price() {
		return dc_price;
	}
	public void setDc_price(int dc_price) {
		this.dc_price = dc_price;
	}
	public String getGoods_no() {
		return goods_no;
	}
	public void setGoods_no(String goods_no) {
		this.goods_no = goods_no;
	}
	public String getMain_img() {
		return main_img;
	}
	public void setMain_img(String main_img) {
		this.main_img = main_img;
	}
	public int getSoldout() {
		return soldout;
	}
	public void setSoldout(int soldout) {
		this.soldout = soldout;
	}
	
	
}
