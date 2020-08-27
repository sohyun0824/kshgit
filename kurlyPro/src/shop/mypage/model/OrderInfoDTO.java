package shop.mypage.model;

import java.sql.Date;

public class OrderInfoDTO {
	
	private long order_no;
	private String user_name;
	private Date pay_date;
	private String status;
	private String no_goods;
	
	public OrderInfoDTO() {
		super();
	}

	public OrderInfoDTO(long order_no, String user_name, Date pay_date, String status, String no_goods) {
		super();
		this.order_no = order_no;
		this.user_name = user_name;
		this.pay_date = pay_date;
		this.status = status;
		this.no_goods = no_goods;
	}

	public long getOrder_no() {
		return order_no;
	}
	public void setOrder_no(long order_no) {
		this.order_no = order_no;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public Date getPay_date() {
		return pay_date;
	}
	public void setPay_date(Date pay_date) {
		this.pay_date = pay_date;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}

	public String getNo_goods() {
		return no_goods;
	}

	public void setNo_goods(String no_goods) {
		this.no_goods = no_goods;
	}
	
	
}
