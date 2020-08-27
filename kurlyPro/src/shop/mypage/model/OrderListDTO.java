package shop.mypage.model;

import java.util.Date;

public class OrderListDTO {
	private long order_no;
	private String status;
	private Date order_date;
	private String group_name;
	private int pay_amount;
	private String main_img;
	private String group_no;
	private String goods_no;
	
	public OrderListDTO() {
	}

	public OrderListDTO(long order_no, String status, Date order_date, String group_name, int pay_amount,
			String main_img, String group_no) {
		this.order_no = order_no;
		this.status = status;
		this.order_date = order_date;
		this.group_name = group_name;
		this.pay_amount = pay_amount;
		this.main_img = main_img;
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

	public Date getOrder_date() {
		return order_date;
	}

	public void setOrder_date(Date order_date) {
		this.order_date = order_date;
	}

	public String getGroup_name() {
		return group_name;
	}

	public void setGoods_name(String group_name) {
		this.group_name = group_name;
	}

	public int getPay_amount() {
		return pay_amount;
	}

	public void setPay_amount(int pay_amount) {
		this.pay_amount = pay_amount;
	}

	public String getMain_img() {
		return main_img;
	}

	public void setMain_img(String main_img) {
		this.main_img = main_img;
	}

	public String getGroup_no() {
		return group_no;
	}

	public void setGroup_no(String group_no) {
		this.group_no = group_no;
	}

	public String getGoods_no() {
		return goods_no;
	}

	public void setGoods_no(String goods_no) {
		this.goods_no = goods_no;
	}
	
	
}
