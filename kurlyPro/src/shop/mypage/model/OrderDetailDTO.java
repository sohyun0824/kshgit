package shop.mypage.model;

public class OrderDetailDTO {
	private long order_no;
	private String status;
	private int cnt;
	private String gr_name;
	private String goods_name;
	private int g_price;
	private String main_img;
	private int discount;
	private String goods_no;
	private String group_no;


	public OrderDetailDTO(){
	}

	public OrderDetailDTO(long order_no, String status, int cnt, String gr_name, String goods_name, int g_price,
			String main_img, int discount, String goods_no, String group_no) {
		super();
		this.order_no = order_no;
		this.status = status;
		this.cnt = cnt;
		this.gr_name = gr_name;
		this.goods_name = goods_name;
		this.g_price = g_price;
		this.main_img = main_img;
		this.discount = discount;
		this.goods_no = goods_no;
		this.group_no = group_no;
	}

	public long getOrder_no() {
		return order_no;
	}

	public void setOrder_no(long order_no) {
		this.order_no = order_no;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}

	public String getGr_name() {
		return gr_name;
	}

	public void setGr_name(String gr_name) {
		this.gr_name = gr_name;
	}

	public String getGoods_name() {
		return goods_name;
	}

	public void setGoods_name(String goods_name) {
		this.goods_name = goods_name;
	}

	public int getG_price() {
		return g_price;
	}

	public void setG_price(int g_price) {
		this.g_price = g_price;
	}

	public String getMain_img() {
		return main_img;
	}

	public void setMain_img(String main_img) {
		this.main_img = main_img;
	}

	public int getDiscount() {
		return discount;
	}

	public void setDiscount(int discount) {
		this.discount = discount;
	}

	public String getGoods_no() {
		return goods_no;
	}

	public void setGoods_no(String goods_no) {
		this.goods_no = goods_no;
	}

	public String getGroup_no() {
		return group_no;
	}

	public void setGroup_no(String group_no) {
		this.group_no = group_no;
	}
	
	
}
