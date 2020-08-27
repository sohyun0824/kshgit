package shop.mypage.model;

public class WishListDTO {
	private String m_id;
	private String goods_no;
	private String goods_name;
	private int price;
	private int soldout;
	private String group_no;
	private String group_name;
	private String main_img;

	
	
	public WishListDTO() {
		super();
	}
	
	public WishListDTO(String m_id, String goods_no, String goods_name, int price, int soldout, String group_no,
			String group_name, String main_img) {
		super();
		this.m_id = m_id;
		this.goods_no = goods_no;
		this.goods_name = goods_name;
		this.price = price;
		this.soldout = soldout;
		this.group_no = group_no;
		this.group_name = group_name;
		this.main_img = main_img;
	}
	public String getM_id() {
		return m_id;
	}
	public void setM_id(String m_id) {
		this.m_id = m_id;
	}
	public String getGoods_no() {
		return goods_no;
	}
	public void setGoods_no(String goods_no) {
		this.goods_no = goods_no;
	}
	public String getGoods_name() {
		return goods_name;
	}
	public void setGoods_name(String goods_name) {
		this.goods_name = goods_name;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getSoldout() {
		return soldout;
	}
	public void setSoldout(int soldout) {
		this.soldout = soldout;
	}
	public String getGroup_no() {
		return group_no;
	}
	public void setGroup_no(String group_no) {
		this.group_no = group_no;
	}
	public String getGroup_name() {
		return group_name;
	}
	public void setGroup_name(String group_name) {
		this.group_name = group_name;
	}
	public String getMain_img() {
		return main_img;
	}
	public void setMain_img(String main_img) {
		this.main_img = main_img;
	}
	
	
}
