package shop.mypage.model;

public class GoodsInfoDTO {
	private String main_img;
	private String goods_no;
	private String group_name;
	private String goods_name;
	private long order_no;
	
	public GoodsInfoDTO() { }

	public GoodsInfoDTO(String main_img, String goods_no, String group_name, String goods_name) {
		this.main_img = main_img;
		this.goods_no = goods_no;
		this.group_name = group_name;
		this.goods_name = goods_name;
	}

	public String getMain_img() {
		return main_img;
	}

	public void setMain_img(String main_img) {
		this.main_img = main_img;
	}

	public String getGoods_no() {
		return goods_no;
	}

	public void setGoods_no(String goods_no) {
		this.goods_no = goods_no;
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

	public long getOrder_no() {
		return order_no;
	}

	public void setOrder_no(long order_no) {
		this.order_no = order_no;
	}
	
}
